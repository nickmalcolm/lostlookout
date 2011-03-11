(function($) {
	$.fn.watermark = function(c, t) {
		var e = function(e) {
			var i = $(this);
			if (!i.val()) {
				if(i.val() == i.attr('title') || i.val() == ""){
					var w = t || i.attr('title'), $c = $($("<div />").append(i.clone()).html().replace(/type=\"?password\"?/, 'type="text"')).val(w).addClass(c)
					i.replaceWith($c);
					$c.focus(function() {
						i.addClass("edited");
						$c.replaceWith(i); setTimeout(function() {i.focus();}, 1);
					})
					.change(function(e) {
						i.val($c.val()); $c.val(w); i.val() && $c.replaceWith(i);
					})
					.closest('form').submit(function() {
						$c.replaceWith(i);
					})
				}
			}	
		};
		return $(this).live('blur change', e).change();
	};
})(jQuery);


$(document).ready(function(){
	//Remove the style if the watermark text isn't present (e.g. browser remembered value)
	if ($("#user_email").val() != $("#user_email").attr('title')){
		$("input#user_email").removeClass("watermark")
	}
});
