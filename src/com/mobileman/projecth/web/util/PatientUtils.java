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
package com.mobileman.projecth.web.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.ui.Model;

import com.mobileman.projecth.business.PatientMedicationService;
import com.mobileman.projecth.domain.data.Name;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.util.user.UserUtil;
import com.mobileman.projecth.util.Pair;
import com.mobileman.projecth.web.controller.InitController;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.DiseaseInfo;
import com.mobileman.projecth.web.service.LocaleService;

public class PatientUtils {

	/**
	 * @param model
	 * @param data
	 * @param visitor
	 * @param patient
	 * @param selectedDisease
	 * @param connectionExists
	 */
	public static void loadPatientHeader(Model model, DataHolder data, User visitor, Patient patient, Disease selectedDisease, boolean connectionExists) {
		loadPatientHeader(model, data, patient, selectedDisease);
		model.addAttribute("visitorCanSeeUserData", PrivacyUtils.visitorCanSeeUserData(visitor, patient, connectionExists));
	}

	/**
	 * @param model
	 * @param data
	 * @param patient
	 * @param selectedDisease
	 */
	public static void loadPatientHeader(Model model, DataHolder data, User patient, Disease selectedDisease) {
		LocaleService localeService = InitController.getWebApplicationContext().getBean(LocaleService.class);
		String patien_name = localeService.getUnknowMessage();
		String patien_surname = localeService.getUnknowMessage();

		Name name = patient.getName();
		if (name != null) {
			patien_name = name.getName();
			patien_surname = name.getSurname();
		}

		model.addAttribute("visitorCanSeeUserData", Boolean.TRUE);
		model.addAttribute("patien_login", patient.getUserAccount().getLogin());

		model.addAttribute("patien_name", patien_name);
		model.addAttribute("patien_surname", patien_surname);

		Pair<Date, Date> diagDates = data.getInitialSymptomAndDaiagnosisDate();
		model.addAttribute("patient_initialsymptomdate", DateUtils.germanLongDate2str(diagDates.getFirst()));
		model.addAttribute("patient_initialdiagnosisdate", DateUtils.germanLongDate2str(diagDates.getSecond()));

		String gend = UserUtil.fmtGender(patient);
		model.addAttribute("patient_gender", gend);
		model.addAttribute("patient_avatar", computeAvatar(patient.getSex()));
		model.addAttribute("patient_age", computeAge(patient.getBirthday()));
		model.addAttribute("patient_place", patient.getCountry() != null ? patient.getCountry().getName() : localeService.getUnknownLocation());

		model.addAttribute("patient_logincount", patient.getLoginsCount());
		model.addAttribute("patient_created", DateUtils.germanShortDate2str(patient.getUserAccount().getCreated()));

		model.addAttribute("patient_lastlogin", DateUtils.germanShortDate2str(patient.getLastLogin()));
		model.addAttribute("patient_lastupdate", DateUtils.germanShortDate2str(patient.getLastUpdate()));
		model.addAttribute("patient_my_story", patient.getAboutMe());
		model.addAttribute("user_weight", UserUtils.fmtUserWeight(patient));

		//diseases
		List<Disease> diseases = patient.getDiseases();
		List<DiseaseInfo> diseaseInfo = new ArrayList<DiseaseInfo>();

		Long selectedDiseaseId = selectedDisease == null ? null : selectedDisease.getId();
		for (Disease disease : diseases) {
			diseaseInfo.add(new DiseaseInfo(disease, patient.getId(), selectedDiseaseId));
		}
		model.addAttribute("patient_diseases", diseaseInfo);

		//medications
		model.addAttribute("patient_selected_disease", data.getDisease());

		if (selectedDiseaseId != null) {
			model.addAttribute("patient_medications", InitController.getWebApplicationContext().getBean(PatientMedicationService.class)
					.findAllConsumedMedications(patient.getId(), selectedDiseaseId));
		}
	}

	static String computeGender(Integer gender) {
		String result = "";
		if (gender != null) {
			if (gender.intValue() == 0) {
				result = "Frau";
			} else {
				result = "Herr";
			}
		}
		return result;
	}

	static String computeAvatar(Integer gender) {
		String result = "avatar_man";
		if (gender != null) {
			if (gender.intValue() == 0) {
				result = "avatar_woman";
			} else if (gender.intValue() == 1) {
				result = "avatar_man";
			} else {
				result = "avatar_man";
			}
		}
		return result;
	}

	static String computeAge(Integer birthday) {
		LocaleService localeService = Services.getLocaleService();
		String stringResult = localeService.getYearsUnknown();
		Integer result = null;
		if (birthday != null) {
			SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy");
			Integer actualYear = new Integer(simpleDateformat.format(new Date()));
			result = actualYear - birthday;
			stringResult = result.toString() + " " + localeService.getYears();
			//Jahre
		}

		return stringResult;
	}

}
