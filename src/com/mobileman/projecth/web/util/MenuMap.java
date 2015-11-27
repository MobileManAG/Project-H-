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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.mobileman.projecth.web.model.MenuItem;

public class MenuMap extends HashMap<String, List<MenuItem>> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8197942488665654026L;

	private ServletContext servletContext;

	private Map<String, MenuInternal> cache = new HashMap<String, MenuInternal>();

	public MenuMap(HttpServletRequest request) {
		this.servletContext = request.getSession().getServletContext();
	}

	@Override
	public List<MenuItem> get(Object key) {
		//key is menu name
		String menuKey = (String) key;
		String menuFile = servletContext.getRealPath("/WEB-INF/tags/menu/" + menuKey + ".menu");
		File file = new File(menuFile);

		MenuInternal data = cache.get(key);
		if (data == null || data.getTimestamp() != file.lastModified()) {
			data = new MenuInternal();
			data.setTimestamp(file.lastModified());
			try {
				data.setItems(loadMenuFile(file));
			} catch (IOException e) {
				e.printStackTrace();
			}
			cache.put(menuKey, data);
		}

		return data.getItems();
	}

	public static List<Integer> urlIndex(List<MenuItem> menus, String url) {
		for (int index = 0; index < menus.size(); index++) {
			MenuItem item = menus.get(index);

			if (item.getSubmenu() != null) {
				List<Integer> rc = urlIndex(item.getSubmenu(), url);
				if (rc != null) {
					rc.add(0, index);
					return rc;
				}
			}

			if (item.getUrl() != null && item.getUrl().equals(url)) {
				List<Integer> rc = new ArrayList<Integer>();
				rc.add(index);
				return rc;
			}

		}
		return null;
	}

	private List<MenuItem> loadMenuFile(File file) throws IOException {
		BufferedReader in = new BufferedReader(new FileReader(file));
		String line;
		List<MenuItem> items = new ArrayList<MenuItem>();

		while ((line = in.readLine()) != null) {
			if ("".equals(line.trim())) {
				continue;
			}
			//split file
			String[] split = line.split("\\|");
			//number of \t
			MenuItem item = new MenuItem(split[0].trim(), split.length > 1 ? split[1].trim() : null);
			if (split.length > 2) {
				item.setTarget(split[2].trim());
			}
			List<MenuItem> target = items;
			int level = 0;
			while (line.charAt(level) == '\t') {
				level++;
				//set target
				target = target.get(target.size() - 1).getSubmenu();
			}
			target.add(item);
		}
		in.close();
		return items;
	}

	class MenuInternal {
		private long timestamp;
		private List<MenuItem> items;

		public long getTimestamp() {
			return timestamp;
		}

		public void setTimestamp(long l) {
			this.timestamp = l;
		}

		public List<MenuItem> getItems() {
			return items;
		}

		public void setItems(List<MenuItem> items) {
			this.items = items;
		}
	}
}
