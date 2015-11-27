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
package com.mobileman.projecth.web.model.chart;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import com.mobileman.projecth.domain.chart.HaqChart;
import com.mobileman.projecth.domain.questionary.Question;

public abstract class AbstractPrepareChartData implements PrepareChartData {

	public static String getDateInfo(Date date, int days, Object value, String color) {
		Date from = date;

		Calendar cFrom = new GregorianCalendar();// Calendar.getInstance();
		cFrom.setTime(from);

		if (days != 0) {
			cFrom.add(Calendar.DAY_OF_MONTH, days);
		}

		StringBuilder sb = new StringBuilder();

		sb.append("x:Date.UTC(");
		sb.append(cFrom.get(Calendar.YEAR));
		sb.append(",");
		sb.append(cFrom.get(Calendar.MONTH));
		sb.append(",");
		sb.append(cFrom.get(Calendar.DAY_OF_MONTH));
		sb.append("),y:");
		sb.append(value == null ? "null" : value);
		if (color != null && !color.isEmpty()) {
			sb.append(",color:");
			sb.append(color);
			sb.append(", marker: { fillColor:");
			sb.append(color);
			sb.append("}");
		}

		return sb.toString();
	}

	/*
		//TODO - remove
		private List<Haq> haqs = null;

		protected void setHaqInfo(Long pacientId, Long haqId, Long diseaseId, QuestionaryInfo info) {
			if (haqs == null) {
				haqs = Services.getHaqService().findByDisease(diseaseId);
			}
			for (Haq haq : haqs) {
				if (haq.getId().equals(haqId)) {
					info.setName(haq.getHaqQuestion());
					info.setInfo(haq.getExplanation());
					info.setId(haqId);
					break;
				}
			}
		}

		protected QuestionaryInfo prepareQuestionaryInfo(DataHolder data, Model model, Long haqChartId) {
			QuestionaryInfo info = new QuestionaryInfo();
			model.addAttribute("haqChartData" + haqChartId, info);
			setHaqInfo(data.getPatient().getId(), haqChartId, data.getDiseaseId(), info);
			return info;
		}
	*/
	public static String getColorName(String name) {
		String color = null;
		if (name.startsWith("Ja")) {
			color = "#6cc0e8";
		} else if (name.startsWith("Keine") || name.startsWith("Kaine") || name.startsWith("Unbekannt")) {
			color = "#fde664";
		} else if (name.startsWith("Nein")) {
			color = "#ff6666";
		} else if (name.startsWith("Man")) {
			color = "#6cc0e8";
		} else if (name.startsWith("Frau")) {
			color = "#ff6666";
		}

		return color;
	}

	protected List<Long> getAllowedQuestions(HaqChart haqChart) {
		List<Question> questions = haqChart.getQuestions();
		List<Long> questionIds = new ArrayList<Long>();
		for (Question question : questions) {
			questionIds.add(question.getId());
		}
		return questionIds;
	}

	/*
	public class QuestionaryInfo {
		private long id;

		private String name;
		private String info;
		private List<PatientQuestionaryAnswerStatistic> questions;

		private List<String> Xinfo;
		private List<YInfo> Yinfo;

		private List<String> pieChart;

		public List<String> getPieChart() {
			return pieChart;
		}

		public void setPieChart(List<String> pieChart) {
			this.pieChart = pieChart;
		}

		public QuestionaryInfo() {
			Xinfo = new ArrayList<String>();
		}

		public List<String> getXinfo() {
			return Xinfo;
		}

		public List<YInfo> getYinfo() {
			return Yinfo;
		}

		public void setYinfo(List<YInfo> yinfo) {
			Yinfo = yinfo;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getInfo() {
			return info;
		}

		public void setInfo(String info) {
			this.info = info;
		}

		public List<PatientQuestionaryAnswerStatistic> getQuestions() {
			return questions;
		}

		public void setQuestions(List<PatientQuestionaryAnswerStatistic> questions) {
			this.questions = questions;
		}

		public long getId() {
			return id;
		}

		public void setId(long id) {
			this.id = id;
		}
	}

	public class YInfo {
		private String name;
		private List<Object> values;
		private String color;

		public YInfo(String name) {
			this.name = name;
			this.color = getColorName(name);
			values = new ArrayList<Object>();
		}

		public String getColor() {
			return color != null ? ("\"" + color + "\"") : "null";
		}

		public void setColor(String color) {
			this.color = color;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public List<Object> getValues() {
			return values;
		}

		public void setValues(List<Object> values) {
			this.values = values;
		}
	}
	*/
}
