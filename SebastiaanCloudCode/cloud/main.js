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
	  channels: [ "" ],
	  where: iosQuery,
	  data: {
	    alert: "Er is een nieuwe nieuwsbrief: " + request.object.get("name"),
            badge: "Increment",
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
	
	Parse.Push.send({
	  channels: [ "newsletter" ],
	  where: androidQuery,
	  data: {
	    alert: "Er is een nieuwe nieuwsbrief: " + request.object.get("name")
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
	  channels: [ "" ],
	  where: iosQuery,
	  data: {
	    alert: "Nieuwe mededeling: " + request.object.get("title"),
            badge: "Increment",
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
	
	Parse.Push.send({
	  channels: [ "bulletin" ],
	  where: androidQuery,
	  data: {
	    alert: "Nieuwe mededeling: " + request.object.get("title")
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


