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
package com.mobileman.projecth.web.model;

import java.util.Date;

import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.domain.util.user.UserUtil;
import com.mobileman.projecth.web.util.DateUtils;

public class PatientInfo {
	private Long id;
	private String name;
	private String gender;
	private Integer year;
	private boolean selected;
	private Disease disease;
	private String state;
	private boolean enabled;
	private String lastLogin;

	public PatientInfo(Long visitorId, PatientService patientService, UserConnection conn, Disease disease,
			Long currentpatientId, Long currentDiseaseId) {
		User user = conn.getUser();
		if (user.getId().equals(visitorId)) {
			user = conn.getOwner();
		}

		Patient patient = patientService.findById(user.getId());

		this.selected = patient.getId().equals(currentpatientId) && (disease != null && disease.getId().equals(currentDiseaseId));
		//this.name = patient.getName() != null ? patient.getName().getName() : "";
		this.name = patient.getUserAccount().getLogin();
		this.gender = UserUtil.fmtGender(user);
		this.year = patient.getBirthday();
		this.id = patient.getId();
		this.lastLogin = DateUtils.germanShortDate2str(patient.getLastLogin());
		this.disease = disease;

		switch (conn.getState()) {
		case A:
			this.state = "state_accepted";
			this.enabled = true;
			break;
		case P:
			this.state = "state_pending";
			break;
		case C:
			this.state = "state_canceled";
			break;
		}
		
		if(disease == null){
			this.enabled = false;
		}
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isSelected() {
		return selected;
	}

	public void setSelected(boolean selected) {
		this.selected = selected;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	/**
	 * @param disease the disease to set
	 */
	public void setDisease(Disease disease) {
		this.disease = disease;
	}

	/**
	 * @return the disease
	 */
	public Disease getDisease() {
		return disease;
	}

	/**
	 * @return lastLogin
	 */
	public String getLastLogin() {
		return this.lastLogin;
	}
}
