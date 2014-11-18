controllers = angular.module('controllers')
controllers.controller('PluginController', [ '$scope', '$routeParams', '$resource', 'flash',
	($scope,$routeParams,$resource, flash)->
		Plugin = $resource('/plugins/:pluginId', { pluginId: "@id", format: 'json' })

		Plugin.get({pluginId: $routeParams.pluginId}, 
			( (plugin)-> $scope.plugin = plugin ),
			( (httpResponse)-> 
				$scope.plugin = null 
				flash.error = "There is no plugin with ID #{$routeParams.pluginId}"
			)
		)
])