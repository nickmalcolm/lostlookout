$(document).ready(function(){
	$(".nav li").click(function(){
		window.location = ($(this).find("a").attr("href"));
	});
	
});