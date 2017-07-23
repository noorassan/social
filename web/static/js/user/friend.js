"use strict";

$(document).ready(function() {
	$("#friends-id").click(function() {
		toggleLike($(this));
	});
});

function toggleLike(button) {
	if(button.text() == "Unfriend") {
		let friends_id = button.data("friends-id");

		$.ajax({
			url: "/api/like/" + friends_id,
			method: "DELETE",
			success: function(data) {
				button.text("Friend");
				button.data("friends-id", data);
			}
		})
	} else {
		let user_id = button.data("user-id");

		$.ajax({
			url:  	"/api/like",
			method: "POST",
			data:		{"friends": {"user_id": user_id}},
			success: function(data) {
				button.text("Unfriend");
				button.data("user-id", data);
			}
		})
	}
};
