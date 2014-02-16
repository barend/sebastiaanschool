// SebastiaanSchool (c) 2014 by Jeroen Leenarts
//
// SebastiaanSchool is licensed under a
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.

Parse.Cloud.beforeSave("NewsLetter", function(request, response) {
  var publishedAt = request.object.get("publishedAt");
  if (publishedAt == null ) {
    // set publishedAt if it's not set.
    request.object.set("publishedAt", new Date());
  }
  response.success();  
});

Parse.Cloud.afterSave("NewsLetter", function(request) {
    if (request.object.existed()) {
		return;
	}
	
	var iosQuery = new Parse.Query(Parse.Installation);
	iosQuery.equalTo('deviceType', 'ios');
	
	Parse.Push.send({
	  where: iosQuery,
	  data: {
	    alert: "Er is een nieuwe nieuwsbrief: " + request.object.get("name"),
            badge: "Increment",
			"content-available": 1,
            t: 1
	  }
	}, {
  	  success: function() {
  		console.log("iOS Push succeeded for newletter " + request.object.get("title"));
  	  },
  	  error: function(error) {
  		console.error("iOS Push failed for newletter " + request.object.get("title") + " with error code: " + error.code + "and message: " + error.message);
  	  }
	});
	
	Parse.Push.send({
      channels: [ "newsletter-android" ],
	  data: {
 		action: "nl.sebastiaanschool.contact.app.OPEN_NEWSLETTER",
		title: "Nieuwe nieuwsbrief",
	    alert: request.object.get("name")
	  }
	}, {
  	  success: function() {
  		console.log("Android Push succeeded for newletter " + request.object.get("title"));
  	  },
  	  error: function(error) {
  		console.error("Android Push failed for newletter " + request.object.get("title") + " with error code: " + error.code + "and message: " + error.message);
  	  }
	});
	
});

Parse.Cloud.afterSave("Bulletin", function(request) {
    if (request.object.existed()) {
		return;
	}
	
	var iosQuery = new Parse.Query(Parse.Installation);
	iosQuery.equalTo('deviceType', 'ios');
	
	Parse.Push.send({
	  where: iosQuery,
	  data: {
	    alert: "Nieuwe mededeling: " + request.object.get("title"),
            badge: "Increment",
			"content-available": 1,
            t: 2
	  }
	}, {
	  success: function() {
		console.log("iOS Push succeeded for bulletin " + request.object.get("title"));
	  },
	  error: function(error) {
		console.error("iOS Push failed for Bulletin " + request.object.get("title") + " with error code: " + error.code + "and message: " + error.message);
	  }
	});
	
	Parse.Push.send({
      channels: [ "bulletin-android" ],
	  data: {
		action: "nl.sebastiaanschool.contact.app.OPEN_BULLETIN",
		title: "Nieuwe mededeling",
	    alert: request.object.get("title")
	  }
	}, {
	  success: function() {
		console.log("Android Push succeeded for bulletin " + request.object.get("title"));
	  },
	  error: function(error) {
		console.error("Android Push failed for Bulletin " + request.object.get("title") + " with error code: " + error.code + "and message: " + error.message);
	  }
	});
	
});


