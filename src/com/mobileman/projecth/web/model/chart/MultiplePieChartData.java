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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.mobileman.projecth.domain.chart.HaqChart;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.dto.patient.PatientQuestionaryAnswerStatistic;
import com.mobileman.projecth.domain.questionary.Question;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.util.Services;

public class MultiplePieChartData extends PieChartData {

	@Override
	public ChartDataResult prepare(DataHolder data, Model model, User patient, Haq haq, HaqChart haqChart) {
		List<PatientQuestionaryAnswerStatistic> questionsAnswers = Services.getPatientService().computeQuestionaryAnswersReport(patient.getId(),
				haqChart.getId(), data.getDateFrom(), data.getDateTo());

		List<Long> tmp = getAllowedQuestions(haqChart);
		List<Long> questionIds = new ArrayList<Long>();

		//sort question ids
		for (Question q : haq.getQuestions()) {
			if (tmp.contains(q.getId())) {
				questionIds.add(q.getId());
			}
		}

		//split questions
		Map<Long, List<PatientQuestionaryAnswerStatistic>> questions = new HashMap<Long, List<PatientQuestionaryAnswerStatistic>>();

		for (PatientQuestionaryAnswerStatistic pqas : questionsAnswers) {
			if (questionIds.contains(pqas.getQuestionId())) {
				List<PatientQuestionaryAnswerStatistic> list = questions.get(pqas.getQuestionId());
				if (list == null) {
					list = new ArrayList<PatientQuestionaryAnswerStatistic>();
					questions.put(pqas.getQuestionId(), list);
				}
				list.add(pqas);
			}
		}

		List<Object[]> rc = new ArrayList<Object[]>(); //prepareData(questionsAnswers, getAllowedQuestions(haqChart));

		//for (List<PatientQuestionaryAnswerStatistic> prepList : questions.values()) {
		for (Long id : questionIds) {
			List<PatientQuestionaryAnswerStatistic> prepList = questions.get(id);
			List<String> o = prepareData(prepList, questionIds);
			Object[] oresult = new Object[2];
			oresult[0] = o;
			oresult[1] = prepList.get(0).getQuestionText();
			rc.add(oresult);
		}

		return new ChartDataResult(rc, rc.size() > 0);
	}
}
