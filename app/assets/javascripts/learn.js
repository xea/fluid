
$(document).ready(function() {
	log("Page loaded");

	$("#user-input").on("keyup", handleKeyPress);

	loadNext();
});
