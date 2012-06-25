(function($) {

  var methods = {
    initIndex: function(options) {

    },
    // Authentication Dialog
    initAuthDialog: function(options) {

      window.fbAsyncInit = function() {
        $(function() {
          FB.init({
            appId  : options.app_id,
            status : true, // check login status
            cookie : true, // enable cookies to allow the server to access the session
            xfbml  : true  // parse XFBML
          });

          var loginbutton = $('#fb-login');
          var logoutButton = $('#fb-logout');
          var closeButton = $('#fb-close-button');
          var statusText = $('#fb-login-status');

          var setLoggedIn = function(response) {
            $.getJSON('/auth/facebook/callback', response, function(json) {
              console.log("logged in");
            });
          };

          FB.getLoginStatus(function(response) {
            if (response.status === 'connected') {
              setLoggedIn(response.authResponse);
              statusText.html("You are already logged in.");
              closeButton.show();
              loginbutton.hide();
              logoutButton.hide();
            } else if (response.status === 'not_authorized') {
              loginbutton.show();
              logoutButton.hide();
            } else {
              loginbutton.show();
              logoutButton.hide();
            }
          });

          loginbutton.click(function(e) {
            e.preventDefault();

            FB.login(function(response) {
              if (response.authResponse) {
                setLoggedIn(response.authResponse);
              }
            }, { scope: options.scope });
          });

          logoutButton.click(function(e) {
            FB.logout(function(response) {
              $.getJSON('/auth/facebook/logout', function(json) {
                history.back();
              });
            });
          });
        });
      };

      // Load the SDK Asynchronously
      (function(d){
         var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
         if (d.getElementById(id)) {return;}
         js = d.createElement('script'); js.id = id; js.async = true;
         js.src = "//connect.facebook.net/en_US/all.js";
         ref.parentNode.insertBefore(js, ref);
      }(document));
    },
    initAllPages: function(options){
    }
  };
  $.fn.initApp = function(method, page) {
    // only initialize if the target page exists
    var $page = $(page);

    if (typeof $page !== "undefined" && $page !== null) {
      console.log("Initializing mobile page: " + page);
      // Method calling logic
      if ( methods[method] ) {
        return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 2 ));
      } else if ( typeof method === 'object' || ! method ) {
        return methods.initAll.apply( this, arguments );
      } else {
        $.error( 'Method ' +  method + ' does not exist' );
      } 
    }
  };
})(jQuery);

$(document).bind("mobileinit", function() {
    $.mobile.page.prototype.options.addBackBtn = true;
});