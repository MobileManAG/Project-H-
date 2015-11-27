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
<%@tag import="com.mobileman.projecth.web.util.MenuMap"%>
<%@ tag description="Patient master menu tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="header" fragment="true" %>
<%@ attribute name="footer" fragment="true" %>
<%@ attribute name="menuitem" required="false" rtexprvalue="true" %>
<%@ attribute name="submenuitem" required="false" rtexprvalue="true" %>
<%@ attribute name="title" required="false" rtexprvalue="true" %>
<%@ attribute name="print" required="false" rtexprvalue="true" %>
<%@ attribute name="menulink" required="false" rtexprvalue="true" %>
<%@ attribute name="caption" required="false" rtexprvalue="true" %>
<%@ attribute name="logoutmenu" required="false" rtexprvalue="true" %>
<%
	String menuitem = (String)jspContext.getAttribute("menuitem");
	if(menuitem==null || "".equals(menuitem)){
		//calc menuitem dynamicaly
		String url = request.getRequestURI();
		int index = url.lastIndexOf('/');
		if(index>=0){
			String page = url.substring(index+1);
			index = page.indexOf('.');
			if(index>=0) {
				page = page.substring(0, index);
			}
			java.util.List<com.mobileman.projecth.web.model.MenuItem> items = (java.util.List<com.mobileman.projecth.web.model.MenuItem>)request.getAttribute("menu2");
			java.util.List<Integer> indexes = MenuMap.urlIndex(items, page);
			String submenuitem=null;
			if(indexes!=null && indexes.size()>0) {
				menuitem = "" + indexes.get(0);
				if(indexes.size()>1){
					submenuitem = "" + indexes.get(1);
				}
			}
			jspContext.setAttribute("menuitem", menuitem);
			jspContext.setAttribute("submenuitem", submenuitem);
		}
	}
%>
<m:siteMaster print="${print}" title="${title}" menulink="${menulink}" logoutmenu="${logoutmenu}" caption="${caption}">
	<jsp:attribute name="header" >
		<jsp:invoke fragment="header" />
    </jsp:attribute>
    <jsp:attribute name="footer">
    	<jsp:invoke fragment="footer" />
    </jsp:attribute>
    <jsp:attribute name="menu">
    <table id="menuTable">
	<tr>
		<td><div class="menuBorder"></div></td>
		<td id="menuMiddle">
		
		<c:forEach var="m" items="${menu2}" varStatus="status">
		<c:if test="${menuitem!=status.index && m.name!=''}">
		<div class="menuItem" ><div><t:a dir="${menulink}" href="${m.url}" xclass="whitelink">${m.name}</t:a>
		</div></div>
		<c:if test="${!status.last && horMenuTextActive!=(status.index+1)}">
		<div class="menuLineBreak" ></div>
		</c:if>
		</c:if>
		
		<c:if test="${menuitem==status.index}">
		<c:set var="vertMenu" value="${m.submenu}" />
		<c:if test="${m.name!=''}">
		<div class="menuActItem"><div class="menuActItem2"><div class="menuActItem3">
		<t:a dir="${menulink}" href="${m.url}">${m.name}</t:a>
		</div></div></div>
		</c:if>
		</c:if>
		
		</c:forEach>
		</td>
		<td><div class="menuBorder"></div></td>
	</tr>
	</table>
    
	    <div id="pagetitle"><div id="pagetitleTextBack"><div id="pagetitleText">
	    ${caption}
	    </div>
	    </div></div>
	    <div id="shadowLine"></div>
	    <div class="stop"></div>
	    <div id="history">
	    <div id="historyText">
	    	<c:forEach var="h" items="${history}" varStatus="status">
	    		<t:a dir="${h.dir}" href="${h.href}">${h.caption}</t:a>
	    		<c:if test="${!status.last}"> &nbsp; &gt; &nbsp; </c:if>
	    	</c:forEach>
	    </div>
	    </div>
	    <script>
	  		$(document).ready(function() {
			    Rounded("div.menuActItem", "#5093C1", "#F5F7F8", 5, 5, true, false);
	  		});
	    </script>
    </jsp:attribute>
    <jsp:body>
        <c:if test="${!print}">
        <div class="stop"></div>
        <script>
        	$(document).ready(function(){
        		$(".arrowCollapsed").live('click', function(){
        			$(".submenuArea").hide();
        			$("#" + this.id.replace("subimg","submenu")).show();
        			$(".arrowMenu").removeClass("arrowExpanded");
        			$(".arrowMenu").addClass("arrowCollapsed");
        			$(this).removeClass("arrowCollapsed");
        			$(this).addClass("arrowExpanded");
        		});
        		$(".arrowExpanded").live('click', function(){
        			$(".submenuArea").hide();
        			$(".arrowMenu").removeClass("arrowExpanded");
        			$(".arrowMenu").addClass("arrowCollapsed");
        		});
        	});
        </script>
	    <div id="leftmain">
	    	<table>
	     <c:forEach var="m" items="${vertMenu}" varStatus="status">
	     	<tr><td style="vertical-align: top;"><div class="arrowMenu ${submenuitem==status.index?'arrowExpanded':'arrowCollapsed'}" id="subimg-${status.index}"></div></td>
			<td><t:a dir="${menulink}" href="${m.url}" xclass="mainlink" target="${m.target}">${m.name}</t:a><br />
			<div id="submenu-${status.index}" class="submenuArea"<c:if test="${submenuitem==status.index}"> style="display: block"</c:if>>
			<c:forEach var="sub" items="${m.submenu}">
				<t:a target="${sub.target}" dir="${menulink}" href="${sub.url}">${sub.name}</t:a><br/>
			</c:forEach>
			</div>	
			<t:img src="line.jpg" />
			</td></tr>
		</c:forEach>
			</table>
	    </div>
	    </c:if>
	    <div id="rightmain">
	   		<jsp:doBody />
	   	</div>
    </jsp:body>
</m:siteMaster>
