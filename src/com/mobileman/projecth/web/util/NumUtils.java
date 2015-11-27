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

import java.math.BigDecimal;

import org.apache.commons.lang.StringUtils;

public class NumUtils {

	public static Long convert2long(String str) {
		try {
			if (StringUtils.isNotBlank(str)) {
				return Long.parseLong(str);
			}
		} catch (Exception ex) {
		}
		return null;
	}

	public static Double convert2double(String str) {
		try {
			if (StringUtils.isNotBlank(str)) {
				return Double.parseDouble(str.replace(',', '.'));
			}
		} catch (Exception ex) {
		}
		return null;
	}
	
	public static BigDecimal convert2decimal(String str) {
		try {
			if (StringUtils.isNotBlank(str)) {
				return new BigDecimal(str);
			}
		} catch (Exception ex) {
		}
		return null;
	}

	public static Integer convert2int(String str) {
		try {
			if (StringUtils.isNotBlank(str)) {
				return Integer.parseInt(str);
			}
		} catch (Exception ex) {
		}
		return null;
	}

}
