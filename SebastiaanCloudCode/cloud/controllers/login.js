// SebastiaanSchool (c) 2014 by Jeroen Leenarts
//
// SebastiaanSchool is licensed under a
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

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

