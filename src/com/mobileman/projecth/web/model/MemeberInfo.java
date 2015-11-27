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
 * MemeberInfo.java
 * 
 * Project: projecth
 * 
 * @author mobileman
 * @date 17.2.2011
 * @version 1.0
 * 
 * (c) 2010 MobileMan GmbH
 */

package com.mobileman.projecth.web.model;

import com.mobileman.projecth.business.PatientService;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.connection.UserConnection;
import com.mobileman.projecth.domain.user.connection.UserConnectionState;
import com.mobileman.projecth.domain.util.user.UserUtil;
import com.mobileman.projecth.web.util.DateUtils;

/**
 * @author mobileman
 *
 */
public class MemeberInfo {

	private final User user;
	private final String created;
	private final String name;
	private final String gender;
	private final String year;
	private final Long connectionId;
	private boolean accepted;
	private boolean pending;
	private boolean pending_confirm;

	/**
	 * @param ownerId
	 * @param conn
	 */
	public MemeberInfo(Long ownerId, UserConnection conn) {
		
		this.connectionId = conn.getId();
		this.created = DateUtils.germanDate2str(conn.getCreated());
		this.user = ownerId.equals(conn.getOwner().getId()) ? conn.getUser() : conn.getOwner();
		this.name = UserUtil.fmtName(this.user);
		this.year = "" + this.user.getBirthday();
		this.gender = UserUtil.fmtGender(this.user);
		
		if (UserConnectionState.A.equals(conn.getState())) {
			this.accepted = true;
		}
		
		if (UserConnectionState.P.equals(conn.getState())) {
			if (!conn.getOwner().getId().equals(ownerId)) {
				this.pending_confirm = true;
			} else {
				this.pending = true;
			}
		}
	}

	/**
	 * @return accepted
	 */
	public boolean isAccepted() {
		return this.accepted;
	}

	/**
	 * @param accepted new value of accepted
	 */
	public void setAccepted(boolean accepted) {
		this.accepted = accepted;
	}

	/**
	 * @return pending
	 */
	public boolean isPending() {
		return this.pending;
	}

	/**
	 * @param pending new value of pending
	 */
	public void setPending(boolean pending) {
		this.pending = pending;
	}

	/**
	 * @return pending_confirm
	 */
	public boolean isPending_confirm() {
		return this.pending_confirm;
	}

	/**
	 * @param pending_confirm new value of pending_confirm
	 */
	public void setPending_confirm(boolean pending_confirm) {
		this.pending_confirm = pending_confirm;
	}

	/**
	 * @return user
	 */
	public User getUser() {
		return this.user;
	}

	/**
	 * @return created
	 */
	public String getCreated() {
		return this.created;
	}

	/**
	 * @return name
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * @return gender
	 */
	public String getGender() {
		return this.gender;
	}

	/**
	 * @return year
	 */
	public String getYear() {
		return this.year;
	}

	/**
	 * @return connectionId
	 */
	public Long getConnectionId() {
		return this.connectionId;
	}

	
}
