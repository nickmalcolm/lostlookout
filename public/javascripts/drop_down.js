function slideMenu(slideDown){
	if(slideDown){
		$('#dd_cont').show();
		$('.dropdown').height(0);
		$('.dropdown').animate({height: "+=160"},     { queue: false, duration:250});
		$('#dropdown_toggler').removeClass("round");
		$('#dropdown_toggler').addClass("top_curve").addClass("right_curve");
	}
	else {
		$('.dropdown').animate({height: "-=135"},     { queue: false, duration:250});
		setTimeout(function(){
			$('#dd_cont').hide();
		},250);
		$('#dropdown_toggler').removeClass("top_curve").removeClass("right_curve");
		$('#dropdown_toggler').addClass("round");
	}
}


$(document).ready(function(){

	$("#dropdown_toggler").click(function(){
		slideMenu( ($("#dd_cont").css('display') == 'none') );
	});
  
});