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
package com.mobileman.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.FlushMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.SessionHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.context.WebApplicationContext;

public class OpenSessionFilter implements Filter {

	@Override
	public void destroy() {
	}

	private static WebApplicationContext webApplicationContext;

	public static WebApplicationContext getWebApplicationContext() {
		return webApplicationContext;
	}

	public static void setWebApplicationContext(
			WebApplicationContext webApplicationContext) {
		OpenSessionFilter.webApplicationContext = webApplicationContext;

		// initialize session...
		SessionFactory sessionFactory = lookupSessionFactory();

		if (sessionFactory != null) {
			if (isSingleSession()) {
				// single session mode
				if (TransactionSynchronizationManager
						.hasResource(sessionFactory)) {
				} else {
					Session session = getSession(sessionFactory);
					TransactionSynchronizationManager.bindResource(
							sessionFactory, new SessionHolder(session));
				}
			} else {
				// deferred close mode
				if (SessionFactoryUtils.isDeferredCloseActive(sessionFactory)) {
				} else {
					SessionFactoryUtils.initDeferredClose(sessionFactory);
				}
			}
		}
	}

	@Override
	public void init(FilterConfig fc) throws ServletException {
		// servletContext = fc.getServletContext();
	}

	public static final String DEFAULT_SESSION_FACTORY_BEAN_NAME = "sessionFactory";

	private static String sessionFactoryBeanName = DEFAULT_SESSION_FACTORY_BEAN_NAME;

	private static boolean singleSession = true;

	private static FlushMode flushMode = FlushMode.AUTO;

	/**
	 * Set the bean name of the SessionFactory to fetch from Spring's root
	 * application context. Default is "sessionFactory".
	 * 
	 * @see #DEFAULT_SESSION_FACTORY_BEAN_NAME
	 */
	public void setSessionFactoryBeanName(String sessionFactoryBeanName) {
		OpenSessionFilter.sessionFactoryBeanName = sessionFactoryBeanName;
	}

	/**
	 * Return the bean name of the SessionFactory to fetch from Spring's root
	 * application context.
	 */
	static protected String getSessionFactoryBeanName() {
		return sessionFactoryBeanName;
	}

	/**
	 * Set whether to use a single session for each request. Default is "true".
	 * <p>
	 * If set to "false", each data access operation or transaction will use its
	 * own session (like without Open Session in View). Each of those sessions
	 * will be registered for deferred close, though, actually processed at
	 * request completion.
	 * 
	 * @see SessionFactoryUtils#initDeferredClose
	 * @see SessionFactoryUtils#processDeferredClose
	 */
	public static void setSingleSession(boolean singleSession) {
		OpenSessionFilter.singleSession = singleSession;
	}

	/**
	 * Return whether to use a single session for each request.
	 */
	static protected boolean isSingleSession() {
		return singleSession;
	}

	/**
	 * Specify the Hibernate FlushMode to apply to this filter's
	 * {@link org.hibernate.Session}. Only applied in single session mode.
	 * <p>
	 * Can be populated with the corresponding constant name in XML bean
	 * definitions: e.g. "AUTO".
	 * <p>
	 * The default is "MANUAL". Specify "AUTO" if you intend to use this filter
	 * without service layer transactions.
	 * 
	 * @see org.hibernate.Session#setFlushMode
	 * @see org.hibernate.FlushMode#MANUAL
	 * @see org.hibernate.FlushMode#AUTO
	 */
	public static void setFlushMode(FlushMode flushMode) {
		OpenSessionFilter.flushMode = flushMode;
	}

	/**
	 * Return the Hibernate FlushMode that this filter applies to its
	 * {@link org.hibernate.Session} (in single session mode).
	 */
	protected static FlushMode getFlushMode() {
		return OpenSessionFilter.flushMode;
	}

