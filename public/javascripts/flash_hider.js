$(document).ready(function(){
  visible_errors = $('#notices_errors').find('.alert:visible').length;
  setTimeout(function(){
      hideAll();
    },5000*visible_errors);
});
function hideMe(hide_this_element){
  hide_this_element.parent().parent().hide(400);
  //When this gets executed it'll still be partially visible
  if($('#notices_errors').find('.alert:visible').length == 1){
    hideAll();
  }
}
function hideAll(){
  $(".notice_container").parent().hide(400);
}