(function($) {

  var methods = {
    initIndex: function(options) {
      
    },
    // Authentication Dialog
    initAuthDialog: function(options) {

      var setLoggedIn = function(response) {
          $.getJSON('/auth/facebook/callback', response, function(json) {
            $('#fb-login-status').html("You are now logged in.");
            $.mobile.hidePageLoadingMsg();
            $('#fb-close-button').show();
          });
        };

      var checkForLogin = function() {
        var loginButton = $('#fb-login');
        var closeButton = $('#fb-close-button');

        loginButton.hide();
        closeButton.hide();
        
        FB.getLoginStatus(function(response) {
          if (response.status === 'connected') {
            setLoggedIn(response.authResponse);
            loginButton.hide();
          } else if (response.status === 'not_authorized') {
            loginButton.show();
            $('#fb-login-status').hide();
          } else {
            loginButton.show();
            $('#fb-login-status').hide();
          }
        });
      };

      window.fbAsyncInit = function() {
        $(function() {
          FB.init({
            appId  : options.app_id,
            status : true, // check login status
            cookie : true, // enable cookies to allow the server to access the session
            xfbml  : true  // parse XFBML
          });
        });
        checkForLogin();
      };

      // should load prevPage now!
      $('#fb-close-button').click(function(e) {
        $.mobile.changePage(window.prevPage,{reloadPage: true, changeHash: false});
      });

      $('#fb-login').unbind('click');
      $('#fb-login').click(function(e) {
        e.preventDefault();

        FB.login(function(response) {
          if (response.authResponse) {
            setLoggedIn(response.authResponse);
          }
        }, { scope: options.scope });
      });

      // Load the SDK Asynchronously
      (function(d){
        var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) { checkForLogin(); return;}
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        ref.parentNode.insertBefore(js, ref);
      }(document));
    },
    initMenuDialog: function(options) {
      $('#logoutButton').unbind('click');
      $('#logoutButton').click(function(e) {
        $.mobile.showPageLoadingMsg();
        $(this).unbind('click');
        $.getJSON('/auth/logout', function(json) {
          if(json.success) {
            $.mobile.changePage(window.prevPage,{reloadPage: true, changeHash: false});
          }
        });
      });
    },
    initPlayBuyDialog: function(options) {
      $('#ticket-submit').unbind('click');
      $('#ticket-submit').click(function(e) {
        $(this).unbind('click');
        data = $('#ticket-form').serialize();
        $.post('/tickets/buy', data, function(response) {
          if(response.success)
            $.mobile.changePage('/ticket/'+response.id);
        }, "json");
      });
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

$(document).bind("pagebeforechange", function() {
    if($.mobile.activePage !== undefined) {
      console.log("Setting window.prevPage: "+ $.mobile.activePage.data('url'));
      window["prevPage"] = $.mobile.activePage.data('url');
    }
});