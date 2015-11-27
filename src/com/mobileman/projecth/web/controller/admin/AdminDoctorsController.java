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
package com.mobileman.projecth.web.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mobileman.projecth.business.exception.LoginException;
import com.mobileman.projecth.business.exception.LoginException.Reason;
import com.mobileman.projecth.domain.doctor.Doctor;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.web.controller.LoginController;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.LoginInfo;
import com.mobileman.projecth.web.util.CaptchaUtil;
import com.mobileman.projecth.web.util.Conversation;

/**
 * @author mobileman
 *
 */
@Controller
public class AdminDoctorsController extends AdminControllerBase {

	/**
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/anmeldung")
	public String getStartPage(HttpServletRequest request, HttpServletResponse response) {
		return processPage(request.getSession().getServletContext(), "anmeldung");
	}

	/**
	 * @param session
	 * @param request
	 * @param page 
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/{page}")
	public String getPage(HttpSession session, HttpServletRequest request, @PathVariable String page) {
		return processPage(session.getServletContext(), page);
	}
	

	/**
	 * @param request
	 * @param model 
	 * @param response 
	 * @param loginInfo 
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/admin/anmeldung")
	public String login(HttpServletRequest request, Model model, HttpServletResponse response, @Valid LoginInfo loginInfo) {
		try {
			
			if (!CaptchaUtil.verify(request, model)) {
				CaptchaUtil.fillConversationWithError(new Conversation(request.getSession()));
				return redirectToLogin();
			}

			User user = userService.login(loginInfo.getLogin(), loginInfo.getPassword());
			if (!user.getUserType().equals(UserType.A)) {
				throw new LoginException(LoginException.Reason.INVALID_CREDENTIALS);
			}
			
			DataHolder data = new DataHolder(request);
			data.setType(user.getUserType());
			data.setAdminId(user.getId());
			
			request.getSession().removeAttribute(LoginController.LOGIN_CAPTCHA_KEY);

			return "redirect:/admin/doctor-verify";
		} catch (Exception e) {
			//e.printStackTrace();
			Conversation conv = new Conversation(request.getSession());
			if (e instanceof LoginException) {
				LoginException loginException = (LoginException) e;
				boolean captcha = true;
				if (Reason.INVALID_CREDENTIALS.equals(loginException.getReason())
						|| Reason.USER_DOES_NOT_EXISTS.equals(loginException.getReason())) {
					if (loginException.getUnsuccessfulLoginsCount() < 3) {
						captcha = false;
					}
				}
				if (captcha) {
					request.getSession().setAttribute(LoginController.LOGIN_CAPTCHA_KEY, true);
				}
			}
			conv.put("login_error", true);
			return redirectToLogin();
		}
	}
	
	/**
	 * @return List<DoctorInfo>
	 */ 
	private List<Doctor> getDoctors() {
		List<Doctor> doctors = doctorService.findAllDoctorsWithAccounts();
		return doctors;
	}
	
	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/doctor-verify")
	public String doctorVerifyGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("doctors", getDoctors());
		return "admin/doctor-verify";
	}
	
	/**
	 * @param request
	 * @param response
	 * @param model
	 * @param doctorId 
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/doctor-verify/{doctorId}")
	public String doctorDoVerifyGet(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String doctorId) {
		
		userService.verifyUser(Long.parseLong(doctorId));
		model.addAttribute("doctors", getDoctors());
		return "admin/doctor-verify";
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @param doctorId 
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/doctor-unverify/{doctorId}")
	public String doctorDoUnverifyGet(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String doctorId) {
				
		userService.unverifyUser(Long.parseLong(doctorId));
		model.addAttribute("doctors", getDoctors());
		return "admin/doctor-verify";
	}
	
	/**
	 * @param request
	 * @param response
	 * @param model
	 * @param doctorId 
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/doctor-block/{doctorId}")
	public String doctorDoBlockGet(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String doctorId) {
		
		userService.blockUser(Long.parseLong(doctorId));
		model.addAttribute("doctors", getDoctors());
		return "admin/doctor-verify";
	}
	
	/**
	 * @param request
	 * @param response
	 * @param model
	 * @param doctorId 
	 * @return String
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/doctor-unblock/{doctorId}")
	public String doctorDoUnblockGet(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String doctorId) {
		
		userService.unblockUser(Long.parseLong(doctorId));
		model.addAttribute("doctors", getDoctors());
		return "admin/doctor-verify";
	}
}
