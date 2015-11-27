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
 * SecurityUtils.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 8.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.util;

import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.rights.GrantedRight;

/**
 * @author mobileman
 *
 */
public final class PrivacyUtils {

	private PrivacyUtils() {}
	
	/**
	 * @param visitor
	 * @param user
	 * @param connectionExists flag specifies if connectiond between visitor and user exists
	 * @return true if for visitor is allowed to see #user's data
	 */
	public static boolean visitorCanSeeUserData(User visitor, User user, boolean connectionExists) {
		if (visitor == null || user == null) {
			return false;
		}
		
		// user can see its own data
		if (visitor.equals(user)) {
			return true;
		}
		
		if (user.getGrantedDataRights() == null || user.getGrantedDataRights().contains(GrantedRight.BASE_DATA_NONE)) {
			return false;
		}
		
		boolean visitorCanSeeUserData = false; 
		if (user.getGrantedDataRights().contains(GrantedRight.BASE_DATA_ALL)) {
			visitorCanSeeUserData = true;
		} else if (user.getGrantedDataRights().contains(GrantedRight.BASE_DATA_CONNECTIONS) && connectionExists) {
			visitorCanSeeUserData = true;
		}	
		
		return visitorCanSeeUserData;
	}
	
	/**
	 * @param visitor
	 * @param user
	 * @param connectionExists flag specifies if connectiond between visitor and user exists
	 * @return true if for visitor is allowed to see #user's data
	 */
	public static boolean visitorCanSeeReportData(User visitor, User user, boolean connectionExists) {
		if (visitor == null || user == null) {
			return false;
		}
		
		// user can see its own data
		if (visitor.equals(user)) {
			return true;
		}
		
		if (user.getGrantedDataRights() == null || user.getGrantedDataRights().contains(GrantedRight.DISEASE_DATA_NONE)) {
			return false;
		}
		
		boolean result = false; 
		if (user.getGrantedDataRights().contains(GrantedRight.DISEASE_DATA_ALL)) {
			result = true;
		} else if (user.getGrantedDataRights().contains(GrantedRight.DISEASE_DATA_CONNECTIONS) && connectionExists) {
			result = true;
		}
		
		return result;
	}
}
