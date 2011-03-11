$(document).ready(function(){
	$(".nav li").click(function(){
		window.location = ($(this).find("a").attr("href"));
	});
  $('.watermarked_title').watermark('watermark');
});
$(function(){
  $(".tooltip").tipTip();
});