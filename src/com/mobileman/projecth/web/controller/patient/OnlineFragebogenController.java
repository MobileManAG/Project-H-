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
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mobileman.projecth.business.HaqService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.patient.PatientQuestionAnswerService;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.questionary.Answer;
import com.mobileman.projecth.domain.questionary.Answer.Kind;
import com.mobileman.projecth.domain.questionary.CustomQuestion;
import com.mobileman.projecth.domain.questionary.OneTimeHaq;
import com.mobileman.projecth.domain.questionary.Question;
import com.mobileman.projecth.domain.questionary.QuestionType;
import com.mobileman.projecth.domain.questionary.QuestionType.AnswerDataType;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.domain.util.patient.questionary.PatientQuestionAnswerHolder;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.OnlineFragebogenData;
import com.mobileman.projecth.web.service.PatientDataService;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.NumUtils;

@Controller
public class OnlineFragebogenController extends AbstractPatientController {

	@Autowired
	PatientDataService patientData;

	@Autowired
	PatientService patientService;

	@Autowired
	HaqService haqService;

	@Autowired
	PatientQuestionAnswerService patientQuestionAnswerService;

	@RequestMapping(method = RequestMethod.GET, value = "/patient/online_fragebogen")
	public String onlineFragebogenInit(HttpServletRequest request, HttpSession session, Model model) {
		// reset data
		new OnlineFragebogenData(session).clearData();
		//load petient Diseases
		Patient patient = new DataHolder(request).getPatient();
		model.addAttribute("diseases", patient.getDiseases());
		return "patient/online_fragebogen";
	}

	private boolean isInitialQuestions(Long patientId, Long diseaseId) {
		//return true;
		return !patientService.existsAnswerToOneTimeQuesion(patientId, diseaseId);
	}

	private boolean patientAnswerExists(DataHolder dataHolder, Patient patient) {
		try {
			return patientService.patientAnswerExists(patient.getId(), dataHolder.getDiseaseId(), new Date());
		} catch (Exception ex) {
		}
		return false;
	}

	private void prepareDiseaseData(OnlineFragebogenData data, DataHolder dataHolder, Model model) {
		Patient patient = dataHolder.getPatient();
		model.addAttribute("data_values", data.getDataForOutput());

		boolean one_time = false;
		// one time values
		if (isInitialQuestions(patient.getId(), dataHolder.getDiseaseId())) {
			one_time = true;
			model.addAttribute("initial_questions_exists", true);
		}

		//haq values
		List<Haq> haqs = haqService.findByDisease(dataHolder.getDiseaseId());

		model.addAttribute("disease_name", dataHolder.getDisease().getName());

		Map<Long, Answer> yesAnswers = new HashMap<Long, Answer>();
		Map<Long, Answer> noAnswers = new HashMap<Long, Answer>();
		model.addAttribute("question_yes_answers", yesAnswers);
		model.addAttribute("question_no_answers", noAnswers);

		//Map<Long, List<Answer>> scaleAnswers = new HashMap<Long, List<Answer>>();
		//model.addAttribute("question_scale_answers", scaleAnswers);

		Iterator<Haq> it = haqs.iterator();
		while (it.hasNext()) {
			Haq haq = it.next();
			if (OneTimeHaq.class.isInstance(haq)) {
				if (one_time) {
					model.addAttribute("initial_questions", haq.getQuestions());
					model.addAttribute("initial_questions_title", haq.getHaqQuestion());
				}
				it.remove();
			}
			//check questions and answer types
			for (Question question : haq.getQuestions()) {
				if (QuestionType.Type.SINGLE_CHOICE_LIST.equals(question.getQuestionType().getType())) {
					//check answers
					if (question.getQuestionType().getAnswers().size() == 3) {
						//kaine angabe
						//yes
						//no
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
							yesAnswers.put(question.getId(), yes);
							noAnswers.put(question.getId(), no);
						}
					}
				}
			}
		}

		model.addAttribute("haq_data", haqs);

		List<CustomQuestion> questions = patientService.findCustomQuestions(patient.getId(), dataHolder.getDiseaseId());
		//filter user questions
		List<CustomQuestion> patientQuestions = new ArrayList<CustomQuestion>();
		List<CustomQuestion> doctorQuestions = new ArrayList<CustomQuestion>();
		for (CustomQuestion q : questions) {
			if (UserType.D.equals(q.getCreator().getUserType())) {
				doctorQuestions.add(q);
			} else {
				patientQuestions.add(q);
			}
		}

		model.addAttribute("doctorQuestions_exists", doctorQuestions.size() > 0);
		model.addAttribute("doctorQuestions", doctorQuestions);
		model.addAttribute("patientQuestions_exists", patientQuestions.size() > 0);
		model.addAttribute("patientQuestions", patientQuestions);

