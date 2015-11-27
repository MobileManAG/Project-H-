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

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mobileman.projecth.business.ConfigurationService;
import com.mobileman.projecth.business.HaqService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.UserConnectionService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.business.patient.PatientQuestionAnswerService;
import com.mobileman.projecth.business.questionary.QuestionService;
import com.mobileman.projecth.business.questionary.QuestionTypeService;
import com.mobileman.projecth.business.user.message.MessageService;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.patient.PatientQuestionAnswer;
import com.mobileman.projecth.domain.questionary.Answer;
import com.mobileman.projecth.domain.questionary.Answer.Kind;
import com.mobileman.projecth.domain.questionary.CustomQuestion;
import com.mobileman.projecth.domain.questionary.Question;
import com.mobileman.projecth.domain.questionary.QuestionType;
import com.mobileman.projecth.domain.questionary.QuestionType.AnswerDataType;
import com.mobileman.projecth.domain.questionary.QuestionType.Type;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.domain.user.message.Message;
import com.mobileman.projecth.domain.user.message.MessageGroupType;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.FragebogenAnnpasenData;
import com.mobileman.projecth.web.model.FragebogenAnnpasenData.FragebogenAnnpasenDataHolder;
import com.mobileman.projecth.web.service.PatientDataService;
import com.mobileman.projecth.web.util.PrivacyUtils;
import com.mobileman.projecth.web.util.Services;

@Controller
public class PatientController extends AbstractPatientController {

	@Autowired
	PatientDataService patientData;

	@Autowired
	PatientService patientService;

	@Autowired
	HaqService haqService;

	@Autowired
	PatientQuestionAnswerService patientQuestionAnswerService;

	@Autowired
	QuestionTypeService questionTyperService;

	@Autowired
	QuestionService questionService;

	@Autowired
	MessageService messageService;

	@Autowired
	UserConnectionService userConnectionService;

	@Autowired
	private UserService userService;

	@Autowired
	ConfigurationService configurationService;

