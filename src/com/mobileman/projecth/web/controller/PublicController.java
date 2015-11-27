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
package com.mobileman.projecth.web.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mobileman.projecth.business.ConfigurationService;
import com.mobileman.projecth.business.DiseaseService;
import com.mobileman.projecth.business.MailManager;
import com.mobileman.projecth.business.SystemService;
import com.mobileman.projecth.business.UserService;
import com.mobileman.projecth.business.exception.LoginException;
import com.mobileman.projecth.business.index.country.CountryService;
import com.mobileman.projecth.domain.data.Address;
import com.mobileman.projecth.domain.data.MedicalInstitution;
import com.mobileman.projecth.domain.data.Name;
import com.mobileman.projecth.domain.data.PhoneNumber;
import com.mobileman.projecth.domain.data.id_types.PostalCode;
import com.mobileman.projecth.domain.disease.Disease;
import com.mobileman.projecth.domain.doctor.Doctor;
import com.mobileman.projecth.domain.index.country.Country;
import com.mobileman.projecth.domain.patient.Patient;
import com.mobileman.projecth.domain.user.User;
import com.mobileman.projecth.domain.user.UserState;
import com.mobileman.projecth.domain.user.UserType;
import com.mobileman.projecth.web.model.DataHolder;
import com.mobileman.projecth.web.util.CaptchaUtil;
import com.mobileman.projecth.web.util.Conversation;
import com.mobileman.projecth.web.util.IndexUtils;
import com.mobileman.projecth.web.util.KeepScroll;
import com.mobileman.projecth.web.util.NumUtils;
import com.mobileman.projecth.web.util.ViewState;

@Controller
public class PublicController extends AbstractController {

	@Autowired
	private LoginController loginController;

	@Autowired
	private UserService userService;

	//	@Autowired
	//	PatientMedicationHelper patientMedicationHelper;

	@Autowired
	private MailManager mailmanager;

	@Autowired
	private SystemService systemService;

	@Autowired
	private CountryService countryService;

	@Autowired
	private ConfigurationService configurationService;

	@Autowired
	private DiseaseService diseaseService;

	public PublicController() {
		super("behandlung");
	}

