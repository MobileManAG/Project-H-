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
package com.mobileman.projecth.web.controller.patient;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.util.ConnectionsHelper;

@Controller
public class VerbindungenController extends AbstractPatientController {
	@Autowired
	ConnectionsHelper connectionsHelper;

	@RequestMapping(method = RequestMethod.GET, value = "/patient/meineverbindungen")
	public String initConnectons(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "patient/" + connectionsHelper.initConnectons(request, response, model, new DataHolder(request).getPatient().getId());
	}

	@RequestMapping(method = RequestMethod.POST, value = "/patient/meineverbindungen_neue")
	public String findLogin(HttpServletRequest request, Model model) {
		return "patient/" + connectionsHelper.findLogin(request, model, UserType.D, new DataHolder(request).getPatient());
	}

	@ResponseBody	
	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/conn/cancel/{connid}")
	public String connectionCancelPost(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String connid) {
		connectionsHelper.connectionCancel(request, response, model, connid, new DataHolder(request).getPatient().getId());
		return "ok";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.GET, value = "/patient/conn/confirm/{connid}")
	public String connectionConfirml(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String connid) {
		return "patient/" + connectionsHelper.connectionConfirml(request, response, model, connid, new DataHolder(request).getPatient().getId());
	}

	@Transactional
	@RequestMapping(method = RequestMethod.GET, value = "/patient/conn/create/{userid}")
	public String connectionCreate(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String userid) {
		DataHolder dataHolder = new DataHolder(request);
		return "patient/" + connectionsHelper.connectionCreate(request, response, model, userid, UserType.D, dataHolder.getPatient());
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return patient/
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/meineverbindungen_neue")
	public String connectionNewGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		connectionsHelper.initConnectons(request, response, model, new DataHolder(request).getPatient().getId());
		return "patient/meineverbindungen_neue";
	}
}
