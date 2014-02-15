var _ = require('underscore');
var Newsletter = Parse.Object.extend('NewsLetter');

// Display all newsletters.
exports.index = function(req, res) {
    if(!Parse.User.current()) {
      res.redirect('/login');
      return;
    }
    var query = new Parse.Query(Newsletter);
    query.descending('publishedAt');
    query.find().then(function(newsletters) {
        res.render('newsletters/index', {
            newsletters: newsletters, test: "This is a test."
        });
    },
    function () {
        res.send(500, 'Failed loading newsletters');
    });
};

exports.create = function(req, res) {
  if(!Parse.User.current()) {
    res.redirect('/login');
    return;
  }

  var newsletter = new Newsletter();
  newsletter.save(_.pick(req.body, 'name', 'url')).then(function() {
    res.redirect('/newsletters');
  },
  function() {
    res,send(500, 'Failed saving newsletter');
  });
};

// Delete a post corresponding to the specified id.
exports.delete = function(req, res) {
  var newsletter = new Newsletter();
  newsletter.id = req.params.id;

  newsletter.destroy().then(function(results) {
    res.redirect('/newsletters');
  },
  function() {
    res.send(500, 'Failed deleting post');
  });
};
