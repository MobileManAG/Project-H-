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
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.mobileman.filter.OpenSessionFilter;
import com.mobileman.projecth.web.util.Menu;

@Controller
@RequestMapping(value = "/init")
public class InitController {

	static WebApplicationContext webApplicationContext;

	@RequestMapping(method = RequestMethod.GET)
	public String init(HttpServletRequest request, Model model) {
		initApplication(request);
		return "redirect:/behandlung";
	}

	private static void initApplication(HttpServletRequest request) {
		// workaround for OpenSessionInView spring class
		webApplicationContext = RequestContextUtils.getWebApplicationContext(request);
		OpenSessionFilter.setWebApplicationContext(webApplicationContext);
		//load menus
		HttpSession session = request.getSession();
		session.getServletContext().setAttribute("menu", new Menu(request));
		//session timeout seconds
		session.getServletContext().setAttribute("session_timeout_seconds", session.getMaxInactiveInterval());
	}

	public static WebApplicationContext getWebApplicationContext() {
		return webApplicationContext;
	}
}
