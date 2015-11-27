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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.mobileman.projecth.business.DoctorService;
import com.mobileman.projecth.business.SystemService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.web.controller.AbstractController;
import com.mobileman.projecth.web.controller.LoginController;

/**
 * @author mobileman
 *
 */
@Controller
public abstract class AdminControllerBase extends AbstractController {

	@Autowired
	LoginController loginController;

	@Autowired
	UserService userService;
	
	@Autowired
	DoctorService doctorService;

	@Autowired
	SystemService systemService;

	/**
	 * 
	 */
	public AdminControllerBase() {
		super("admin");
	}
	
	/**
	 * @return String
	 */
	public static String redirectToLogin() {
		String result= "redirect:/admin/anmeldung";
		return result;
	}
}
