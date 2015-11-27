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

public class HistoryHolder {
	private String dir;
	private String href;
	private String caption;

	public HistoryHolder(String dir, String href, String caption) {
		this.dir = dir;
		this.href = href;
		this.caption = caption;
	}

	public String getDir() {
		return dir;
	}

	public void setDir(String dir) {
		this.dir = dir;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		HistoryHolder src = (HistoryHolder) obj;
		if (src == null) {
			return false;
		}
		return src.getDir().equals(getDir()) && src.getHref().equals(getHref());
	}
}
