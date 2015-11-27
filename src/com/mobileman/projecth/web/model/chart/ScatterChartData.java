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

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.ui.Model;

import com.mobileman.projecth.domain.chart.HaqChart;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.questionary.Question;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.DiaryData;
import com.mobileman.projecth.web.model.DiaryDataItem;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.Services;

public class ScatterChartData extends AbstractPrepareChartData {
	@Override
	public ChartDataResult prepare(DataHolder data, Model model, User patient, Haq haq, HaqChart haqChart) {
		//haq5
		List<DiaryData> yesnodata = new ArrayList<DiaryData>();
		List<String> questionsStr = new ArrayList<String>();

		Object[] result = new Object[2];
		result[0] = yesnodata;
		result[1] = questionsStr;

		Date nextDay = DateUtils.addDays(data.getDateTo(), 1);
		Date prevDay = DateUtils.addDays(data.getDateFrom(), -1);

		List<Question> questions = haqChart.getQuestions();
		List<Long> questionIds = new ArrayList<Long>();
		for (Question question : questions) {
			questionIds.add(question.getId());
		}

		List<Object[]> odata = Services.getPatientService().computeAllAnswersFrequencyReport(patient.getId(), haqChart.getId(), data.getDateFrom(),
				data.getDateTo());
		//Timestamp, Question, Answer  qa.logDate, question id, question text, answer id , string answer text
		for (Object[] obj : odata) {
			Timestamp ts = (Timestamp) obj[0];
			Long questionId = (Long) obj[1];
			String question = (String) obj[2];
			String answer = (String) obj[4];
			//find answer
			if (questionIds.size() != 0) {
				if (!questionIds.contains(questionId)) {
					continue;
				}
			}

			DiaryData dd = null;
			for (DiaryData d : yesnodata) {
				if (d.getName().equals(answer)) {
					dd = d;
					break;
				}
			}
			if (dd == null) {
				dd = new DiaryData(answer);
				yesnodata.add(dd);
				dd.setColor(getColorName(answer));
				dd.getItems().add(new DiaryDataItem(prevDay, null));
			}
			//add question
			int index = 0;
			for (index = 0; index < questionsStr.size(); index++) {
				String str = questionsStr.get(index);
				/*if ("".equals(str)) {
					if (question.contains(words[index])) {
						questionsStr.set(index, question);
						break;
					}
				} else*/
				{
					if (str.equals(question)) {
						break;
					}
				}
			}

			if (index >= questionsStr.size()) {
				questionsStr.add(question);
				index = questionsStr.size() - 1;
			}

			dd.getItems().add(new DiaryDataItem(ts, (long) (index + 1)));

		}
		//add last day
		for (DiaryData dd : yesnodata) {
			dd.getItems().add(new DiaryDataItem(nextDay, null));
		}

		return new ChartDataResult(result, odata.size() > 0);
	}

}
