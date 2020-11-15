var $container;	
var $parent;	
var $rlImage;
var result="";		

var childImage = new Array();
var isExecute = false;

$(function(){
	$container = jQuery("#container").eq(0);
	$parent = $container.children("div");
	$rlImage = $parent.children("img");

	$parent.each(function(i){
		childImage[i] = jQuery(this).html();
	});

	$rlImage.each(function(i){
		var imgSrc = jQuery(this).attr("src");
	});

});

function roolet() {

	if(isExecute==false) {
		rooletExecute(1);
	} else {
		location.reload();
	}
}

function rooletExecute(num) {
	$parent.each(function(i){
		jQuery(this).delay((i+2)*20).animate({"top":"-="+jQuery(this).height()*(num+1)},3000+(i*300));
	});

	for(var j=0;j<num;j++) {
		$parent.each(function(i){
			jQuery(this).append(childImage[i]);

			if(j+1==num) {
				var rand = rnd(0,12);
				jQuery(this).append("<img src='"+ jQuery(this).children().eq(rand).attr("src") +"' />");
				result += jQuery(this).children().eq(rand).attr("src")  + ", ";

			}
		});
	}

	isExecute = true;
}


function rnd(startNumber,endNumber) {
	var randValue = Math.floor(Math.random()*endNumber+startNumber);
	return randValue;
}