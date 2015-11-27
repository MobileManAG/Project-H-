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
package com.mobileman.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.mobileman.projecth.web.model.DataHolder;

public class SecurityCheckFilter implements Filter {

	@Override
	public void destroy() {
	}

	@Override
	public void init(FilterConfig fc) throws ServletException {
		// servletContext = fc.getServletContext();
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {

		HttpServletRequest rq1 = (HttpServletRequest) request;
		String requestURI = rq1.getRequestURI().toLowerCase();
		DataHolder holder = new DataHolder(rq1);
		boolean error = false;
		if (requestURI.contains("/patient/")) {
			//check patient loaded			
			if (!holder.isPatient()) {
				error = true;
			}
		} else if (requestURI.contains("/arzt/")) {
			//check doctor loaded
			if (!holder.isDoctor()) {
				error = true;
			}
		} else if (requestURI.contains("/admin/") && !requestURI.contains("/admin/anmeldung")) {
			//check admin loaded
			if (!holder.isAdmin()) {
				error = true;
			}
		}

		///////////////
		if (requestURI.contains("/public")) {
			//redirect to /behandlung
			StringBuffer sb = rq1.getRequestURL();
			String newUrl = StringUtils.replace(sb.toString(), "/public", "/behandlung");
			java.io.PrintWriter out = response.getWriter();
			response.setContentType("text/html");

			out.println("<html>");
			out.println("<head>");
			out.println("<meta http-equiv=\"refresh\" content=\"0;url=");
			out.print(newUrl);
			out.println("\" />");
			out.println("</head>");
			out.println("<body>");
			out.println("</body>");
			out.println("</html>");

			return;
		}

		if (error) {
			//redirect
			request.getRequestDispatcher("/").forward(request, response);
			return;
		}
		filterChain.doFilter(request, response);
	}
}
