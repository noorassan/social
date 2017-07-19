"use strict";

$(document).ready(function() {
	$('.btn.btn-primary.btn-xs').click(function() {
		toggleLike($(this));
	});
});

function toggleLike(button) {
	if(button.text() == "Unlike") {
		let like_id = button.data("like-id");
		console.log("like-id at unlike time is " + like_id);

		$.ajax({
			url: "/api/like/" + like_id,
			method: "DELETE",
			success: function(data) {
				button.text("Like");
				console.log(data)
				button.data("post-id", data);
			}
		})
	} else {
		let post_id = button.data("post-id");

		$.ajax({
			url:  	"/api/like",
			method: "POST",
			data:		{"like": {"post_id": post_id}},
			success: function(data) {
				console.log("data after like is " + data);
				button.text("Unlike");
				button.data("like-id", data);
				console.log("like-id after like is " + button.data("like-id"));
			}
		})
	}
};
