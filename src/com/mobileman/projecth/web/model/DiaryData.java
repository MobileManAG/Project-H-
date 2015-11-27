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

import java.util.ArrayList;
import java.util.List;

public class DiaryData {
	private String name;
	private List<DiaryDataItem> items;
	private Long medId;
	private String color;

	private Object tag;

	public DiaryData(String name) {
		this.name = name;
		this.items = new ArrayList<DiaryDataItem>();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<DiaryDataItem> getItems() {
		return items;
	}

	public void setItems(List<DiaryDataItem> items) {
		this.items = items;
	}

	public Long getMedId() {
		return medId;
	}

	public void setMedId(Long medId) {
		this.medId = medId;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public Object getTag() {
		return tag;
	}

	public void setTag(Object tag) {
		this.tag = tag;
	}

}
