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

import javax.servlet.http.HttpServletRequest;

import nl.captcha.Captcha;

import org.springframework.ui.Model;

public class CaptchaUtil {

	private static final String KEY_ERROR = "CAPTCHA_ERROR";

	static public boolean verify(HttpServletRequest request, Model model) {
		Captcha captcha = (Captcha) request.getSession().getAttribute(Captcha.NAME);
		String answer = request.getParameter("captchaAnswer");
		if (captcha.isCorrect(answer)) {
			return true;
		}
		model.addAttribute(KEY_ERROR, true);
		return false;
	}
	
	static public boolean verify(HttpServletRequest request, Model model, String answer) {
		Captcha captcha = (Captcha) request.getSession().getAttribute(Captcha.NAME);
		if (captcha.isCorrect(answer)) {
			return true;
		}
		model.addAttribute(KEY_ERROR, true);
		return false;
	}

	public static void fillConversationWithError(Conversation conversation) {
		conversation.put(KEY_ERROR, true);
	}
}
