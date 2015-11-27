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
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mobileman.projecth.business.HaqService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.patient.PatientQuestionAnswerService;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.patient.PatientQuestionAnswer;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.service.PatientDataService;
import com.mobileman.projecth.web.util.DateUtils;

@Controller
public class ExportController extends AbstractController {

	public ExportController() {
		super("customer");
	}

	@Autowired
	PatientService patientService;

	@Autowired
	HaqService haqService;

	@Autowired
	PatientQuestionAnswerService patientQuestionAnswerService;

	@RequestMapping(method = RequestMethod.GET, value = "/customer")
	public String initExportData(HttpServletRequest request, Model model) {
		DataHolder data = new DataHolder(request);
		if (data.getType() != UserType.C) {
			return LoginController.redirectToLogin();
		}

		prepareModel(data, model);

		return processPage(request.getSession().getServletContext(), null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/customer/{page}")
	public String getPage(HttpSession session, HttpServletRequest request, @PathVariable String page) {
		return processPage(session.getServletContext(), page);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/customer/index")
	public String index(HttpServletRequest request, Model model) {
		return initExportData(request, model);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/customer/cd")
	public String changeDate(HttpServletRequest request, Model model, @RequestParam("d_from") String date_from, @RequestParam("d_to") String date_to) {
		DataHolder data = new DataHolder(request);
		// change date
		data.setDateFrom(DateUtils.str2date(date_from));
		data.setDateTo(DateUtils.str2date(date_to));
		prepareModel(data, model);
		return "customer/index";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/customer/date/{len}-{type}")
	public String changeDatePreddefined(HttpServletRequest request, Model model, @PathVariable Integer len, @PathVariable String type) {
		DataHolder data = new DataHolder(request);
		PatientDataService.changeDatePreddefined(request, model, len, type);
		prepareModel(data, model);
		return "customer/index";
	}

	private void prepareModel(DataHolder data, Model model) {
		// enumerate haqs
		model.addAttribute("exports", haqService.findAll());

		model.addAttribute("date_from", DateUtils.date2str(data.getDateFrom()));
		model.addAttribute("date_to", DateUtils.date2str(data.getDateTo()));

		List<Disease> rc = new ArrayList<Disease>();
		//rc.add(patientMedicationHelper.getRheuma());
		model.addAttribute("diseases", rc);
	}

	private ResponseEntity<String> generateCsv(String data) {
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.set("Content-Type", "application/octet-stream");
		responseHeaders.set("Content-disposition", "attachment; filename=export.csv");
		return new ResponseEntity<String>(data, responseHeaders, HttpStatus.OK);
	}

	//export all page
	@RequestMapping(method = RequestMethod.GET, value = "/customer/cust/{haqId}")
	public ResponseEntity<String> exportCustData(@PathVariable Long haqId, HttpServletRequest request) {
		StringBuffer rc = new StringBuffer();

		DataHolder data = new DataHolder(request);

		if (haqId == 0) {
			List<Haq> haqs = haqService.findAll();
			for (Haq haq : haqs) {
				exportHaq(haq.getId(), rc, data);
				rc.append(newLine);
			}
		} else {
			exportHaq(haqId, rc, data);
		}

		return generateCsv(rc.toString());
	}

	private void exportHaq(Long haqId, StringBuffer rc, DataHolder data) {
		List<PatientQuestionAnswer> pars = patientQuestionAnswerService.exportData(haqId, data.getDateFrom(), data.getDateTo());

		for (PatientQuestionAnswer p : pars) {
			rc.append(formatDate(p.getLogDate()));
			rc.append(separator);
			rc.append(p.getQuestion().getHaq().getId());
			rc.append(separator);
			rc.append(p.getQuestion().getHaq().getKind().name());
			rc.append(separator);
			rc.append(p.getQuestion().getHaq().getHaqQuestion());
			rc.append(separator);
			rc.append(p.getQuestion().getHaq().getExplanation());
			rc.append(separator);
			rc.append(p.getQuestion().getId());
			rc.append(separator);
			rc.append(p.getQuestion().getKind().name());
			rc.append(separator);
			if (p.getQuestion().getExtendedType() != null) {
				rc.append(p.getQuestion().getExtendedType().name());
				rc.append(separator);
			}

			rc.append(p.getQuestion().getGroupText());
			rc.append(separator);
			rc.append(p.getQuestion().getText());
			rc.append(separator);

			rc.append(p.getAnswer().getId());
			rc.append(separator);
			rc.append(p.getAnswer().getKind().name());
			rc.append(separator);
			rc.append(p.getAnswer().getAnswer());
			rc.append(separator);
			rc.append(p.getAnswer().getExplanation());
			rc.append(separator);

			rc.append(p.getPatient().getId());
			rc.append(separator);
			rc.append(p.getPatient().getGender());
			rc.append(separator);

			if (p.getPatient().getName() != null) {
				rc.append(p.getPatient().getName().getName()).append(" ");
				rc.append(p.getPatient().getName().getSurname());
				rc.append(separator);
			}

			rc.append(p.getCustomAnswer());

			rc.append(newLine);
		}
	}

	//from report page - for patient data only
	@RequestMapping(method = RequestMethod.GET, value = "/customer/exp/{haqId}")
	public ResponseEntity<String> exportData(@PathVariable Long haqId, HttpServletRequest request) {
		StringBuffer rc = new StringBuffer();

		DataHolder data = new DataHolder(request);

		if (haqId == 1 || haqId == 2) {
			exportTime(rc, haqId, data);
		} else {
			exportStat(rc, haqId, data);
		}

		return generateCsv(rc.toString());
	}

	private static final String separator = ";";
	private static final String newLine = "\r\n";

	private void exportStat(StringBuffer rc, Long haqId, DataHolder data) {
		/*
		List<PatientQuestionaryAnswerStatistic> data1 = patientService.computeQuestionaryAnswersStatistics(data.getPatient().getId(), haqId,
				data.getDateFrom(), data.getDateTo());
		for (PatientQuestionaryAnswerStatistic question : data1) {
			// format
			rc.append(question.getHaqDescription());
			rc.append(separator);
			rc.append(question.getQuestionText());
			rc.append(separator);
			rc.append(question.getAnswerText());
			rc.append(separator);
			rc.append(question.getCount());
			rc.append(separator);
			rc.append(newLine);
		}
		*/
	}

	private void exportTime(StringBuffer rc, Long haqId, DataHolder data) {
		/*
		List<Object[]> data1 = patientService.computeQuestionaryAnswersTimeStatistics(data.getPatient().getId(), haqId, data.getDateFrom(), data.getDateTo());

		for (Object[] obj : data1) {
			Calendar cal = Calendar.getInstance();
			cal.setTime((Date) obj[0]);
			Long count = (Long) obj[1];

			// format
			rc.append(formatDate((Date) obj[0]));
			rc.append(separator);
			rc.append(count);
			rc.append(newLine);
		}
		*/
	}

	private String formatDate(Date date) {
		if (date != null) {
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);

			StringBuffer rc = new StringBuffer();
			// format
			rc.append(cal.get(Calendar.YEAR));
			rc.append("-");
			rc.append(cal.get(Calendar.MONTH));
			rc.append("-");
			rc.append(cal.get(Calendar.DAY_OF_MONTH));
			return rc.toString();
		}
		return "";
	}

}
