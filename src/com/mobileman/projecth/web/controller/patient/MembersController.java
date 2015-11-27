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
 * UserController.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 16.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.controller.patient;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mobileman.projecth.business.DoctorService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.UserConnectionService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.MemeberInfo;
import com.mobileman.projecth.web.service.PatientDataService;

/**
 * @author mobileman
 *
 */
@Controller
public class MembersController extends AbstractPatientController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserConnectionService userConnectionService;

	@Autowired
	PatientService patientService;
	
	@Autowired
	DoctorService doctorService;
	
	@Autowired
	PatientDataService patientDataService;

	/**
	 * 
	 */
	public MembersController() {
		super();
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/members")
	public String memebersInfoGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		DataHolder dataHolder = new DataHolder(request);
		User loggedUser = dataHolder.getUser();
		if (loggedUser == null) {
			return "/patient/index";
		}
		
		User visitor = dataHolder.getUser();
		model.addAttribute("visitor", visitor);
		patientDataService.prepareData(request, model, visitor, null, null);
		
		return "/patient/members";
	}
	
	/**
	 * @param request
	 * @param model
	 * @param patientId
	 * @param diseaseId
	 * @return "/patient/members"
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/members/{patientId}/{diseaseId}")
	public String memeberInfoGet(HttpServletRequest request, Model model, @PathVariable Long patientId, @PathVariable Long diseaseId) {
		DataHolder data = new DataHolder(request);
		data.setSelectedPatientId(patientId);
		data.setSelectedDiseaseId(diseaseId);
		patientDataService.prepareData(request, model, data.getUser(), patientId == null ? null : patientId.toString(),
				diseaseId == null ? null : diseaseId.toString());
		return "/patient/members";
	}
	
	/**
	 * @param request
	 * @param model
	 * @param len
	 * @param type
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/members/date/{len}-{type}")
	public String changeDatePreddefined(HttpServletRequest request, Model model, @PathVariable Integer len, @PathVariable String type) {
		DataHolder data = new DataHolder(request);
		PatientDataService.changeDatePreddefined(request, model, len, type);
		return memeberInfoGet(request, model, data.getSelectedPatientId(), data.getSelectedDiseaseId());
	}
	
	/**
	 * @param request
	 * @param model
	 * @param d_from
	 * @param d_to
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/patient/members/changedate")
	public String changeDate(HttpServletRequest request, Model model, @RequestParam String d_from, @RequestParam String d_to) {
		DataHolder data = new DataHolder(request);
		patientDataService.changeDate(request, model, d_from, d_to);
		return memeberInfoGet(request, model, data.getSelectedPatientId(), data.getSelectedDiseaseId());
	}
	
	private List<MemeberInfo> initMemebers(User owner, Model model) {
		List<MemeberInfo> members = new ArrayList<MemeberInfo>();
		if (owner == null) {
			return members;
		}
		
		List<UserConnection> all = userConnectionService.findAllNotCanceledConnections(owner.getId());
		
		for (UserConnection conn : all) {
			members.add(new MemeberInfo(owner.getId(), conn));
		}

		model.addAttribute("members", members);
		model.addAttribute("owner", owner);
		
		return members;
	}
}
