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
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.mobileman.projecth.domain.chart.HaqChart;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.questionary.Answer;
import com.mobileman.projecth.domain.questionary.Answer.Kind;
import com.mobileman.projecth.domain.questionary.Question;
import com.mobileman.projecth.domain.questionary.ScaleAnswer;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.model.DiaryData;
import com.mobileman.projecth.web.model.DiaryDataItem;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.Services;

public class BarChartData extends AbstractPrepareChartData {

	public ChartDataResult prepareQuestion(DataHolder data, Model model, User patient, Long questionId) {

		List<Object[]> odata = Services.getPatientService().computeCustomQuestionAnswersFrequencyReport(patient.getId(), questionId, data.getDateFrom(),
				data.getDateTo());

		return prepareInternal(data, new ArrayList<Long>(), odata);
	}

	@Override
	public ChartDataResult prepare(DataHolder data, Model model, User patient, Haq haq, HaqChart haqChart) {
		List<Long> questionIds = getAllowedQuestions(haqChart);

		List<Object[]> odata = Services.getPatientService().computeAllAnswersFrequencyReport(patient.getId(), haqChart.getId(), data.getDateFrom(),
				data.getDateTo());

		return prepareInternal(data, questionIds, odata);
	}

	private ChartDataResult prepareInternal(DataHolder data, List<Long> questionIds, List<Object[]> odata) {
		Map<Long, List<Object[]>> answersCache = new HashMap<Long, List<Object[]>>();

		//haq3,4, 6, 7
		List<Object[]> result = new ArrayList<Object[]>();
		//list of <%--0 - counter 1 - question text  2 - answers and array of dates and values DiaryValue  --%>
		Date nextDay = DateUtils.addDays(data.getDateTo(), 1);
		Date prevDay = DateUtils.addDays(data.getDateFrom(), -1);

		//Timestamp, Question, Answer  qa.logDate, question id, question text, answer id , string answer text, Answer Kind Order
		if (odata != null) {
			for (Object[] obj : odata) {
				Timestamp ts = (Timestamp) obj[0];
				Long questionId = (Long) obj[1];
				String question = (String) obj[2];
				String answer = (String) obj[4];
				Answer.Kind kind = (Kind) obj[5];
				if (Answer.Kind.NO_ANSWER.equals(kind)) {
					continue;
				}
				//find answer

				if (questionIds.size() != 0) {
					if (!questionIds.contains(questionId)) {
						continue;
					}
				}

				Object[] dd = null;
				for (Object[] d : result) {
					if (((String) d[1]).equals(question)) {
						dd = d;
						break;
					}
				}
				if (dd == null) {
					dd = new Object[3];
					dd[0] = result.size();
					dd[1] = question;

					//add all answers
					List<DiaryData> listDD = new ArrayList<DiaryData>();
					dd[2] = listDD;

					for (Object[] tmp : getAllAnswers(questionId, answersCache)) {
						String a = (String) tmp[0];
						String expl = (String) tmp[2];
						DiaryData diaryData = new DiaryData(expl != null ? expl : a); //list of diary data
						diaryData.setTag(tmp); //tag[1] range
						diaryData.getItems().add(new DiaryDataItem(prevDay, null));
						listDD.add(diaryData);
					}

					result.add(dd);
				}
				//add answer into answers if not added
				int index = -1;
				boolean found = false;
				@SuppressWarnings("unchecked")
				List<DiaryData> answers = (List<DiaryData>) dd[2];
				for (index = 0; index < answers.size(); index++) {
					DiaryData str = answers.get(index);
					if (((Object[]) str.getTag())[1] != null) {
						//check range
						Object[] orange = (Object[]) ((Object[]) str.getTag())[1];
						double from = (Double) orange[0];
						double to = (Double) orange[1];
						double a = Double.parseDouble(answer);
						if (a >= from && a < to) {
							found = true;
							break;
						}
					} else {
						Object[] tmp1 = (Object[]) str.getTag();
						String name = (String) tmp1[0];
						if (name.equals(answer)) {
							found = true;
							break;
						}
					}
				}

				/*	if (index >= answers.size()) {
					DiaryData diaryData = new DiaryData(answer); //list of diary data
					diaryData.getItems().add(new DiaryDataItem(prevDay, null));
					answers.add(diaryData);
					index = answers.size() - 1;
				}*/

				if (found) {
					answers.get(index).getItems().add(new DiaryDataItem(ts, (long) (index + 1)));
				}
			}
		}

		//add last day
		for (Object[] dd : result) {
			@SuppressWarnings("unchecked")
			List<DiaryData> answers = (List<DiaryData>) dd[2];
			for (DiaryData diary : answers) {
				diary.getItems().add(new DiaryDataItem(nextDay, null));
			}
		}

		return new ChartDataResult(result, odata != null && odata.size() > 0);
	}

	private List<Object[]> getAllAnswers(Long questionId, Map<Long, List<Object[]>> answersCache) {
		if (answersCache.containsKey(questionId)) {
			return answersCache.get(questionId);
		}
		List<Object[]> result = new ArrayList<Object[]>();

		Question question = Services.getQuestionService().findById(questionId);

		answersCache.put(questionId, result);
		List<Answer> answers = new ArrayList<Answer>(question.getQuestionType().getAnswers());

		Collections.sort(answers, new Comparator<Answer>() {
			@Override
			public int compare(Answer o1, Answer o2) {
				return o1.getSortOrder() - o2.getSortOrder();
			}
		});

		for (Answer a : answers) {
			if (!Answer.Kind.NO_ANSWER.equals(a.getKind())) {

				if (Answer.Kind.SCALE.equals(a.getKind())) {
					ScaleAnswer sa = (ScaleAnswer) a;
					double step = sa.getStep().doubleValue();
					double start = sa.getMinValue().doubleValue();
					double end = sa.getMaxValue().doubleValue();
					if ((end - start) / step > 10) {
						step = 10;
					}
					for (double d = start; d <= end; d += step) {
						Object[] rc = new Object[3]; //0 - name; 1 range
						Object[] range = new Object[2];
						range[0] = d;
						range[1] = d + step;

						rc[1] = range;
						if (Math.floor(d) == d) {
							rc[0] = "" + (int) (d);
						} else {
							rc[0] = "" + d;
						}
						result.add(rc);
					}
				} else {
					Object[] rc = new Object[3]; //0 - name; 1 range; 2 explanation
					rc[0] = a.getAnswer();
					rc[2] = a.getExplanation();
					result.add(rc);
				}
			}
		}

		return result;
	}
}
