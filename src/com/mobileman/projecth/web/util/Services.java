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

import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.DoctorService;
import com.mobileman.projecth.business.HaqService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.business.patient.PatientQuestionAnswerService;
import com.mobileman.projecth.business.questionary.QuestionService;
import com.mobileman.projecth.web.controller.InitController;
import com.mobileman.projecth.web.service.LocaleService;

public final class Services {

	private static <T> T getService(Class<T> type) {
		return InitController.getWebApplicationContext().getBean(type);
	}

	public static HaqService getHaqService() {
		return getService(HaqService.class);
	}

	public static UserService getUserService() {
		return getService(UserService.class);
	}

	public static DiseaseService getDiseaseService() {
		return getService(DiseaseService.class);
	}

	public static PatientService getPatientService() {
		return getService(PatientService.class);
	}

	public static DoctorService getDoctorService() {
		return getService(DoctorService.class);
	}

	public static PatientQuestionAnswerService getPatientQuestionAnswerService() {
		return getService(PatientQuestionAnswerService.class);
	}

	public static QuestionService getQuestionService() {
		return getService(QuestionService.class);
	}

	public static LocaleService getLocaleService() {
		return getService(LocaleService.class);
	}
}
