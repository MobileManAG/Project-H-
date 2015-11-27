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
<%@ tag description="Man tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="prefix" required="true"%>

<table class="rheumaMan">
	<tr><td><d:manImage image="man/rheuma/headright.png" prefix="${prefix}">
			<area shape="circle" coords="92, 102, 37" id="vis-ch${currentHaq.questions[0].id}" href="" class="visualClick" />
			<area shape="rect" coords="0,0,160,176" id="fis-ch${currentHaq.questions[0].id}" href="" class="visualClickRect" />
		</d:manImage></td><td style="width: 2px"></td>
		<td><d:manImage image="man/rheuma/headleft.png" prefix="${prefix}">
			<area shape="circle" coords="30, 102, 37" id="vis-ch${currentHaq.questions[14].id}" href="" class="visualClick" />
			<area shape="rect" coords="0,0,160,176" id="fis-ch${currentHaq.questions[14].id}" href="" class="visualClickRect" />
		</d:manImage></td></tr>
	
	<tr><td><d:manImage image="man/rheuma/armright.png" prefix="${prefix}">
			<area shape="circle" coords="67, 25, 37" id="vis-ch${currentHaq.questions[1].id}" href="" class="visualClick" />
			<area shape="rect" coords="0,0,160,82" id="fis-ch${currentHaq.questions[1].id}" href="" class="visualClickRect" />
		</d:manImage></td><td style="width: 2px"></td>
		<td><d:manImage image="man/rheuma/armleft.png" prefix="${prefix}">
			<area shape="circle" coords="55, 25, 37" id="vis-ch${currentHaq.questions[15].id}" href="" class="visualClick" />
			<area shape="rect" coords="0,0,160,82" id="fis-ch${currentHaq.questions[15].id}" href="" class="visualClickRect" />
		</d:manImage></td></tr>
	
	<tr><td><d:manImage image="man/rheuma/handright.png" prefix="${prefix}">
			<area shape="circle" coords="36, 4, 27" id="zis-ch${currentHaq.questions[2].id}" href="#${prefix}righthandimg"  class="visualClickZoom" />
			<area shape="circle" coords="17, 26, 7" id="zis-ch${currentHaq.questions[3].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="25, 22, 7" id="zis-ch${currentHaq.questions[4].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="18, 39, 7" id="zis-ch${currentHaq.questions[5].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="24, 32, 7" id="zis-ch${currentHaq.questions[6].id}" href="#${prefix}righthandimg"  class="visualClickZoom" />
			<area shape="circle" coords="24, 46, 7" id="zis-ch${currentHaq.questions[7].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="29, 37, 7" id="zis-ch${currentHaq.questions[8].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="32, 50, 7" id="zis-ch${currentHaq.questions[9].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="35, 40, 7" id="zis-ch${currentHaq.questions[10].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="41, 50, 7" id="zis-ch${currentHaq.questions[11].id}" href="#${prefix}righthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="42, 42, 7" id="zis-ch${currentHaq.questions[12].id}" href="#${prefix}righthandimg"  class="visualClickZoom" />
			<area shape="rect" coords="0, 0, 160, 82 " href="#${prefix}righthandimg" class="visualClickZoom" />
		</d:manImage></td><td style="width: 2px"></td>
		<td><d:manImage image="man/rheuma/handleft.png" prefix="${prefix}">
			<area shape="circle" coords="95, 4, 27"  id="zis-ch${currentHaq.questions[16].id}" href="#${prefix}lefthandimg"   class="visualClickZoom" />
			<area shape="circle" coords="135, 26, 7" id="zis-ch${currentHaq.questions[17].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="127, 22, 7" id="zis-ch${currentHaq.questions[18].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="135, 39, 7" id="zis-ch${currentHaq.questions[19].id}" href="#${prefix}lefthandimg"  class="visualClickZoom" />
			<area shape="circle" coords="128, 32, 7" id="zis-ch${currentHaq.questions[20].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="129, 46, 7" id="zis-ch${currentHaq.questions[21].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="123, 36, 7" id="zis-ch${currentHaq.questions[22].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="121, 49, 7" id="zis-ch${currentHaq.questions[23].id}" href="#${prefix}lefthandimg"  class="visualClickZoom" />
			<area shape="circle" coords="117, 40, 7" id="zis-ch${currentHaq.questions[24].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="112, 51, 7" id="zis-ch${currentHaq.questions[25].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="circle" coords="110, 41, 7" id="zis-ch${currentHaq.questions[26].id}" href="#${prefix}lefthandimg"  class="visualClickZoom"  />
			<area shape="rect" coords="0, 0, 160, 82 " href="#${prefix}lefthandimg" class="visualClickZoom" />
		</d:manImage></td></tr>
	
	<tr><td><d:manImage image="man/rheuma/legright.png" prefix="${prefix}">
			<area shape="circle" coords="104, 51, 37" id="vis-ch${currentHaq.questions[13].id}" href="" class="visualClick" />
			<area shape="rect" coords="0,0,160,224" id="fis-ch${currentHaq.questions[13].id}" href="" class="visualClickRect" />
		</d:manImage></td><td style="width: 2px"></td>
		<td><d:manImage image="man/rheuma/legleft.png" prefix="${prefix}">
			<area shape="circle" coords="18, 51, 37" id="vis-ch${currentHaq.questions[27].id}" href="" class="visualClick" />
			<area shape="rect" coords="0,0,160,224" id="fis-ch${currentHaq.questions[27].id}" href="" class="visualClickRect" />
		</d:manImage></td></tr>
</table>
<d:manZoomedImage image="man/rheuma/handright_big.png" prefix="${prefix}" id="${prefix}righthandimg">
			<area shape="circle" coords="220, 26, 164" id="vis-ch${currentHaq.questions[2].id}" href=""  class="visualClick"/>
			<area shape="circle" coords="104, 160, 41" id="vis-ch${currentHaq.questions[3].id}" href=""  class="visualClick"/>
			<area shape="circle" coords="149, 135, 41" id="vis-ch${currentHaq.questions[4].id}" href=""  class="visualClick"/>
			<area shape="circle" coords="107, 238, 41" id="vis-ch${currentHaq.questions[5].id}" href=""  class="visualClick"/>
			<area shape="circle" coords="147, 194, 41" id="vis-ch${currentHaq.questions[6].id}" href=""  class="visualClick" />
			<area shape="circle" coords="145, 276, 41" id="vis-ch${currentHaq.questions[7].id}" href=""  class="visualClick" />
			<area shape="circle" coords="178, 221, 41" id="vis-ch${currentHaq.questions[8].id}" href=""  class="visualClick"/>
			<area shape="circle" coords="191, 299, 41" id="vis-ch${currentHaq.questions[9].id}" href="" class="visualClick" />
			<area shape="circle" coords="214, 243, 41" id="vis-ch${currentHaq.questions[10].id}" href="" class="visualClick" />
			<area shape="circle" coords="244, 304, 41" id="vis-ch${currentHaq.questions[11].id}" href=""  class="visualClick"/>
			<area shape="circle" coords="254, 253, 41" id="vis-ch${currentHaq.questions[12].id}" href=""  class="visualClick"/>
</d:manZoomedImage>
<d:manZoomedImage image="man/rheuma/handleft_big.png" prefix="${prefix}" id="${prefix}lefthandimg">
			<area shape="circle" coords="145, 26, 164" id="vis-ch${currentHaq.questions[16].id}" href="" class="visualClick"/>
			<area shape="circle" coords="380, 159, 41" id="vis-ch${currentHaq.questions[17].id}" href="" class="visualClick"/>
			<area shape="circle" coords="334, 133, 41" id="vis-ch${currentHaq.questions[18].id}" href="" class="visualClick"/>
			<area shape="circle" coords="380, 238, 41" id="vis-ch${currentHaq.questions[19].id}" href="" class="visualClick"/>
			<area shape="circle" coords="341, 193, 41" id="vis-ch${currentHaq.questions[20].id}" href="" class="visualClick"/>
			<area shape="circle" coords="344, 278, 41" id="vis-ch${currentHaq.questions[21].id}" href="" class="visualClick"/>
			<area shape="circle" coords="310, 220, 41" id="vis-ch${currentHaq.questions[22].id}" href="" class="visualClick"/>
			<area shape="circle" coords="297, 297, 41" id="vis-ch${currentHaq.questions[23].id}" href="" class="visualClick"/>
			<area shape="circle" coords="274, 242, 41" id="vis-ch${currentHaq.questions[24].id}" href="" class="visualClick"/>
			<area shape="circle" coords="245, 310, 41" id="vis-ch${currentHaq.questions[25].id}" href="" class="visualClick"/>
			<area shape="circle" coords="233, 249, 41" id="vis-ch${currentHaq.questions[26].id}" href="" class="visualClick"/>
</d:manZoomedImage>