		model.addAttribute("patientAnswerExists", patientAnswerExists(dataHolder, patient));
	}

	//@Transactional
	@RequestMapping(method = RequestMethod.GET, value = "/patient/online_fragebogen_enter_data/{diseaseId}")
	public String onlineFragebogenSelectDisease(HttpServletRequest request, Model model, @PathVariable Long diseaseId) {
		// prepare data for rendering
		DataHolder dataHolder = new DataHolder(request);
		if (diseaseId != null) {
			Patient patient = dataHolder.getPatient();
			for (Disease disease : patient.getDiseases()) {
				if (disease.getId().equals(diseaseId)) {
					dataHolder.setDiseaseId(diseaseId);
					break;
				}
			}
		}

		prepareDiseaseData(new OnlineFragebogenData(request.getSession()), dataHolder, model);
		return "patient/online_fragebogen_enter_data";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/online_fragebogen_enter_data")
	public String onlineFragebogen(HttpServletRequest request, Model model) {
		return onlineFragebogenSelectDisease(request, model, null);
	}

	private static final String FILE_KEY = "UploadedFileName";//warning - key is also used in SINGLE_ANSWER_ENTER.jsp
	private static final String FILE_KEY_CONTENT_TYPE = "UploadedFileName_content_type";

	@RequestMapping(method = RequestMethod.GET, value = "/patient/previewimage")
	public ModelAndView imagePreview(HttpServletRequest request, HttpServletResponse response, Model model) {
		String name = (String) request.getSession().getAttribute(FILE_KEY);
		if (name != null) {
			//check filename
			response.setContentType((String) request.getSession().getAttribute(FILE_KEY_CONTENT_TYPE));
			FileInputStream fis = null;
			try {
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

	@RequestMapping(method = RequestMethod.POST, value = "/patient/online_fragebogen_enter_data")
	public String onlineFragebogenEnterDataNoImage(HttpServletRequest request, Model model) {
		return onlineFragebogenEnterData1(request, model, null);
	}

	@RequestMapping(method = RequestMethod.POST, value = "/patient/online_fragebogen_enter_data/fileupload")
	public String onlineFragebogenEnterData1(HttpServletRequest request, Model model, @RequestParam("file") MultipartFile file) {
		// save into session
		OnlineFragebogenData data = new OnlineFragebogenData(request.getSession());
		data.storeData(request);

		//store image if any
		if (file != null && file.getSize() > 0) {
			//save to temporary file
			try {
				File tmp = File.createTempFile("projecth", "imgupload");
				String ct = file.getContentType();
				//remember in the session file name
				file.transferTo(tmp);
				request.getSession().setAttribute(FILE_KEY, tmp.getCanonicalPath());
				request.getSession().setAttribute(FILE_KEY_CONTENT_TYPE, ct);
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		// prepare data for rendering
		prepareDiseaseData(data, new DataHolder(request), model);
		return "patient/online_fragebogen_confirm_data";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/online_fragebogen_confirm_data")
	public String onlineFragebotenStoreData(HttpServletRequest request) {

		DataHolder dataHolder = new DataHolder(request);
		Patient patient = dataHolder.getPatient();
		if (patient == null || patient.getId() == 0) {
			return "redirect:/patient";
		}

		// TODO
		// check 1 day only answer
		OnlineFragebogenData data = new OnlineFragebogenData(request.getSession());

		// initial data
		/*if (initialQuestions(patient)) {
			projecthPatientInitialPost init = data.getData().getInitialPost();
			init.setPatientId(patient.getId());
			init.setDiseaseId(dataHolder.getDiseaseId());
			patientService.processPatientInitialPost(init);
		}*/

		List<Haq> haqList = haqService.findByDisease(dataHolder.getDiseaseId());
		final Date logDate = new Date();
		Map<String, String> answers = data.getData().getRawData();

		boolean init_data = isInitialQuestions(patient.getId(), dataHolder.getDiseaseId());

		List<PatientQuestionAnswerHolder> answersData = new ArrayList<PatientQuestionAnswerHolder>();
		for (Haq haq : haqList) {
			if (!init_data && OneTimeHaq.class.isInstance(haq)) {
				continue;
			}
			for (Question question : haq.getQuestions()) {
				PatientQuestionAnswerHolder holder = saveAnswer(request, question, answers, haq.getId());
				if (holder != null) {
					holder.setHaqId(haq.getId());
					answersData.add(holder);
				}
			}
		}

		List<CustomQuestion> customQuestions = patientService.findCustomQuestions(patient.getId(), dataHolder.getDiseaseId());
		if (customQuestions != null) {
			//custom questions
			for (CustomQuestion question : customQuestions) { //.entrySet()) {
				PatientQuestionAnswerHolder holder = saveAnswer(request, question, answers, null);
				if (holder != null) {
					answersData.add(holder);
				}

			}
		}

		if (answersData.size() > 0) {
			patientQuestionAnswerService.saveAnswers(patient.getId(), dataHolder.getDiseaseId(), logDate, answersData);
		}
		// reset data
		new OnlineFragebogenData(request.getSession()).clearData();
		return "redirect:/patient";
	}

	private PatientQuestionAnswerHolder saveAnswer(HttpServletRequest request, Question question, Map<String, String> answers, Long haqId) {
		//extract questionid, answerid and result text
		//cqIDQUESTION				- value is string		 (text)
		//cqIDQUESTION-ANSWERID 	- value is not important (checkbox)
		//cvIDQUESTION 				- value is ANSWERID      (radio)
		//chIDQUESTION				- value is hidden (like checkbox - if there is a 1 as value

		String strQuestionId = "" + question.getId();
		PatientQuestionAnswerHolder patientQuestionAnswerHolder = new PatientQuestionAnswerHolder();
		patientQuestionAnswerHolder.setHaqId(haqId);
		patientQuestionAnswerHolder.setQuestionId(question.getId());

		Entry<String, String> val = null;
		for (Entry<String, String> kvp : answers.entrySet()) {
			if (kvp.getKey().contains(strQuestionId)) {
				val = kvp;
				break;
			}
		}

		if (val == null || val.getValue() == null || "".equals(val.getValue().trim())) {
			if (AnswerDataType.IMAGE.equals(question.getQuestionType().getAnswerDataType())) {
				//check for images
				//TODO content type???
				String filename = (String) request.getSession().getAttribute(FILE_KEY);
				if (filename != null) {
					request.getSession().removeAttribute(FILE_KEY);
					for (Answer answer : question.getQuestionType().getAnswers()) {
						if (answer.isActive()) {
							patientQuestionAnswerHolder.setAnswerId(answer.getId());
							patientQuestionAnswerHolder.setCustomAnswer(filename);
							return patientQuestionAnswerHolder;
						}
					}
				}
			}

			Long noAnswerId = null;
			for (Answer answer : question.getQuestionType().getAnswers()) {
				if (Kind.NO_ANSWER.equals(answer.getKind())) {
					noAnswerId = answer.getId();
					break;
				}
			}
			if (noAnswerId != null) {
				patientQuestionAnswerHolder.setAnswerId(noAnswerId);
				return patientQuestionAnswerHolder;
			}
			return null;
		}

		//Long questionId = null;
		Long answerId = null;
		String answer = null;
		String name = val.getKey();
		boolean error = false;
		if (name.startsWith("cv")) {
			//radio
			//questionId = NumUtils.convert2long(name.substring(2));
			answerId = NumUtils.convert2long(val.getValue());
		} else if (name.startsWith("cq")) {
			int index = name.indexOf('-');
			if (index < 0) {
				//input text
				//questionId = NumUtils.convert2long(name.substring(2));
				answer = val.getValue();
				if (AnswerDataType.DATE.equals(question.getQuestionType().getAnswerDataType())) {
					//parse data
					Date date = DateUtils.normalStr2date(answer);
					if (date != null) {
						answer = "" + date.getTime();
					}
				}
				//answerid find first not keine angabe
				for (Answer a1 : question.getQuestionType().getAnswers()) {
					if (StringUtils.isNotBlank(answer)) {
						if (!a1.getKind().equals(Kind.NO_ANSWER)) {
							answerId = a1.getId();
							break;
						}
					} else {
						if (a1.getKind().equals(Kind.NO_ANSWER)) {
							answerId = a1.getId();
							break;
						}
					}
				}
			} else {
				//checkbox
				//questionId = NumUtils.convert2long(name.substring(2, index));
				answerId = NumUtils.convert2long(name.substring(index + 1));
			}
		} else if (name.startsWith("ch")) {
			//questionId = NumUtils.convert2long(name.substring(2));
			//hidden input - test for 1 (yes) or 0 (no)
			Integer value = NumUtils.convert2int(val.getValue());
			for (Answer a1 : question.getQuestionType().getAnswers()) {
				if (value == null) {
					if (a1.getKind().equals(Kind.NO_ANSWER)) {
						answerId = a1.getId();
						break;
					}
				} else {
					if (!a1.getKind().equals(Kind.NO_ANSWER)) {
						if (value > 0) {
							if (a1.isActive()) {
								answerId = a1.getId();
								break;
							}
						} else {
							if (!a1.isActive()) {
								answerId = a1.getId();
								break;
							}
						}
					}
				}
			}
		} else {
			//error
			error = true;
		}

		if (!error) {
			patientQuestionAnswerHolder.setAnswerId(answerId);
			patientQuestionAnswerHolder.setCustomAnswer(answer);
			return patientQuestionAnswerHolder;
		}
		return null;
	}
}
