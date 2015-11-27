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
import java.util.Collections;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.mobileman.projecth.business.ConfigurationService;
import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.business.exception.LoginException;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserWeight;
import com.mobileman.projecth.domain.user.connection.UserConnection;

public class UserUtils {

	public static void changePassword(User user, HttpServletRequest request, Model model, UserService service,
			ConfigurationService configurationService) {
		
		try {
			//String oldPassword = request.getParameter("oldpassword");
			String password = request.getParameter("password");
			String password2 = request.getParameter("password2");
			if (StringUtils.isNotBlank(password)) {
				if (!password.equals(password2)) {
					model.addAttribute("passwordnotsame", true);
				} else {
					service.changePassword(user.getId(), password);
					model.addAttribute("passwordchanged", true);
				}
			}
		} catch (LoginException lex) {
			switch (lex.getReason()) {
			case PASSWORD_TOO_LONG:
				model.addAttribute("errorpassword_too_long", Boolean.TRUE);
				model.addAttribute("max_password_length", configurationService.getMaxPasswordLength());
				break;
			case PASSWORD_TOO_SHORT:
				model.addAttribute("errorpassword_too_short", Boolean.TRUE);
				model.addAttribute("min_password_length", configurationService.getMinPasswordLength());
				break;
			default:
				model.addAttribute("passworderror", true);
			}
		} catch (Exception ex) {
			model.addAttribute("passworderror", true);
		}
	}

	public static boolean changeAutologin(User user, HttpServletRequest request, HttpServletResponse response) {
		boolean autoLogin = false;
		PersistentCookieHelper cookie = new PersistentCookieHelper();
		if (request.getParameter("staylogged") != null) {
			cookie.setUser(response, user);
			autoLogin = true;
		} else {
			cookie.removeUser(request, response);
		}
		return autoLogin;
	}

	public static User findUserByLogin(UserService userService, String login) {
		if (StringUtils.isBlank(login)) {
			return null;
		}

		final User u;
		try {
			u = userService.findUserByLogin(login);
		} catch (Exception e) {
			return null;
		}

		return u;
	}

	/**
	 * @param userService
	 * @param data
	 * @return users
	 */
	public static List<User> findUsersByLoginNamePlace(UserService userService, String data) {
		if (StringUtils.isBlank(data)) {
			return Collections.emptyList();
		}

		final List<User> users;
		try {
			users = userService.findUsersByLoginNamePlace(data);
		} catch (Exception e) {
			return Collections.emptyList();
		}

		return users;
	}

	/**
	 * @param user
	 * @param conns
	 * @return true if for given user exists connection
	 */
	public static boolean connectionExists(User user, List<UserConnection> conns) {
		boolean result = false;
		for (UserConnection conn : conns) {
			if (conn.getUser().getId().equals(user.getId())) {
				result = true;
				break;
			}
			if (conn.getOwner().getId().equals(user.getId())) {
				result = true;
				break;
			}
		}
		
		return result;
	}

	/**
	 * @param user
	 * @return UserWeight
	 */
	public static UserWeight getUserWeight(User user) {
		UserWeight userWeight = null;
		if (user != null && user.getWeights() != null && !user.getWeights().isEmpty()) {
			userWeight = user.getWeights().get(user.getWeights().size() - 1);
		}
		
		return userWeight;
	}
	
	/**
	 * @param user
	 * @return UserWeight
	 */
	public static String fmtUserWeight(User user) {
		UserWeight userWeight = null;
		if (user != null && user.getWeights() != null && !user.getWeights().isEmpty()) {
			userWeight = user.getWeights().get(user.getWeights().size() - 1);
		}
		
		String result = "";
		if (userWeight != null) {
			result = userWeight.getWeight().doubleValue() + "kg (" + DateUtils.germanShortDate2str(userWeight.getDate()) + ")"; 
		}
		
		return result;
	}
	
	/**
	 * @param diseaseId
	 * @param diseases
	 * @return boolean
	 */
	public static boolean containsDisease(Long diseaseId, List<Disease> diseases) {
		for (Disease disease : diseases) {
			if (diseaseId.equals(disease.getId())) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * @param request
	 * @param doctor
	 */
	public static void saveDiseases(HttpServletRequest request, User doctor, UserService userService, DiseaseService diseaseService) {
		List<Long> diseaseIds = new ArrayList<Long>();
		for (@SuppressWarnings("unchecked")
		Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
			String nameStr = e.nextElement();
			if (nameStr.startsWith("disease")) {
				String value = request.getParameter(nameStr);
				Long diseaseId = NumUtils.convert2long(value);
				diseaseIds.add(diseaseId);
			}
		}
		List<Disease> addDiseases = new ArrayList<Disease>();
		List<Disease> removeDiseases = new ArrayList<Disease>();
		//add new diseases
		for (Long diseaseId : diseaseIds) {
			if (!UserUtils.containsDisease(diseaseId, doctor.getDiseases())) {
				addDiseases.add(diseaseService.findById(diseaseId));
			}
		}
		//remove old diseases
		for (Disease disease : doctor.getDiseases()) {
			if (!diseaseIds.contains(disease.getId())) {
				removeDiseases.add(disease);
			}
		}

		if (addDiseases.size() > 0) {
			userService.addDiseasesToUser(doctor.getId(), addDiseases);
		}
		if (removeDiseases.size() > 0) {
			userService.removeDiseasesFromUser(doctor.getId(), removeDiseases);
		}
	}
}
