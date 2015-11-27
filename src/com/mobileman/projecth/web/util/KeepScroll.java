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

import org.springframework.ui.Model;

public class KeepScroll {
	private static final String KEEP_SCROLL_KEY = "keepScrollHidden";

	public static void save(HttpServletRequest request, Model model) {
		model.addAttribute(KEEP_SCROLL_KEY, request.getParameter(KEEP_SCROLL_KEY));
	}
}
