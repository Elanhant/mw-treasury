require 'spec_helper'

describe PluginsController do
	render_views
	describe "index" do
		before do
			Plugin.create!(name: 'Connary\'s Landscapes: West Gash')
			Plugin.create!(name: 'Julan the Ashlander Companion')
			Plugin.create!(name: 'Ashlander Tent v2.0')
			Plugin.create!(name: 'Redesigned Vivec')

			xhr :get, :index, format: :json, keywords: keywords
		end

		subject(:results) { JSON.parse(response.body) }

		def extract_name
			->(object) { object["name"] }
		end

		context "when the search finds results" do
			let(:keywords) { 'Ashlander' }
			it "should 200" do
				expect(response.status).to eq(200)
			end
			it "should return two results" do
				expect(results.size).to eq(2)
			end
			it "should include 'Julan the Ashlander Companion'" do
				expect(results.map(&extract_name)).to include('Julan the Ashlander Companion')
			end
			it "should include 'Ashlander Tent v2.0'" do
				expect(results.map(&extract_name)).to include('Ashlander Tent v2.0')
			end
		end

		context 'when the search doesn\'t find results' do
			let(:keywords) { 'dagoth' }
			it "should return no results" do
				expect(results.size).to eq(0)
			end
		end

	end

	describe "show" do
		before do
		  xhr :get, :show, format: :json, id: plugin_id
		end

		subject(:results) { JSON.parse(response.body) }

		context 'when the plugin exists' do
			let(:plugin) { 
				Plugin.create!(name: 'Mountaineous Red Mountain',
					description: "Makes the Red Mountain more edgy and high")
			}
			let(:plugin_id) { plugin.id }

			it { expect(response.status).to eq(200) }
			it { expect(results["id"]).to eq(plugin.id) }
			it { expect(results["name"]).to eq(plugin.name) }
			it { expect(results["description"]).to eq(plugin.description) }
		end

		context 'when the plugin doesn\'t exist' do
			let(:plugin_id) { -9999 }
			it { expect(response.status).to eq(404) }
		end
	end

	describe "create" do
		before do
		  xhr :post, :create, format: :json, plugin: { name: 'Morrowind Graphic Extender',
		  																			description: 'Overhauls graphics - distant land, shaders support, antialaising' }
		end
		it { expect(response.status).to eq(201) }
		it { expect(Plugin.last.name).to eq('Morrowind Graphic Extender') }
		it { expect(Plugin.last.description).to eq('Overhauls graphics - distant land, shaders support, antialaising') }
	end

	describe "update" do
		let(:plugin) { 
			Plugin.create!(name: 'Better Almalexia',
							description: 'Improves Almalexia\'s appearance, making her look up to Better Bodies standart')
		}
		before do
		  xhr :put, :update, format: :json, id: plugin.id, plugin: { name: 'Morrowind Graphic Extender',
		  																			description: 'Overhauls graphics - distant land, shaders support, antialaising' }
			plugin.reload		  																			
		end
		it { expect(response.status).to eq(204) }
		it { expect(plugin.name).to eq('Morrowind Graphic Extender') }
		it { expect(plugin.description).to eq('Overhauls graphics - distant land, shaders support, antialaising') }
	end

	describe "destroy" do
		let(:plugin_id) { 
			Plugin.create!(name: 'Better Almalexia',
							description: 'Improves Almalexia\'s appearance, making her look up to Better Bodies standart').id
		}
		before do
		  xhr :delete, :destroy, format: :json, id: plugin_id
		end
		it { expect(response.status).to eq(204) }
		it { expect(Plugin.find_by_id(plugin_id)).to be_nil }
	end
end
