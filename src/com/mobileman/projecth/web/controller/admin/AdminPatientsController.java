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
 * AdminPatientsController.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 27.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.domain.patient.Patient;

/**
 * @author mobileman
 *
 */
@Controller
public class AdminPatientsController extends AdminControllerBase {
	
	@Autowired
	PatientService patientService;

	/**
	 * @return List<Patient>
	 */ 
	private List<Patient> getPatients() {
		List<Patient> patients = patientService.findAllPatientsWithAccounts();
		return patients;
	}
	
	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/patients")
	public String patientsGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("patients", getPatients());
		return "admin/patients";
	}
}
