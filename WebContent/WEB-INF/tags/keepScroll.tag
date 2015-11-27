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
<%@ tag description="A tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="id" required="true" rtexprvalue="true" %>
<script>
	$(document).ready(function(){
		var hidId = "keepScrollHidden";
		$("#${id}").click(function(){
			//create hidden
			$(this).after("<input type='hidden' name='" +  hidId + "' id='" + hidId + "'/>");
			//save values
			var val1 = $(window).scrollTop();
			var val2 = $(this).offset().top;
			$("#" + hidId).val(val1 +  " " + val2);
			return true;
		});
		//scroll to previous value
		var val = "${keepScrollHidden}";
		if(val.indexOf(" ") > 0) {
			var spl = val.split(" ");
			var prevScroll = parseInt(spl[0]);
			var prevElement = parseInt(spl[1]);
			var currElement = $("#${id}").offset().top;
			var scrl = prevScroll + currElement - prevElement;
			$(window).scrollTop(scrl);
		}
	});
</script>
