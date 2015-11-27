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
package com.mobileman.projecth.web.controller.patient;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mobileman.projecth.business.ConfigurationService;
import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.MedicationService;
import com.mobileman.projecth.business.PatientMedicationService;
import com.mobileman.projecth.domain.data.id_types.PznBarcode;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.medicine.Medication;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.patient.medication.PatientMedication;
import com.mobileman.projecth.domain.util.medication.MedicationFrequency;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.DiaryData;
import com.mobileman.projecth.web.model.DiaryDataItem;
import com.mobileman.projecth.web.model.patient.medication.ConsumedMedication;
import com.mobileman.projecth.web.service.LocaleService;
import com.mobileman.projecth.web.service.PatientDataService;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.KeepScroll;
import com.mobileman.projecth.web.util.NumUtils;
import com.mobileman.projecth.web.util.ViewState;

@Controller
public class MedikamenteController extends AbstractPatientController {
	
	/**
	 * @author mobileman
	 *
	 */
	public class MedicationFrequencyInfo {
		private final LocaleService localeService;
		private final MedicationFrequency frequency;
		
		/**
		 * @param frequency
		 * @param localeService
		 */
		public MedicationFrequencyInfo(MedicationFrequency frequency,  LocaleService localeService) {
			this.localeService = localeService;
			this.frequency = frequency;			
		}
		
		/**
		 * @return name
		 */
		public String getName() {
			final String name;
			switch (getFrequency()) {
    		case BI_WEEKLY:
    			name = localeService.getMedicationFrequencyBiWeekly();
    			break;
    		case WEEKLY:
    			name = localeService.getMedicationFrequencyWeekly();
    			break;
    		case ONE_TIME:
    			name = localeService.getMedicationFrequencyOneTime();
    			break;
    		case DAILY:
    			name = localeService.getMedicationFrequencyDaily();
    			break;
    		default:
    			name = localeService.getUnknowMessage();
    			break;
    		}
			return name;
		}
		
		/**
		 * @return frequency
		 */
		public MedicationFrequency getFrequency() {
			return this.frequency;
		}
	}
	
	@Autowired
	private LocaleService localeService;

	@Autowired
	PatientMedicationService patientMedicationService;

	@Autowired
	MedicationService medicationService;

	@Autowired
	DiseaseService diseasService;

	@RequestMapping(method = RequestMethod.GET, value = "/patient/medikamente")
	public String medicamenteGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		// chart
		DataHolder holder = new DataHolder(request);

		Date startDate = null;
		Date endDate = null;
		startDate = DateUtils.addDays(holder.getDateFrom(), -1);
		endDate = DateUtils.addDays(holder.getDateTo(), 1);
		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();
		List<Object[]> data = patientMedicationService.findConsumedMedicationsDiary(patient.getId(), holder.getDateFrom(), holder.getDateTo());

