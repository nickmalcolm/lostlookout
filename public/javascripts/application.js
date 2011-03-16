$(document).ready(function(){
	$(".nav li").click(function(){
		window.location = ($(this).find("a").attr("href"));
	});
  $('.watermarked_title').watermark('watermark');
	$("#contact_toggler").click(function(){
		$("#user_contact").toggle(400);
	});
});
$(function(){
  $(".tooltip").tipTip();
});