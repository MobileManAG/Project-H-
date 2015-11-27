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
/**
 * PatientsKpiAverageScoreTimelineByDisease.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 13.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.model.doctor;

import java.util.ArrayList;
import java.util.List;

import com.mobileman.projecth.domain.dto.patient.kpi.KeyPerformanceIndicatorStatistics;
import com.mobileman.projecth.domain.index.kpi.KeyPerformanceIndicatorType;
import com.mobileman.projecth.web.model.chart.AbstractPrepareChartData;

/**
 * @author mobileman
 *
 */
public class PatientsKpiAverageScoreTimelineByDisease {
	
	/**
	 */
	public static class KpiScores {
		
		List<KeyPerformanceIndicatorStatistics> data;
	}
	
	private final KeyPerformanceIndicatorType kpi;
	
	private List<String> scores = new ArrayList<String>();
	
	
	/**
	 * @param kpi
	 * @param stats 
	 */
	public PatientsKpiAverageScoreTimelineByDisease(KeyPerformanceIndicatorType kpi, List<KeyPerformanceIndicatorStatistics> stats) {
		super();
		this.kpi = kpi;
		this.scores = new ArrayList<String>(stats.size());
		for (KeyPerformanceIndicatorStatistics stat : stats) {
			scores.add("{" + AbstractPrepareChartData.getDateInfo(stat.getDate(), 0, stat.getValue(), null) + "}");
		}
	}
	
	/**
	 * @return kpi
	 */
	public KeyPerformanceIndicatorType getKpi() {
		return this.kpi;
	}
	
	/**
	 * @return scores
	 */
	public List<String> getScores() {
		return this.scores;
	}

	/**
	 * @param score
	 */
	public void add(String score) {
		scores.add(score);
	}
}
