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
				console.log(data);
				button.text("Like");
				button.attr("data-post-id", data);
			}
		})
	} else {
		let post_id = button.data("post-id");

		$.ajax({
			url:  	"/api/like",
			method: "POST",
			data:		{"like": {"post_id": post_id}},
			success: function(data) {
				console.log(data);
				button.text("Unlike");
				button.attr("data-like-id", data);
				console.log(button.attr("data-like-id"));
			}
		})
	}
};