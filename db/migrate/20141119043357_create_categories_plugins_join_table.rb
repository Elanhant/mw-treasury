class CreateCategoriesPluginsJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_plugins, id: false do |t|
    	t.integer :category_id
    	t.integer :plugin_id
    end
  end
end
