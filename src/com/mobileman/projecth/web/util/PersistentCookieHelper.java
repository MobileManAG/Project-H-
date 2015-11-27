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

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.domain.user.User;

public class PersistentCookieHelper {

	private static final String COOKIE_NAME = "AutoLogin";
	private static final String SEPARATOR = ",";
	private static final String PATH = "/";

	public void setUser(HttpServletResponse response, User user) {
		String hash = createHash("" + System.currentTimeMillis(), user);
		//save hash to cvookie
		Cookie cookie = new Cookie(COOKIE_NAME, hash);
		cookie.setPath(PATH);
		cookie.setMaxAge(365 * 24 * 3600);

		response.addCookie(cookie);
	}

	public User getUser(UserService userService, HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		boolean removeCookie = false;
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (COOKIE_NAME.equals(c.getName())) {
					removeCookie = true;
					String hash = c.getValue();

					//extract id, salt, hash
					if (StringUtils.isNotBlank(hash)) {
						//if not found remove cookie!!!
						String[] split = hash.split(SEPARATOR);
						if (split.length == 3) {
							try {
								Long id = Long.parseLong(split[0]);
								//find user
								User user = userService.findById(id);
								if (user != null) {
									//check hash
									String h2 = createHash(split[1], user);
									if (hash.equals(h2)) {
										return user;
									}
								}
							} catch (Exception ex) {
							}
						}
					}
				}
			}
		}
		if (removeCookie && response != null) {
			removeUser(request, response);
		}
		return null;
	}

	public void removeUser(HttpServletRequest request, HttpServletResponse response) {
		//remove from request
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (COOKIE_NAME.equals(c.getName())) {
					c.setValue("deleted");
					break;
				}
			}
		}

		//remove from browser
		Cookie cookie = new Cookie(COOKIE_NAME, "1");
		cookie.setPath(PATH);
		cookie.setMaxAge(0); //0 = remove cookie
		response.setContentType("text/html"); //else delete cookie not works
		response.addCookie(cookie);
	}

	private String createHash(String salt, User user) {
		StringBuilder sb = new StringBuilder();

		sb.append(salt);
		sb.append(user.getId());
		sb.append(user.getName().getName());
		sb.append(user.getName().getSurname());
		sb.append(user.getUserAccount().getEmail());

		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-1");
			byte[] src = sb.toString().getBytes("utf-8");
			md.update(src, 0, src.length);
			byte[] sha1hash = new byte[40];
			sha1hash = md.digest();

			String sha1 = convertToHex(sha1hash);

			sb.delete(0, sb.length());

			sb.append(user.getId());
			sb.append(SEPARATOR);
			sb.append(salt);
			sb.append(SEPARATOR);
			sb.append(sha1);

			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "";
	}

	private static String convertToHex(byte[] data) {
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < data.length; i++) {
			int halfbyte = (data[i] >>> 4) & 0x0F;
			int two_halfs = 0;
			do {
				if ((0 <= halfbyte) && (halfbyte <= 9))
					buf.append((char) ('0' + halfbyte));
				else
					buf.append((char) ('a' + (halfbyte - 10)));
				halfbyte = data[i] & 0x0F;
			} while (two_halfs++ < 1);
		}
		return buf.toString();
	}
}
