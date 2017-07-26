"use strict";

$(document).ready(function() {
	$("#friend-button").click(function() {
		console.log("hi");
		toggleFriend($(this));
	});
});

function toggleFriend(button) {
	if(button.text() == "Unfriend") {
		let friends_id = button.data("friends-id");

		$.ajax({
			url: "/api/friends/" + friends_id,
			method: "DELETE",
			success: function(data) {
				button.text("Friend");
				button.data("user-id", data);
			}
		})
	} else {
		let friend_id = button.data("user-id");
		$.ajax({
			url:  	"/api/friends",
			method: "POST",
			data:		{"friend_id": friend_id},
			success: function(data) {
				button.text("Unfriend");
				button.data("friends-id", data);
			}
		})
	}
};
