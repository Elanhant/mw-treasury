controllers = angular.module('controllers')
controllers.controller('PluginController', [ '$scope', '$routeParams', '$resource', '$location', 'flash',
	($scope,$routeParams,$resource,$location,flash)->
		Plugin = $resource('/plugins/:pluginId', { pluginId: "@id", format: 'json' }, 
			{
				'save': 	{method: 'PUT'},
				'create': {method: 'POST'}
			}
		)

		if $routeParams.pluginId
			Plugin.get({pluginId: $routeParams.pluginId}, 
				( (plugin)-> $scope.plugin = plugin ),
				( (httpResponse)-> 
					$scope.plugin = null 
					flash.error = "There is no plugin with ID #{$routeParams.pluginId}"
				)
			)
		else
			$scope.plugin = {}

		$scope.back 	= -> $location.path("/")
		$scope.edit 	= -> $location.path("/plugins/#{$scope.plugin.id}/edit")
		$scope.cancel = ->
			if $scope.plugin.id
				$location.path("/plugins/#{$scope.plugin.id}")
			else
				$location.path("/")

		$scope.save = ->
			onError = (_httpResponse)-> flash.error = "Something went wrong"
			if $scope.plugin.id
				$scope.plugin.$save(
					( ()-> $location.path("/plugins/#{$scope.plugin.id}") ),
					onError
				)
			else
				Plugin.create($scope.plugin,
					( (newPlugin)-> $location.path("/plugins/#{newPlugin.id}") ),
					onError
				)

		$scope.delete = ->
			$scope.plugin.$delete()
			$scope.back()
])