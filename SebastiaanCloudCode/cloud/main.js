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
	Parse.Push.send({
	  channels: [ "" ],
	  data: {
	    alert: "Er is een nieuwe nieuwsbrief: " + request.object.get("name"),
            badge: "Increment",
            t: 1
	  }
	}, {
	  success: function() {
		console.log("Push succeeded for newsletter " + request.object.get("name"));
	  },
	  error: function(error) {
		console.error("Push failed for newsletter " + request.object.get("name") + " with error code: " + error.code + "and message: " + error.message);
	  }
	});
});

Parse.Cloud.afterSave("Bulletin", function(request) {
    if (request.object.existed()) {
		return;
	}
	Parse.Push.send({
	  channels: [ "" ],
	  data: {
	    alert: "Nieuwe mededeling: " + request.object.get("title"),
            badge: "Increment",
            t: 2
	  }
	}, {
	  success: function() {
		console.log("Push succeeded for bulletin " + request.object.get("title"));
	  },
	  error: function(error) {
		console.error("Push failed for Bulletin " + request.object.get("title") + " with error code: " + error.code + "and message: " + error.message);
	  }
	});
});


