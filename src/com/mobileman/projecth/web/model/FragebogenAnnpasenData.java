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

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class FragebogenAnnpasenData {

	private static final String DATA_KEY = "FragebogenAnnpasenData";

	private HttpSession session;

	public FragebogenAnnpasenData(HttpSession session) {
		this.session = session;
	}
	
	public FragebogenAnnpasenDataHolder getData() {
		FragebogenAnnpasenDataHolder holder = (FragebogenAnnpasenDataHolder) session.getAttribute(DATA_KEY);
		if (holder == null) {
			holder = new FragebogenAnnpasenDataHolder();
			session.setAttribute(DATA_KEY, holder);
		}

		return holder;
	}

	public void clearData() {
		session.removeAttribute(DATA_KEY);
	}
	
	public void storeData(HttpServletRequest request) {
		clearData();
		FragebogenAnnpasenDataHolder holder = getData();
		List<String> elements = new ArrayList<String>();
		for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
			String name = null;
			String value = null;
			
			name = e.nextElement();
			value = request.getParameter(name);	
			
			elements.add(name);
			
			//id
			if(name.length() > 5 && name.substring(0, 5).equals("q_id_")){
				String question_id = name.substring(5);
				holder.putQuestionId(Long.valueOf(question_id), value);
			}
			
			//type
			if(name.length() > 5 && name.substring(0, 5).equals("type_")){
				String type_id = name.substring(5);
				holder.putType(Long.valueOf(type_id), value);
			}
			
			//action
			if(name.length() > 7 && name.substring(0, 7).equals("action_")){
				String action_id = name.substring(7);
				holder.putAction(Long.valueOf(action_id), value);
			}
			
			//question
			if(name.length() > 9 && name.substring(0, 9).equals("question_")){
				String question_id = name.substring(9);
				holder.putQuestion(Long.valueOf(question_id), value);
			}
			//explanation
			if(name.length() > 12 && name.substring(0, 12).equals("explanation_")){
				String explanation_id = name.substring(12);
				holder.putExplanation(Long.valueOf(explanation_id), value);
			}
			//options
			if(name.length() > 7 && name.substring(0, 7).equals("option_")){
				String option_id = name.substring(7, 8);
				String option_order = name.substring(9);
				holder.putOption(Long.valueOf(option_id), Long.valueOf(option_order), value);
			}
		}
		
		System.out.println("end.");
	}
	
	public class FragebogenAnnpasenDataHolder {
		
		Map<Long, Map<String, Object>> data;
		
		public FragebogenAnnpasenDataHolder() {
			this.data = new HashMap<Long, Map<String, Object>>();
		}

		public Map<Long, Map<String, Object>> getData() {
			return data;
		}

		public void setData(Map<Long, Map<String, Object>> data) {
			this.data = data;
		}
		
		public void putQuestionId(Long index, String value){
			
			Map<String, Object> question = getData().get(index);
			
			if(question == null){
				question = new HashMap<String, Object>();
				getData().put(index, question);
			}
			question.put("question_id", value);
		}
		
		public void putType(Long index, String value){
			
			Map<String, Object> question = getData().get(index);
			
			if(question == null){
				question = new HashMap<String, Object>();
				getData().put(index, question);
			}
			question.put("type", value);
		}
		
		public void putAction(Long index, String value){
			
			Map<String, Object> question = getData().get(index);
			
			if(question == null){
				question = new HashMap<String, Object>();
				getData().put(index, question);
			}
			question.put("action", value);
		}
		
		public void putQuestion(Long index, String value){
			
			Map<String, Object> question = getData().get(index);
			
			if(question == null){
				question = new HashMap<String, Object>();
				getData().put(index, question);
			}
			question.put("question", value);
		}

		public void putExplanation(Long index, String value){
	
			Map<String, Object> question = getData().get(index);
	
			if(question == null){
				question = new HashMap<String, Object>();
				getData().put(index, question);
			}
			question.put("explanation", value);
		}
		
		@SuppressWarnings("unchecked")
		public void putOption(Long index, Long order, String value){
			Map<String, Object> question = getData().get(index);
			Map<Long, String> option = null;
			if(question == null){
				option = new HashMap<Long, String>();
				question = new HashMap<String, Object>();
				question.put("option", option);
				getData().put(index, question);
			}
			
			option = (Map<Long, String>) question.get("option");
			
			if(option == null){
				option = new HashMap<Long, String>();
			}
			
			option.put(order, value);
			question.put("option", option);
		}
	}
}
