require "spec_helper.rb"

feature 'Looking up plugins', js: true do
  before do
    Plugin.create!(name: 'Connary\'s Landscapes: West Gash')
    Plugin.create!(name: 'Connary\'s Landscapes: Azura Coast')
    Plugin.create!(name: 'Julan the Ashlander Companion')
    Plugin.create!(name: 'Ashlander Tent v2.0')
  end
  scenario 'finding plugins' do
    visit '/'
    fill_in "keywords", with: 'Connary'
    click_on "Search"

    expect(page).to have_content("West Gash")
    expect(page).to have_content("Azura Coast")
  end
end