	private static final String INIT_SERVLET_URI = "/init";

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException {

		if (webApplicationContext == null) {
			HttpServletRequest rq1 = (HttpServletRequest) request;
			String requestURI = rq1.getRequestURI();
			if (!requestURI.endsWith(INIT_SERVLET_URI)) {
				request.getRequestDispatcher(INIT_SERVLET_URI).forward(request,
						response);
				return;
			}
		}

		SessionFactory sessionFactory = lookupSessionFactory();
		boolean participate = false;

		if (sessionFactory != null) {
			if (isSingleSession()) {
				// single session mode
				if (TransactionSynchronizationManager
						.hasResource(sessionFactory)) {
					// Do not modify the Session: just set the participate flag.
					participate = true;
				} else {
					Session session = getSession(sessionFactory);
					TransactionSynchronizationManager.bindResource(
							sessionFactory, new SessionHolder(session));
				}
			} else {
				// deferred close mode
				if (SessionFactoryUtils.isDeferredCloseActive(sessionFactory)) {
					// Do not modify deferred close: just set the participate
					// flag.
					participate = true;
				} else {
					SessionFactoryUtils.initDeferredClose(sessionFactory);
				}
			}
		}

		try {
			filterChain.doFilter(request, response);
		}

		finally {
			if (sessionFactory != null) {
				if (!participate) {
					if (isSingleSession()) {
						// single session mode
						SessionHolder sessionHolder = (SessionHolder) TransactionSynchronizationManager
								.unbindResource(sessionFactory);
						closeSession(sessionHolder.getSession(), sessionFactory);
					} else {
						// deferred close mode
						SessionFactoryUtils
								.processDeferredClose(sessionFactory);
					}
				}
			}
		}
	}

	/**
	 * Look up the SessionFactory that this filter should use.
	 * <p>
	 * The default implementation looks for a bean with the specified name in
	 * Spring's root application context.
	 * 
	 * @return the SessionFactory to use
	 * @see #getSessionFactoryBeanName
	 */
	static protected SessionFactory lookupSessionFactory() {
		try {
			// WebApplicationContext wac = WebApplicationContextUtils
			// .getRequiredWebApplicationContext(this.servletContext);
			// return wac.getBean(getSessionFactoryBeanName(),
			// SessionFactory.class);

			return getWebApplicationContext() != null ? getWebApplicationContext()
					.getBean(getSessionFactoryBeanName(), SessionFactory.class)
					: null;
		} catch (Exception ex) {
			return null;
		}
	}

	/**
	 * Get a Session for the SessionFactory that this filter uses. Note that
	 * this just applies in single session mode!
	 * <p>
	 * The default implementation delegates to the
	 * <code>SessionFactoryUtils.getSession</code> method and sets the
	 * <code>Session</code>'s flush mode to "MANUAL".
	 * <p>
	 * Can be overridden in subclasses for creating a Session with a custom
	 * entity interceptor or JDBC exception translator.
	 * 
	 * @param sessionFactory
	 *            the SessionFactory that this filter uses
	 * @return the Session to use
	 * @throws DataAccessResourceFailureException
	 *             if the Session could not be created
	 * @see org.springframework.orm.hibernate3.SessionFactoryUtils#getSession(SessionFactory,
	 *      boolean)
	 * @see org.hibernate.FlushMode#MANUAL
	 */
	static protected Session getSession(SessionFactory sessionFactory)
			throws DataAccessResourceFailureException {
		Session session = SessionFactoryUtils.getSession(sessionFactory, true);
		FlushMode flushMode = getFlushMode();
		if (flushMode != null) {
			session.setFlushMode(flushMode);
		}
		return session;
	}

	/**
	 * Close the given Session. Note that this just applies in single session
	 * mode!
	 * <p>
	 * Can be overridden in subclasses, e.g. for flushing the Session before
	 * closing it. See class-level javadoc for a discussion of flush handling.
	 * Note that you should also override getSession accordingly, to set the
	 * flush mode to something else than NEVER.
	 * 
	 * @param session
	 *            the Session used for filtering
	 * @param sessionFactory
	 *            the SessionFactory that this filter uses
	 */
	protected void closeSession(Session session, SessionFactory sessionFactory) {
		SessionFactoryUtils.closeSession(session);
	}

}
