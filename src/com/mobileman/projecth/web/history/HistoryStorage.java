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
package com.mobileman.projecth.web.history;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class HistoryStorage {

	private static final String HISTORY_KEY = "HistoryValues";

	private static final String URL_PART = "/WEB-INF/views/";

	@SuppressWarnings("unchecked")
	public static void store(HttpServletRequest request, String caption) {
		List<HistoryHolder> list;

		list = (List<HistoryHolder>) request.getSession().getAttribute(HISTORY_KEY);
		if (list == null) {
			list = new ArrayList<HistoryHolder>();
			request.getSession().setAttribute(HISTORY_KEY, list);
		}

		String url = request.getRequestURI();
		// /projecth/WEB-INF/views/behandlung/mitmachen.jsp
		//split url
		int index = url.indexOf(URL_PART);
		if (index >= 0) {
			//extract dir, href
			int dirIndex = url.indexOf('/', index + URL_PART.length() + 1);
			if (dirIndex >= 0) {
				String dir = url.substring(index + URL_PART.length(), dirIndex);
				//href
				int hrefStart = url.lastIndexOf('/');
				int hrefEnd = url.lastIndexOf('.');
				if (hrefStart >= 0 && hrefEnd >= 0 && hrefEnd > hrefStart) {
					String href = url.substring(hrefStart + 1, hrefEnd);

					//remove from list existing
					HistoryHolder holder = new HistoryHolder(dir, href, caption);
					for (int i = 0; i < list.size(); i++) {
						HistoryHolder src = list.get(i);
						if (src.equals(holder)) {
							//remove all to end
							while (list.size() > i) {
								list.remove(i);
							}
							break;
						}
					}

					list.add(holder);
				}
			}
		}

		///////////////////////////////////
		int lastItems = 3;

		List<HistoryHolder> items = new ArrayList<HistoryHolder>();
		int i = list.size() - lastItems;
		if (i < 0) {
			i = 0;
		}
		//show only last 3 items
		for (; i < list.size(); i++) {
			items.add(list.get(i));
		}

		request.setAttribute("history", items);
	}

	public static void clear(HttpServletRequest request) {
		request.getSession().removeAttribute(HISTORY_KEY);
	}
}
