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
controllers.controller("PluginsController", [ '$scope', '$routeParams', '$location', '$resource',
	($scope,$routeParams,$location,$resource)->
		$scope.search = (keywords)-> $location.path("/").search('keywords', keywords)

		if $routeParams.keywords
			keywords = $routeParams.keywords.toLowerCase()
			$scope.plugins = plugins.filter (plugin)-> plugin.name.toLowerCase().indexOf(keywords) != -1
		else
			$scope.plugins = []
])