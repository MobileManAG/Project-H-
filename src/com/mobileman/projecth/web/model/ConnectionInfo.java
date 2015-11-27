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

import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserAccount;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.domain.user.connection.UserConnectionState;
import com.mobileman.projecth.domain.util.user.UserUtil;
import com.mobileman.projecth.web.util.DateUtils;

public class ConnectionInfo {
	private String date;
	private String name;
	private String gender;
	private String year;
	private Long id;
	private boolean accepted;
	private boolean pending;
	private boolean pending_confirm;

	public ConnectionInfo(Long userId, UserConnection conn, PatientService patientService) {
		this.date = DateUtils.germanDate2str(conn.getCreated());

		User other = userId.equals(conn.getOwner().getId()) ? conn.getUser() : conn.getOwner();

		this.name = UserUtil.fmtName(other);
		if (this.name == null || this.name.trim().length() == 0) {
			UserAccount userAccount = other.getUserAccount();
			if (userAccount != null) {
				this.name = userAccount.getLogin();
			}			
		}
		
		if (UserType.P.equals(other.getUserType())) {
			Patient patient = patientService.findById(other.getId());
			this.year = "" + patient.getBirthday();
			this.gender = UserUtil.fmtGender(patient);
		}

		this.id = conn.getId();

		if (UserConnectionState.A.equals(conn.getState())) {
			this.accepted = true;
		}
		if (UserConnectionState.P.equals(conn.getState())) {
			if (!conn.getOwner().getId().equals(userId)) {
				this.pending_confirm = true;
			} else {
				this.pending = true;
			}
		}
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public boolean isAccepted() {
		return accepted;
	}

	public void setAccepted(boolean accepted) {
		this.accepted = accepted;
	}

	public boolean isPending() {
		return pending;
	}

	public void setPending(boolean pending) {
		this.pending = pending;
	}

	public boolean isPending_confirm() {
		return pending_confirm;
	}

	public void setPending_confirm(boolean pending_confirm) {
		this.pending_confirm = pending_confirm;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

}
