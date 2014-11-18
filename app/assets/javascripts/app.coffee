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
			)
])

controllers = angular.module('controllers', [])