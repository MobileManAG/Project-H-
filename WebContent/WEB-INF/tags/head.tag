<!--
Copyright 2015 MobileMan GmbH
www.mobileman.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<%@ tag description="Head tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="header" fragment="true" %>
<%@ attribute name="title" required="false" rtexprvalue="true" %>
<head>
	<title><c:if test="${title!=null && title!=''}">${title}</c:if><c:if test="${title==null || title==''}">projecth&reg; - Transparenz für eine bessere Behandlung</c:if></title>
	<link rel="shortcut icon" href="<c:url value="/images/favicon.png" />">
	<meta name="Robots" content="no follow" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="description" content="projecth schafft Transparenz" />
	<meta name="keywords" content="projecth" />
	<meta name="Content-language" content="de" />
	<meta http-equiv="X-UA-Compatible" content="IE=8" />	
	<link href="<c:url value="/styles/reset.css" />" rel="stylesheet" type="text/css">
	<link href="<c:url value="/styles/main.css" />" rel="stylesheet" type="text/css">
	<link href="<c:url value="/styles/jquery-ui-1.8.6.custom.css" />" rel="stylesheet" type="text/css">
	
  	<script src="<c:url value="/scripts/jquery-1.4.4.min.js" />"></script>
  	<script src="<c:url value="/scripts/jquery-ui-1.8.6.custom.min.js" />"></script>
	<script src="<c:url value="/scripts/jquery.datepick-de-CH.js" />"></script>
	<script src="<c:url value="/scripts/vtip.js" />"></script>
	<script src="<c:url value="/scripts/roundedCorners.js" />"></script>
	<script src="<c:url value="/scripts/jquery.blockUI.js" />"></script>
	<script src="<c:url value="/scripts/WebKitDetect.js" />"></script>
	
 	<jsp:invoke fragment="header" /> 	
 	
</head>
