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
package com.mobileman.projecth.web.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import com.mobileman.projecth.web.controller.InitController;
import com.mobileman.projecth.web.service.LocaleService;

public class DateUtils {
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static SimpleDateFormat normalDateFormat = new SimpleDateFormat("dd.MM.yyyy");
	private static SimpleDateFormat germanDateFormat = new SimpleDateFormat("d.M.yyyy");
	private static SimpleDateFormat germanLongDateFormat = new SimpleDateFormat("d. MMM yyyy");
	private static SimpleDateFormat germanShortDateFormat = new SimpleDateFormat("dd/MM/yyyy");

	public static Date str2date(String str) {
		try {
			return dateFormat.parse(str);
		} catch (ParseException e) {
			// ???
			return new Date();
		}
	}

	public static String date2str(Date date) {
		return dateFormat.format(date);
	}

	public static String dateTime2str(Date date) {
		return dateTimeFormat.format(date);
	}

	public static String germanDate2str(Date date) {
		return germanDateFormat.format(date);
	}
	
	public static String germanLongDate2str(Date date) {
		LocaleService localeService = InitController.getWebApplicationContext().getBean(LocaleService.class);
		String result = localeService.getUnknowMessage();
		if(date != null){
			result = germanLongDateFormat.format(date);
		}
		return result;
	}
	
	public static String germanShortDate2str(Date date) {
		LocaleService localeService = InitController.getWebApplicationContext().getBean(LocaleService.class);
		String result = localeService.getUnknowMessage();
		if(date != null){
			result = germanShortDateFormat.format(date);
		}
		return result;
	}

	public static Date germanStr2date(String str) {
		try {
			return dateFormat.parse(str);
		} catch (ParseException e) {
			// ???
			return null;
		}
	}
	
	public static Date normalStr2date(String str) {
		try {
			return normalDateFormat.parse(str);
		} catch (ParseException e) {
			// ???
			return null;
		}
	}
	
	public static String normalDate2Str(Date date) {
		if(date != null){			
			return normalDateFormat.format(date);
		} 
		
		return null;
	}

	public static Date addDays(Date date, int days) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, days);
		return cal.getTime();
	}
}
