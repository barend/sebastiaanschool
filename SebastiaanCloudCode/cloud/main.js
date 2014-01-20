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
	
	var androidQuery = new Parse.Query(Parse.Installation);
	androidQuery.equalTo('deviceType', 'android');
	androidQuery.equalTo('channels', 'newsletter');
	
	Parse.Push.send({
	  where: androidQuery,
	  data: {
  		action: "nl.sebastiaanschool.contact.app.OPEN_PAGE",
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
	
	var androidQuery = new Parse.Query(Parse.Installation);
	androidQuery.equalTo('deviceType', 'android');
	androidQuery.equalTo('channels', 'bulletin');
	
	Parse.Push.send({
	  where: androidQuery,
	  data: {
		action: "nl.sebastiaanschool.contact.app.OPEN_PAGE",
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


