
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.afterSave("NewsLetter", function(request) {
	Parse.Push.send({
	  channels: [ "" ],
	  data: {
	    alert: "Er is een nieuwe nieuwsbrief: " + request.object.get("name")
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
	Parse.Push.send({
	  channels: [ "" ],
	  data: {
	    alert: request.object.get("title")
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


