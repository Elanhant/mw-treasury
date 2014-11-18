require 'spec_helper.rb'

feature 'Viewing a plugin', js: true do
  before do
    Plugin.create!(name: 'Connary\'s Landscapes: West Gash',
						description: 'Retexture for the West Gash Region (Balmora, Caldera, Gnisis)')

    Plugin.create!(name: 'Connary\'s Landscapes: Azure Coast',
    				description: 'Retextured landscapes of the Azura Coast Region - east and southeast Vvardenfell')
  end
  scenario 'view one plugin' do
    visit '/'
    fill_in "keywords", with: "Connary"
    click_on "Search"
    click_on "Connary's Landscapes: Azure Coast"

    expect(page).to have_content("Connary's Landscapes: Azure Coast")
    expect(page).to have_content("Vvardenfell")

    click_on "Back"

    expect(page).to have_content("Connary's Landscapes: Azure Coast")
    expect(page).to have_content("Balmora, Caldera")
  end
end