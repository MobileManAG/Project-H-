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

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Conversation {

	private HttpSession session;
	private HttpServletRequest request;

	private static final String CONV_KEY = "ConversationImpl1";

	public Conversation(HttpSession session) {
		this(session, null);
	}

	public Conversation(HttpSession session, HttpServletRequest request) {
		this.session = session;
		this.request = request;
	}

	public void put(String key, Object value) {
		@SuppressWarnings("unchecked")
		Map<String, Object> data = (Map<String, Object>) this.session.getAttribute(CONV_KEY);

		if (data == null) {
			data = new HashMap<String, Object>();
			this.session.setAttribute(CONV_KEY, data);
		}
		data.put(key, value);
	}

	// retrieve all from conversations cope to request scope
	public void retrieve() {
		@SuppressWarnings("unchecked")
		Map<String, Object> data = (Map<String, Object>) this.session.getAttribute(CONV_KEY);
		if (data == null) {
			return;
		}

		this.session.removeAttribute(CONV_KEY);

		for (Entry<String, Object> entry : data.entrySet()) {
			this.request.setAttribute(entry.getKey(), entry.getValue());
		}
	}
}
