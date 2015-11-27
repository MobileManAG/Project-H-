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
package com.mobileman.projecth.web.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;

import com.mobileman.projecth.business.DoctorService;
import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.business.UserConnectionService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserActivationState;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.web.model.ConnectionInfo;
import com.mobileman.projecth.web.model.DataHolder;

@Service
public class ConnectionsHelper {

	@Autowired
	UserConnectionService userConnectionService;

	@Autowired
	UserService userService;

	@Autowired
	PatientService patientService;
	
	@Autowired
	DoctorService doctorService;

	/*
	private List<UserConnection> myConnections(Long userId) {
		List<UserConnection> rc = new ArrayList<UserConnection>();

		List<UserConnection> connections = userConnectionService.findAll();
		for (UserConnection uc : connections) {
			if (!UserConnectionState.C.equals(uc.getState()) && (userId.equals(uc.getUser().getId()) || userId.equals(uc.getOwner().getId()))) {
				rc.add(uc);
			}
		}

		return rc;
	}
	 */

	public String initConnectons(HttpServletRequest request, HttpServletResponse response, Model model, Long userId) {
		
		List<UserConnection> all = userConnectionService.findAllNotCanceledConnections(userId);
		User user = userService.findById(userId);
		List<ConnectionInfo> rc = new ArrayList<ConnectionInfo>();
		
		for (UserConnection conn : all) {
			rc.add(new ConnectionInfo(userId, conn, patientService));
		}

		model.addAttribute("connections", rc);
		model.addAttribute("owner", user);
		
		return "meineverbindungen";
	}

	public String findLogin(HttpServletRequest request, Model model, UserType userType, User owner) {
		DataHolder data = new DataHolder(request);
		//find doctor - if found then add into connections
		String login = request.getParameter("login");
		if (login == null || login.trim().length() == 0) {
			model.addAttribute("notfound", true);
			return "meineverbindungen_neue";
		}
		
		boolean connectionExists = userConnectionService.notCanceledConnectionExists(owner.getId(), login);
		if (connectionExists) {
			model.addAttribute("connection_exists", true);
		} else if (!owner.getUserType().equals(UserType.P)) {
			User user = UserUtils.findUserByLogin(userService, login);
			if (user != null && userType.equals(user.getUserType())) {
				if (!user.isConnectionRequestsBlocked() && user.getActivationState().equals(UserActivationState.VERIFIED)) {
					//user found
					if (UserType.P.equals(user.getUserType())) {
						//load patient info
						PatientUtils.loadPatientHeader(model, data, owner, patientService.findById(user.getId()), null, connectionExists);
					} else if (UserType.D.equals(user.getUserType())) {
						DoctorUtils.loadDoctorHeader(model, data, owner, user, connectionExists);
					}
					
					model.addAttribute("user", user);
				} else {
					model.addAttribute("userblocked", true);
				}
			} else {
				model.addAttribute("notfound", true);
			}
			
			model.addAttribute("users", null);
		} else {
			
			List<User> invitableUsers = userConnectionService.findInvitableUsers(login, owner.getId(), Arrays.asList(UserType.D, UserType.P));
			if (invitableUsers.isEmpty()) {
				model.addAttribute("notfound", true);
			} else {
				List<UserType> standardUserTypes = Arrays.asList(UserType.P);
				
				List<User> doctors = new ArrayList<User>();
				List<User> standardUsers = new ArrayList<User>();
				
				for (User user : invitableUsers) {
					if (!user.isConnectionRequestsBlocked() && user.getActivationState().equals(UserActivationState.VERIFIED)) {
						if (standardUserTypes.contains(user.getUserType())) {
							standardUsers.add(user);
						} else if (user.getUserType().equals(UserType.D)) {
							doctors.add(user);
						}
					}
				}
				
				if (doctors.isEmpty() && standardUsers.isEmpty()) {
					standardUsers = null;
					doctors = null;
					model.addAttribute("notfound", true);
				} else {
					if (doctors.isEmpty()) {
						doctors = null;
					}
					
					if (standardUsers.isEmpty()) {
						standardUsers = null;
					}
					
					model.addAttribute("doctors", doctors);
					model.addAttribute("users", standardUsers);
				}			
			}
		}

		return "meineverbindungen_neue";
	}

	private UserConnection loadConnection(Long connid) {
		try {
			UserConnection uc = userConnectionService.findById(connid);
			return uc;
		} catch (Exception ex) {
		}
		return null;
	}

	private UserConnection loadConnectionForConfirm(Long connid, Long userId) {
		UserConnection uc = loadConnection(connid);
		if (uc != null) {
			if (userId.equals(uc.getUser().getId())) {
				return uc;
			}
		}
		return null;
	}

	private UserConnection loadConnectionForCancel(Long connid, Long userId) {
		UserConnection uc = loadConnection(connid);
		if (uc != null) {
			if (userId.equals(uc.getUser().getId()) || userId.equals(uc.getOwner().getId())) {
				return uc;
			}
		}
		return null;
	}

	public String connectionCancel(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String connid, Long userId) {
		Long coId = NumUtils.convert2long(connid);
		UserConnection uc = loadConnectionForCancel(coId, userId);
		if (uc != null) {
			//uc.setState(UserConnectionState.C);
			//userConnectionService.save(uc);
			userConnectionService.cancelInvitation(uc.getOwner().getId(), uc.getUser().getId());
		}
		return initConnectons(request, response, model, userId);
	}

	public String connectionConfirml(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String connid, Long userId) {
		Long coId = NumUtils.convert2long(connid);
		UserConnection uc = loadConnectionForConfirm(coId, userId);
		if (uc != null) {
			try {
				userConnectionService.acceptInvitation(uc.getUser().getId(), uc.getOwner().getId());
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return initConnectons(request, response, model, userId);
	}

	public String connectionCreate(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String userid, UserType userType,
			User owner) {
		//check userid
		Long id = NumUtils.convert2long(userid);
		boolean connectionCreated = false;
		if (userid != null) {
			User user = userService.findById(id);
			try {
				// patient can have connections with doctor and also with patient
				if (userType.equals(user.getUserType()) || owner.getUserType().equals(UserType.P)) {
					userConnectionService.invite(owner.getId(), id);
					connectionCreated = true;
				}
			} catch (Exception ex) {
				
			}
			
			// First sign-in of user and connection was created
			List<UserConnection> connections = userConnectionService.findAllNotCanceledConnections(owner.getId());
			if (connectionCreated && owner.getLoginsCount() == 1 && connections.size() == 1) {
				// return to index in case of First sign-in when successful conection was made
				return "index";
			}
		}
		
		return initConnectons(request, response, model, owner.getId());
	}
}
