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

package com.mobileman.projecth.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobileman.projecth.business.UserService;

/**
 * @author mobileman
 *
 */
@Controller
public class UserController extends AbstractController {
	
	@Autowired
	UserService userService;

	/**
	 * 
	 */
	public UserController() {
		super("user");
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/user/user-info")
	public String userInfoGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		if (!isUserLoggedIn(request)) {
			return "/index";
		}
		
		String userId = request.getParameter("userId");
		if (userId == null || userId.equals("0") || userId.trim().length() == 0) {
			return "error";
		}
		
		model.addAttribute("user", userService.findById(Long.valueOf(userId.trim())));
		return "ok";
	}
}
