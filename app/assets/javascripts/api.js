var adminService = angular.module('adminService', [ 'ngResource' ]);

adminService.factory('Language', [ '$resource', 
	function($resource) {
		return $resource('/api/language/:languageId', {}, {
			list: { method: 'GET', params: { }, isArray: true },
			get: { method: 'GET', params: { languageId: "@languageId" }, isArray: false },
			create: { method: 'POST', url: "/api/language", params: { languageName: "language_filter"} },
		});
	}
]);

adminService.factory('Skill', [ '$resource', 
	function($resource) {
		return $resource('/api/skill/:skillId', {}, {
			list: { method: 'GET', url: "/api/language/:languageId/skills", params: { languageId: "@languageId"  }, isArray: true }
		});
	}
]);

adminService.factory('Lesson', [ '$resource', 
	function($resource) {
		return $resource('/api/lesson/:lessonId', {}, {
			list: { method: 'GET', url: "/api/skill/:skillId/lessons", params: { skillId: "@skillId"  }, isArray: true }
		});
	}
]);

adminService.factory('Sentence', [ '$resource', 
	function($resource) {
		return $resource('/api/sentence/:sentenceId', {}, {
			list: { method: 'GET', url: "/api/lesson/:lessonId/sentences", params: { lessonId: "@lessonId"  }, isArray: true }
		});
	}
]);

adminService.factory('Translation', [ '$resource', 
	function($resource) {
		return $resource('/api/translation/:translationId', {}, {
			list: { method: 'GET', url: "/api/sentence/:sentenceId/translations", params: { sentenceId: "@sentenceId"  }, isArray: true },
			update: { method: 'POST', url: "/api/translation/:translationId", params: { translationId: "@translation.id" }, isArray: false  }
		});
	}
]);
