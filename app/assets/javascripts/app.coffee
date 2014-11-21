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
				controller: 'HomeController'
			).when('/plugins/new',
				templateUrl: "form.html"
				controller: 'PluginController'
			).when('/plugins/:pluginId',
				templateUrl: "show.html"
				controller: 'PluginController'
			).when('/plugins/:pluginId/edit',
				templateUrl: "form.html"
				controller: 'PluginController'
			).when('/categories'
				templateUrl: "categories/index.html"
				controller: 'CategoriesController'
			)
])

controllers = angular.module('controllers', [])

mwTreasury.factory('dimmerService', [ ()->
		open: (elementId)->
				jQuery(elementId).dimmer 'toggle'
				return true
	])
	.factory('sidebarService', [ ()->
		open: (elementId)->
				jQuery(elementId).sidebar 'toggle'
				return true
	])

mwTreasury.controller('SidebarController', ($scope, $location, $routeParams, $resource, dimmerService, sidebarService)->	
		$scope.showMenu = -> sidebarService.open('#menu')

		$scope.showCategories = -> 
			Category = $resource('/categories/:categoryId', { categoryId: "@id", format: 'json' })
			Category.query([], (results)-> $scope.categories = results)
			dimmerService.open('#dimmer-categories')

		$scope.returnHome = -> $location.path("/")

		$scope.search = (keywords)-> $location.path("/").search('keywords', keywords)
		Plugin = $resource('/plugins/:pluginId', { pluginId: "@id", format: 'json' })

		if $routeParams.keywords
			Plugin.query(keywords: $routeParams.keywords, (results)-> $scope.plugins = results)
		else
			Plugin.query([], (results)-> $scope.plugins = results)
)
