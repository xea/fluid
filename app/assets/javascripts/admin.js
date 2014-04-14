var controllers = angular.module("controllers", []);

controllers.controller("languageController", function($scope, Language, Skill, Lesson, Sentence, Translation) {

	$scope.listLanguages = function() {
		$scope.languages = Language.list();
	};

	$scope.createLanguage = function(name) {
		Language.save({}, { language: { name : name }});
		
		$scope.language_filter = "";
		$scope.languages = Language.list();
	};

	$scope.selectLanguage = function(language) {
		$scope.skills = Skill.list({ languageId: language.id });
		$scope.lessons = [];
		$scope.sentences = [];
		$scope.selectedLanguage = language;
		$scope.selectedSkill = undefined;
		$scope.selectedLesson = undefined;
		switchPanels("skill");
	};

	$scope.createSkill = function(skillName) {
		Skill.save({}, { skill: { language_id: $scope.selectedLanguage.id, name: skillName } });
		$scope.skill_filter = "";
		$scope.skills  = Skill.list({ languageId: $scope.selectedLanguage.id });
	};

	$scope.selectSkill = function(skill) {
		$scope.lessons = Lesson.list({ skillId: skill.id });
		$scope.sentences = [];
		$scope.selectedSkill = skill;
		$scope.selectedLesson = undefined;
		$scope.lesson_filter = "";
		switchPanels("lesson");
	};

	$scope.createLesson = function(lessonName) {
		Lesson.save({}, { lesson: { skill_id: $scope.selectedSkill.id, name: lessonName } });
		$scope.lesson_filter = "";
		$scope.lessons = Lesson.list({ skillId: $scope.selectedSkill.id });
	};

	$scope.selectLesson = function(lesson) {
		$scope.selectedLesson = lesson;
		$scope.sentences = Sentence.list({ lessonId: lesson.id });
		switchPanels("sentence");
	};

	$scope.createSentence = function(sentenceText, defaultTranslation) {
		Sentence.save({}, { sentence: { lesson_id: $scope.selectedLesson.id, text: sentenceText , default_translation: defaultTranslation} });
		$scope.sentence_filter = "";
		$scope.default_translation = "";
		$scope.sentences = Sentence.list({ lessonId: $scope.selectedLesson.id });
	};

	$scope.selectSentence = function(sentence) {
		$scope.selectedSentence = sentence;
		$scope.translations = Translation.list({ sentenceId: sentence.id });
		$("#sentence-details").modal("show");
	};

	$scope.addNewTranslation = function(text) {
		Translation.save({}, { translation: { sentence_id: $scope.selectedSentence.id, text: text } });
		$scope.translations = Translation.list({ sentenceId: $scope.selectedSentence.id });
	};

	$scope.updateTranslation = function(translation) {
		Translation.update({ translation: { id: translation.id, text: translation.text } } );
		$scope.translations = Translation.list({ sentenceId: $scope.selectedSentence.id });
	};

//	$scope.orderProp = 'name';
	$scope.languages = Language.list();

}).directive('ngEnter', function () {
	return function (scope, element, attrs) {
		element.bind("keydown keypress", function (event) {
			if(event.which === 13) {
				scope.$apply(function (){
					scope.$eval(attrs.ngEnter);
				});

				event.preventDefault();
			}
		});
	};
}).directive("clickToEdit", function() {
	var editorTemplate = '<div class="click-to-edit">' +
		'<div class="col-lg-4" ng-hide="view.editorEnabled">' +
			'{{value}} ' +
			'<a ng-click="enableEditor()">Edit!</a>' +
		'</div>' +
		'<div ng-show="view.editorEnabled">' +
			'<input class="form-control" ng-model="view.editableValue">' +
			'<a href="#" ng-click="save()">Save</a>' +
			' or ' +
			'<a ng-click="disableEditor()">cancel</a>.' +
		'</div>' +
	'</div>';

	editorTemplate = '<td class="click-to-edit">' +
		'<span class="col-lg-8" ng-hide="view.editorEnabled">' +
			'{{value}}' +
		'</span><span class="col-lg-2" ng-hide="view.editorEnabled">'+ 
			'<a ng-click="enableEditor()">Edit</a>' +
		'</span>' + 
		'<span class="col-lg-8" ng-show="view.editorEnabled">' +
			'<input class="form-control" ng-model="value" />' + 
		'</span>' +
		'<span class="col-lg-2" ng-show="view.editorEnabled">' + 
			'<a href="#" ng-click="save()">Save</a>' +
			' or ' +
			'<a ng-click="disableEditor()">cancel</a>.' +
		'</span>' + 
	'</td>';
 
	return {
		restrict: "A",
		replace: true,
		template: editorTemplate,
		scope: {
			value: "=clickToEdit",
			onSave: "&onSave"
		},
		controller: function($scope) {
			$scope.view = {
				editableValue: $scope.value,
				editorEnabled: false
			};
 
			$scope.enableEditor = function() {
				$scope.view.editorEnabled = true;
				$scope.view.editableValue = $scope.value;
			};
 
			$scope.disableEditor = function() {
				$scope.view.editorEnabled = false;
			};
 
			$scope.save = function() {
				$scope.value = $scope.view.editableValue;
				$scope.disableEditor();
				$scope.onSave();
			};
		}
	};
});;

function switchPanels(mode) {
	
	switch (mode) {
	case "language":
		$("#language-filter").show();
		$("#skill-filter").hide();
		$("#lesson-filter").hide();
		$("#sentence-filter").hide();
		$("#default-translation").hide();
		$("#create-language-button").show();
		$("#create-skill-button").hide();
		$("#create-lesson-button").hide();
		$("#create-sentence-button").hide();
		break;
	case "skill":
		$("#language-filter").hide();
		$("#skill-filter").show();
		$("#lesson-filter").hide();
		$("#sentence-filter").hide();
		$("#default-translation").hide();
		$("#create-language-button").hide();
		$("#create-skill-button").show();
		$("#create-lesson-button").hide();
		$("#create-sentence-button").hide();
		break;
	case "lesson":
		$("#language-filter").hide();
		$("#skill-filter").hide();
		$("#lesson-filter").show();
		$("#sentence-filter").hide();
		$("#default-translation").hide();
		$("#create-language-button").hide();
		$("#create-skill-button").hide();
		$("#create-lesson-button").show();
		$("#create-sentence-button").hide();
		break;
	case "sentence":
		$("#language-filter").hide();
		$("#skill-filter").hide();
		$("#lesson-filter").hide();
		$("#sentence-filter").show();
		$("#default-translation").show();
		$("#create-language-button").hide();
		$("#create-skill-button").hide();
		$("#create-lesson-button").hide();
		$("#create-sentence-button").show();
	}
}

var fluid = angular.module("fluid", [ "controllers", "adminService" ]);

