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

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public final class ViewState {

	public static void copyViewState(HttpServletRequest request, Model model) {
		Map<String, String> postValues = new HashMap<String, String>();
		model.addAttribute("postValues", postValues);
		for (@SuppressWarnings("unchecked")
		Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
			String name = e.nextElement();
			String value = request.getParameter(name);
			postValues.put(name, value);

			//remove later, use only postValues
			if (!name.startsWith("select") && !name.contains("password")) {
				model.addAttribute(name, value);
			}
		}
	}
}
