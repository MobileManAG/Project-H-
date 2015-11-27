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
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc"%>
<script>
	var active="_active";
	function redrawMorbus() {
		$(".morbusImg").each(function() {
			var src = $(this).attr("src");
			var classList =$(this).attr('class').split(/\s+/);
			var id = null;
			$.each( classList, function(index, item){
			    if (item.substring(0, 8)==='image-ch') {
			       //do something
			       id = item.substring(6);
			    }
			});
			var state = $("#" + id).val();
			if(state=="1"){
				//activate if not activated
				if(src.indexOf(active)<0) {
					str = src.replace(".png", active + ".png");
					$(this).attr("src", str);
				}
			}else{
				//deactivate
				if(src.indexOf(active)>=0) {
					str = src.replace(active, "");
					$(this).attr("src", str);
				}
			}
		});
	}

	function morbusImgClick(id) {
<c:if test="${readonly==null}">		
		var hid = $("#" + id);
		var value = hid.val();
		if(value=="1") {
			hid.val("0");
		}else{
			hid.val("1");
		}
		redrawMorbus();
</c:if>		
	}
	
	$(document).ready(function(){
		redrawMorbus();	
	});
	
</script>
<div style="width: 100%; text-align: center;">
<table style="margin: auto;">
<tr><td><d:morbusManFront /></td><td><d:morbusManBack /></td></tr>
</table>
<input type="hidden" name="ch${currentHaq.questions[0].id}" id="ch${currentHaq.questions[0].id}" />
<input type="hidden" name="ch${currentHaq.questions[1].id}" id="ch${currentHaq.questions[1].id}" />
<input type="hidden" name="ch${currentHaq.questions[2].id}" id="ch${currentHaq.questions[2].id}" />
<input type="hidden" name="ch${currentHaq.questions[3].id}" id="ch${currentHaq.questions[3].id}" />
<input type="hidden" name="ch${currentHaq.questions[4].id}" id="ch${currentHaq.questions[4].id}" />
<input type="hidden" name="ch${currentHaq.questions[5].id}" id="ch${currentHaq.questions[5].id}" />
<input type="hidden" name="ch${currentHaq.questions[6].id}" id="ch${currentHaq.questions[6].id}" />
<input type="hidden" name="ch${currentHaq.questions[7].id}" id="ch${currentHaq.questions[7].id}" />
</div>
<div class="questionFrame">
	<q:question question="${currentHaq.questions[8]}"/>
</div>
<div class="questionFrame" style="background-color: #F5F5F5">
	<q:question question="${currentHaq.questions[9]}"/>
</div>
