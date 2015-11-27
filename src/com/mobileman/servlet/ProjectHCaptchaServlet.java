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
package com.mobileman.servlet;

import java.awt.Color;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.servlet.SimpleCaptchaServlet;

public class ProjectHCaptchaServlet extends SimpleCaptchaServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6355895807742207331L;

	private static Color colorFrom = new Color(0x7e, 0xc0, 0xe2);
	private static Color colorTo = new Color(255, 255, 255);
	private static Color borderColor = new Color(0x6c, 0xc0, 0xe8);

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Captcha captcha = new Captcha.Builder(Integer.parseInt(getInitParameter("width")), Integer.parseInt(getInitParameter("height"))).addText()
				.addBackground(new GradiatedBackgroundProducer(colorFrom, colorTo)).gimp().addNoise().addBorder(borderColor).build();

		CaptchaServletUtil.writeImage(resp, captcha.getImage());

		req.getSession().setAttribute(Captcha.NAME, captcha);
	}
}
