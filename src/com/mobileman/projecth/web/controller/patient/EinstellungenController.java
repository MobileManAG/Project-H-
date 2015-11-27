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
package com.mobileman.projecth.web.controller.patient;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobileman.projecth.business.ConfigurationService;
import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.business.index.country.CountryService;
import com.mobileman.projecth.business.index.education.EducationService;
import com.mobileman.projecth.business.index.family.FamilySituationService;
import com.mobileman.projecth.business.index.race.RaceService;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.index.country.Country;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.user.UserWeight;
import com.mobileman.projecth.domain.user.rights.GrantedRight;
import com.mobileman.projecth.web.controller.LoginController;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.util.DateUtils;
import com.mobileman.projecth.web.util.IndexUtils;
import com.mobileman.projecth.web.util.NumUtils;
import com.mobileman.projecth.web.util.PersistentCookieHelper;
import com.mobileman.projecth.web.util.UserUtils;

@Controller
public class EinstellungenController extends AbstractPatientController {
	@Autowired
	UserService userService;

	@Autowired
	DiseaseService diseaseService;

	@Autowired
	LoginController loginController;

	@Autowired
	CountryService countryService;

	@Autowired
	RaceService raceService;

	@Autowired
	EducationService educationService;

	@Autowired
	FamilySituationService familySituationService;

	@Autowired
	private ConfigurationService configurationService;

