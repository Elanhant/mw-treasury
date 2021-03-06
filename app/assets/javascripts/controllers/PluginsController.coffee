controllers = angular.module('controllers')
controllers.controller("PluginsController", [ '$scope', '$routeParams', '$location', '$resource',
	($scope,$routeParams,$location,$resource)->
		$scope.search = (keywords)-> $location.path("/").search('keywords', keywords)
		Plugin = $resource('/plugins/:pluginId', { pluginId: "@id", format: 'json' })

		if $routeParams.keywords
			Plugin.query(keywords: $routeParams.keywords, (results)-> $scope.plugins = results)
		else
			$scope.plugins = []

		$scope.view = (pluginId)-> $location.path("/plugins/#{pluginId}")

		$scope.newPlugin 	= -> $location.path("/plugins/new")
		$scope.edit 			= (pluginId)-> $location.path("/plugins/#{pluginId}/edit")
])