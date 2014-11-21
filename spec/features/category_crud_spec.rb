require 'spec_helper.rb'

feature 'Creating, editing and deleting a category', js: true do
  scenario 'CRUD a category' do
    visit '/'
    click_on "Manage Categories"

    click_on "New Category"

    fill_in "name", with: "Test category"

    click_on "Save"

    expect(page).to have_content("Test category")

    click_on "Edit"

    fill_in "name", with: "Another category"

    click_on "Save"

    expect(page).to have_content("Another category")

    visit '/'
    click_on "Manage Categories"

    click_on "Another category"

    click_on "Delete"

    expect(Category.find_by_name("Another category")).to be_nil
  end
end