	@RequestMapping(method = RequestMethod.GET, value = "/behandlung")
	public String getStartPage(HttpServletRequest request, HttpServletResponse response) {
		// try auto login
		new Conversation(request.getSession(), request).retrieve();
		String rc = loginController.autoLogin(request, response);
		if (rc != null) {
			return rc;
		}
		return processPage(request.getSession().getServletContext(), null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/behandlung/afterlogout")
	public String afterLogout(HttpSession session, HttpServletRequest request) {
		new Conversation(request.getSession(), request).retrieve();
		return processPage(session.getServletContext(), null);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/behandlung/{page}")
	public String getPage(HttpSession session, HttpServletRequest request, @PathVariable String page) {
		return processPage(session.getServletContext(), page);
	}

	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/gesundheitsgruppen_anmelden")
	public String newDisease(HttpServletRequest request, HttpServletResponse response, Model model) {
		ViewState.copyViewState(request, model);
		boolean error = false;
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String type = request.getParameter("usertype");

		if (!CaptchaUtil.verify(request, model)) {
			error = true;
		}

		if (StringUtils.isBlank(name)) {
			model.addAttribute("errorname", true);
			error = true;
		}
		if (StringUtils.isBlank(type)) {
			model.addAttribute("errortype", true);
			error = true;
		}

		if (!error) {
			try {
				systemService.requestNewDiseaseGroup(name, email, "P".equals(type) ? UserType.P : UserType.D);
				model.addAttribute("infosend", true);
			} catch (Exception ex) {
				model.addAttribute("errorsend", ex.getMessage());
			}
		}
		return "behandlung/gesundheitsgruppen_anmelden";
	}

	/**
	 * @param session
	 * @param request
	 * @param model
	 * @return behandlung/mitmachen_arzt
	 */
	@RequestMapping(method = RequestMethod.GET, value = "behandlung/mitmachen_arzt")
	public String getPageSignUpDoctor(HttpSession session, HttpServletRequest request, Model model) {
		prepareSignUpModel(model, UserType.D);
		return "behandlung/mitmachen_arzt";
	}

	/**
	 * @param model
	 */
	private void prepareSignUpModel(Model model, UserType userType) {
		model.addAttribute("usertype", userType);
		List<Disease> diseases = diseaseService.findAll();
		model.addAttribute("diseases", diseases);

		List<Country> countries = countryService.findAll();
		List<Country> filteredCountries = IndexUtils.find(countries, IndexUtils.getInitialCountryCodes());
		model.addAttribute("countries", filteredCountries);
	}

	/**
	 * @param session
	 * @param request
	 * @param model
	 * @return "behandlung/mitmachen_chronisch_betroffener"
	 */
	@RequestMapping(method = RequestMethod.GET, value = "behandlung/mitmachen_chronisch_betroffener")
	public String getPageSignUpPatient(HttpSession session, HttpServletRequest request, Model model) {
		prepareSignUpModel(model, UserType.P);
		return "behandlung/mitmachen_chronisch_betroffener";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/signup")
	public String signup(HttpServletRequest request, HttpServletResponse response, Model model) {
		ViewState.copyViewState(request, model);
		KeepScroll.save(request, model);

		String result = "behandlung/mitmachen";

		boolean error = false;
		boolean passworderror = false;

		String login = request.getParameter("login");
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");
		String nameOfInstitution = request.getParameter("nameofinstitution");
		String title = request.getParameter("title");
		String namename = request.getParameter("namename");
		String surname = request.getParameter("surname");
		String address = request.getParameter("address");
		String nr = request.getParameter("nr");
		String postcode = request.getParameter("postcode");
		String place = request.getParameter("place");
		String country = request.getParameter("country");
		String telefonCountryCode = request.getParameter("telefoncountrycode");
		String telefon = request.getParameter("telefonnumber");
		String faxCountryCode = request.getParameter("faxcountrycode");
		String fax = request.getParameter("faxnumber");
		String homepage = request.getParameter("homepage");
		String email = request.getParameter("email");
		String accepted = request.getParameter("accepted");
		String type = request.getParameter("usertype");
		String strDisease = request.getParameter("disease");
		Long diseaseId = NumUtils.convert2long(strDisease);

		model.addAttribute("val_nameofinstitution", nameOfInstitution);
		model.addAttribute("val_title", title);
		model.addAttribute("val_namename", namename);
		model.addAttribute("val_surname", surname);
		model.addAttribute("val_address", address);
		model.addAttribute("val_nr", nr);

		model.addAttribute("val_postcode", postcode);
		model.addAttribute("val_place", place);
		model.addAttribute("val_country", country);
		model.addAttribute("val_telefonnumber", telefon);
		model.addAttribute("val_homepage", homepage);
		model.addAttribute("val_disease_id", strDisease);
		model.addAttribute("val_telefoncountrycode", telefonCountryCode);
		model.addAttribute("val_faxcountrycode", faxCountryCode);

		if (StringUtils.isBlank(nameOfInstitution)) {
			nameOfInstitution = null;
		}

		if (StringUtils.isBlank(title)) {
			title = null;
		}
		if (StringUtils.isBlank(namename)) {
			namename = null;
		}
		if (StringUtils.isBlank(surname)) {
			surname = null;
		}
		if (StringUtils.isBlank(address)) {
			address = null;
		}
		if (StringUtils.isBlank(nr)) {
			nr = null;
		}
		if (StringUtils.isBlank(postcode)) {
			postcode = null;
		}
		if (StringUtils.isBlank(place)) {
			place = null;
		}
		if (StringUtils.isBlank(country)) {
			country = null;
		}
		if (StringUtils.isBlank(telefonCountryCode)) {
			telefonCountryCode = null;
		}
		if (StringUtils.isBlank(telefon)) {
			telefon = null;
		}
		if (StringUtils.isBlank(faxCountryCode)) {
			faxCountryCode = null;
		}
		if (StringUtils.isBlank(fax)) {
			fax = null;
		}
		if (StringUtils.isBlank(homepage)) {
			homepage = null;
		}

		if (StringUtils.isBlank(accepted)) {
			model.addAttribute("erroraccepted", true);
			error = true;
		}
		// send activation
		if (StringUtils.isBlank(login)) {
			model.addAttribute("errorlogin", true);
			error = true;
		}
		if (StringUtils.isBlank(password)) {
			model.addAttribute("errorpassword", true);
			error = true;
			passworderror = true;
		}

		if (StringUtils.isBlank(email)) {
			model.addAttribute("erroremail", true);
			error = true;
		}

		if (type.equals("D")) {
			error = checkDoctorMandatoryFileds(request, model);
		}

		if (StringUtils.isBlank(type)) {
			model.addAttribute("errortype", true);
			error = true;
		} else {
			if (type.equals("D")) {
				result = "behandlung/mitmachen_arzt";
			} else {
				result = "behandlung/mitmachen_chronisch_betroffener";
			}
		}

		if (diseaseId == null || diseaseId.equals(0L)) {
			model.addAttribute("errordisease", true);
			error = true;
		}

		if (!CaptchaUtil.verify(request, model)) {
			error = true;
		}

		if (!passworderror) {
			if (!password.equals(password2)) {
				model.addAttribute("errorpasssame", true);
				error = true;
			}
		}

		UserType utype = request.getParameter("usertype").equals("D") ? UserType.D : UserType.P;

		if (!error) {
			do {
				// check login
				try {
					User user = userService.findUserByLogin(login);
					if (user != null) {
						model.addAttribute("errorloginexists", true);
						break;
					}
				} catch (Exception ex) {
				}
				// check email

				try {
					User user = userService.findUserByEmail(email);
					if (user != null) {
						model.addAttribute("erroremailexists", true);
						break;
					}
				} catch (Exception ex) {
				}

				try {

					diseaseService.findById(diseaseId);
					List<Disease> diseases = Arrays.asList(diseaseService.findById(diseaseId));

					if (utype.equals(UserType.D)) {
						Doctor doctor = new Doctor();
						Name name = new Name(namename, surname);
						doctor.setName(name);
						MedicalInstitution medicalInstitution = new MedicalInstitution();
						medicalInstitution.setName(nameOfInstitution);
						Address add = new Address();
						add.setAddress(address);
						add.setNumber(nr);
						add.setPlace(place);
						PostalCode postalCode = new PostalCode();
						postalCode.setCode(postcode);
						add.setPostalCode(postalCode);
						medicalInstitution.setAddress(add);

						Country countr = countryService.findByCode(country);
						medicalInstitution.setCountry(countr);
						PhoneNumber phoneNumber = new PhoneNumber();
						phoneNumber.setCountryCode(telefonCountryCode);
						phoneNumber.setNumber(telefon);
						PhoneNumber faxNumber = new PhoneNumber();
						faxNumber.setCountryCode(faxCountryCode);
						faxNumber.setNumber(fax);
						medicalInstitution.setPhoneNumber(phoneNumber);
						medicalInstitution.setFaxNumber(faxNumber);
						medicalInstitution.setHomePageUrl(homepage);
						doctor.setMedicalInstitution(medicalInstitution);
						doctor.setTitle(title);
						userService.register(doctor, login, password, email, diseases, request.getServerName());

					} else if (utype.equals(UserType.P)) {
						Patient patient = new Patient();
						patient.setName(new Name(login, null));
						userService.register(patient, login, password, email, diseases, request.getServerName());
					}

					model.addAttribute("info", true);
					result = "behandlung/anmeldung_erfolg";
				} catch (Exception ex) {
					if (LoginException.class.isInstance(ex)) {
						fillLoginError(model, LoginException.class.cast(ex));
					} else {
						model.addAttribute("error", "System error");
					}

					ex.printStackTrace();

					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				}
			} while (false);
		}

		prepareSignUpModel(model, utype);
		return result;
	}

	/**
	 * @param model
	 * @param lex
	 */
	private void fillLoginError(Model model, LoginException lex) {

		switch (lex.getReason()) {
		case LOGIN_TOO_LONG:
			model.addAttribute("errorlogin_too_long", Boolean.TRUE);
			model.addAttribute("max_login_length", configurationService.getMaxLoginLength());
			break;
		case LOGIN_TOO_SHORT:
			model.addAttribute("errorlogin_too_short", Boolean.TRUE);
			model.addAttribute("min_login_length", configurationService.getMinLoginLength());
			break;
		case PASSWORD_TOO_LONG:
			model.addAttribute("errorpassword_too_long", Boolean.TRUE);
			model.addAttribute("max_password_length", configurationService.getMaxPasswordLength());
			break;
		case PASSWORD_TOO_SHORT:
			model.addAttribute("errorpassword_too_short", Boolean.TRUE);
			model.addAttribute("min_password_length", configurationService.getMinPasswordLength());
			break;
		default:
			break;
		}
	}

	/**
	 * @param model
	 * 
	 */
	private boolean checkDoctorMandatoryFileds(HttpServletRequest request, Model model) {
		boolean error = false;
		String nameOfInstitution = request.getParameter("nameofinstitution");
		if (StringUtils.isBlank(nameOfInstitution)) {
			model.addAttribute("errornameofinstitution", true);
			error = true;
		}

		String namename = request.getParameter("namename");
		if (StringUtils.isBlank(namename)) {
			model.addAttribute("errornamename", true);
			error = true;
		}

		String surname = request.getParameter("surname");
		if (StringUtils.isBlank(surname)) {
			model.addAttribute("errorsurname", true);
			error = true;
		}

		String address = request.getParameter("address");
		if (StringUtils.isBlank(address)) {
			model.addAttribute("erroraddress", true);
			error = true;
		}

		String nr = request.getParameter("nr");
		if (StringUtils.isBlank(nr)) {
			model.addAttribute("errornr", true);
			error = true;
		}

		String postcode = request.getParameter("postcode");
		if (StringUtils.isBlank(postcode)) {
			model.addAttribute("errorpostcode", true);
			error = true;
		}

		String place = request.getParameter("place");
		if (StringUtils.isBlank(place)) {
			model.addAttribute("errorplace", true);
			error = true;
		}

		String country = request.getParameter("country");
		if (StringUtils.isBlank(country) || country.equals("0")) {
			model.addAttribute("errorcountry", true);
			error = true;
		}

		String telefonCountryCode = request.getParameter("telefoncountrycode");
		if (StringUtils.isBlank(telefonCountryCode)) {
			model.addAttribute("errortelefoncountrycode", true);
			error = true;
		}

		String telefon = request.getParameter("telefonnumber");
		if (StringUtils.isBlank(telefon)) {
			model.addAttribute("errortelefonnumber", true);
			error = true;
		}

		return error;
	}

	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/pwbnvergessen")
	public String resetPassword(HttpServletRequest request, HttpServletResponse response, Model model) {

		boolean captcha = CaptchaUtil.verify(request, model);

		String email = request.getParameter("email");
		if (StringUtils.isBlank(email)) {
			model.addAttribute("erroremail", true);
			return "behandlung/pwbnvergessen";
		} else {
			if (captcha) {
				try {
					User u = userService.findUserByEmail(email);
					if (u != null) {
						try {

							userService.resetCredientials(email, request.getServerName());
							model.addAttribute("info", true);
						} catch (Exception ex) {
							model.addAttribute("error", true);
						}
					} else {
						model.addAttribute("erroremailunknown", true);
					}
				} catch (Exception ex) {
					model.addAttribute("erroremailunknown", true);
				}
			}
		}
		return "behandlung/pwbnvergessen";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.GET, value = "/confirm/{code}")
	public String confirm(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable String code) {
		if (StringUtils.isBlank(code)) {
			return LoginController.redirectToLogin();
		}

		model.addAttribute("code", code);
		try {
			User tmp = userService.findUserByActivationUID(code);
			UserState state = null;
			if (tmp != null) {
				state = tmp.getState();
			}
			if (UserState.P.equals(state)) {
				// change password - ask for new password
				return "behandlung/pwbnvergessen2";
			} else if (UserState.R.equals(state)) {
				// try to activate
				try {
					User user = userService.activateUserAccount(code);
					if (user != null) {
						user = userService.findById(user.getId());
						loginController.logInUser(request, user);
						if (UserType.P.equals(user.getUserType())) {
							model.addAttribute("patient", user);
							return "patient/user_created";
						} else if (UserType.D.equals(user.getUserType())) {
							model.addAttribute("arzt", user);
							return "arzt/user_created";
						}
					}
				} catch (Exception ex) {
				}
				return "behandlung/user_created";
			}
		} catch (Exception ex) {
		}

		return "behandlung/pwbnvergessen";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/patient/user_created")
	public String userCreatedTest(HttpServletRequest request, Model model) {
		model.addAttribute("patient", new DataHolder(request).getPatient());
		return "patient/user_created";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/pwbnvergessen2")
	public String changepwd(HttpServletRequest request, HttpServletResponse response, Model model) {
		String code = request.getParameter("code");
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");

		model.addAttribute("code", code);

		boolean error = true;
		try {
			if (StringUtils.isNotBlank(password) && StringUtils.isNotBlank(password2) && StringUtils.isNotBlank(code)) {
				if (password.equals(password2)) {
					User user = userService.findUserByActivationUID(code);
					if (user != null) {
						userService.changePassword(user.getId(), null, password);
						model.addAttribute("info", true);
						error = false;
					}
				} else {
					model.addAttribute("errorsame", true);
					error = false;
				}
			}

		} catch (Exception ex) {
			if (LoginException.class.isInstance(ex)) {
				fillLoginError(model, LoginException.class.cast(ex));
				error = false;
			}

			ex.printStackTrace();

			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}

		if (error) {
			model.addAttribute("error", true);
		}

		return "behandlung/pwbnvergessen2";
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/kontakt")
	public String kontakt(HttpServletRequest request, HttpServletResponse response, Model model) {

		sendContactMessage(request, model, configurationService.getPublicContactReceiverEmail());
		return "behandlung/kontakt";
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return ok/error
	 */
	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/hpad_mobile")
	public String kontaktHpadMobile(HttpServletRequest request, HttpServletResponse response, Model model) {
		sendContactMessage(request, model, configurationService.getPublicContactReceiverEmail());
		return "behandlung/hpad_mobile";
	}

	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return ok/error
	 */
	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/projecth_mobile")
	public String kontaktprojecthMobile(HttpServletRequest request, HttpServletResponse response, Model model) {
		sendContactMessage(request, model, configurationService.getPublicContactReceiverEmail());
		return "behandlung/projecth_mobile";
	}

	/**
	 * @param request
	 * @param model
	 */
	private String sendContactMessage(HttpServletRequest request, Model model, String receiverEmail) {
		ViewState.copyViewState(request, model);
		String subject = request.getParameter("selectsubject");
		String email = request.getParameter("email");
		String message = request.getParameter("message");

		boolean error = false;

		if (StringUtils.isBlank(subject)) {
			error = true;
			model.addAttribute("errorsubject", true);
		}
		if (StringUtils.isBlank(email)) {
			error = true;
			model.addAttribute("erroremail", true);
		}
		if (StringUtils.isBlank(message)) {
			error = true;
			model.addAttribute("errormessage", true);
		}
		if (!CaptchaUtil.verify(request, model)) {
			error = true;
		}

		String result = "ok";
		if (!error) {
			try {
				mailmanager.sendMessage(email, receiverEmail, subject, message);
				model.addAttribute("infosend", true);
			} catch (Exception ex) {
				model.addAttribute("errorsend", ex.getMessage());
				result = "error";
			}
		}

		return result;
	}

	@Transactional
	@RequestMapping(method = RequestMethod.POST, value = "/behandlung/indextellafriend")
	public @ResponseBody
	String tellafriend(HttpServletRequest request, HttpServletResponse response, Model model) {

		String result = "";
		String senderName = request.getParameter("senderName");
		String senderEmail = request.getParameter("senderEmail");
		String receiverEmails = request.getParameter("receiverEmails");
		String body = request.getParameter("body");
		String capchta = request.getParameter("capchta");

		boolean error = false;

		if (!CaptchaUtil.verify(request, model, capchta)) {
			error = true;
		}

		if (!error) {
			try {
				mailmanager.sendTellAFriendMessage(senderName, senderEmail, receiverEmails, body);
				result = "ok";
			} catch (Exception ex) {
				result = "error";
			}

		} else {
			result = "errorcapchta";
		}

		return result;
	}
}
