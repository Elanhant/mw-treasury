controllers = angular.module('controllers')
controllers.controller('PluginController', [ '$scope', '$routeParams', '$resource',
	($scope,$routeParams,$resource)->
		Plugin = $resource('/plugins/:pluginId', { pluginId: "@id", format: 'json' })

		Plugin.get({pluginId: $routeParams.pluginId}, 
			( (plugin)-> $scope.plugin = plugin ),
			( (httpResponse)-> $scope.plugin = null )
		)
])