	@RequestMapping(method = RequestMethod.GET, value = "/patient")
	public String getStartPage(HttpServletRequest request, Model model) {
		return getPage(request, model, "index", null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/{patientId}/{diseaseId}")
	public String getStartPageWithDisease(HttpServletRequest request, Model model, @PathVariable String patientId, @PathVariable String diseaseId) {
		return getPage(request, model, "index", Long.valueOf(diseaseId));
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/{page}")
	public String getPage(HttpServletRequest request, Model model, @PathVariable String page, Long diseaseId) {
		if ("index".equals(page)) {
			DataHolder dataHolder = new DataHolder(request);
			User user = dataHolder.getUser();
			Disease disease = null;
			if (diseaseId == null) {
				diseaseId = dataHolder.getDiseaseId();
			}

			if (diseaseId != null) {
				disease = Services.getDiseaseService().findById(diseaseId);
				dataHolder.setDiseaseId(diseaseId);
			} else if (user.getDiseases() != null && !user.getDiseases().isEmpty()) {
				disease = user.getDiseases().get(0);
				dataHolder.setDiseaseId(disease.getId());
				dataHolder.setDiseaseId(disease.getId());
			}

			patientData.prepareData(request, model, user, disease);
		}
		return processPage(request.getSession().getServletContext(), page);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/index/print")
	public String getPage(HttpServletRequest request, Model model) {
		patientData.prepareData(request, model, null, null);
		model.addAttribute("print", true);
		return processPage(request.getSession().getServletContext(), "index");
	}

	@RequestMapping(method = RequestMethod.POST, value = "/patient/changedate")
	public String changeDate(HttpServletRequest request, Model model, @RequestParam String d_from, @RequestParam String d_to) {
		patientData.changeDate(request, model, d_from, d_to);
		patientData.prepareData(request, model, null, null);
		return processPage(request.getSession().getServletContext(), null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/date/{len}-{type}")
	public String changeDatePreddefined(HttpServletRequest request, Model model, @PathVariable Integer len, @PathVariable String type) {
		PatientDataService.changeDatePreddefined(request, model, len, type);
		patientData.prepareData(request, model, null, null);
		return processPage(request.getSession().getServletContext(), null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/fragebogen_anpassen")
	public String onlineFragebogenAnpassen(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		new FragebogenAnnpasenData(session).clearData();

		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();
		Disease disease = dataHolder.getDisease();

		List<CustomQuestion> customQuestions = patientService.findCustomQuestions(patient.getId(), disease.getId());

		model.addAttribute("user", patient);
		model.addAttribute("userdefaultname", "doctor");
		model.addAttribute("patient", patient);
		model.addAttribute("disease", disease);
		model.addAttribute("customQuestions", customQuestions);
		model.addAttribute("patient_diseases", patient.getDiseases());

		return "patient/fragebogen_anpassen";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/fragebogen_anpassen/{disId}")
	public String getStartPageWithDisease(HttpServletRequest request, Model model, @PathVariable String disId) {

		Long diseaseId = Long.valueOf(disId);
		DataHolder dataHolder = new DataHolder(request);
		User user = dataHolder.getUser();
		Disease disease = null;
		if (diseaseId == null) {
			diseaseId = dataHolder.getDiseaseId();
		}

		if (diseaseId != null) {
			disease = Services.getDiseaseService().findById(diseaseId);
			dataHolder.setDiseaseId(diseaseId);
		} else if (user.getDiseases() != null && !user.getDiseases().isEmpty()) {
			disease = user.getDiseases().get(0);
			dataHolder.setDiseaseId(disease.getId());
			dataHolder.setDiseaseId(disease.getId());
		}

		return onlineFragebogenAnpassen(request, model);
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/save_fragebogen_anpassen")
	public @ResponseBody
	String saveFragebogenAnnpassen(HttpServletRequest request, Model model) {
		String result = "";

		// save into session
		FragebogenAnnpasenData fragebogenAnnpasendata = new FragebogenAnnpasenData(request.getSession());
		fragebogenAnnpasendata.storeData(request);

		FragebogenAnnpasenDataHolder holder = fragebogenAnnpasendata.getData();
		Map<Long, Map<String, Object>> fragebogenAnnpasenDataHolderdata = holder.getData();

		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();
		Disease disease = dataHolder.getDisease();

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
				questionType.setUser(patient);
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
					newId = patientService.addCustomQuestion(patientId, diseaseId, questionTextString, explanationText, questionType.getId());
				} else {
					newId = patientService.addCustomQuestion(patientId, diseaseId, questionTextString, explanationText, questionType);
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

	@RequestMapping(method = RequestMethod.GET, value = "/patient/nachrichten")
	public String getNachrichten(HttpServletRequest request, Model model) {

		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();
		if (patient == null || patient.getId() == 0) {
			return "redirect:/patient";
		}

		List<Message> inbox = messageService.findAll(patient.getId(), MessageGroupType.INBOX);
		model.addAttribute("inbox", inbox);
		List<Message> outbox = messageService.findAll(patient.getId(), MessageGroupType.OUTBOX);
		List<Long> replies = new ArrayList<Long>();
		for (Message message : outbox) {
			if (message.getInReplyToMessage() != null) {
				replies.add(message.getInReplyToMessage().getId());
			}
		}
		model.addAttribute("replies", replies);

		List<User> userConnections = new ArrayList<User>();
		List<UserConnection> connections = userConnectionService.findAllNotCanceledConnections(patient.getId());
		for (UserConnection conn : connections) {
			if (conn.getUser().getId().equals(patient.getId())) {
				userConnections.add(conn.getOwner());
			}
			if (conn.getOwner().getId().equals(patient.getId())) {
				userConnections.add(conn.getUser());
			}
		}
		model.addAttribute("connections", userConnections);

		return "patient/nachrichten";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/nachrichten_versendet")
	public String getNachrichtenVersendet(HttpServletRequest request, Model model) {

		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();
		if (patient == null || patient.getId() == 0) {
			return "redirect:/patient";
		}

		List<Message> outbox = messageService.findAll(patient.getId(), MessageGroupType.OUTBOX);
		model.addAttribute("outbox", outbox);

		return "patient/nachrichten_versendet";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/send_new_message")
	public @ResponseBody
	String sendMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();

		String result = "";
		String receiver = request.getParameter("receiver");
		String subject = StringEscapeUtils.escapeHtml(request.getParameter("subject"));
		String body = StringEscapeUtils.escapeHtml(request.getParameter("body"));
		boolean copy = Boolean.parseBoolean(request.getParameter("copy"));

		try {
			messageService.sendMessage(patient.getId(), Long.valueOf(receiver), subject, body, copy);
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/reply_to_message")
	public @ResponseBody
	String replyMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");
		String body = StringEscapeUtils.escapeHtml(request.getParameter("body"));
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
	@RequestMapping(method = RequestMethod.POST, value = "/patient/mark_as_read")
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
	@RequestMapping(method = RequestMethod.POST, value = "/patient/mark_as_unread")
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
	@RequestMapping(method = RequestMethod.POST, value = "/patient/delete_message")
	public @ResponseBody
	String deleteMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");

		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();

		try {
			messageService.deleteMessage(patient.getId(), Long.valueOf(messageId));
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/mark_as_spam")
	public @ResponseBody
	String markAsSpamMessage(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String messageId = request.getParameter("messageId");

		DataHolder dataHolder = new DataHolder(request);
		try {
			messageService.markAsSpam(Long.valueOf(messageId), true);
			result = "ok";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = "error";
		}

		return result;
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/patient/user_info")
	public String userInfoGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		DataHolder dataHolder = new DataHolder(request);
		User currentUser = dataHolder.getUser();
		if (currentUser == null) {
			return "error";
		}

		String userId = request.getParameter("userId");
		if (userId == null || userId.equals("0") || userId.trim().length() == 0) {
			return "error";
		}

		User user = userService.findById(Long.valueOf(userId.trim()));
		boolean visitorCanSeeUserData = PrivacyUtils.visitorCanSeeUserData(currentUser, user, false);
		model.addAttribute("visitorCanSeeUserData", Boolean.valueOf(visitorCanSeeUserData));
		model.addAttribute("user", user);
		return "ok";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/getimage/{id}")
	public ModelAndView imagePreview(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable Long id) {
		//load patient answer and check current patient??? or member
		PatientQuestionAnswer pqa = patientQuestionAnswerService.findById(id);

		//zmenit na test aj voci membrom
		if (pqa.getPatient().getId().equals(new DataHolder(request).getPatient().getId())) {
			//response.setContentType((String) request.getSession().getAttribute(FILE_KEY_CONTENT_TYPE));
			FileInputStream fis = null;
			try {
				File dir = new File(configurationService.getImagesRootDirectoryPath());
				File name = new File(dir, pqa.getCustomAnswer());
				fis = new FileInputStream(name);
				FileCopyUtils.copy(fis, response.getOutputStream());
			} catch (IOException e) {
			} finally {
				if (fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
					}
				}
			}
		}
		return null;
	}
}
