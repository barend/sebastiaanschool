var _ = require('underscore');

exports.index = function(req, res) {
  res.render('login/index.ejs');
};

exports.logout = function(req, res) {
  Parse.User.logOut();
  res.redirect('/');
};

exports.login = function(req, res) {
  Parse.User.logIn(req.body.username, req.body.password).then(function() {
    // Login succeeded, redirect to homepage.
    // parseExpressCookieSession will automatically set a cookie.
    res.redirect('/');
  },
  function(error) {
    // Login failed, redirect back to login form.
    res.redirect('/login');
  });
};

