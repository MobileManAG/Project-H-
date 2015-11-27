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
 * IndexUtils.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 11.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import com.mobileman.projecth.domain.index.country.Country;

/**
 * @author mobileman
 *
 */
public final class IndexUtils {

	private IndexUtils() {}
	
	
	/**
	 * @param countries
	 * @param firstGroupCodes
	 * @return splited countries
	 */
	public static List<Country> sort(List<Country> countries, List<String> firstGroupCodes) {
		List<Country> grp1 = new ArrayList<Country>();
		
		Collections.sort(countries, new Comparator<Country>(){
			@Override
			public int compare(Country o1, Country o2) {
				return o1.getName().compareTo(o2.getName());
			}
		});
		
		for (Iterator<Country> iterator = countries.iterator(); iterator.hasNext();) {
			Country country = iterator.next();
			if (firstGroupCodes.contains(country.getCode())) {
				grp1.add(country);
				iterator.remove();
			}
		}
		
		List<Country> grp2 = new ArrayList<Country>();
		
		for (String code : firstGroupCodes) {
			for (Country tmp : grp1) {
				if (tmp.getCode().equals(code)) {
					grp2.add(tmp);
				}
			}
		}
		
		grp2.addAll(countries);
		return grp2;
	}
	
	/**
	 * @param countries
	 * @param filerWithOrder
	 * @return filtered countries
	 */
	public static List<Country> find(List<Country> countries, List<String> filerWithOrder) {
		
		List<Country> grp2 = new ArrayList<Country>();
		
		for (String code : filerWithOrder) {
			for (Country tmp : countries) {
				if (tmp.getCode().equals(code)) {
					grp2.add(tmp);
				}
			}
		}
		
		return grp2;
	}
	
	/**
	 * @return "DE", "AT", "CH", "LI"
	 */
	public static List<String> getInitialCountryCodes() {
		return Arrays.asList("DE", "AT", "CH", "LI");
	}
}