		List<DiaryData> rc = new ArrayList<DiaryData>();
		if (data != null) {
			for (Object[] o : data) {
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

		model.addAttribute("diarydata", rc);
		model.addAttribute("selected_days", milis / (24 * 3600 * 1000L) + 1);
		model.addAttribute("patientMedication", null);

		model.addAttribute("date_from", DateUtils.date2str(startDate));
		model.addAttribute("date_to", DateUtils.date2str(endDate));

		model.addAttribute("diseases", patient.getDiseases());
		model.addAttribute("selectedDiseaseId", dataHolder.getDiseaseId());

		return "patient/medikamente";
	}

	private void setupFields(Model model, String name, PznBarcode pzn, String units) {
		model.addAttribute("name", name);
		model.addAttribute("pzn", pzn != null ? pzn.getNumber() : null);
		model.addAttribute("unitssize", units);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/medikamente_eingeben")
	public String medicamenteEingebenGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		// prepare data
		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();

		if (dataHolder.getDiseaseId() != null) {
			model.addAttribute("historymed", patientMedicationService.findAllConsumedMedications(patient.getId(), dataHolder.getDiseaseId()));
		}

		model.addAttribute("diseases", patient.getDiseases());
		final String consumptionDate = DateUtils.normalDate2Str(new Date());
		model.addAttribute("consum_start_date", consumptionDate);
		model.addAttribute("consum_end_date", consumptionDate);

		String selectedHistoryMedication = request.getParameter("selecthistory");
		model.addAttribute("selected_history_medication", selectedHistoryMedication);
		if (StringUtils.isBlank(selectedHistoryMedication)) {
			model.addAttribute("selected_history_medication", "-1");
		} else {
			model.addAttribute("selected_history_medication", selectedHistoryMedication);
		}
		
		List<MedicationFrequencyInfo> medication_frequencies = getMedicationFrequencies();
		model.addAttribute("medication_frequencies", medication_frequencies);

		return "patient/medikamente_eingeben";
	}

	/**
	 * 
	 */
	private List<MedicationFrequencyInfo> getMedicationFrequencies() {
		List<MedicationFrequencyInfo> result = new ArrayList<MedikamenteController.MedicationFrequencyInfo>();
		
		for (MedicationFrequency frequency : MedicationFrequency.values()) {
			result.add(new MedicationFrequencyInfo(frequency, localeService));
		}
		
		return result;
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @param patientMedicationId
	 * @return "patient/medikamente_eingeben"
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/medikamente_eingeben/{patientMedicationId}")
	public String medicamenteEditGet(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable Long patientMedicationId) {
		// prepare data
		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();

		PatientMedication patientMedication = patientMedicationService.findById(patientMedicationId);
		model.addAttribute("patientMedication", patientMedication);
		model.addAttribute("patientMedicationId", patientMedicationId);
		model.addAttribute("historymed", patientMedicationService.findAllConsumedMedications(patient.getId(), dataHolder.getDiseaseId()));
		model.addAttribute("diseases", patient.getDiseases());

		setupFields(model, patientMedication.getMedication().getName(), patientMedication.getMedication().getPzn(), patientMedication.getMedication()
				.getStandardUnitSize());
		model.addAttribute("comment", patientMedication.getComment());
		model.addAttribute("selectedUnits", "" + patientMedication.getAmount().intValue());
		final String consumptionDate = DateUtils.normalDate2Str(patientMedication.getConsumptionDate());
		model.addAttribute("consum_start_date", consumptionDate);
		model.addAttribute("consum_end_date", consumptionDate);
		model.addAttribute("selected_disease_code", patientMedication.getDisease().getCode());

		return "patient/medikamente_eingeben";
	}

	/**
	 * Called to change disease
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return medicamenteGet
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/patient/medikamente/change_disease")
	public String medicamenteChangeDisease(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
		DataHolder holder = new DataHolder(request);
		String selectedDiseaseStr = request.getParameter("selectDisease");
		Long diseaseId = NumUtils.convert2long(selectedDiseaseStr);
		holder.setDiseaseId(diseaseId);
		return medicamenteGet(request, response, model);
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/medikamente_eingeben")
	public String medicamentePost(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
		KeepScroll.save(request, model);
		// save request parameters into map
		request.setCharacterEncoding("UTF-8");
		ViewState.copyViewState(request, model);
		String diseaseCode = request.getParameter("selectdisease");
		model.addAttribute("selected_disease_code", diseaseCode);

		String selectunits = request.getParameter("selectunits");
		model.addAttribute("selectedUnits", selectunits);

		String takingFrequnecyStr = request.getParameter("select_taking_frequency");
		model.addAttribute("select_taking_frequency", takingFrequnecyStr);
		MedicationFrequency medicationFrequency = (takingFrequnecyStr == null || takingFrequnecyStr.equals("0")) ? null
				: MedicationFrequency.valueOf(takingFrequnecyStr);

		String selectedHistoryMedication = request.getParameter("selecthistory");
		model.addAttribute("selected_history_medication", selectedHistoryMedication);

		Long patientMedicationId = NumUtils.convert2long(request.getParameter("patientMedicationId"));
		if (patientMedicationId != null) {
			return medicamenteEditPost(request, response, model, patientMedicationId);
		}

		boolean error = false;

		if (StringUtils.isNotBlank(request.getParameter("search.x"))) {
			model.addAttribute("wasSearch", true);
			// search
			//
			String filter = request.getParameter("filter");
			List<Medication> medications = null;
			try {
				if (StringUtils.isNotBlank(filter)) {
					medications = medicationService.findAllByNameOrPzn(filter, Locale.GERMANY);
				} else {
					// error
					model.addAttribute("errorsearchnodata", true);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				model.addAttribute("errorsearch", true);
			}
			// clear fields
			setupFields(model, null, null, null);
			if (medications != null) {
				// store result
				// if zero clear text boxes
				// if only one save into text boxes
				// if more fill list
				if (medications.size() == 0) {
					model.addAttribute("infosearchnotfound", true);
				} else if (medications.size() == 1) {
					Medication tmp = medications.get(0);
					setupFields(model, tmp.getName(), tmp.getPzn(), tmp.getStandardUnitSize());
					// setup fields
				} else if (medications.size() > 1) {
					// fill combo
					model.addAttribute("searchresult", medications);
				}
			}
		} else {

			model.addAttribute("wasEnter", true);
			Long medid = null;
			// find for mednumer
			String pzn = request.getParameter("pzn");
			try {

				Medication med = medicationService.findByPzn(pzn, Locale.GERMANY);
				if (med != null) {
					medid = med.getId();
				}
			} catch (Exception e) {
			}

			if (medid == null) {
				// insert new medicine
				String name = request.getParameter("name");
				String units = request.getParameter("unitssize");

				if (StringUtils.isBlank(name)) {
					error = true;
					model.addAttribute("errorname", true);
				}
				if (StringUtils.isBlank(units)) {
					error = true;
					model.addAttribute("errorunits", true);
				}

				if (!error) {
					try {
						Medication med = new Medication();
						med.setLocale(Locale.GERMANY);
						med.setName(name);
						if (pzn != null && pzn.trim().length() > 0) {
							med.setPzn(new PznBarcode());
							med.getPzn().setNumber(pzn);
						}

						med.setCreatedatetime(new Date());
						med.setStandardUnitSize(units);
						medid = medicationService.save(med);
					} catch (Exception e) {
						// show error
						model.addAttribute("erroraddmed", true);
					}
				}
			}

			Double units = NumUtils.convert2double(selectunits);
			if (units == null) {
				model.addAttribute("errorselectunits", true);
				error = true;
			}

			if (StringUtils.isBlank(diseaseCode) || "0".equals(diseaseCode)) {
				model.addAttribute("errordisease", true);
				error = true;
			}

			if (medicationFrequency == null) {
				model.addAttribute("error_taking_frequency", true);
				error = true;
			}

			String startDateStr = request.getParameter("consum_start_date");
			String endDateStr = request.getParameter("consum_end_date");

			Date dateStart = DateUtils.normalStr2date(startDateStr);
			Date endDate = DateUtils.normalStr2date(endDateStr);
			if (dateStart == null) {
				model.addAttribute("error_consum_start_date", true);
				error = true;
			}

			if (endDate == null) {
				model.addAttribute("error_consum_end_date", true);
				error = true;
			}

			if (dateStart != null && endDate != null) {
				if (endDate.before(dateStart)) {
					model.addAttribute("error_consum_end_date", true);
					error = true;
				}
			}

			String comment = request.getParameter("comment");

			if (!error && medid != null) {
				Disease disease = diseasService.findByCode(diseaseCode);
				Patient patient = new DataHolder(request).getPatient();
				
				try {
					patientMedicationService.addConsumedMedication(patient.getId(), disease.getId(), medid, units,
							medicationFrequency, dateStart, endDate, comment);

					model.addAttribute("infoconsume", true);
				} catch (Exception ex) {
					model.addAttribute("errorconsume", true);
				}
			}
		}

		String result = medicamenteEingebenGet(request, response, model);
		if (!error) {
			setupFields(model, null, null, null);
		}

		return result;
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @param patientMedicationId
	 * @return
	 */
	private String medicamenteEditPost(HttpServletRequest request, HttpServletResponse response, Model model, Long patientMedicationId) {
		PatientMedication patientMedication = patientMedicationService.findById(patientMedicationId);
		model.addAttribute("wasEnter", true);

		String diseaseCode = request.getParameter("selectdisease");
		BigDecimal units = NumUtils.convert2decimal(request.getParameter("selectunits"));
		boolean error = false;
		if (units == null) {
			model.addAttribute("errorselectunits", true);
			error = true;
		}

		if (StringUtils.isBlank(diseaseCode) || "0".equals(diseaseCode)) {
			model.addAttribute("errordisease", true);
			error = true;
		}

		String startDateStr = request.getParameter("consum_start_date");

		if (StringUtils.isBlank(startDateStr)) {
			model.addAttribute("error_consum_start_date", true);
			error = true;
		}

		Date dateStart = DateUtils.normalStr2date(startDateStr);
		String comment = request.getParameter("comment");

		if (!error) {

			try {
				Disease disease = diseasService.findByCode(diseaseCode);
				patientMedication.setDisease(disease);
				patientMedication.setComment(comment);
				patientMedication.setAmount(units);
				patientMedication.setConsumptionDate(dateStart);
				patientMedicationService.update(patientMedication);

				model.addAttribute("infoconsume", true);
			} catch (Exception ex) {
				model.addAttribute("errorconsume", true);
			}
		}

		return medicamenteEditGet(request, response, model, patientMedicationId);
	}

	/**
	 * Called to change date (time window)
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param len
	 * @param type
	 * @return medicamenteGet
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/medikamente/date/{len}-{type}")
	public String medikamenteChangeDate(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable Integer len,
			@PathVariable String type) {
		PatientDataService.changeDatePreddefined(request, model, len, type);
		return medicamenteGet(request, response, model);
	}

	/**
	 * Called to change date (time window) from calendar
	 * 
	 * @param request
	 * @param model
	 * @param d_from
	 * @param d_to
	 * @return medicamenteGet
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/patient/medikamente_date")
	public String changeDateMedikamente(HttpServletRequest request, Model model, @RequestParam String d_from, @RequestParam String d_to) {
		PatientDataService.changeDatePreddefined(request, model, d_from, d_to);
		return medicamenteGet(request, null, model);
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return "/patient/medikamente_journal"
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/medikamente_journal")
	public String medikamenteJournalsichtGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		final DataHolder dataHolder = new DataHolder(request);
		final Patient patient = dataHolder.getPatient();
		List<ConsumedMedication> medications = Collections.emptyList();
		if (dataHolder.getDiseaseId() != null) {
			List<Object[]> medicationData = patientMedicationService.findAllConsumedMedicationsForDisease(patient.getId(), dataHolder.getDiseaseId());
			medications = new ArrayList<ConsumedMedication>();
			for (Object[] data : medicationData) {
				medications.add(new ConsumedMedication((Long) data[0], (Date) data[1], (String) data[2], (BigDecimal) data[3]));
			}
		}

		model.addAttribute("medications", medications);

		return "/patient/medikamente_journal";
	}
}
