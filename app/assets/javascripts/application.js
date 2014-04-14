//= require jquery
//= require jquery_ujs
//= require turbolinks
//application= require_tree .

/**
 * Queries the server for the next question when in learning mode. The response
 * will update the UI automatically.
 */
function loadNext() {
	log("load next");
	var nextUrl = document.URL + "/next";

	$.getJSON(nextUrl, function(data) {
		updateQuestion(data);
	});
}

/**
 * Assigns the provided question to the current learning UI
 */
function updateQuestion(question) {
	log("update question (" + question.sentence.text + ")");
	$("#question").text(question.display_sentence);
	$("#sentence-id").text(question.sentence.id);
	$("#sentence-type").val(question.type);
}

/**
 * Handles special keyboard events, eg. when the user presses enter.
 * This function is used to make working with the Web UI easier.
 */
function handleKeyPress(eventData) {
	if (eventData.which == 13) {
		eventData.preventDefault();
		submitAnswer();
	}
}

/**
 * Sends the given answer to the server and tells the user if the answer
 * was correct or not.
 */
function submitAnswer() {
	var typedAnswer = $("#user-input").val();
	var checkUrl = buildCheckUrl();
	var userInput = $("#user-input").val();
	var sentenceId = $("#sentence-id").text();
	var questionType = $("#sentence-type").val();

	log("submit answer: " + typedAnswer);

	$("#user-input").prop("disabled", true);

	var data = { sentence_id: sentenceId, value: userInput, type: questionType }

	$.post(checkUrl, data, function(response) {
		checkAnswer(response);
	}, "json");
}

function checkAnswer(response) {
	log("Check answer");
	if (response.score == 0) {
		badAnswer();
	} else {
		goodAnswer();
	}
}

function badAnswer() {
	log("Bad answer");
	$("#user-input").css("background-color", "#ee8888");
	setupTrigger();
}

function goodAnswer() {
	log("Good answer");
	$("#user-input").css("background-color", "#88ee88");
	$("#button-submit").addClass("btn-success");
	$("#button-submit").removeClass("btn-primary");
	setupTrigger();
}

function setupTrigger() {
	log("setup trigger");
	if ($("#user-input").prop("disabled") == true) {
		$("body").on("keyup", loaderTrigger);
	}
}

function loaderTrigger(eventData) {
	log("loaderTrigger");
	if (eventData.which == 13) {
		loadNext();	
		resetUI();
		removeTrigger();
	}
}

function resetUI() {
	log("reset ui");
	$("#user-input").val("");
	$("#user-input").prop("disabled", false);
	$("#user-input").css("background-color", "#ffffff");
}

function log(event) {
	var newLine = event + "<br />";
	var oldText = $("#debug").html();
	$("#debug").html(newLine + oldText);
}

function removeTrigger() {
	log("removeTrigger");
	$("body").off("keyup", loaderTrigger);
}

function buildCheckUrl() {
	return "/learn/" + config.languageCode + "/" + config.skillCode + "/" + config.lessonCode;
}

