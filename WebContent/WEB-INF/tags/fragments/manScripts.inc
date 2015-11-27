#-------------------------------------------------------------------------------
# Copyright 2015 MobileMan GmbH
# www.mobileman.com
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------------------------------------
<script type="text/javascript">
	var data_values = ${data_values};
	
	$(document).ready(function() {
		//create hidden fields from maps
		var hiddens="";
		$('area[id^="vis-"]').each(function(){
			var hid = this.id.substring(4);
			var str = '<input type="hidden" id="' + hid + '" name="'+ hid +'" value="0"/>';
			hiddens += str;
		});
		$("#hiddensContainer").append(hiddens);
		
		$.each(data_values, function(index, value) {
			//radios and checkboxes
			$('input[name="' + value[0] + '"]').filter('[value="' + value[1] + '"]').attr('checked', true);
			//hidden fields
			$('input[name="' + value[0] + '"]').filter('[type="hidden"]').val(value[1]);
			$('input[name="' + value[0] + '"]').filter('[type="text"]').val(value[1]);
		});

		//recalculate circles and store original
		var circles = {};
		$("area[id^='vis-'], area[id^='zis-']").each(function() {
			var all = $(this).attr("coords");
			circles[this.id] = all;
			
			var coords = all.split(",");
	       	var x =  parseInt(coords[0]);
	       	var y =  parseInt(coords[1]);
	       	var d =  parseInt(coords[2]);
	       	x += d/2;
	       	y += d/2;
	       	d /= 2;
	       	$(this).attr("coords","" + x + "," + y +"," + d);
		});
		
		/////////////////////////
		var imgUrl = "<c:url value="/images/man/red_points/red_XXXXX.png"/>";
		
		function getImgId(superid) {
			var imgid = superid.replace("vis-","img-").replace("zis-","zmg-");
			return imgid;
		}
		
		function getImgClass(superid) {
			if(superid.substring(0,4)=="zis-") {
				return "visualClickZoom";
			}
			return "visualClickRed";
		}
		
		function redrawImages() {
			$('span[id$="-holder"]').empty();
			$("area[id^='vis-'], area[id^='zis-']").each( 
			    function() {
			    	if($("#" + this.id.substring(4)).val()!="1") {
			    		return;
			    	}
			       	//create image
			       	var coords = circles[this.id].split(",");
			       	var x =  parseInt(coords[0]);
			       	var y =  parseInt(coords[1]);
			       	var d =  parseInt(coords[2]);
			       	
			     	str = '<img src="' + imgUrl.replace("XXXXX",""+d) + '" class="' + getImgClass(this.id) + '" style="left: ' + x 
			     	 + 'px; top: ' + y + 'px;" id="' + getImgId(this.id) + '"/>';
			          
			      	$(this).parent().next().append(str);				    } 
			);
		}
		
		function animate(superid, up) {
			if(superid.substring(0, 4)=="img-"){
				superid = "vis-" + superid.substring(4);
			}
			if(superid.substring(0, 4)=="zmg-"){
				superid = "zis-" + superid.substring(4);
			}
			var coords = circles[superid].split(",");
	       	var x =  parseInt(coords[0]);
	       	var y =  parseInt(coords[1]);
	       	var d =  parseInt(coords[2]);

	       	var imgid= getImgId(superid);
	       	$("#" + imgid).remove(); //if exists

	       	//load image
	       	var startx,starty,startd,endx,endy,endd;
	       	if(up){
	       		endx=x;
	       		endy=y;
	       		endd=d;
	       		
	       		startx = x + d/2+2;
	       		starty = y + d/2+2;
	       		startd = 1;
	       	}else{
	       		startx = x;
	       		starty = y;
	       		startd = d;
	       		
	       		endx = x + d/2+2;
	       		endy = y + d/2+2;
	       		endd = 1;
	       	}
	       	var str = '<img src="' + imgUrl.replace("XXXXX","37") + '" class="' + getImgClass(superid) + '" style="left: ' + startx 
	     	 + 'px; top: ' + starty + 'px; width:' + startd + 'px" id="' + imgid + '"/>';
		       	
	     	 $("#" + superid).parent().next().append(str);

	       	//animate image to the destination
	       	$("#" + imgid).animate({
	       		top: endy,
	       		left: endx,
	       		width: endd
	       	}, 300, "linear", function(){redrawImages();} );
		}
		
		redrawImages();
		
		<c:if test="${readonly==null}">
		
		function clickImage(superid) {
			var hiddenid ="#" + superid.substring(4);
			var up = false;
			if($(hiddenid).val()=="1") {
				$(hiddenid).val("0");
			}else{
				$(hiddenid).val("1");
				up = true;
			}
			//animate(superid, up);
			redrawImages();
			return false;
		}
		
		//click on image map
		$(".visualClick").click(function() {
			return clickImage(this.id);
		});

		$(".visualClickRect").click(function() {
			return clickImage(this.id.replace("fis-","vis-"));
		});
		
		//click on red circle
		$('.visualClickRed').live('click', function() {
			return clickImage(this.id);			
		});
		
		
		//zoom
		$(".visualClickZoom").live('click', function(){
			var item="";
			if($(this).attr("href")!=null) {
				item = "#" + $(this).attr("href").substring(1);
			}else{
				//red image
				item = "#" + $(this).parent().prev().children().first().attr("href").substring(1);
			}
			$.blockUI({ 
				message: $(item), 
				css: {
					top: '10px'
				}
			});
			$(".blockMsg ").css("position","absolute"); //user can scroll zoomed image on small displays
			return false;
		});
		</c:if>
		<c:if test="${readonly!=null}">
		//click on image map
		$(".visualClick").click(function() {
			return false;
		});
		
		//click on red circle
		$('.visualClickRed').live('click', function() {
			return false;
		});
		
		//zoom
		$(".visualClickZoom").click(function(){
			return false;
		});
		</c:if>
		
		$(".closeZoom").click(function(){
			$.unblockUI(); 
			$(document).unbind('keypress');
			return false;
		});
});

</script>
