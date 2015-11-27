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
/**
 * DoctorUtils.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 8.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.util;

import org.springframework.ui.Model;

import com.mobileman.projecth.domain.data.MedicalInstitution;
import com.mobileman.projecth.domain.doctor.Doctor;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.util.data.MedicalInstitutionUtil;
import com.mobileman.projecth.domain.util.user.UserUtil;
import com.mobileman.projecth.web.controller.InitController;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.service.LocaleService;

/**
 * @author mobileman
 *
 */
public final class DoctorUtils {

	private DoctorUtils(){}
	
	/**
	 * @param model
	 * @param data
	 * @param visitor
	 * @param user
	 * @param connectionExists 
	 */
	public static void loadDoctorHeader(Model model, DataHolder data, User visitor, User user, boolean connectionExists) {
		loadDoctorHeader(model, data, user);
		//model.addAttribute("visitorCanSeeUserData", PrivacyUtils.visitorCanSeeUserData(visitor, user, connectionExists));
	}

	/**
	 * @param model
	 * @param data
	 * @param user
	 */
	public static void loadDoctorHeader(Model model, DataHolder data, User user) {
		
		if (Doctor.class.isInstance(user)) {
			MedicalInstitution mi = Doctor.class.cast(user).getMedicalInstitution();
			String miString = MedicalInstitutionUtil.fmtMedicalInstitution(mi);
			model.addAttribute("medicalInstitution", miString);
			if (mi != null) {
				model.addAttribute("medicalInstitutionPhoneNmr", (mi.getPhoneNumber() != null ? mi.getPhoneNumber().format() : ""));
				model.addAttribute("medicalInstitutionFaxNmr", (mi.getFaxNumber() != null ? mi.getFaxNumber().format() : ""));
			}
			
		}
		model.addAttribute("visitorCanSeeUserData", Boolean.TRUE);
		
		String gend = UserUtil.fmtGender(user);
		LocaleService localeService = InitController.getWebApplicationContext().getBean(LocaleService.class);
		model.addAttribute("user_gender", gend.trim().length() == 0 ? localeService.getUnknowMessage() : gend);
		model.addAttribute("user_avatar", PatientUtils.computeAvatar(user.getSex()));
		model.addAttribute("user_age", PatientUtils.computeAge(user.getBirthday()));
		
	}
}
