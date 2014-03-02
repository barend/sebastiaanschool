// SebastiaanSchool (c) 2014 by Jeroen Leenarts
//
// SebastiaanSchool is licensed under a
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

var _ = require('underscore');
var Bulletin = Parse.Object.extend('Bulletin');

// Display all bulletins.
exports.index = function(req, res) {
    if(!Parse.User.current()) {
      res.redirect('/login');
      return;
    }
    var query = new Parse.Query(Bulletin);
    query.descending('updatedAt');
    query.find().then(function(bulletins) {
        res.render('bulletins/index', {
            bulletins: bulletins
        });
    },
    function () {
        res.send(500, 'Failed loading bulletins');
    });
};

exports.create = function(req, res) {
  if(!Parse.User.current()) {
    res.redirect('/login');
    return;
  }

  var bulletin = new Bulletin();
  bulletin.save(_.pick(req.body, 'title', 'body')).then(function() {
    res.redirect('/bulletins');
  },
  function() {
    res,send(500, 'Failed saving bulletin');
  });
};

// Delete a post corresponding to the specified id.
exports.delete = function(req, res) {
  var bulletin = new Bulletin();
  bulletin.id = req.params.id;

  bulletin.destroy().then(function(results) {
    res.redirect('/bulletins');
  },
  function() {
    res.send(500, 'Failed deleting post');
  });
};
