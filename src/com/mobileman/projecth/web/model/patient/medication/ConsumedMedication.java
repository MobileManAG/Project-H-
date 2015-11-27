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
 * ConsumedMedication.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 7.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.model.patient.medication;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author mobileman
 *
 */
public class ConsumedMedication {
	
	private Long id;

	private BigDecimal amount;
	
	private String medicationName;
	
	private Date consumptionDate;

	/**
	 * @param medicationId 
	 * @param amount
	 * @param medicationName
	 * @param consumptionDate
	 */
	public ConsumedMedication(Long id, Date consumptionDate, String medicationName, BigDecimal amount) {
		super();
		this.id = id;
		this.amount = amount;
		this.medicationName = medicationName;
		this.consumptionDate = consumptionDate;
	}

	/**
	 * @return amount
	 */
	public BigDecimal getAmount() {
		return this.amount;
	}

	/**
	 * @param amount new value of amount
	 */
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	/**
	 * @return medicationName
	 */
	public String getMedicationName() {
		return this.medicationName;
	}

	/**
	 * @param medicationName new value of medicationName
	 */
	public void setMedicationName(String medicationName) {
		this.medicationName = medicationName;
	}

	/**
	 * @return consumptionDate
	 */
	public Date getConsumptionDate() {
		return this.consumptionDate;
	}

	/**
	 * @param consumptionDate new value of consumptionDate
	 */
	public void setConsumptionDate(Date consumptionDate) {
		this.consumptionDate = consumptionDate;
	}
	
	/**
	 * @return id
	 */
	public Long getId() {
		return this.id;
	}
}
