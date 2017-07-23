"use strict";

$(document).ready(function() {
	$("#like-button").click(function() {
		toggleLike($(this));
	});
});

function toggleLike(button) {
	if(button.text() == "Unlike") {
		let like_id = button.data("like-id");

		$.ajax({
			url: "/api/like/" + like_id,
			method: "DELETE",
			success: function(data) {
				button.text("Like");
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
				button.text("Unlike");
				button.data("like-id", data);
			}
		})
	}
};
