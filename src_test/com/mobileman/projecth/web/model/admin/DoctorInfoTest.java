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
 * DoctorInfoTest.java
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

import static org.junit.Assert.*;

import org.junit.Test;

import com.mobileman.projecth.domain.data.Address;
import com.mobileman.projecth.domain.data.MedicalInstitution;
import com.mobileman.projecth.domain.data.Name;
import com.mobileman.projecth.domain.data.PhoneNumber;
import com.mobileman.projecth.domain.data.id_types.PostalCode;
import com.mobileman.projecth.domain.doctor.Doctor;

/**
 * @author mobileman
 *
 */
public class DoctorInfoTest {

	/**
	 * @throws Exception
	 */
	@Test
	public void getDetail() throws Exception {
		
		Doctor doctor = new Doctor();
		doctor.setTitle("Mudr.");
		doctor.setName(new Name("Jan", "Novak"));
		doctor.setMedicalInstitution(new MedicalInstitution());
		doctor.getMedicalInstitution().setAddress(new Address());
		doctor.getMedicalInstitution().getAddress().setAddress("Berlin strasse");
		doctor.getMedicalInstitution().getAddress().setPlace("Berlin");
		doctor.getMedicalInstitution().getAddress().setNumber("10/2");
		doctor.getMedicalInstitution().getAddress().setPostalCode(new PostalCode("05901"));
		doctor.getMedicalInstitution().setFaxNumber(new PhoneNumber("+49", "917918345"));
		doctor.getMedicalInstitution().setPhoneNumber(new PhoneNumber("+49", "423345675"));
		doctor.getMedicalInstitution().setName("Hospital Berlin");
		doctor.getMedicalInstitution().setHomePageUrl("www.media.com");
		DoctorInfo doctorInfo = new DoctorInfo(doctor);
		String detail = doctorInfo.getDetail();
		assertEquals("Hospital Berlin, Mudr. Jan Novak, Berlin strasse 10/2, 05901 Berlin, +49 423345675, +49 917918345", detail);
		
		doctor.setMedicalInstitution(null);
		detail = doctorInfo.getDetail();
		assertEquals("Mudr. Jan Novak", detail);
	}
}
