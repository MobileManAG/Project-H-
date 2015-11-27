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

import org.apache.commons.lang.StringUtils;
import org.springframework.ui.Model;

import com.mobileman.projecth.domain.chart.HaqChart;
import com.mobileman.projecth.domain.disease.Haq;
import com.mobileman.projecth.domain.patient.PatientQuestionAnswer;
import com.mobileman.projecth.domain.questionary.Question;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.Services;

public class ImageChartData extends AbstractPrepareChartData {

	@Override
	public ChartDataResult prepare(DataHolder data, Model model, User patient, Haq haq, HaqChart haqChart) {
		if (haqChart.getQuestions().size() == 0) {
			return null;
		}
		Question q = haqChart.getQuestions().get(0);
		List<PatientQuestionAnswer> result = Services.getPatientQuestionAnswerService().findAll(patient.getId(), q.getId(), data.getDateFrom(),
				data.getDateTo());
		List<Object[]> images = new ArrayList<Object[]>();
		if (result != null) {
			for (PatientQuestionAnswer pqa : result) {
				if (StringUtils.isNotBlank(pqa.getCustomAnswer())) {
					Object[] obj = new Object[2];
					obj[0] = pqa.getId();
					obj[1] = DateUtils.germanDate2str(pqa.getLogDate());
					images.add(obj);
				}
			}
		}
		return new ChartDataResult(images, images.size() > 0);
	}
}
