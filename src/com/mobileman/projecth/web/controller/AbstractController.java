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

import java.io.File;
import java.io.FileFilter;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.model.DataHolder;

public abstract class AbstractController {

	private String prefix;

	private Set<String> views = null;

	private static final String DEFAULT_VIEW = "index";

	public AbstractController(String prefix) {
		this.prefix = prefix;
	}
	
	/**
	 * @param user
	 * @return true if user exists in context
	 */
	public boolean isUserLoggedIn(User user) {
		if (user != null && !user.getId().equals(0L)) {
			return true;
		}
		
		return false;
	}
	
	/**
	 * @param request 
	 * @return true if user did login-in
	 */
	public boolean isUserLoggedIn(HttpServletRequest request) {
		if (new DataHolder(request).getUser() == null) {
			return false;
		}
		
		return true;
	}

	protected String processPage(ServletContext servletContext, String page) {
		// load views
		if (views == null) {
			Set<String> tmp = new HashSet<String>();
			String publicViews = servletContext.getRealPath("/WEB-INF/views/" + prefix);
			File dir = new File(publicViews);
			final File[] files = dir.listFiles(new FileFilter() {
				@Override
				public boolean accept(File pathname) {
					if (pathname.isDirectory()) {
						return false;
					}
					String name = pathname.getName().toLowerCase();
					if (name.endsWith(".jsp")) {
						return true;
					}
					return false;
				}

			});
			for (File file : files) {
				String name = file.getName();
				tmp.add(name.substring(0, name.length() - 4));
			}
			views = tmp;
		}
		if (page == null || !views.contains(page)) {
			page = DEFAULT_VIEW;
		}
		return prefix + "/" + page;
	}
}
