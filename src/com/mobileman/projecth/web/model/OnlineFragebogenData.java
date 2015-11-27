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
package com.mobileman.projecth.web.model;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

//remove later
public class OnlineFragebogenData {

	private static final String DATA_KEY = "OnlineFragebogenData";

	private HttpSession session;

	public OnlineFragebogenData(HttpSession session) {
		this.session = session;
	}

	public OnlineFragebogenDataHolder getData() {
		OnlineFragebogenDataHolder holder = (OnlineFragebogenDataHolder) session.getAttribute(DATA_KEY);
		if (holder == null) {
			holder = new OnlineFragebogenDataHolder();
			session.setAttribute(DATA_KEY, holder);
		}

		return holder;
	}

	public void clearData() {
		session.removeAttribute(DATA_KEY);
	}

	public String getDataForOutput() {
		//[ ['sss', '2'], ['sss', '2'],['sss', '2'], ]
		//$('input:radio[name="gender"]').filter('[value="Male"]').attr('checked', true);

		StringBuilder sb = new StringBuilder();
		sb.append("[ ");
		OnlineFragebogenDataHolder holder = getData();

		for (Entry<String, String> custMap : holder.getRawData().entrySet()) {
			sb.append("['");
			sb.append(custMap.getKey());
			sb.append("','");
			sb.append(custMap.getValue());
			sb.append("'], ");
		}
		sb.append(" ]");
		return sb.toString();
	}

	public void storeData(HttpServletRequest request) {
		clearData();
		OnlineFragebogenDataHolder holder = getData();

		for (@SuppressWarnings("unchecked")
		Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
			String name = e.nextElement();
			//haq1-7
			//Long haq = null;
			//Long question = null;
			String value = null;
			value = request.getParameter(name);

			if (name.startsWith("cq") || name.startsWith("cv") || name.startsWith("ch")) {
				//custom question
				holder.getRawData().put(name, value);
			}
		}
	}

	public class OnlineFragebogenDataHolder {

		Map<String, String> rawData;

		public OnlineFragebogenDataHolder() {
			//this.data = new HashMap<Long, Map<Long, String>>();
			this.rawData = new HashMap<String, String>();
		}

		public Map<String, String> getRawData() {
			return rawData;
		}
	}
}
