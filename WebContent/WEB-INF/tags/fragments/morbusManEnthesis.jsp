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

<%@ include file="/WEB-INF/tags/fragments/manScripts.inc"%>
<div style="width: 100%; text-align: center;">
<table style="margin: auto;"><tr><td>
<d:manImage image="man/morbus_enthesis/morbusbechterew_man.png" prefix="${prefix}" style="float:left;">
			<area shape="circle" coords="152, 112, 11" id="vis-ch${currentHaq.questions[0].id}" href="" class="visualClick" />
			<area shape="circle" coords="137, 112, 11" id="vis-ch${currentHaq.questions[1].id}" href="" class="visualClick" />
			<area shape="circle" coords="152, 150, 11" id="vis-ch${currentHaq.questions[2].id}" href="" class="visualClick" />
			<area shape="circle" coords="137, 150, 11" id="vis-ch${currentHaq.questions[3].id}" href="" class="visualClick" />
			<area shape="circle" coords="175, 206, 11" id="vis-ch${currentHaq.questions[4].id}" href="" class="visualClick" />
			<area shape="circle" coords="163, 206, 11" id="vis-ch${currentHaq.questions[5].id}" href="" class="visualClick" />
			<area shape="circle" coords="114, 206, 11" id="vis-ch${currentHaq.questions[6].id}" href="" class="visualClick" />
			<area shape="circle" coords="126, 206, 11" id="vis-ch${currentHaq.questions[7].id}" href="" class="visualClick" />
</d:manImage></td><td>
<d:manImage image="man/morbus_enthesis/man_mitlinealen_mb_back.png" prefix="${prefix}">
			<area shape="circle" coords="126, 206, 11" id="vis-ch${currentHaq.questions[8].id}" href="" class="visualClick" />
			<area shape="circle" coords="163, 206, 11" id="vis-ch${currentHaq.questions[9].id}" href="" class="visualClick" />
			<area shape="circle" coords="144, 227, 11" id="vis-ch${currentHaq.questions[10].id}" href="" class="visualClick" />
			<area shape="circle" coords="110, 504, 11" id="vis-ch${currentHaq.questions[11].id}" href="" class="visualClick" />
			<area shape="circle" coords="178, 504, 11" id="vis-ch${currentHaq.questions[12].id}" href="" class="visualClick" />
</d:manImage>
</td></tr></table></div>
<div id="hiddensContainer"></div>
