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
import java.util.List;

import org.springframework.ui.Model;

import com.mobileman.projecth.domain.chart.HaqChart;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.dto.patient.PatientQuestionaryAnswerStatistic;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.util.Services;

public class PieChartData extends AbstractPrepareChartData {
	//private static final String YESNO_QUESTION_PREFIX = "Waren";

	// {name: 'Ja', y: 16, color: '#54B655' },
	// {name: 'Keine Angabe', y: 2, color: '#ff6002' },
	// {name: 'Nein', y: 19, color: '#ed6330' }
	private String addToPieChart(PatientQuestionaryAnswerStatistic question) {
		StringBuilder sb = new StringBuilder();

		sb.append("name:'");
		sb.append(question.getAnswerText());
		sb.append("',y:");
		sb.append(question.getCount());

		// color

		String color = getColorName(question.getAnswerText());

		if (color != null) {
			sb.append(",color:'");
			sb.append(color);
			sb.append("'");
		}

		return sb.toString();
	}

	protected List<String> prepareData(List<PatientQuestionaryAnswerStatistic> questionsAnswers, List<Long> questionIds) {
		List<String> rc = new ArrayList<String>();
		for (PatientQuestionaryAnswerStatistic question : questionsAnswers) {
			if (questionIds.size() == 0 || questionIds.contains(question.getQuestionId())) {
				if (question.getCount() > 0) {
					rc.add(addToPieChart(question));
				}
			}
		}
		return rc;
	}

	@Override
	public ChartDataResult prepare(DataHolder data, Model model, User patient, Haq haq, HaqChart haqChart) {
		List<PatientQuestionaryAnswerStatistic> questionsAnswers = Services.getPatientService().computeQuestionaryAnswersReport(patient.getId(),
				haqChart.getId(), data.getDateFrom(), data.getDateTo());

		List<String> rc = prepareData(questionsAnswers, getAllowedQuestions(haqChart));
		return new ChartDataResult(rc, rc.size() > 0);
	}

	public ChartDataResult prepareQuestion(DataHolder data, Model model, User patient, Long questionId) {
		List<PatientQuestionaryAnswerStatistic> questionsAnswers = Services.getPatientService().computeCustomQuestionAnswersReport(patient.getId(), questionId,
				data.getDateFrom(), data.getDateTo());

		List<String> rc = prepareData(questionsAnswers, new ArrayList<Long>());
		return new ChartDataResult(rc, rc.size() > 0);
	}

}
