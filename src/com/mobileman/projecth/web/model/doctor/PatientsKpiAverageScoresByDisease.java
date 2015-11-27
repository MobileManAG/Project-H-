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
 * PatientsKpiAverageScoreByDisease.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 12.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.model.doctor;

import java.util.ArrayList;
import java.util.List;

import com.mobileman.projecth.domain.index.kpi.KeyPerformanceIndicatorType;

/**
 * @author mobileman
 *
 */
public class PatientsKpiAverageScoresByDisease {
	
	public static class PatientsKpiAverageScoreByDisease {
		private double score;	
		private KeyPerformanceIndicatorType kpiType;
		
		/**
		 * @param kpiType
		 * @param score
		 */
		public PatientsKpiAverageScoreByDisease(KeyPerformanceIndicatorType kpiType, double score) {
			this.kpiType = kpiType;
			this.score = score;
		}

		/**
		 * @param score new value of score
		 */
		public void setScore(double score) {
			this.score = score;
		}
		
		/**
		 * @param kpiType new value of kpiType
		 */
		public void setKpiType(KeyPerformanceIndicatorType kpiType) {
			this.kpiType = kpiType;
		}

		/**
		 * @return score
		 */
		public double getScore() {
			return this.score;
		}

		/**
		 * @return kpiType
		 */
		public KeyPerformanceIndicatorType getKpiType() {
			return this.kpiType;
		}
	}
	
	private List<PatientsKpiAverageScoreByDisease> scores = new ArrayList<PatientsKpiAverageScoresByDisease.PatientsKpiAverageScoreByDisease>();
	
	/**
	 * 
	 */
	public PatientsKpiAverageScoresByDisease() {
		super();
	}

	/**
	 * @param kpit
	 * @param value
	 */
	public void add(KeyPerformanceIndicatorType kpit, double value) {
		getScores().add(new PatientsKpiAverageScoreByDisease(kpit, value));
	}
	
	/**
	 * @return scores
	 */
	public List<PatientsKpiAverageScoreByDisease> getScores() {
		return this.scores;
	}
}
