controllers = angular.module('controllers')
controllers.controller("CategoriesConrtoller", [ '$scope', '$routeParams', '$location', '$resource',
	($scope,$routeParams,$location,$resource)->
		Category = $resource('/categories/:categoryId', { categoryId: "@id", formar: 'json' })

		Category.query([], (results)-> $scope.categories = results)

		$scope.indexCategory = -> $location.path("/categories")
		$scope.view = (categoryId)-> $location.path("/categories/#{categoryId}")
		$scope.newCategory = -> $location.path("/categories/new")
		$scope.edit = (categoryId)-> $location.path("/categories/#{categoryId}/edit")
])