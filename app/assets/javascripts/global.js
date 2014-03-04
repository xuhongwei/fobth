// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
(function () {
    function SBoxz_Global() {}

    SBoxz_Global.prototype.fb_login_popup=function(){
      $('.weibo-login').click(function(e) {
        e.preventDefault();
        FB.login(function(response) {
          if (response.authResponse) {
            window.location = "/users/auth/facebook/callback"
          }else {
            window.location.reload();
          }
        }, {scope: 'email,publish_stream'});
      });
    }

    SBoxz_Global.prototype.initial=function(){
        this.fb_login_popup();
    };
    window._sboxz_global = window._sboxz_global ? window._sboxz_global: new SBoxz_Global();
})();