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
 * PatientsCountsByAgeByDisease
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
import com.mobileman.projecth.web.model.doctor.PatientsCountByGendersByDisease.PatientsCountByGenderByDisease;
import com.mobileman.projecth.web.service.LocaleService;

/**
 * @author mobileman
 *
 */
public class PatientsCountsByAgeByDisease {
	
	public static class Group {
		private int count;
		private final String ageGroup;
		private final int ageGroupId;
		
		/**
		 * @param count
		 * @param ageGroup
		 */
		public Group(int count, String ageGroup, int ageGroupId) {
			super();
			this.count = count;
			this.ageGroup = ageGroup;
			this.ageGroupId = ageGroupId;
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
		 * @return ageGroup
		 */
		public String getAgeGroup() {
			return this.ageGroup;
		}

		/**
		 * @return ageGroupId
		 */
		public int getAgeGroupId() {
			return this.ageGroupId;
		}
		
	}
	
	private List<Group> groups = new ArrayList<PatientsCountsByAgeByDisease.Group>();
	private final Disease disease;

	/**
	 * @param disease 
	 * @param localeService
	 */
	public PatientsCountsByAgeByDisease(Disease disease, LocaleService localeService) {
		this.disease = disease;
		int[] grps = { 0, 1, 2, 3, 4, 5, 6, 7 };
		for (int grp : grps) {
			String ageGrpString = localeService.getAgeGroupMessage(grp);
			getGroups().add(new Group(0, ageGrpString, grp));
		}
	}

	/**
	 * @return groups
	 */
	public List<Group> getGroups() {
		return this.groups;
	}
	
	/**
	 * @param count 
	 * @param ageGroup 
	 */
	public void add(int count, int ageGroup) {
		for (Group item : getGroups()) {
			if (item.getAgeGroupId() == ageGroup) {
				item.setCount(count);
			}
		}
	}

	/**
	 * @return disease
	 */
	public Disease getDisease() {
		return this.disease;
	}
}
