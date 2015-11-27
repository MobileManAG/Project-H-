/**
Vertigo Tip by www.vertigo-project.com
Requires jQuery
*/

this.vtip = function() {    
    this.xOffset = -17; // x distance from mouse
    this.yOffset = 30; // y distance from mouse       
    
    $(".vtip").unbind().hover(    
        function(e) {
            this.t = getTitle(this.title);
            this.c = getContent(this.title);
            this.title = ''; 
            this.top = (e.pageY + yOffset); this.left = (e.pageX + xOffset);
            
            $('body').append( '<div id="vtip"><img id="vtipArrow" /><div style="padding-bottom:3px"><strong>' + this.t + '</strong></div><p>' + this.c +'</p></div>' );
                        
            $('div#vtip #vtipArrow').attr("src", '../images/vtip_arrow.png');
            $('div#vtip').css("top", this.top+"px").css("left", this.left+"px").fadeIn("slow");
            
        },
        function() {
            this.title = this.t + "^" + this.c;
            $("div#vtip").fadeOut("slow").remove();
        }
    ).mousemove(
        function(e) {
            this.top = (e.pageY + yOffset);
            this.left = (e.pageX + xOffset);
                         
            $("div#vtip").css("top", this.top+"px").css("left", this.left+"px");
        }
    );            
    
};

function getTitle(text){
	index = text.indexOf("^");
		if(index<0) {
			return '';
		}
	return text.substr(0, index);
}

function getContent(text){
	index = text.indexOf("^");
		if(index<0) {
			return text;
		}
	return text.substr(index+1, text.length);
}

jQuery(document).ready(function($){vtip();}) 
