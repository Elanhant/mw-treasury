mwTreasury = angular.module('mwTreasury', [
	'templates',
	'ngRoute',
	'ngResource',
	'controllers',
	'angular-flash.service',
	'angular-flash.flash-alert-directive'
])

mwTreasury.config(['$routeProvider', 
	($routeProvider)->
		$routeProvider
			.when('/',
				templateUrl: "index.html"
				controller: 'PluginsController'
			).when('/plugins/:pluginId',
				templateUrl: "show.html"
				controller: 'PluginController'
			)
])

controllers = angular.module('controllers', [])