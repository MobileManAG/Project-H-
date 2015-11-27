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
import com.mobileman.projecth.domain.dto.patient.AnswerFrequency;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.util.Services;

public class LineChartData extends AbstractPrepareChartData {

	@Override
	public ChartDataResult prepare(DataHolder data, Model model, User patient, Haq haq, HaqChart haqChart) {
		//computeQuestionaryAnswersTimeStatistics haq12
		List<AnswerFrequency> data1 = Services.getPatientService().computePositiveAnswerFrequencyReport(patient.getId(), haqChart.getId(), data.getDateFrom(),
				data.getDateTo());

		List<String> rc = new ArrayList<String>();
		// date - a date + 1 day
		rc.add(getDateInfo(data.getDateFrom(), -1, null, null));

		// find data
		if (data1 != null) {
			for (AnswerFrequency obj : data1) {
				rc.add(getDateInfo(obj.getDate(), 0, obj.getCount(), null));
			}
		}

		rc.add(getDateInfo(data.getDateTo(), 1, null, null));
		return new ChartDataResult(rc, data1 != null && data1.size() > 0);
	}
}
