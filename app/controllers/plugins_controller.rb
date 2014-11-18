class PluginsController < ApplicationController
  def index
  	@plugins = 	if params[:keywords]
  								Plugin.where('name ilike ?', "%#{params[:keywords]}%")
  							else
  								[]
  							end
  end

  def show
  	@plugin = Plugin.find(params[:id])
  end
end
