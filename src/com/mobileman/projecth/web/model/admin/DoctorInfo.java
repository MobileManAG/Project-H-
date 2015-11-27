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
 * DoctorInfo.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 6.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.model.admin;

import com.mobileman.projecth.domain.doctor.Doctor;
import com.mobileman.projecth.domain.util.data.MedicalInstitutionUtil;
import com.mobileman.projecth.domain.util.user.UserUtil;

/**
 * @author mobileman
 *
 */
public class DoctorInfo {
	
	private final  Doctor doctor;
	
	/**
	 * @param doctor
	 */
	public DoctorInfo(Doctor doctor) {
		super();
		this.doctor = doctor;
	}
	
	/**
	 * 
	 * @return description of a doctor
	 */
	public String getDetail() {
		StringBuffer buffer = new StringBuffer(500);
		if (doctor.getMedicalInstitution() != null) {
			if (doctor.getMedicalInstitution().getName() != null) {
				buffer.append(doctor.getMedicalInstitution().getName());
				buffer.append(", ");
			}
		}
		
		String name = UserUtil.fmtName(doctor);
		if (name.length() > 0) {
			buffer.append(name);
			buffer.append(", ");
		}
		
		if (doctor.getMedicalInstitution() != null) {
			String mi = MedicalInstitutionUtil.fmtMedicalInstitution(doctor.getMedicalInstitution());
			if (mi.length() > 0) {			
				buffer.append(mi);
				buffer.append(", ");
			}
			
			if (doctor.getMedicalInstitution().getPhoneNumber() != null) {
				buffer.append(doctor.getMedicalInstitution().getPhoneNumber().format());
				buffer.append(", ");
			}
			
			if (doctor.getMedicalInstitution().getFaxNumber() != null) {
				buffer.append(doctor.getMedicalInstitution().getFaxNumber().format());
				buffer.append(", ");
			}
		}
		
		//${doctor.medicalInstitution.name}, ${doctor.title} ${doctor.name.name} ${doctor.name.surname}, ${doctor.medicalInstitution.address.address} ${doctor.medicalInstitution.address.number}, ${doctor.medicalInstitution.address.postalCode.code} ${doctor.medicalInstitution.address.place}
		//</br>Telefon: ${doctor.medicalInstitution.phoneNumber.countryCode} ${doctor.medicalInstitution.phoneNumber.number} Fax: ${doctor.medicalInstitution.faxNumber.countryCode} ${doctor.medicalInstitution.faxNumber.number} Homepage:${doctor.medicalInstitution.homePageUrl}
		String result = buffer.toString().trim();
		if (result.length() > 0 && result.charAt(result.length() - 1) == ',') {
			result = result.substring(0, result.length() - 1);
		}
		return result;
	}
	
	/**
	 * @return True if doctor's account is deleted
	 */
	public boolean hasDeletedAccount() {
		return doctor.getUserAccount() == null;
	}

	/**
	 * @return doctor
	 */
	public Doctor getDoctor() {
		return this.doctor;
	}
}
