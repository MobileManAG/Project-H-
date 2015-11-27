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

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.mobileman.projecth.web.model.MenuItem;

public class Menu {

	private MenuMap menuMap;

	public Menu(HttpServletRequest request) {
		this.menuMap = new MenuMap(request);
	}

	public Map<String, List<MenuItem>> getItems() {
		return menuMap;
	}
}
