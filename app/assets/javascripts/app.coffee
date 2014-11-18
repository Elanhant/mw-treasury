mwTreasury = angular.module('mwTreasury', [
	'templates',
	'ngRoute',
	'ngResource',
	'controllers',
])

mwTreasury.config(['$routeProvider', 
	($routeProvider)->
		$routeProvider
			.when('/',
				templateUrl: "index.html"
				controller: 'PluginsController'
			).when('/recipes/:recipeId',
				templateUrl: "show.html"
				controller: 'PluginController'
			)
])

controllers = angular.module('controllers', [])