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

import com.mobileman.projecth.domain.disease.Disease;


public class DiseaseInfo {
	private Long id;
	private String name;
	private boolean selected;
	private boolean enabled;
	private Date symptBeginDate;
	private Date diagnoseDate;
	private Long patientId;
	
	
	public DiseaseInfo(Disease disease, Long patientId, Long currentDiseaseId) {
		this.id = disease.getId();
		this.name = disease.getName();
		this.setPatientId(patientId);
		this.selected = disease.getId().equals(currentDiseaseId);
		this.enabled = true;
	}
	
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}


	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}


	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}


	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}


	/**
	 * @return the selected
	 */
	public boolean isSelected() {
		return selected;
	}


	/**
	 * @param selected the selected to set
	 */
	public void setSelected(boolean selected) {
		this.selected = selected;
	}


	/**
	 * @return the enabled
	 */
	public boolean isEnabled() {
		return enabled;
	}


	/**
	 * @param enabled the enabled to set
	 */
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}


	/**
	 * @return the symptBeginDate
	 */
	public Date getSymptBeginDate() {
		return symptBeginDate;
	}


	/**
	 * @param symptBeginDate the symptBeginDate to set
	 */
	public void setSymptBeginDate(Date symptBeginDate) {
		this.symptBeginDate = symptBeginDate;
	}


	/**
	 * @return the diagnoseDate
	 */
	public Date getDiagnoseDate() {
		return diagnoseDate;
	}


	/**
	 * @param diagnoseDate the diagnoseDate to set
	 */
	public void setDiagnoseDate(Date diagnoseDate) {
		this.diagnoseDate = diagnoseDate;
	}

	/**
	 * @param patientId the patientId to set
	 */
	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}

	/**
	 * @return the patientId
	 */
	public Long getPatientId() {
		return patientId;
	}

}
