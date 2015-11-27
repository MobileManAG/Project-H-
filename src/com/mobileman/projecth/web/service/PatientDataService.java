/*******************************************************************************
 * Copyright 2015 MobileMan GmbH
 * www.mobileman.com
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
package com.mobileman.projecth.web.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.DoctorService;
import com.mobileman.projecth.business.HaqService;
import com.mobileman.projecth.business.PatientMedicationService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.UserConnectionService;
import com.mobileman.projecth.business.chart.HaqChartService;
import com.mobileman.projecth.business.index.kpi.KeyPerformanceIndicatorTypeService;
import com.mobileman.projecth.business.patient.PatientKPIService;
import com.mobileman.projecth.business.patient.PatientKPIValidationService;
import com.mobileman.projecth.domain.chart.ChartType;
import com.mobileman.projecth.domain.chart.ChartType.Type;
import com.mobileman.projecth.domain.chart.HaqChart;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.dto.patient.kpi.KeyPerformanceIndicatorStatistics;
import com.mobileman.projecth.domain.index.kpi.KeyPerformanceIndicatorType;
import com.mobileman.projecth.domain.medicine.Medication;
import com.mobileman.projecth.domain.patient.PatientQuestionAnswer;
import com.mobileman.projecth.domain.patient.kpi.PatientKeyPerformanceIndicatorValidation;
import com.mobileman.projecth.domain.questionary.Answer;
import com.mobileman.projecth.domain.questionary.Answer.Kind;
import com.mobileman.projecth.domain.questionary.CustomQuestion;
import com.mobileman.projecth.domain.questionary.OneTimeHaq;
import com.mobileman.projecth.domain.questionary.QuestionType;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.domain.user.UserWeight;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.domain.user.connection.UserConnectionState;
import com.mobileman.projecth.web.controller.InitController;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.DiaryData;
import com.mobileman.projecth.web.model.DiaryDataItem;
import com.mobileman.projecth.web.model.PatientInfo;
import com.mobileman.projecth.web.model.chart.AbstractPrepareChartData;
import com.mobileman.projecth.web.model.chart.AreaChartData;
import com.mobileman.projecth.web.model.chart.BarChartData;
import com.mobileman.projecth.web.model.chart.BubbleChartData;
import com.mobileman.projecth.web.model.chart.ChartDataResult;
import com.mobileman.projecth.web.model.chart.ChartTypeExt;
import com.mobileman.projecth.web.model.chart.ImageChartData;
import com.mobileman.projecth.web.model.chart.LineChartData;
import com.mobileman.projecth.web.model.chart.MultiplePieChartData;
import com.mobileman.projecth.web.model.chart.PieChartData;
import com.mobileman.projecth.web.model.chart.PrepareChartData;
import com.mobileman.projecth.web.model.chart.ScatterChartData;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.NumUtils;
import com.mobileman.projecth.web.util.PatientUtils;
import com.mobileman.projecth.web.util.PrivacyUtils;
import com.mobileman.projecth.web.util.Services;
import com.mobileman.projecth.web.util.UserUtils;

@Service
public class PatientDataService {

	@Autowired
	PatientKPIValidationService patientKPIValidationService;

	@Autowired
	PatientService patientService;

	@Autowired
	UserConnectionService userConnectionService;

	@Autowired
	PatientMedicationService patientMedicationService;

	@Autowired
	DiseaseService diseaseService;

	@Autowired
	HaqService haqService;

	@Autowired
	DoctorService doctorService;

	@Autowired
	KeyPerformanceIndicatorTypeService keyPerformanceIndicatorTypeService;

	@Autowired
	PatientKPIService patientKPIService;

	@Autowired
	HaqChartService haqChartService;

	@Autowired
	LocaleService localeService;

	/**
	 * @param visitor
	 * @param model
	 */
	private void applyPrivacy(HttpServletRequest request, Model model, User visitor, List<UserConnection> connections, User selectedUser,
			Disease selectedDisease) {
		boolean showUserData = false;
		boolean showReportData = false;
		boolean canEditHeader = false;
		if (!ObjectUtils.equals(visitor, selectedUser) && selectedUser != null) {
			//load patient if belongs to visitor
			boolean connectionExists = UserUtils.connectionExists(selectedUser, connections);
			showUserData = PrivacyUtils.visitorCanSeeUserData(visitor, selectedUser, connectionExists);
			showReportData = PrivacyUtils.visitorCanSeeReportData(visitor, selectedUser, connectionExists);
		}

		if (connections != null && selectedUser != null) {
			for (UserConnection userConnection : connections) {
				User other = userConnection.getUser();
				if (other.getId().equals(selectedUser.getId())) {
					other = userConnection.getOwner();
				}

				if (userConnection.getState().equals(UserConnectionState.A) && other.getUserType().equals(UserType.D)) {
					model.addAttribute("doctorOfPatient", other);
					break;
				}
			}
		}

		if (ObjectUtils.equals(visitor, selectedUser)) {
			showUserData = true;
			showReportData = true;
			canEditHeader = true;
		}

		model.addAttribute("visitorCanSeeUserData", Boolean.valueOf(showUserData));
		model.addAttribute("showReportData", Boolean.valueOf(showReportData));
		model.addAttribute("canEditHeader", Boolean.valueOf(canEditHeader));
	}

	/**
	 * @param visitor
	 * @param model
	 * @param userId
	 * @param diseaseId
	 */
	public void prepareData(HttpServletRequest request, Model model, User visitor, String userId, String diseaseId) {

		model.addAttribute("visitor", visitor);
		// prepare patients for visitor
		User selectedUser = null;
		Long selectedUserId = NumUtils.convert2long(userId);
		Long selectedDiseaseId = NumUtils.convert2long(diseaseId);
		if (selectedUserId != null) {
			//load patient if belongs to visitor
			selectedUser = patientService.findById(selectedUserId);
		}

		Disease selectedDisease = null;
		if (selectedDiseaseId != null) {
			selectedDisease = diseaseService.findById(selectedDiseaseId);
		}

		List<PatientInfo> patients = new ArrayList<PatientInfo>();

		List<UserConnection> conns = patientService.findAllByDoctor(visitor.getId());
		for (UserConnection conn : conns) {
			List<Disease> diseases = Collections.emptyList();
			if (conn.getOwner().getId().equals(visitor.getId())) {
				diseases = conn.getUser().getDiseases();
			} else {
				diseases = conn.getOwner().getDiseases();
			}
			if (diseases.size() > 0) {
				for (Disease disease : diseases) {
					patients.add(new PatientInfo(visitor.getId(), patientService, conn, disease, selectedUserId, selectedDiseaseId));
				}
			} else {
				patients.add(new PatientInfo(visitor.getId(), patientService, conn, null, selectedUserId, selectedDiseaseId));
			}
		}

		//sort list

		Collections.sort(patients, new Comparator<PatientInfo>() {
			@Override
			public int compare(PatientInfo o1, PatientInfo o2) {
				return o1.getName().compareTo(o2.getName());
			}
		});

		//load data for selected patient
		if (selectedUser != null && selectedUser.getId() != null) {
			prepareData(request, model, selectedUser, selectedDisease);
		}

		model.addAttribute("patients", patients);
		applyPrivacy(request, model, visitor, conns, selectedUser, selectedDisease);
	}

	public void prepareData(HttpServletRequest request, Model model, User selectedUser, Disease selectedDisease) {
		DataHolder data = new DataHolder(request);
		User visitor = data.getUser();

		if (selectedUser == null) {
			DataHolder holder = new DataHolder(request);
			selectedUser = visitor;
			selectedDisease = holder.getDisease();
			if (selectedUser != null) {
				if (selectedDisease == null && selectedUser.getDiseases() != null && !selectedUser.getDiseases().isEmpty()) {
					selectedDisease = selectedUser.getDiseases().get(0);
					holder.setDiseaseId(selectedDisease.getId());
				}
			}
		}

		if (selectedUser != null) {
			preparePatientModel(data, model, selectedUser, selectedDisease);
		}

		List<UserConnection> conns = userConnectionService.findAllNotCanceledConnections(visitor.getId());

		applyPrivacy(request, model, visitor, conns, selectedUser, selectedDisease);
	}

	@Transactional
	public void changeKpi(HttpServletRequest request, Model model, String kpi, String kpiId) {
		DataHolder data = new DataHolder(request);
		if (data.getPatient() == null) {
			return;
		}
		// save cdai
		//List<KeyPerformanceIndicatorType> kpit = keyPerformanceIndicatorTypeService.findAll(data.getDiseaseId());
		doctorService.saveValidatedKpiValue(data.getDoctor().getId(), data.getPatient().getId(), new Date(),
				keyPerformanceIndicatorTypeService.findById(Long.parseLong(kpiId)) /*kpit*/, new BigDecimal(kpi));
		prepareData(request, model, data.getPatient(), null);
	}

	public void changeDate(HttpServletRequest request, Model model, String date_from, String date_to) {
		DataHolder data = new DataHolder(request);
		// change date
		if (StringUtils.isNotBlank(date_from)) {
			data.setDateFrom(DateUtils.str2date(date_from));
		}
		if (StringUtils.isNotBlank(date_to)) {
			data.setDateTo(DateUtils.str2date(date_to));
		}
		//prepareData(request, model);
	}

	private static void changeDate(HttpServletRequest request, Model model, Date date_from, Date date_to) {
		DataHolder data = new DataHolder(request);
		// change date
		data.setDateFrom(date_from);
		data.setDateTo(date_to);
		model.addAttribute("date_from_text", DateUtils.germanShortDate2str(date_from));
		model.addAttribute("date_to_text", DateUtils.germanShortDate2str(date_to));
	}

	private static PatientService getPatientService() {
		return InitController.getWebApplicationContext().getBean(PatientService.class);
	}

	public static void changeDatePreddefined(HttpServletRequest request, Model model, Integer len, String type) {
		Date d_from = new Date();
		Date d_to = new Date();

		boolean changed = false;
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTime(d_to);

		if (StringUtils.isNotBlank(type) && len != null) {
			if ("w".equals(type)) {
				cal.add(Calendar.DAY_OF_MONTH, -len * 7);
				d_from = cal.getTime();
				changed = true;
			} else if ("m".equals(type)) {
				cal.add(Calendar.MONTH, -len);
				d_from = cal.getTime();
				changed = true;
			} else if ("y".equals(type)) {
				cal.add(Calendar.YEAR, -len);
				d_from = cal.getTime();
				changed = true;
			} else if ("a".equals(type)) {
				//patient all
				DataHolder data = new DataHolder(request);
				if (data.getPatient() != null) {
					d_from = getPatientService().findOldestPatientAnswerDate(data.getPatient().getId());
				}

				if (d_from == null) {
					d_from = new Date();
				}
				changed = true;
			} else if ("x".equals(type)) {
				//all patients
				d_from = getPatientService().findOldestPatientsAnswerDate();
				if (d_from == null) {
					d_from = new Date();
				}
				changed = true;
			}

		}

		if (changed) {
			changeDate(request, model, d_from, d_to);
		} else {
			//prepareData(request, model);
		}
	}

	private void preparePatientModel(DataHolder data, Model model, User patient, Disease disease) {

		prepareCommon(data, model, patient, disease);

		prepareCharts(data, model, patient, disease);

		// patient can see its own data
		model.addAttribute("visitorCanSeeUserData", Boolean.TRUE);
	}

	static private Map<ChartType.Type, PrepareChartData> prepareChart;

	void fillPrepareChart() {
		Map<ChartType.Type, PrepareChartData> tmp = new HashMap<ChartType.Type, PrepareChartData>();
		tmp.put(ChartType.Type.AREA, new AreaChartData());
		tmp.put(ChartType.Type.LINE, new LineChartData());
		tmp.put(ChartType.Type.PIE, new PieChartData());
		tmp.put(ChartType.Type.BAR, new BarChartData());
		tmp.put(ChartType.Type.BUBLE, new BubbleChartData());
		tmp.put(ChartType.Type.SCATTER, new ScatterChartData());
		tmp.put(ChartType.Type.IMAGE, new ImageChartData());
		tmp.put(ChartType.Type.MULTIPLE_PIE, new MultiplePieChartData());

		prepareChart = tmp;
	}

	private final static Long haqId = 0L;

	private void addToHaqChartsMap(Map<Long, List<HaqChart>> haqChartsMap, HaqChart haqChart) {
		List<HaqChart> charts = haqChartsMap.get(haqId);
		if (charts == null) {
			charts = new ArrayList<HaqChart>();
			haqChartsMap.put(haqId, charts);
		}
		charts.add(haqChart);
	}

	void prepareCharts(DataHolder data, Model model, User patient, Disease disease) {
		if (prepareChart == null) {
			fillPrepareChart();
		}

		if (disease == null) {
			return;
		}

		List<Haq> haqs = haqService.findByDisease(disease.getId());
		model.addAttribute("haqs", haqs);

		Map<Long, List<HaqChart>> haqChartsMap = new HashMap<Long, List<HaqChart>>();
		model.addAttribute("haq_charts", haqChartsMap);

		Map<Long, Object> haqDataMap = new HashMap<Long, Object>();
		model.addAttribute("haqChart_data", haqDataMap);

		Iterator<Haq> it = haqs.iterator();
		boolean hasData = false;
		while (it.hasNext()) {
			Haq haq = it.next();
			if (OneTimeHaq.class.isInstance(haq)) {
				it.remove();
				continue;
			}

			List<HaqChart> charts = haqChartService.findByHaq(haq.getId());
			haqChartsMap.put(haq.getId(), charts);
			// if there are no charts remove also header
			if (charts.isEmpty()) {
				it.remove();
			}

			//prepare date
			for (HaqChart haqChart : charts) {
				ChartDataResult cdr = prepareChart.get(haqChart.getChartType().getType()).prepare(data, model, patient, haq, haqChart);
				if (cdr != null) {
					hasData = hasData | cdr.isHasData();
					haqDataMap.put(haqChart.getId(), cdr.getData());
				}
			}
		}
		//custom questions report
		List<CustomQuestion> customQuestions = patientService.findCustomQuestions(patient.getId(), disease.getId());
		if (customQuestions != null && customQuestions.size() > 0) {
			//custom questions
			//prepare dummy haq (id 0), haq charts
			Haq haq = new Haq();
			haq.setId(haqId);
			haq.setHaqQuestion(Services.getLocaleService().getReportCustonQuestions());
			haqs.add(haq);
			long id = 10000000000L;

			////////////////////////
			/*{
				hasData = true;
				HaqChart haqChart = new HaqChart();
				haqChart.setId(++id);
				haqChart.setTitle("test question");
				haqChart.setChartType(new ChartTypeExt("TEXT"));
				addToHaqChartsMap(haqChartsMap, haqChart);
				List<Object[]> prepData = new ArrayList<Object[]>();
				for (int i = 0; i < 20; i++) {
					Object[] r = new Object[2];
					r[0] = DateUtils.germanDate2str(DateUtils.addDays(new Date(), i));
					r[1] = "some text kskl skljlk skls lkhjklh jklhs jkl jkls klsj klshls kljs jklsjklsh sjhjskhjklsjklshjksjks jkls klsjkls klskl";
					prepData.add(r);
				}
				haqDataMap.put(haqChart.getId(), prepData);
			}*/
			//////////////////////

			for (CustomQuestion question : customQuestions) { //.entrySet()) {
				//haq_chart from question type
				//SINGLE_ANSWER_ENTER, - show texts
				//SINGLE_CHOICE_LIST - bar single
				//SCALE ???
				//MULTIPLE_CHOICE_LIST ???

				if (QuestionType.Type.SINGLE_ANSWER_ENTER.equals(question.getQuestionType().getType())) {
					//text output list (date, text)
					List<PatientQuestionAnswer> result = Services.getPatientQuestionAnswerService().findAll(patient.getId(), question.getId(),
							data.getDateFrom(), data.getDateTo());
					if (result != null && result.size() > 0) {
						hasData = true;
						HaqChart haqChart = new HaqChart();
						haqChart.setId(++id);
						haqChart.setTitle(question.getText());
						haqChart.setChartType(new ChartTypeExt("TEXT"));
						addToHaqChartsMap(haqChartsMap, haqChart);
						List<Object[]> prepData = new ArrayList<Object[]>(result.size());
						for (PatientQuestionAnswer pqa : result) {
							Object[] r = new Object[2];
							r[0] = DateUtils.germanDate2str(pqa.getLogDate());
							r[1] = pqa.getCustomAnswer();
							prepData.add(r);
						}
						haqDataMap.put(haqChart.getId(), prepData);
					}
				} else if (QuestionType.Type.SINGLE_CHOICE_LIST.equals(question.getQuestionType().getType())) {
					//bar - BarChart or Pie Chart if yes/no answers only
					ChartDataResult cdr = null;
					ChartType.Type cType = Type.BAR;

					if (question.getQuestionType().getAnswers().size() == 3) {
						boolean kaineAngabe = false;
						Answer yes = null;
						Answer no = null;
						for (Answer answer : question.getQuestionType().getAnswers()) {
							if (Kind.NO_ANSWER.equals(answer.getKind())) {
								kaineAngabe = true;
							} else {
								if (answer.isActive()) {
									yes = answer;
								} else {
									no = answer;
								}
							}
						}
						if (kaineAngabe && yes != null && no != null) {
							cType = Type.PIE;
						}
					}

					if (cType == Type.BAR) {
						BarChartData bcd = (BarChartData) prepareChart.get(cType);
						cdr = bcd.prepareQuestion(data, model, patient, question.getId());
					} else {
						//pie
						PieChartData pcd = (PieChartData) prepareChart.get(cType);
						cdr = pcd.prepareQuestion(data, model, patient, question.getId());
					}

					if (cdr.isHasData()) {
						hasData = true;
						HaqChart haqChart = new HaqChart();
						haqChart.setId(++id);
						haqChart.setTitle(question.getText());
						ChartType type = new ChartType();
						type.setType(cType);
						haqChart.setChartType(type);
						addToHaqChartsMap(haqChartsMap, haqChart);

						haqDataMap.put(haqChart.getId(), cdr.getData());
					}
				}

			}
		}

		model.addAttribute("chart_data_exists", hasData);

	}

	private void prepareCommon(DataHolder data, Model model, User patient, Disease disease) {
		model.addAttribute("date_from", DateUtils.date2str(data.getDateFrom()));
		model.addAttribute("date_to", DateUtils.date2str(data.getDateTo()));

		model.addAttribute("is_doctor", data.getType() == UserType.D);

		model.addAttribute("patient", patient);
		model.addAttribute("disease", disease);

		if (patient.getGender() == null) {
			patient.setGender(localeService.getUnknowMessage());
		}

		prepareKpi(data, model, patient, disease);
		prepareMedicineModel(data, model, patient, disease);

		model.addAttribute("chart_properties", getChartProperties());
		model.addAttribute("pie_chart_properties", getPieChartProperties());

		PatientUtils.loadPatientHeader(model, data, patient, disease);

		//weights
		List<String> weightResult = new ArrayList<String>();
		// date - a date + 1 day
		weightResult.add(AbstractPrepareChartData.getDateInfo(data.getDateFrom(), -1, null, null));

		List<UserWeight> userWeights = new ArrayList<UserWeight>(patient.getWeights());

		Collections.sort(userWeights, new Comparator<UserWeight>() {
			@Override
			public int compare(UserWeight o1, UserWeight o2) {
				long t1 = o1.getDate().getTime();
				long t2 = o2.getDate().getTime();
				return t1 < t2 ? -1 : (t1 > t2 ? 1 : 0);
			}
		});

		// find data
		for (UserWeight userWeight : userWeights) {
			if (userWeight.getDate().before(data.getDateFrom())) {
				continue;
			}
			if (userWeight.getDate().after(data.getDateTo())) {
				continue;
			}
			weightResult.add(AbstractPrepareChartData.getDateInfo(userWeight.getDate(), 0, userWeight.getWeight().doubleValue(), null));
		}

		weightResult.add(AbstractPrepareChartData.getDateInfo(data.getDateTo(), 1, null, null));
		model.addAttribute("weights", weightResult);
	}

	private void prepareMedicineModel(DataHolder dataHolder, Model model, User patient, Disease disease) {

		Date startDate = DateUtils.addDays(dataHolder.getDateFrom(), -1);
		Date endDate = DateUtils.addDays(dataHolder.getDateTo(), 1);

		if (disease == null) {
			return;
		}

		List<Object[]> datas = patientMedicationService.findConsumedMedicationsDiary(patient.getId(), dataHolder.getDateFrom(),
				dataHolder.getDateTo());

		// Map<String, Long> days = new HashMap<String, Long>();

		List<DiaryData> rc = new ArrayList<DiaryData>();
		if (datas != null) {
			for (Object[] o : datas) {
				// date, medication, long
				/*
				 * {name: 'Anthodoxyin 220mg', data: [ {x:Date.UTC(2010,10,6),
				 * y:null}, {x:Date.UTC(2010,10,7), y:1 -0.5},
				 * {x:Date.UTC(2010,10,7), y:2 -0.5}, {x:Date.UTC(2010,10,7),
				 * y:3 -0.5}, {x:Date.UTC(2010,10,10), y:3 -0.5},
				 * {x:Date.UTC(2010,10,11), y:2 -0.5}, {x:Date.UTC(2010,10,12),
				 * y:2 -0.5}, {x:Date.UTC(2010,10,13), y:null}, ] , color:
				 * colors[(index++) % colors.length]},
				 */
				Date date = (Date) o[0];
				Medication med = (Medication) o[1];
				Long count = (Long) o[2];
				// find diary data
				DiaryData diary = null;
				for (DiaryData dd : rc) {
					if (dd.getMedId().equals(med.getId())) {
						diary = dd;
						break;
					}
				}
				if (diary == null) {
					diary = new DiaryData(med.getName());
					diary.setMedId(med.getId());
					rc.add(diary);
				}
				/*
				 * String key = DiaryDataItem.convDate(date); Long len = 0L; if
				 * (days.containsKey(key)) { len = days.get(key); }
				 * 
				 * for (long i = 0; i < count; i++) { diary.getItems().add(new
				 * DiaryDataItem(date, len + i + 1)); }
				 * 
				 * days.put(key, len + count);
				 */
				diary.getItems().add(new DiaryDataItem(date, count));
			}
		}

		if (rc.size() > 0) {
			for (DiaryData diary : rc) {
				diary.getItems().add(0, new DiaryDataItem(startDate, null));
				diary.getItems().add(new DiaryDataItem(endDate, null));
			}
		}

		long milis = endDate.getTime() - startDate.getTime();

		Date today = new Date();
		if (rc.size() == 0 && endDate.after(today)) {
			model.addAttribute("diarydata_exists", false);
		} else {
			model.addAttribute("diarydata_exists", true);
		}
		model.addAttribute("diarydata", rc);
		model.addAttribute("selected_days", milis / (24 * 3600 * 1000L) + 1);
	}

	private void prepareKpi(DataHolder data, Model model, User patient, Disease disease) {
		//find kpitype
		if (disease == null) {
			return;
		}

		Date dateFrom = data.getDateFrom();
		Date dateTo = data.getDateTo();

		List<KeyPerformanceIndicatorType> kpis = keyPerformanceIndicatorTypeService.findAll(disease.getId());

		if (kpis == null || kpis.size() == 0) {
			return;
		}

		List<Object[]> result = new ArrayList<Object[]>();
		model.addAttribute("kpis", result);

		for (KeyPerformanceIndicatorType kpi : kpis) {
			Object[] re = new Object[4];
			boolean add = false;
			re[0] = kpi;
			//model.addAttribute("kpi_title", kpi.getDescription());
			//model.addAttribute("kpi_code", kpi.getCode());
			//Patient patient = data.getPatient();
			BigDecimal kpiResult = patientKPIService.computeKPI(patient.getId(), kpi.getId(), dateFrom, dateTo);
			if (kpiResult != null) {
				double rounded = Math.round(kpiResult.doubleValue() * 100.0) / 100.0;
				//model.addAttribute("kpi_value", rounded);
				re[1] = rounded;
				add = true;
			}

			//calculated
			List<KeyPerformanceIndicatorStatistics> kpiData = patientKPIService.computeKPITimeline(patient.getId(), kpi.getId(), data.getDateFrom(),
					data.getDateTo());
			//data
			//double
			if (kpiData != null) {
				List<String> rc = new ArrayList<String>();
				rc.add(AbstractPrepareChartData.getDateInfo(data.getDateFrom(), -1, null, null));
				for (KeyPerformanceIndicatorStatistics obj : kpiData) {
					rc.add(AbstractPrepareChartData.getDateInfo(obj.getDate(), 0, obj.getValue().toString().replace(',', '.'), null));
				}
				rc.add(AbstractPrepareChartData.getDateInfo(data.getDateFrom(), 1, null, null));
				re[2] = rc;
				add = true;
			}

			//modified for chart 
			if (data.getType() == UserType.D) {
				List<PatientKeyPerformanceIndicatorValidation> cdais = patientKPIValidationService.findValidatedValues(data.getPatient().getId(), kpi.getId(),
						data.getDateFrom(), data.getDateTo());
				List<String> result2 = new ArrayList<String>();
				model.addAttribute("modified_kpi", result2);

				result2.add(AbstractPrepareChartData.getDateInfo(data.getDateFrom(), -1, null, null));
				for (PatientKeyPerformanceIndicatorValidation validation : cdais) {
					if (validation.getValue() != null) {
						result2.add(AbstractPrepareChartData.getDateInfo(validation.getLogDate(), 0,
								Double.toString(Math.round(validation.getValue().doubleValue() * 100.0) / 100.0).replace(',', '.'), null));
					}
				}
				result2.add(AbstractPrepareChartData.getDateInfo(data.getDateFrom(), 1, null, null));
				re[3] = result2;
				add = true;
			}
			if (add) {
				result.add(re);
			}
		}
	}

	private String getChartProperties() {
		String cp = "backgroundColor: \"#F5F5F5\"," + "borderColor: \"#000000\"," + "borderRadius: 10," + "borderWidth: 0,"
				+ "plotBackgroundColor: \"#FFFFFF\"," + "shadow: true";

		return cp;
	}

	private String getPieChartProperties() {
		String cp = "backgroundColor: \"#F5F5F5\"," + "borderColor: \"#000000\"," + "borderRadius: 10," + "borderWidth: 0,"
				+ "plotBackgroundColor: \"#F5F5F5\"," + "shadow: true";

		return cp;
	}

	/**
	 * @param request
	 * @param model
	 * @param date_from
	 * @param date_to
	 */
	public static void changeDatePreddefined(HttpServletRequest request, Model model, String date_from, String date_to) {
		DataHolder data = new DataHolder(request);
		if (StringUtils.isNotBlank(date_from)) {
			data.setDateFrom(DateUtils.str2date(date_from));
		}
		if (StringUtils.isNotBlank(date_to)) {
			data.setDateTo(DateUtils.str2date(date_to));
		}
	}

}