	@RequestMapping(method = RequestMethod.GET, value = "/patient/einstellungen_profil")
	public String settingsGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		return settingsGetInternal(request, response, model, null);
	}

	private String settingsGetInternal(HttpServletRequest request, HttpServletResponse response, Model model, Boolean autoLogin) {
		if (autoLogin != null) {
			if (autoLogin) {
				model.addAttribute("autologinenabled", true);
			}

		} else {
			if (new PersistentCookieHelper().getUser(userService, request, response) != null) {
				// auto login enabled
				model.addAttribute("autologinenabled", true);
			}
		}

		Patient patient = new DataHolder(request).getPatient();
		model.addAttribute("patient", patient);
		model.addAttribute("year", patient.getBirthday());
		// diseases
		List<Disease> diseases = diseaseService.findAll();

		if (patient.getDiseases() != null && patient.getDiseases().size() > 0) {
			Iterator<Disease> it = diseases.iterator();
			while (it.hasNext()) {
				Disease disease = it.next();
				for (Disease patientDisease : patient.getDiseases()) {
					if (patientDisease.getId().equals(disease.getId())) {
						it.remove();
						break;
					}
				}
			}
		}

		model.addAttribute("diseases", diseases);

		List<Country> countries = IndexUtils.sort(countryService.findAll(), IndexUtils.getInitialCountryCodes());

		model.addAttribute("countries", IndexUtils.find(countries, IndexUtils.getInitialCountryCodes()));
		model.addAttribute("nationalities", countries);
		model.addAttribute("races", raceService.findAll());
		model.addAttribute("educations", educationService.findAll());
		model.addAttribute("familySituations", familySituationService.findAll());

		model.addAttribute("weight", UserUtils.fmtUserWeight(patient));

		return "patient/einstellungen_profil";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/einstellungen_profil")
	public String settingsChange(HttpServletRequest request, HttpServletResponse response, Model model) {
		boolean autoLogin = false;
		
		try {
			Patient patient = new DataHolder(request).getPatient();
			autoLogin = UserUtils.changeAutologin(patient, request, response);

			//birthday
			String strYear = request.getParameter("year");
			Integer birthday = NumUtils.convert2int(strYear);
			// user deleted birthday or birthday is correct
			if ((strYear == null || strYear.trim().length() ==0)
					|| birthday != null) {
				patient.setBirthday(birthday);
			}

			//country
			String strCountry = request.getParameter("country");
			Long country = NumUtils.convert2long(strCountry);
			if (country != null && !country.equals(0L)) {
				patient.setCountry(countryService.findById(country));
			} else {
				patient.setCountry(null);
			}

			String strNationality = request.getParameter("nationality");
			Long nationalityId = NumUtils.convert2long(strNationality);
			if (nationalityId != null && !nationalityId.equals(0L)) {
				patient.setNationality(countryService.findById(nationalityId));
			} else {
				patient.setNationality(null);
			}

			String strRace = request.getParameter("race");
			Long raceId = NumUtils.convert2long(strRace);
			if (raceId != null && !raceId.equals(0L)) {
				patient.setRace(raceService.findById(raceId));
			} else {
				patient.setRace(null);
			}

			String streducation = request.getParameter("education");
			Long educationId = NumUtils.convert2long(streducation);
			if (educationId != null && !educationId.equals(0L)) {
				patient.setEducation(educationService.findById(educationId));
			} else {
				patient.setEducation(null);
			}

			String familySituation = request.getParameter("familySituation");
			Long familySituationId = NumUtils.convert2long(familySituation);
			if (familySituationId != null && !familySituationId.equals(0L)) {
				patient.setFamilySituation(familySituationService.findById(familySituationId));
			} else {
				patient.setFamilySituation(null);
			}

			String heightStr = request.getParameter("height");
			Integer height = NumUtils.convert2int(heightStr);
			// user deleted height or height is correct
			if ((heightStr == null || heightStr.trim().length() ==0)
					|| height != null) {
				patient.setHeight(height);
			}

			String genderStr = request.getParameter("gender");
			Integer gender = NumUtils.convert2int(genderStr);
			patient.setSex(gender);

			userService.update(patient);

			//diseases
			UserUtils.saveDiseases(request, patient, userService, diseaseService);
			model.addAttribute("base_settings_saved", Boolean.TRUE);
			
		} catch (Exception e) {
			model.addAttribute("base_settings_save_error", Boolean.TRUE);
			model.addAttribute("base_settings_save_error_message", e.getMessage());
		}
		
		return settingsGetInternal(request, response, model, autoLogin);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/einstellungen_endgueltig_loeschen")
	public String deletePatient(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("patient", new DataHolder(request).getPatient());
		return "patient/einstellungen_endgueltig_loeschen";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/einstellungen_endgueltig_loeschen/confirm")
	public String realDeletePatient(HttpServletRequest request, HttpServletResponse response, Model model) {
		// real delete patient
		Long patientId = new DataHolder(request).getPatient().getId();
		String rc = loginController.logout(request, response);
		userService.deleteUserAccount(patientId);
		return rc;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/einstellungen_password")
	public String passwordGet() {
		return "patient/einstellungen_password";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/patient/einstellungen_password")
	public String passwordPost(HttpServletRequest request, Model model) {
		Patient patient = new DataHolder(request).getPatient();
		UserUtils.changePassword(patient, request, model, userService, configurationService);
		return passwordGet();
	}

	/**
	 * @param request
	 * @param model
	 * @return patient/einstellungen_share_your_story
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/einstellungen_share_your_story")
	public String shareYourStoryGet(HttpServletRequest request, Model model) {
		Patient patient = new DataHolder(request).getPatient();
		model.addAttribute("patient", patient);
		return "patient/einstellungen_share_your_story";
	}

	/**
	 * @param request
	 * @param model
	 * @return patient/einstellungen_share_your_story
	 * @throws UnsupportedEncodingException
	 */
	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/einstellungen_share_your_story")
	public String shareYourStoryPost(HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		Patient patient = new DataHolder(request).getPatient();
		String value = StringEscapeUtils.escapeHtml(request.getParameter("aboutMe"));
		patient.setAboutMe(value);
		userService.update(patient);
		model.addAttribute("about_me_saved", Boolean.TRUE);
		return shareYourStoryGet(request, model);
	}

	/**
	 * @param request
	 * @param model
	 * @return patient/einstellungen_share_your_story
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/patient/einstellungen_privacy")
	public String privacyGet(HttpServletRequest request, Model model) {
		Patient patient = new DataHolder(request).getPatient();
		model.addAttribute("patient", patient);
		if (patient.getGrantedDataRights() == null) {
			patient.setGrantedDataRights(new HashSet<GrantedRight>());
		}

		if (patient.getGrantedDataRights() == null || patient.getGrantedDataRights().isEmpty()) {
			model.addAttribute(GrantedRight.BASE_DATA_NONE.name(), GrantedRight.BASE_DATA_NONE);
			model.addAttribute(GrantedRight.DISEASE_DATA_NONE.name(), GrantedRight.DISEASE_DATA_NONE);
		} else {
			for (GrantedRight right : patient.getGrantedDataRights()) {
				model.addAttribute(right.name(), right);
			}
		}

		model.addAttribute("requestblocked", Boolean.valueOf(patient.isConnectionRequestsBlocked()));

		return "patient/einstellungen_privacy";
	}

	/**
	 * @param request
	 * @param model
	 * @return patient/einstellungen_share_your_story
	 */
	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/patient/einstellungen_privacy")
	public String privacyPost(HttpServletRequest request, Model model) {
		Patient patient = new DataHolder(request).getPatient();
		if (patient.getGrantedDataRights() == null) {
			patient.setGrantedDataRights(new HashSet<GrantedRight>());
		}

		patient.getGrantedDataRights().clear();

		String stammdaten = request.getParameter("stammdaten");
		String fragebogen_daten = request.getParameter("fragebogen_daten");

		if (stammdaten == null || stammdaten.trim().length() == 0) {
			patient.getGrantedDataRights().add(GrantedRight.BASE_DATA_NONE);
		} else {
			patient.getGrantedDataRights().add(GrantedRight.valueOf(stammdaten));
		}

		if (fragebogen_daten == null || fragebogen_daten.trim().length() == 0) {
			patient.getGrantedDataRights().add(GrantedRight.DISEASE_DATA_NONE);
		} else {
			patient.getGrantedDataRights().add(GrantedRight.valueOf(fragebogen_daten));
		}

		String value = request.getParameter("requestblocked");
		boolean blocked = false;
		if (StringUtils.isNotBlank(value)) {
			blocked = true;
		}

		patient.setConnectionRequestsBlocked(blocked);

		userService.update(patient);
		model.addAttribute("privacy_saved", true);

		return privacyGet(request, model);
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/patient/einstellungen_profil/weight")
	public String userWeightGet(HttpServletRequest request, HttpServletResponse response, Model model) {
		Patient patient = new DataHolder(request).getPatient();
		String result = UserUtils.fmtUserWeight(patient);
		return result;
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@Transactional
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/patient/einstellungen_profil/change_weight")
	public String changeUserWeight(HttpServletRequest request, HttpServletResponse response, Model model) {
		Patient patient = new DataHolder(request).getPatient();

		String weightStr = request.getParameter("weight");

		BigDecimal weight = null;
		try {
			weight = new BigDecimal(weightStr);
		} catch (NumberFormatException e) {
			return "error";
		}
		
		if (patient.getWeights() == null) {
			patient.setWeights(new ArrayList<UserWeight>());
		}

		String weightDateStr = request.getParameter("weight_date_text");
		Date date = DateUtils.normalStr2date(weightDateStr);
		if (date == null) {
			return "error";
		}

		if (patient.getWeights() == null) {
			patient.setWeights(new ArrayList<UserWeight>());
		}

		UserWeight userWeight = new UserWeight();
		userWeight.setDate(date);
		userWeight.setWeight(weight);
		patient.getWeights().add(userWeight);

		userService.update(patient);

		return "ok";
	}
}
