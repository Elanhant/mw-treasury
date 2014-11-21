controllers = angular.module('controllers')
controllers.controller("HomeController", [ '$scope', '$routeParams', '$location', '$resource' 
	($scope,$routeParams,$location,$resource)->

		Plugin = $resource('/plugins/:pluginId', { pluginId: "@id", format: 'json' })
		Plugin.query([], (results)-> $scope.plugins = results)

])