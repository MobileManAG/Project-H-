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
<%@ tag description="Footer tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="print" required="false" rtexprvalue="true" %>
<%@ attribute name="dir" required="true"  %>
<c:if test="${!print}">
<div id="footer"> 
  <div class="chromlinez"></div>
  <div id="mainfooter"> 
  	<div id="innerfooter"> 
	    <t:a dir="${dir}" href="impressum" xclass="footerlink">Impressum</t:a>
	</div>
    <div id="medadvice">&copy;2011 projecth. Informationen auf projecth konstituieren keinen medizinischen Ratschlag.</div>
  </div>
</div>
</c:if>
<!-- 
<c:if test="${print}">
<div id="printfooter"> 
  <div id="printmainfooter"><p class="centerme" >www.projecth.de | www.projecth.at | www.projecth.ch</p></div>
</div>
</c:if>
 -->
