var _ = require('underscore');
var Newsletter = Parse.Object.extend('NewsLetter');

// Display all newsletters.
exports.index = function(req, res) {
    var query = new Parse.Query(Newsletter);
    query.descending('createdAt');
    query.find().then(function(newsletters) {
        res.render('newsletters/index', {
            newsletters: newsletters, test: "This is a test."
        });
    },
    function () {
        res.send(500, 'Failed loading newsletters');
    });
};
