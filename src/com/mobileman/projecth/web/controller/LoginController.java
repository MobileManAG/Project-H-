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
package com.mobileman.projecth.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.business.exception.LoginException;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.history.HistoryStorage;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.LoginInfo;
import com.mobileman.projecth.web.util.CaptchaUtil;
import com.mobileman.projecth.web.util.Conversation;
import com.mobileman.projecth.web.util.PersistentCookieHelper;

@Controller
@RequestMapping(value = "/login")
public class LoginController {

	public static final String LOGIN_CAPTCHA_KEY = "useLoginCaptcha";

	@Autowired
	private UserService userService;

	@RequestMapping(method = RequestMethod.GET)
	public String nothing(HttpServletRequest request) {
		return redirectToLogin();
	}

	@RequestMapping(method = RequestMethod.GET, value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		//remove persistent cookie
		new PersistentCookieHelper().removeUser(request, response);
		request.getSession().invalidate();
		return redirectToLogin();
	}

	@RequestMapping(method = RequestMethod.POST)
	public String doLogin(HttpServletRequest request, Model model, HttpServletResponse response, @Valid LoginInfo loginInfo) {
		try {
			//captcha

			Boolean useCaptcha = (Boolean) request.getSession().getAttribute(LOGIN_CAPTCHA_KEY);
			if (useCaptcha != null && useCaptcha) {
				if (!CaptchaUtil.verify(request, model)) {
					CaptchaUtil.fillConversationWithError(new Conversation(request.getSession()));
					return redirectToLogin();
				}
			}

			User user = userService.login(loginInfo.getLogin(), loginInfo.getPassword());

			PersistentCookieHelper cookieHelper = new PersistentCookieHelper();
			//create persistent cookie
			if (loginInfo.getStaylogged() != null && loginInfo.getStaylogged()) {
				cookieHelper.setUser(response, user);
			} else {
				cookieHelper.removeUser(request, response);
			}

			request.getSession().removeAttribute(LOGIN_CAPTCHA_KEY);

			return logInUser(request, user);
		} catch (Exception e) {
			//e.printStackTrace();
			Conversation conv = new Conversation(request.getSession());
			if (e instanceof LoginException) {
				LoginException loginException = (LoginException) e;
				boolean captcha = true;
				switch (loginException.getReason()) {
				case INVALID_CREDENTIALS:
					if (loginException.getUnsuccessfulLoginsCount() < 3) {
						captcha = false;
					}
					conv.put("login_error", true);
					break;
				case BLOCKED:
					conv.put("login_error_user_blocked", true);
					break;
				default:
					conv.put("login_error", true);
					break;
				}

				if (captcha) {
					request.getSession().setAttribute(LOGIN_CAPTCHA_KEY, true);
				}

			} else {
				conv.put("login_error", true);
			}

			return redirectToLogin();
		}
	}

	public String logInUser(HttpServletRequest request, User user) throws Exception {
		HistoryStorage.clear(request);

		DataHolder data = new DataHolder(request);
		data.setType(user.getUserType());

		switch (user.getUserType()) {
		case D:
			data.setPatientId(null);
			data.setDoctorId(user.getId());
			return "redirect:/arzt/";
		case P:
			data.setPatientId(user.getId());
			if (data.getUser().getLoginsCount() == 1) {
				return "redirect:/patient/meineverbindungen_neue";
			}

			return "redirect:/patient/";
		case C:
			data.setPatientId(null);
			data.setDoctorId(null);
			return "redirect:/customer/";
		default:
			throw new Exception();
		}
	}

	public static String redirectToLogin() {
		return "redirect:/behandlung/afterlogout";
	}

	public String autoLogin(HttpServletRequest request, HttpServletResponse response) {
		User user = new PersistentCookieHelper().getUser(userService, request, response);
		if (user != null) {
			//try to login
			try {
				return logInUser(request, user);
			} catch (Exception ex) {
			}
		}
		return null;
	}
}
