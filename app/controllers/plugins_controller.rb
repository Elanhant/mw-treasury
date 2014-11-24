class PluginsController < ApplicationController
	skip_before_filter :verify_authenticity_token

  def index
  	@plugins = 	if params[:keywords]
  								Plugin.where('name ilike ?', "%#{params[:keywords]}%")
  							else
  								Plugin.last(10)
  							end
  end

  def show
  	@plugin = Plugin.find(params[:id])
    @categories = Category.all
  end

  def create
  	@plugin = Plugin.new(params.require(:plugin).permit(:name,:description))
  	@plugin.save
  	render 'show', status: 201
  end

  def update
  	plugin = Plugin.find(params[:id])
  	plugin.update_attributes(params.require(:plugin).permit(:name,:description))
  	head :no_content
  end

  def destroy
  	plugin = Plugin.find(params[:id])
  	plugin.destroy
  	head :no_content
  end
end
