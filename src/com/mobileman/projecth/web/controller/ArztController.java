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
package com.mobileman.projecth.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobileman.projecth.business.ConfigurationService;
import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.DoctorService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.UserConnectionService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.business.index.country.CountryService;
import com.mobileman.projecth.business.index.kpi.KeyPerformanceIndicatorTypeService;
import com.mobileman.projecth.business.patient.PatientKPIService;
import com.mobileman.projecth.business.questionary.QuestionService;
import com.mobileman.projecth.business.questionary.QuestionTypeService;
import com.mobileman.projecth.business.user.message.MessageService;
import com.mobileman.projecth.domain.data.Address;
import com.mobileman.projecth.domain.data.Gender;
import com.mobileman.projecth.domain.data.MedicalInstitution;
import com.mobileman.projecth.domain.data.Name;
import com.mobileman.projecth.domain.data.PhoneNumber;
import com.mobileman.projecth.domain.data.id_types.PostalCode;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.doctor.Doctor;
import com.mobileman.projecth.domain.dto.patient.kpi.KeyPerformanceIndicatorStatistics;
import com.mobileman.projecth.domain.index.country.Country;
import com.mobileman.projecth.domain.index.kpi.KeyPerformanceIndicatorType;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.questionary.Answer;
import com.mobileman.projecth.domain.questionary.Answer.Kind;
import com.mobileman.projecth.domain.questionary.CustomQuestion;
import com.mobileman.projecth.domain.questionary.Question;
import com.mobileman.projecth.domain.questionary.QuestionType;
import com.mobileman.projecth.domain.questionary.QuestionType.AnswerDataType;
import com.mobileman.projecth.domain.questionary.QuestionType.Type;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.domain.user.message.Message;
import com.mobileman.projecth.domain.user.message.MessageGroupType;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.FragebogenAnnpasenData;
import com.mobileman.projecth.web.model.FragebogenAnnpasenData.FragebogenAnnpasenDataHolder;
import com.mobileman.projecth.web.model.doctor.PatientsCountByDisease;
import com.mobileman.projecth.web.model.doctor.PatientsCountByGendersByDisease;
import com.mobileman.projecth.web.model.doctor.PatientsCountsByAgeByDisease;
import com.mobileman.projecth.web.model.doctor.PatientsKpiAverageScoreTimelineByDisease;
import com.mobileman.projecth.web.model.doctor.PatientsKpiAverageScoresByDisease;
import com.mobileman.projecth.web.service.LocaleService;
import com.mobileman.projecth.web.service.PatientDataService;
import com.mobileman.projecth.web.util.ConnectionsHelper;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.NumUtils;
import com.mobileman.projecth.web.util.PersistentCookieHelper;
import com.mobileman.projecth.web.util.UserUtils;

@Controller
public class ArztController extends AbstractController {

	@Autowired
	UserService userService;

	@Autowired
	PatientService patientService;

	@Autowired
	DoctorService doctorService;

	@Autowired
	PatientDataService patientData;

	@Autowired
	LoginController loginController;

	@Autowired
	ConnectionsHelper connectionsHelper;

	@Autowired
	CountryService countryService;

	@Autowired
	QuestionTypeService questionTyperService;

	@Autowired
	QuestionService questionService;

	@Autowired
	MessageService messageService;

	@Autowired
	UserConnectionService userConnectionService;

	@Autowired
	KeyPerformanceIndicatorTypeService keyPerformanceIndicatorTypeService;

	@Autowired
	private LocaleService localeService;

	@Autowired
	DiseaseService diseaseService;

	@Autowired
	private ConfigurationService configurationService;

	@Autowired
	private PatientKPIService patientKPIService;

