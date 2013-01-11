
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.beforeSave("NewsLetter", function(request, response) {
  var publishedAt = request.object.get("publishedAt");
  if (publishedAt == null ) {
    // set publishedAt if it's not set.
    request.object.set("publishedAt", new Date());
  }
  response.success();  
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


