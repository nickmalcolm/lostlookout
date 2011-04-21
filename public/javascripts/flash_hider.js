$(document).ready(function(){
  if($("#notices").attr("data-show-me") == "true"){
    $("#notices").parent().show();
    $("#notices").slideDown(400);
    setTimeout(function(){
        $("#notices").slideUp(400);
      },5000);
    }
});