	public ArztController() {
		super("arzt");
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt")
	public String getStartPage(HttpServletRequest request, Model model) {
		return getDoctorOverview(request, model);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/{page}")
	public String getPage(HttpServletRequest request, Model model, @PathVariable String page) {
		if ("index".equals(page)) {
			return getIndex(request, model, null, null);
		}

		return processPage(request.getSession().getServletContext(), page);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/index/print")
	public String getPage(HttpServletRequest request, Model model) {
		model.addAttribute("print", true);
		return getIndex(request, model, null, null);
	}

	@RequestMapping(method = RequestMethod.POST, value = "/arzt/kpi/{kpiId}")
	public String changeCdai(HttpServletRequest request, Model model, @RequestParam String kpi, @PathVariable String kpiId) {
		patientData.changeKpi(request, model, kpi, kpiId);
		return getIndex(request, model, null, null);
	}

	@RequestMapping(method = RequestMethod.POST, value = "/arzt/changedate")
	public String changeDate(HttpServletRequest request, Model model, @RequestParam String d_from, @RequestParam String d_to) {
		patientData.changeDate(request, model, d_from, d_to);
		return getIndex(request, model, null, null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/date/{len}-{type}")
	public String changeDatePreddefined(HttpServletRequest request, Model model, @PathVariable Integer len, @PathVariable String type) {
		PatientDataService.changeDatePreddefined(request, model, len, type);
		patientData.prepareData(request, model, null, null);
		return getIndex(request, model, null, null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/{patientId}/{diseaseId}")
	public String getIndex(HttpServletRequest request, Model model, @PathVariable String patientId, @PathVariable String diseaseId) {
		DataHolder data = new DataHolder(request);
		if (data.getType() != UserType.D || !data.isDoctor()) {
			return "redirect:/behandlung";
		}

		prepareData(request, model, data, patientId, diseaseId);
		return processPage(request.getSession().getServletContext(), "patients_overview");
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/fragebogen_anpassen")
	public String getStartFragebogenAnpassen(HttpServletRequest request, Model model) {
		DataHolder data = new DataHolder(request);
		prepareData(request, model, data, null, null);

		HttpSession session = request.getSession();
		new FragebogenAnnpasenData(session).clearData();

		Doctor doctor = data.getDoctor();
		Patient patient = data.getPatient();
		Disease disease = data.getDisease();

		if (patient != null && disease != null) {
			List<CustomQuestion> customQuestions = patientService.findCustomQuestions(patient.getId(), disease.getId());

			model.addAttribute("user", doctor);
			model.addAttribute("userdefaultname", "patient");
			model.addAttribute("patient", patient);
			model.addAttribute("disease", disease);
			model.addAttribute("customQuestions", customQuestions);
		}

		return "arzt/fragebogen_anpassen";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/fragebogen_anpassen/{patientId}/{diseaseId}")
	public String getFragebogenAnpassen(HttpServletRequest request, Model model, @PathVariable String patientId, @PathVariable String diseaseId) {
		DataHolder data = new DataHolder(request);
		prepareData(request, model, data, patientId, diseaseId);

		HttpSession session = request.getSession();
		new FragebogenAnnpasenData(session).clearData();

		Doctor doctor = data.getDoctor();
		Patient patient = data.getPatient();
		Disease disease = data.getDisease();

		if (patient != null && disease != null) {
			List<CustomQuestion> customQuestions = patientService.findCustomQuestions(patient.getId(), disease.getId());

			model.addAttribute("user", doctor);
			model.addAttribute("userdefaultname", "patient");
			model.addAttribute("patient", patient);
			model.addAttribute("disease", disease);
			model.addAttribute("customQuestions", customQuestions);

		}

		return "arzt/fragebogen_anpassen";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/save_fragebogen_anpassen")
	public @ResponseBody
	String saveFragebogenAnnpassen(HttpServletRequest request, Model model) {
		String result = "";

		// save into session
		FragebogenAnnpasenData fragebogenAnnpasendata = new FragebogenAnnpasenData(request.getSession());
		fragebogenAnnpasendata.storeData(request);

		FragebogenAnnpasenDataHolder holder = fragebogenAnnpasendata.getData();
		Map<Long, Map<String, Object>> fragebogenAnnpasenDataHolderdata = holder.getData();

		DataHolder dataHolder = new DataHolder(request);
		Doctor doctor = dataHolder.getDoctor();
		Patient patient = dataHolder.getPatient();
		Disease disease = dataHolder.getDisease();

		Long doctorId = doctor.getId();
		Long patientId = patient.getId();
		Long diseaseId = disease.getId();

		Iterator it = fragebogenAnnpasenDataHolderdata.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();

			Map<String, Object> question = (Map<String, Object>) entry.getValue();

			String questionIdString = (String) question.get("question_id");
			String questionTypeString = (String) question.get("type");
			String questionActionString = (String) question.get("action");
			String questionTextString = (String) question.get("question");
			String questionExplanationString = (String) question.get("explanation");
			Map<Long, String> questionOptions = (Map<Long, String>) question.get("option");

			QuestionType questionType = null;
			boolean editQuestionType = false;
			// yes/no question
			if (questionTypeString.equals("0")) {
				//find standart yes/no question type
				questionType = findQuestionType(Type.SINGLE_CHOICE_LIST, AnswerDataType.BOOLEAN);
			}
			// multiple choice question
			if (questionTypeString.equals("1")) {
				editQuestionType = true;
				//new question type
				questionType = new QuestionType();
				questionType.setUser(doctor);
				questionType.setType(Type.SINGLE_CHOICE_LIST);
				questionType.setAnswerDataType(AnswerDataType.TEXT);
				List<Answer> answers = new ArrayList<Answer>();
				Answer answer = null;

				//NO ANSWER

				answer = new Answer();
				answer.setAnswer("Kaine Angabe");
				answer.setSortOrder(answers.size());
				answer.setKind(Kind.NO_ANSWER);
				answer.setQuestionType(questionType);
				answers.add(answer);

				Iterator optionIt = questionOptions.entrySet().iterator();
				while (optionIt.hasNext()) {
					Map.Entry optionEntry = (Map.Entry) optionIt.next();

					Long optionOrder = (Long) optionEntry.getKey();
					String option = (String) optionEntry.getValue();

					answer = new Answer();
					answer.setAnswer(option);
					answer.setSortOrder(optionOrder.intValue());
					answer.setKind(Kind.DEFAULT);
					answer.setQuestionType(questionType);
					answers.add(answer);
				}
				questionType.setAnswers(answers);
			}
			// text question
			if (questionTypeString.equals("2")) {
				//find standart text question type
				questionType = findQuestionType(Type.SINGLE_ANSWER_ENTER, AnswerDataType.TEXT);
			}

			String explanationText = null;
			if (!questionExplanationString.isEmpty()) {
				explanationText = questionExplanationString;
			}

			if (!questionIdString.isEmpty()) {
				if (questionActionString.equals("EDIT")) {

					Question customQuestion = questionService.findById(Long.valueOf(questionIdString));
					customQuestion.setExplanation(explanationText);
					customQuestion.setText(questionTextString);

					if (editQuestionType) {
						questionType.getAnswers().remove(0);

						List<Answer> customQuestionAnswers = customQuestion.getQuestionType().getAnswers();
						for (int index = 0; index < customQuestionAnswers.size(); index++) {
							Answer customQuestionAnswer = customQuestionAnswers.get(index);
							customQuestionAnswer.setAnswer(questionType.getAnswers().get(index).getAnswer());
						}
					}
					questionService.update(customQuestion);
					result = "ok";
				}
				if (questionActionString.equals("DELETE")) {
					try {
						questionService.deleteCustomQuestion(Long.valueOf(questionIdString));
						result = "ok";
					} catch (Exception e) {
						result = "error";
					}
				}
			} else {
				Long newId = null;
				if (questionType.getId() != null) {
					newId = doctorService.addCustomQuestion(doctor.getId(), patientId, diseaseId, questionTextString, explanationText, questionType.getId());
				} else {
					newId = doctorService.addCustomQuestion(doctor.getId(), patientId, diseaseId, questionTextString, explanationText, questionType);
				}
				result = newId.toString();
			}
		}

		return result;
	}

	private QuestionType findQuestionType(Type type, AnswerDataType answerDataType) {
		QuestionType result = null;
		result = questionTyperService.find(type, answerDataType);
		return result;
	}

	void prepareData(HttpServletRequest request, Model model, DataHolder data, String patientId, String diseaseId) {
		Doctor doctor = data.getDoctor();
		model.addAttribute("doctor", doctor);

		if (patientId != null) {
			data.setPatientId(NumUtils.convert2long(patientId));
		} else {
			patientId = data.getPatient() != null ? data.getPatient().getId().toString() : null;
		}

		if (diseaseId != null) {
			data.setDiseaseId(NumUtils.convert2long(diseaseId));
		} else {
			diseaseId = data.getDiseaseId() != null ? data.getDiseaseId().toString() : null;
		}

		patientData.prepareData(request, model, doctor, patientId, diseaseId);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/einstellungen")
	public String settingsGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		return settingsGetInternal(request, response, model);
	}

	public String settingsGetInternal(HttpServletRequest request, HttpServletResponse response, Model model) {

		Doctor doctor = new DataHolder(request).getDoctor();
		model.addAttribute("doctor", doctor);
		try {
			model.addAttribute("country", doctor.getMedicalInstitution().getCountry().getCode());
		} catch (Exception ex) {
		}

		List<Disease> diseases = diseaseService.findAll();

		if (doctor.getDiseases() != null && doctor.getDiseases().size() > 0) {
			Iterator<Disease> it = diseases.iterator();
			while (it.hasNext()) {
				Disease disease = it.next();
				for (Disease patientDisease : doctor.getDiseases()) {
					if (patientDisease.getId().equals(disease.getId())) {
						it.remove();
						break;
					}
				}
			}
		}

		model.addAttribute("diseases", diseases);

		return "arzt/einstellungen";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/einstellungen_passwort")
	public String settingsGetPasswort(HttpServletRequest request, HttpServletResponse response, Model model) {
		return settingsGetInternalPassword(request, response, model, null);
	}

	public String settingsGetInternalPassword(HttpServletRequest request, HttpServletResponse response, Model model, Boolean autoLogin) {
		if (autoLogin != null) {
			if (autoLogin) {
				model.addAttribute("autologinenabled", true);
			}
		} else if (new PersistentCookieHelper().getUser(userService, request, response) != null) {
			//auto login enabled
			model.addAttribute("autologinenabled", true);
		}

		Doctor doctor = new DataHolder(request).getDoctor();
		model.addAttribute("doctor", doctor);

		if (doctor.isConnectionRequestsBlocked()) {
			model.addAttribute("requestblocked", true);
		}

		return "arzt/einstellungen_passwort";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/arzt/settings")
	@Transactional
	public String settingsChange(HttpServletRequest request, HttpServletResponse response, Model model) {

		try {
			String nameOfInstitution = request.getParameter("nameofinstitution");
			String title = request.getParameter("title");
			String namename = request.getParameter("namename");
			String surname = request.getParameter("surname");
			String address = request.getParameter("address");
			String nr = request.getParameter("nr");
			String postcode = request.getParameter("postcode");
			String place = request.getParameter("place");
			String country = request.getParameter("country");
			String telefonCountryCode = request.getParameter("telefoncountrycode");
			String telefon = request.getParameter("telefonnumber");
			String faxCountryCode = request.getParameter("faxcountrycode");
			String fax = request.getParameter("faxnumber");
			String homepage = request.getParameter("homepage");

			if (StringUtils.isBlank(nameOfInstitution)) {
				nameOfInstitution = null;
			}
			if (StringUtils.isBlank(title)) {
				title = null;
			}
			if (StringUtils.isBlank(namename)) {
				namename = null;
			}
			if (StringUtils.isBlank(surname)) {
				surname = null;
			}
			if (StringUtils.isBlank(address)) {
				address = null;
			}
			if (StringUtils.isBlank(nr)) {
				nr = null;
			}
			if (StringUtils.isBlank(postcode)) {
				postcode = null;
			}
			if (StringUtils.isBlank(place)) {
				place = null;
			}
			if (StringUtils.isBlank(country)) {
				country = null;
			}
			if (StringUtils.isBlank(telefonCountryCode)) {
				telefonCountryCode = null;
			}
			if (StringUtils.isBlank(telefon)) {
				telefon = null;
			}
			if (StringUtils.isBlank(faxCountryCode)) {
				faxCountryCode = null;
			}
			if (StringUtils.isBlank(fax)) {
				fax = null;
			}
			if (StringUtils.isBlank(homepage)) {
				homepage = null;
			}

			Doctor doctor = new DataHolder(request).getDoctor();

			Name name = new Name(namename, surname);
			doctor.setName(name);
			MedicalInstitution medicalInstitution = new MedicalInstitution();
			medicalInstitution.setName(nameOfInstitution);
			Address add = new Address();
			add.setAddress(address);
			add.setNumber(nr);
			add.setPlace(place);
			PostalCode postalCode = new PostalCode();
			postalCode.setCode(postcode);
			add.setPostalCode(postalCode);
			medicalInstitution.setAddress(add);

			Country countr = findCountryIndex(country);
			medicalInstitution.setCountry(countr);
			PhoneNumber phoneNumber = new PhoneNumber();
			phoneNumber.setCountryCode(telefonCountryCode);
			phoneNumber.setNumber(telefon);
			PhoneNumber faxNumber = new PhoneNumber();
			faxNumber.setCountryCode(faxCountryCode);
			faxNumber.setNumber(fax);
			medicalInstitution.setPhoneNumber(phoneNumber);
			medicalInstitution.setFaxNumber(faxNumber);
			medicalInstitution.setHomePageUrl(homepage);
			doctor.setMedicalInstitution(medicalInstitution);
			doctor.setTitle(title);
			userService.update(doctor);

			//diseases
			UserUtils.saveDiseases(request, doctor, userService, diseaseService);
			model.addAttribute("base_settings_saved", Boolean.TRUE);

		} catch (Exception e) {
			model.addAttribute("base_settings_save_error", Boolean.TRUE);
			model.addAttribute("base_settings_save_error_message", e.getMessage());
		}

		return settingsGetInternal(request, response, model);
	}

	private Country findCountryIndex(String code) {
		Country result = null;
		if (!code.isEmpty()) {
			result = countryService.findByCode(code);
		}
		return result;
	}

	@RequestMapping(method = RequestMethod.POST, value = "/arzt/settings_password")
	public String settingsChangePassword(HttpServletRequest request, HttpServletResponse response, Model model) {
		Doctor doctor = new DataHolder(request).getDoctor();
		UserUtils.changePassword(doctor, request, model, userService, configurationService);
		boolean autoLogin = UserUtils.changeAutologin(doctor, request, response);
		String value = request.getParameter("requestblocked");
		boolean blocked = false;
		if (StringUtils.isNotBlank(value)) {
			blocked = true;
		}
		doctor.setConnectionRequestsBlocked(blocked);
		userService.setConnectionRequestsBlocked(doctor.getId(), blocked);
		return settingsGetInternalPassword(request, response, model, autoLogin);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/konto_endgueltig_loeschen")
	public String deletePatient(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("doctor", new DataHolder(request).getDoctor());
		return "arzt/konto_endgueltig_loeschen";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/konto_endgueltig_loeschen/confirm")
	public String realDeleteDoctor(HttpServletRequest request, HttpServletResponse response, Model model) {
		//real delete patient
		Long doctorId = new DataHolder(request).getDoctor().getId();
		String rc = loginController.logout(request, response);
		userService.deleteUserAccount(doctorId);
		return rc;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/meineverbindungen")
	public String initConnectons(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "arzt/" + connectionsHelper.initConnectons(request, response, model, new DataHolder(request).getDoctor().getId());
	}

	@RequestMapping(method = RequestMethod.POST, value = "/arzt/meineverbindungen")
	public String findLogin(HttpServletRequest request, Model model) {
		DataHolder holder = new DataHolder(request);
		model.addAttribute("owner", holder.getDoctor());
		return "arzt/" + connectionsHelper.findLogin(request, model, UserType.P, new DataHolder(request).getDoctor());
	}

	@ResponseBody
	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/conn/cancel/{connid}")
	public String connectionCancel(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String connid) {
		connectionsHelper.connectionCancel(request, response, model, connid, new DataHolder(request).getDoctor().getId());
		return "ok";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.GET, value = "/arzt/conn/confirm/{connid}")
	public String connectionConfirml(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String connid) {
		return "arzt/" + connectionsHelper.connectionConfirml(request, response, model, connid, new DataHolder(request).getDoctor().getId());
	}

	@Transactional
	@RequestMapping(method = RequestMethod.GET, value = "/arzt/conn/create/{userid}")
	public String connectionCreate(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String userid) {
		return "arzt/" + connectionsHelper.connectionCreate(request, response, model, userid, UserType.P, new DataHolder(request).getDoctor());
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/meineverbindungen_neue")
	public String connectionsNewGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		DataHolder holder = new DataHolder(request);
		model.addAttribute("owner", holder.getDoctor());
		return "arzt/meineverbindungen_neue";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/nachrichten")
	public String getNachrichten(HttpServletRequest request, Model model) {

		DataHolder dataHolder = new DataHolder(request);
		Doctor doctor = dataHolder.getDoctor();

		List<Message> inbox = messageService.findAll(doctor.getId(), MessageGroupType.INBOX);
		model.addAttribute("inbox", inbox);
		List<Message> outbox = messageService.findAll(doctor.getId(), MessageGroupType.OUTBOX);
		List<Long> replies = new ArrayList<Long>();
		for (Message message : outbox) {
			if (message.getInReplyToMessage() != null) {
				replies.add(message.getInReplyToMessage().getId());
			}
		}
		model.addAttribute("replies", replies);

		List<User> userConnections = new ArrayList<User>();
		//List<UserConnection> connections = userConnectionService.findConfirmedConnections(doctor.getId());
		List<UserConnection> connections = patientService.findAllByDoctor(doctor.getId());
		for (UserConnection conn : connections) {
			if (conn.getUser().getId().equals(doctor.getId())) {
				userConnections.add(conn.getOwner());
			}
			if (conn.getOwner().getId().equals(doctor.getId())) {
				userConnections.add(conn.getUser());
			}
		}
		model.addAttribute("connections", userConnections);

		return "arzt/nachrichten";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/nachrichten_versendet")
	public String getNachrichtenVersendet(HttpServletRequest request, Model model) {

		DataHolder dataHolder = new DataHolder(request);
		Doctor doctor = dataHolder.getDoctor();

		List<Message> outbox = messageService.findAll(doctor.getId(), MessageGroupType.OUTBOX);
		model.addAttribute("outbox", outbox);

		return "arzt/nachrichten_versendet";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/send_new_message")
	public @ResponseBody
	String sendMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		DataHolder dataHolder = new DataHolder(request);
		Doctor doctor = dataHolder.getDoctor();

		String result = "";
		String receiver = request.getParameter("receiver");
		String subject = request.getParameter("subject");
		String body = request.getParameter("body");
		boolean copy = Boolean.parseBoolean(request.getParameter("copy"));

		try {
			messageService.sendMessage(doctor.getId(), Long.valueOf(receiver), subject, body, copy);
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/reply_to_message")
	public @ResponseBody
	String replyMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");
		String body = request.getParameter("body");
		boolean copy = Boolean.parseBoolean(request.getParameter("copy"));

		try {
			messageService.sendReplyToMessage(Long.valueOf(messageId), body, copy);
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/mark_as_read")
	public @ResponseBody
	String markAsRead(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");

		try {
			messageService.markAsRead(Long.valueOf(messageId), true);
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/mark_as_unread")
	public @ResponseBody
	String markAsUnread(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");

		try {
			messageService.markAsRead(Long.valueOf(messageId), false);
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/delete_message")
	public @ResponseBody
	String deleteMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");

		DataHolder dataHolder = new DataHolder(request);
		Doctor doctor = dataHolder.getDoctor();

		try {
			messageService.deleteMessage(doctor.getId(), Long.valueOf(messageId));
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/arzt/mark_as_spam")
	public @ResponseBody
	String markAsSpamMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");

		try {
			messageService.markAsSpam(Long.valueOf(messageId), true);
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/arzt/patients_overview")
	public String getPatientsOverview(HttpServletRequest request, Model model) {
		DataHolder data = new DataHolder(request);
		if (data.getType() != UserType.D || !data.isDoctor()) {
			return "redirect:/behandlung";
		}

		prepareData(request, model, data, null, null);
		return "/arzt/patients_overview";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/artz/index/date/{len}-{type}")
	public String changeDateDoctorOverview(HttpServletRequest request, Model model, @PathVariable Integer len, @PathVariable String type) {
		DataHolder dataHolder = new DataHolder(request);
		PatientDataService.changeDatePreddefined(request, model, len, type);

		return getDoctorOverview(request, model);
	}

	/**
	 * @param request
	 * @param model
	 * @return "arzt/index"
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/arzt/index")
	public String getDoctorOverview(HttpServletRequest request, Model model) {
		DataHolder dataHolder = new DataHolder(request);
		Doctor doctor = dataHolder.getDoctor();
		model.addAttribute("doctor", doctor);
		model.addAttribute("date_from", DateUtils.date2str(dataHolder.getDateFrom()));
		model.addAttribute("date_to", DateUtils.date2str(dataHolder.getDateTo()));
		Date dateFrom = dataHolder.getDateFrom();
		Date dateTo = dataHolder.getDateTo();

		boolean hasData = false;
		///////////////////////////////////////////////////
		List<Object[]> data = doctorService.findPatientsCountByDisease(doctor.getId());
		List<PatientsCountByDisease> patientsCountByDiseases = new ArrayList<PatientsCountByDisease>();
		model.addAttribute("patientsCountByDiseases", patientsCountByDiseases);
		for (Object[] item : data) {
			PatientsCountByDisease pc = new PatientsCountByDisease(Number.class.cast(item[0]).intValue(), (Disease) item[1]);
			patientsCountByDiseases.add(pc);
			hasData = true;
		}

		///////////////////////////////////////////////////
		List<PatientsKpiAverageScoreTimelineByDisease> kpiStats = new ArrayList<PatientsKpiAverageScoreTimelineByDisease>();
		model.addAttribute("patientsKpiAverageScoreTimelineByDiseases", kpiStats);
		for (PatientsCountByDisease pc : patientsCountByDiseases) {
			List<KeyPerformanceIndicatorType> kpis = keyPerformanceIndicatorTypeService.findAll(pc.getDisease().getId());
			for (KeyPerformanceIndicatorType kpit : kpis) {
				List<KeyPerformanceIndicatorStatistics> statistics = patientKPIService.computeKPIAverageTimeline(kpit.getId(), dateFrom, dateTo);
				if (statistics != null && !statistics.isEmpty()) {
					PatientsKpiAverageScoreTimelineByDisease item = new PatientsKpiAverageScoreTimelineByDisease(kpit, statistics);
					kpiStats.add(item);
				}
			}
		}

		///////////////////////////////////////////////////////////////
		data = doctorService.findPatientsCountByGenderByDisease(doctor.getId());
		List<PatientsCountByGendersByDisease> patientsCountByGenderByDiseases = new ArrayList<PatientsCountByGendersByDisease>();
		model.addAttribute("patientsCountByGenderByDiseases", patientsCountByGenderByDiseases);
		for (PatientsCountByDisease pcd : patientsCountByDiseases) {
			PatientsCountByGendersByDisease stat = new PatientsCountByGendersByDisease(pcd.getDisease(), localeService);
			patientsCountByGenderByDiseases.add(stat);
			for (Object[] countItem : data) {
				if (countItem[2].equals(pcd.getDisease())) {
					int count = Number.class.cast(countItem[0]).intValue();
					stat.add(count, Gender.class.cast(countItem[1]));
				}
			}

			hasData = true;
		}

		///////////////////////////////////////////////////////////////
		data = doctorService.findPatientsCountByAgeByDisease(doctor.getId());
		List<PatientsCountsByAgeByDisease> patientsCountByAgeByDisease = new ArrayList<PatientsCountsByAgeByDisease>();
		model.addAttribute("patientsCountByAgeByDisease", patientsCountByAgeByDisease);
		for (PatientsCountByDisease pcd : patientsCountByDiseases) {
			PatientsCountsByAgeByDisease stat = new PatientsCountsByAgeByDisease(pcd.getDisease(), localeService);
			patientsCountByAgeByDisease.add(stat);
			for (Object[] countItem : data) {

				if (countItem[2].equals(pcd.getDisease())) {
					int count = countItem[0] != null ? Number.class.cast(countItem[0]).intValue() : 0;
					stat.add(count, Number.class.cast(countItem[1]).intValue());
				}
			}

			hasData = true;
		}

		///////////////////////////////////////////////////////////////
		data = doctorService.findPatientsKpiAverageScoreByDisease(doctor.getId());
		List<PatientsKpiAverageScoresByDisease> patientsKpiAverageScoreByDisease = new ArrayList<PatientsKpiAverageScoresByDisease>();
		model.addAttribute("patientsKpiAverageScoreByDisease", patientsKpiAverageScoreByDisease);
		for (PatientsCountByDisease stat : patientsCountByDiseases) {

			PatientsKpiAverageScoresByDisease pkpis = new PatientsKpiAverageScoresByDisease();
			patientsKpiAverageScoreByDisease.add(pkpis);

			List<KeyPerformanceIndicatorType> kpits = keyPerformanceIndicatorTypeService.findAll(stat.getDisease().getId());
			for (KeyPerformanceIndicatorType kpit : kpits) {

				boolean found = false;
				for (Object[] item : data) {
					KeyPerformanceIndicatorType kpitTmp = KeyPerformanceIndicatorType.class.cast(item[1]);
					if (kpit.equals(kpitTmp)) {
						Double score = Double.class.cast(item[2]);
						pkpis.add(kpit, score.doubleValue());
						found = true;
						break;
					}
				}

				if (!found) {
					pkpis.add(kpit, 0.0d);
				}
			}

			hasData = true;
		}

		model.addAttribute("hasData", Boolean.valueOf(hasData));

		return "arzt/index";
	}

	/**
	 * @param request
	 * @param model
	 * @param d_from
	 * @param d_to
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/artz/index/changedate")
	public String changeDateDoctorOverview(HttpServletRequest request, Model model, @RequestParam String d_from, @RequestParam String d_to) {
		DataHolder data = new DataHolder(request);
		if (StringUtils.isNotBlank(d_from)) {
			data.setDateFrom(DateUtils.str2date(d_from));
		}
		if (StringUtils.isNotBlank(d_to)) {
			data.setDateTo(DateUtils.str2date(d_to));
		}

		return getDoctorOverview(request, model);
	}
}
