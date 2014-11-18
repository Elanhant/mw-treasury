mwTreasury = angular.module('mwTreasury', [
	'templates',
	'ngRoute',
	'ngResource',
	'controllers',
	'angular-flash.service',
	'angular-flash.flash-alert-directive'
])

mwTreasury.config(['$routeProvider', 'flashProvider', 
	($routeProvider,flashProvider)->

		flashProvider.errorClassnames.push("error")
		flashProvider.warnClassnames.push("warnning")
		flashProvider.infoClassnames.push("info")
		flashProvider.successClassnames.push("success")

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