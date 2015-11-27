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
 * LocaleService.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 12.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.service;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.mobileman.projecth.domain.data.Gender;

/**
 * @author mobileman
 * 
 */
@Service
public class LocaleService {

	@Autowired
	MessageSource messageSource;

	/**
	 * @return gender.unknown
	 */
	public String getUnknowMessage() {
		String unkn = messageSource.getMessage("gender.unknown", null, Locale.GERMANY);
		return unkn;
	}

	/**
	 * @return location.unknown
	 */
	public String getUnknownLocation() {
		String unkn = messageSource.getMessage("location.unknown", null, Locale.GERMANY);
		return unkn;
	}

	/**
	 * @param intValue
	 * @return age.group.
	 */
	public String getAgeGroupMessage(int intValue) {
		String result = messageSource.getMessage("age.group." + intValue, null, Locale.GERMANY);
		return result;
	}

	/**
	 * @param gender
	 * @return age.group.
	 */
	public String getGenderMessage(Gender gender) {
		final String result;
		if (gender == null) {
			result = messageSource.getMessage("gender.unknown", null, Locale.GERMANY);
		} else {
			result = messageSource.getMessage("gender." + gender.name().toLowerCase(), null, Locale.GERMANY);
		}

		return result;
	}

	/**
	 * @return public.contact.receiver.email
	 */
	public String getPublicContactReceiverEmail() {
		return messageSource.getMessage("public.contact.receiver.email", null, Locale.GERMANY);
	}

	public String getYearsUnknown() {
		return messageSource.getMessage("years.unknown", null, Locale.GERMANY);
	}

	public String getYears() {
		return messageSource.getMessage("years", null, Locale.GERMANY);
	}

	public String getReportCustonQuestions() {
		return messageSource.getMessage("report.custom.questions", null, Locale.GERMANY);
	}

	/**
	 * @return
	 */
	public String getMedicationFrequencyBiWeekly() {
		return messageSource.getMessage("medication.frequeency.bi-weekly", null, Locale.GERMANY);
	}

	/**
	 * @return
	 */
	public String getMedicationFrequencyWeekly() {
		return messageSource.getMessage("medication.frequeency.weekly", null, Locale.GERMANY);
	}

	/**
	 * @return
	 */
	public String getMedicationFrequencyOneTime() {
		return messageSource.getMessage("medication.frequeency.one-time", null, Locale.GERMANY);
	}

	/**
	 * @return
	 */
	public String getMedicationFrequencyDaily() {
		return messageSource.getMessage("medication.frequeency.daily", null, Locale.GERMANY);
	}

}
