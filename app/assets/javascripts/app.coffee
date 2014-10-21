mwTreasury = angular.module('mwTreasury', [
	'templates',
	'ngRoute',
	'ngResources',
	'controllers',
])

mwTreasury.config(['$routeProvider', 
	($routeProvider)->
		$routeProvider
			.when('/',
				templateUrl: "index.html"
				controller: 'PluginsController'
			)
])

controllers = angular.module('controllers', [])
controllers.controller("PluginsController", ['$scope',
	($scope)->
])