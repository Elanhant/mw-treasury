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
end
