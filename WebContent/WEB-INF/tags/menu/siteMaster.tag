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
<%@ tag description="Global site master page tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="header" fragment="true" %>
<%@ attribute name="footer" fragment="true" %>
<%@ attribute name="menu" fragment="true" %>
<%@ attribute name="title" required="false" rtexprvalue="true" %>
<%@ attribute name="print" required="false" rtexprvalue="true" %>
<%@ attribute name="caption" required="false" rtexprvalue="true"%>
<%@ attribute name="menulink" required="false" rtexprvalue="true" %>
<%@ attribute name="logoutmenu" required="false" rtexprvalue="true" %>
<%
String caption = (String)jspContext.getAttribute("caption");
com.mobileman.projecth.web.history.HistoryStorage.store(request, caption);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="de" xml:lang="de">
<t:head title="${title}">
	<jsp:attribute name="header">
		<jsp:invoke fragment="header" />
    </jsp:attribute>
</t:head>
<body>
<div id="container">
  <c:if test="${!print}">
  
  <div id="header2">
  	<div id="headertext">
  		<div id="projecthlogo">
  			<c:if test="${menulink!=null}"><t:a href="index" dir="${menulink}"><t:img src="projecth_logo.png" /></t:a></c:if>
  			<c:if test="${menulink==null}"><t:img src="projecth_logo.png" /></c:if>
  		</div>
  		<c:if test="${menulink!=null}">
  		<div id="headermenu">
  			<c:forEach var="m" items="${horSmallMenuText}" varStatus="status">
  				<c:if test="${status.index!=0}">|</c:if>
  				<t:a href="${horSmallMenuUrl[status.index]}" dir="${menulink}" xclass="whitelink">${m}</t:a> 
  			</c:forEach>
  			<c:if test="${logoutmenu}"> 
  			| <a href="<c:url value="/login/logout"/>" class="whitelink">Abmelden</a>
  			</c:if>
  		</div>
  		</c:if>
  		<c:if test="${logoutmenu=='false'}">
	  		<div id="headermenu">
	  			<!-- AddThis Button BEGIN
				<a class="addthis_button" href="http://www.addthis.com/bookmark.php">
		        	<img src="http://s7.addthis.com/static/btn/sm-plus.gif" width="8" height="8" alt="Share" /></a>
				<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=xa-4d527cf47f8cc043"></script>
				-->
				
	  			<input type="image" id='showTAFModal' src="<c:url value="/images/tell.png"/>"  value="1"/>
	  			
	  		</div>
  		</c:if>
  		<c:if test="${menulink==null}">
	  		<div id="headermenu">
	  			<!-- AddThis Button BEGIN
				<a class="addthis_button" href="http://www.addthis.com/bookmark.php">
		        	<img src="http://s7.addthis.com/static/btn/sm-plus.gif" width="8" height="8" alt="Share" /></a>
				<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=xa-4d527cf47f8cc043"></script>
				-->
				
	  			<input type="image" id='showTAFModal' src="<c:url value="/images/tell.png"/>"  value="1"/>
	  		</div>
  		</c:if>
  	</div> 
  	<c:if test="${menulink==null}">
  		<div id="header2_bottom"></div>
  		<div id="chromline2"></div>
  	</c:if>
  </div>
  <div class="stop"></div>
  <jsp:invoke fragment="menu" />
  <div id="maincontent"> 
    	<jsp:doBody />
    <div id="pointlessbox">	</div>
  </div>
  </c:if>
  
  <c:if test="${print}">
  	<div id="print_header">
	<table width="100%">
		<tr>
			<td style="height: 40px; vertical-align: bottom; text-align: left; font-size: 24px; color: #65b7df;">
				projecth&reg; Profil
			</td>
			<td style="height: 40px; vertical-align: bottom; text-align: right;  font-size: 20px; color: #666666;">
				Pers&ouml;nliche Auswertung
			</td>
		</tr>
	</table>
	</div>
	<div id="print_footer">
		<table width="100%">
			<tr>
				<td style="text-align: left; font-size: 12px; color: #65b7df;">
					Transparenz für eine bessere Behandlung
				</td>
			</tr>
			<tr>
				<td style="text-align: left; font-size: 12px; color: #666666;">
					&copy;2011 projecth&reg;. Informationen auf projecth&reg; konstituieren keinen medizinischen Ratschlag.
				</td>
			</tr>
		</table>
	</div>
  	<!-- 
  	<div id="printheader"> 
	  	<div id="printmainheader"> 
	  		<div id="printheaderimage">
	  		</div>
	  	</div>
  	</div>
  	 -->
  	<div id="printmaincontent"> 
    	<jsp:doBody />
    <div id="pointlessbox">	</div>
  </div>
  </c:if>
</div>
<jsp:invoke fragment="footer" />

