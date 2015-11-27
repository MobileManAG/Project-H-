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
package com.mobileman.projecth.web.model;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DiaryDataItem {
	private String date;
	private String value;

	public DiaryDataItem(Date date, Long value) {
		this.value = value == null ? "null" : ("" + value);
		//2010,10,6
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		this.date = "" + cal.get(Calendar.YEAR) + "," + (cal.get(Calendar.MONTH)) + "," + cal.get(Calendar.DAY_OF_MONTH);
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public static String convDate(Date date) {
		//2010,10,6
		Calendar cal = new GregorianCalendar();
		cal.setTime(date);
		return "" + cal.get(Calendar.YEAR) + "," + (cal.get(Calendar.MONTH)) + "," + cal.get(Calendar.DAY_OF_MONTH);
	}
}
