$(document).ready( function(){ 
  
    if($("#listing_lost").attr("checked") ){
      $("#lost").attr("class", 'cb-enable selected');
      $("#found").attr("class", 'cb-disable');
      $('.checkbox',parent).attr('checked', true);
    }
    else{
      $("#lost").attr("class", 'cb-enable');
      $("#found").attr("class", 'cb-disable selected');
      $('.checkbox',parent).attr('checked', false);
			//Hide fields for lost only listings
			$('#lost_only').hide();
    }
    
    $(".cb-enable").click(function(){
        var parent = $(this).parents('.switch');
        $('.cb-disable',parent).removeClass('selected');
        $(this).addClass('selected');
        $('.checkbox',parent).attr('checked', true);
				if($(this).attr("id") == ("lost")){
					$('#lost_only').show(200);
				}
				else{
					$('#lost_only').hide();
				}
    });
    $(".cb-disable").click(function(){
        var parent = $(this).parents('.switch');
        $('.cb-enable',parent).removeClass('selected');
        $(this).addClass('selected');
        $('.checkbox',parent).attr('checked', false);
				if($(this).attr("id") == ("lost")){
					$('#lost_only').show(200);
				}
				else{
					$('#lost_only').hide();
				}
    });
});