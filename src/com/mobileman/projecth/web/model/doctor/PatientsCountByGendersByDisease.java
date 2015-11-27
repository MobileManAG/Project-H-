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
 * PatientsCountByGendersByDisease
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 13.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.model.doctor;

import java.util.ArrayList;
import java.util.List;

import com.mobileman.projecth.domain.data.Gender;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.web.model.chart.AbstractPrepareChartData;
import com.mobileman.projecth.web.service.LocaleService;

/**
 * @author mobileman
 *
 */
public class PatientsCountByGendersByDisease {
	
	/**
	 * @author mobileman
	 *
	 */
	public static class PatientsCountByGenderByDisease {
		private int count;
		private final String gender;
		private final Gender enumGender;
		private final String color;
		
		/**
		 * @param count
		 * @param gender
		 * @param enumGender 
		 */
		public PatientsCountByGenderByDisease(int count, String gender, Gender enumGender) {
			super();
			this.count = count;
			this.gender = gender;
			this.enumGender = enumGender;
			this.color = AbstractPrepareChartData.getColorName(gender);
		}
		/**
		 * @return count
		 */
		public int getCount() {
			return this.count;
		}
		
		/**
		 * @param count new value of count
		 */
		public void setCount(int count) {
			this.count = count;
		}
		
		/**
		 * @return gender
		 */
		public String getGender() {
			return this.gender;
		}
		
		/**
		 * @return enumGender
		 */
		public Gender getEnumGender() {
			return this.enumGender;
		}
		
		/**
		 * @return color
		 */
		public String getColor() {
			return this.color;
		}
	}
	
	private List<PatientsCountByGenderByDisease> genders = new ArrayList<PatientsCountByGenderByDisease>();
	
	private Disease disease;

	/**
	 * @param disease
	 * @param localeService  
	 */
	public PatientsCountByGendersByDisease(Disease disease, LocaleService localeService) {
		super();
		setDisease(disease);
		for (Gender gender : Gender.values()) {
			String genderString = localeService.getGenderMessage(gender);
			getGenders().add(new PatientsCountByGenderByDisease(0, genderString, gender));
		}
	}
	
	/**
	 * @param disease
	 */
	public void setDisease(Disease disease) {
		this.disease = disease;
	}
	
	/**
	 * @return disease
	 */
	public Disease getDisease() {
		return this.disease;
	}

	/**
	 * @return counts
	 */
	public List<PatientsCountByGenderByDisease> getGenders() {
		return this.genders;
	}
	
	/**
	 * @param count 
	 * @param gender
	 */
	public void add(int count, Gender gender) {
		if (gender == null) {
			gender = Gender.UNKNOWN;
		}
		
		for (PatientsCountByGenderByDisease item : getGenders()) {
			if (item.getEnumGender().equals(gender)) {
				item.setCount(count);
				break;
			}
		}
	}

}
