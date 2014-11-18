require 'spec_helper.rb'

feature 'Creating, editing and deleting a plugin', js: true do
  scenario 'CRUD a plugin' do
    visit '/'
    click_on "Add Plugin"

    fill_in "name", with: "Abot's Silt Striders"
    fill_in "description", with: "Brings marvellous scenic travels by silt striders into Morrowind!"

    click_on "Save"

    expect(page).to have_content("Abot's Silt Striders")
    expect(page).to have_content("scenic travels")

    click_on "Edit"

    fill_in "name", with: "Abot's Silt Striders v2.0"
    fill_in "description", with: "Brings into Morrowind marvellous scenic travels by silt striders. Boats and Gondoliers Coming Soon!"

    click_on "Save"

    expect(page).to have_content("Abot's Silt Striders v2.0")
    expect(page).to have_content("Boats and Gondoliers")

    visit '/'
    fill_in "keywords", with: "Silt Striders"
    click_on "Search"

    click_on "Abot's Silt Striders v2.0"

    click_on "Delete"

    expect(Plugin.find_by_name("Abot's Silt Striders v2.0")).to be_nil
  end
end