<!-- Tell A Friend Modal -->
<div id="tellafriendmodal" class="tellafriendmodal"> 
	<h3>
		<font color="#000000" face="Arial, Helvetica, sans-serif">Weiterempfehlen!</font>
	</h3>
	<br /> 
	<label class="opt">
		Empfehlen Sie projecth&reg; Freunden und Bekannten weiter. Sie verpflichten sich zu redlicher, sachlicher, respektvoller und gesetzeskonformer Kommunikation. 
	</label>
	<br />
	<br /> 
	<table width="430">
		<tr align="left">
		    <td colspan="2">
				<label class="vtip" title="Sie erhalten ein Kopie zu Ihren Informationen.">E-Mail des Absenders:</label>
			</td>
		</tr>
		<tr align="left">
			<td>
				<input style="width: 198px" name="email" type="text" id="tellafriendemail" />
				<div style="display: none; text-align: left;" class="error">Fehler E-Mail</div>
				
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<label class="vtip" title="Sie k&ouml;nnen bis zu 5 E-Mails eingeben. Trennen Sie die einzelnen E-Mails einfach mit einem Komma.">E-Mail des Empf&auml;ngers:</label>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<input style="width: 422px" name="emails" type="text" id="tellafriendemails" />
				<div style="display: none; text-align: left;" class="error">Fehler - Es gab einen Fehler in der E-Mail.</div>
				
			</td>
		</tr>
		<tr align="left">
			<td colspan="2" >
				<label>Ihre Mitteilung:</label>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<textarea style="width: 418px; height: 60px; resize: none;" name="tellafriendmessage" id="tellafriendmessage" >${message}</textarea>
				<div style="display: none; text-align: left;" class="error">Fehlermeldung</div>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<label 
					class="vtip"
					title="Diese Massnahmen sch&uuml;tzt unser System vor automatisierten Abfragen."
				>Bitte wiederholen Sie den Sicherheitscode.</label><br />
				
			</td>
		</tr>
		<tr align="left">
			<td colspan="2" id='captchatd'>
				<t:captcha />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<br />
			</td>
		</tr>
		<tr>
			<td colspan="2" align="left">
				<!-- send --> 
				<input type="image" id='send_message' src="<c:url value="/images/button_senden.png"/>"  value="1"/>
				<!-- clear --> 
				<input type="image" id='cancel' src="<c:url value="/images/button_abbrechen_grau.png"/>"  value="1"/>
			</td>
		</tr>
		<tr>
			<td colspan="2"  align="left">
				<div style="display: none; text-align: left;" class="error" id="sendingError">Fehler in der &Uuml;bermittlung - Bitte versuchen Sie es erneut.</div>
				<div style="display: none; text-align: left;" class="success" id="sendingSuccess">Mitteilung konnte erfolgreich &uuml;bermittelt werden.</div>
			</td>
		</tr>
	</table>
</div> 
<script type="text/javascript"> 

	function showTAFModal(){
		resetTellAFriendCaptcha();
		resetTellAFriendForm();
    	$('#sendingError').hide();
        $('#sendingSuccess').hide();
		$.blockUI({ message: $('#tellafriendmodal')});
		$(".blockMsg ").css("position","absolute");
	}
	
	$(function() {

		$("#showTAFModal").live('click', function() {
			showTAFModal();
		});
		
        $('#send_message').click(function() { 
            if(validateTellAFriendForm() == true){
        		$.ajax({
					type: "POST",
					url: '<c:url value="/behandlung/indextellafriend"/>',
					data: {
						senderName: $('#tellafriendname').val(),
						senderEmail: $('#tellafriendemail').val(),
						receiverEmails: $('#tellafriendemails').val(),
						body: $('#tellafriendmessage').val(),
						capchta: $('#captchaAnswer').val()
					},
					success: function(msg){
					  if(msg == "errorcapchta"){
						  resetTellAFriendCaptcha();
						  $('#captchaError').show();
					  }
					  if(msg == "error"){
						  resetTellAFriendCaptcha();
						  $('#sendingError').show();
					  }
					  if(msg == "ok"){
						  $('#sendingSuccess').show();
						  setTimeout($.unblockUI, 1000);
					  }
					}
				});
            } 
        });  
        
        $('#cancel').click(function() { 
            $.unblockUI(); 
            
            $('#tellafriendmodal').find(".error").each(function(index, domEle) {
        		$(this).css("display","none");
    		}); 
            $('#sendingError').hide();
            $('#sendingSuccess').hide();
        });  
 
    }); 

	function resetTellAFriendCaptcha() {
		$('#captchaAnswer').val("");
		var randomnumber = Math.random();
		$('#captchaImage').removeAttr('src');
		$('#captchaImage').attr('src', '<c:url value="/captchaImg?'+ randomnumber +'"/>');
	}
	
	function resetTellAFriendForm() {
		$('#tellafriendmodal').find(":input[type=text], textarea").each(function(index, domEle) {
			$(domEle).val("");
		});
	}
	
	function validateTellAFriendForm() {
		var isValid = true;

		$('#tellafriendmodal').find(":input[type=text], textarea").each(function(index, domEle) {
			var input_value = $(domEle).val();
			if(input_value.length == 0){
				$(domEle).next().show();
				isValid = false;
			} else {
				$(domEle).next().hide();
			}
		});

		return isValid;
	}
</script>
</body>
</html>

