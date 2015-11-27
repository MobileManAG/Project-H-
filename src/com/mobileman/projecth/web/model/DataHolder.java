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

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.DoctorService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.doctor.Doctor;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.util.Pair;
import com.mobileman.projecth.web.controller.InitController;
import com.mobileman.projecth.web.util.PersistentCookieHelper;
import com.mobileman.projecth.web.util.Services;

public class DataHolder {

	private static final String LOGGED_TYPE = "logged_type";
	private static final String CURRENT_PATIENT = "logged_user";
	private static final String CURRENT_DISEASE = "selected_disease";
	private static final String LOGGED_DOCTOR = "logged_doctor";
	private static final String LOGGED_ADMIN = "logged_admin";
	private static final String DATE_FROM = "date_from";
	private static final String DATE_TO = "date_to";
	
	private static final String SELECTED_PATIENT = "selected_user";
	private static final String SELECTED_PATIENT_DISEASE = "selected_user_disease";

	private HttpServletRequest request;

	public DataHolder(HttpServletRequest request) {
		this.request = request;
	}

	public UserType getType() {
		return (UserType) request.getSession().getAttribute(LOGGED_TYPE);
	}

	public void setType(UserType type) {
		request.getSession().setAttribute(LOGGED_TYPE, type);
	}

	public Patient getPatient() {
		//load from db
		Long id = (Long) request.getSession().getAttribute(CURRENT_PATIENT);

		PatientService patientService = InitController.getWebApplicationContext().getBean(PatientService.class);
		if (id == null) {
			//try to autologin - if cookie is doctor don't load
			User u = new PersistentCookieHelper().getUser(Services.getUserService(), request, null);
			if (u != null) {
				id = u.getId();
			}
			return null;
		}
		return patientService.findById(id);
	}

	/**
	 * @return User
	 */
	public User getUser() {
		//load from db
		User result = null;
		Long id = (Long) request.getSession().getAttribute(CURRENT_PATIENT);
		if (id == null) {
			id = (Long) request.getSession().getAttribute(LOGGED_DOCTOR);
			if (id != null) {
				result = Services.getDoctorService().findById(id);
			}
		} else {
			result = Services.getPatientService().findById(id);
		}
		
		if (result == null) {
			//try to autologin - if cookie is doctor don't load
			result = new PersistentCookieHelper().getUser(Services.getUserService(), request, null);
		}

		return result;
	}

	public void setPatientId(Long patientId) {
		request.getSession().setAttribute(CURRENT_PATIENT, patientId);
	}

	public Disease getDisease() {
		Disease result = null;
		Long id = (Long) request.getSession().getAttribute(CURRENT_DISEASE);
		DiseaseService diseaseService = InitController.getWebApplicationContext().getBean(DiseaseService.class);
		if (id != null) {
			result = diseaseService.findById(id);
		}

		return result;
	}
	/**
	 * @return InitialSymptomAndDaiagnosisDate
	 */
	public Pair<Date, Date> getInitialSymptomAndDaiagnosisDate() {
		Pair<Date, Date> result = new Pair<Date, Date>(null, null);
		
		PatientService patientService = InitController.getWebApplicationContext().getBean(PatientService.class);
		Long diseaseId = (Long) request.getSession().getAttribute(CURRENT_DISEASE);
		Long patientId = (Long) request.getSession().getAttribute(CURRENT_PATIENT);
		if (patientId != null && diseaseId != null) {
			result = patientService.findFirstSymptomeAndDiagnosisDate(patientId, diseaseId);
		}

		return result;
	}

	public void setDiseaseId(Long diseaseId) {
		request.getSession().setAttribute(CURRENT_DISEASE, diseaseId);
	}

	public Long getDiseaseId() {
		return (Long) request.getSession().getAttribute(CURRENT_DISEASE);
	}

	public boolean isPatient() {
		return getPatient() != null;
	}

	public Doctor getDoctor() {
		//load from db
		Long id = (Long) request.getSession().getAttribute(LOGGED_DOCTOR);

		DoctorService doctorService = InitController.getWebApplicationContext().getBean(DoctorService.class);
		if (id == null) {
			UserService userService = InitController.getWebApplicationContext().getBean(UserService.class);
			//try to autologin - if cookie is doctor don't load
			User u = new PersistentCookieHelper().getUser(userService, request, null);
			if (u != null) {
				id = u.getId();
			}
			return null;
		}
		return doctorService.findById(id);
	}
	
	/**
	 * @return Admin
	 */
	public User getAdmin() {
		//load from db
		Long id = (Long) request.getSession().getAttribute(LOGGED_ADMIN);
		if (id == null) {
			return null;
		}
		
		UserService userService = InitController.getWebApplicationContext().getBean(UserService.class);
		return userService.findById(id);
	}

	public void setDoctorId(Long doctorId) {
		request.getSession().setAttribute(LOGGED_DOCTOR, doctorId);
	}

	public boolean isDoctor() {
		return getDoctor() != null;
	}

	public Date getDateFrom() {
		Date date = (Date) request.getSession().getAttribute(DATE_FROM);
		if (date == null) {
			Calendar c1 = Calendar.getInstance();
			c1.add(Calendar.DATE, -30);
			date = c1.getTime();
		}
		return date;
	}

	public void setDateFrom(Date date) {
		request.getSession().setAttribute(DATE_FROM, date);
	}

	public Date getDateTo() {
		Date date = (Date) request.getSession().getAttribute(DATE_TO);
		return date == null ? new Date() : date;
	}

	public void setDateTo(Date date) {
		request.getSession().setAttribute(DATE_TO, date);
	}
	
	public boolean isAdmin() {
		return getAdmin() != null;
	}

	/**
	 * @param id
	 */
	public void setAdminId(Long id) {
		request.getSession().setAttribute(LOGGED_ADMIN, id);
	}

	/**
	 * @param patientId
	 */
	public void setSelectedPatientId(Long patientId) {
		request.getSession().setAttribute(SELECTED_PATIENT, patientId);
	}
	
	/**
	 * @return SELECTED_PATIENT
	 */
	public Long getSelectedPatientId() {
		return (Long) request.getSession().getAttribute(SELECTED_PATIENT);
	}

	/**
	 * @param diseaseId
	 */
	public void setSelectedDiseaseId(Long diseaseId) {
		request.getSession().setAttribute(SELECTED_PATIENT_DISEASE, diseaseId);
	}
	
	/**
	 * @return SELECTED_PATIENT
	 */
	public Long getSelectedDiseaseId() {
		return (Long) request.getSession().getAttribute(SELECTED_PATIENT_DISEASE);
	}

}
