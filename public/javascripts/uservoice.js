var uservoiceOptions = {
  key: 'lostlookout',
  host: 'lostlookout.uservoice.com', 
  forum: '110815',
  alignment: 'left',
  background_color:'#555555', 
  text_color: 'white',
  hover_color: '#3FBDFF',
  lang: 'en',
  showTab: true
};
function _loadUserVoice() {
  var s = document.createElement('script');
  s.src = ("https:" == document.location.protocol ? "https://" : "http://") + "cdn.uservoice.com/javascripts/widgets/tab.js";
  document.getElementsByTagName('head')[0].appendChild(s);
}
_loadSuper = window.onload;
window.onload = (typeof window.onload != 'function') ? _loadUserVoice : function() { _loadSuper(); _loadUserVoice(); };