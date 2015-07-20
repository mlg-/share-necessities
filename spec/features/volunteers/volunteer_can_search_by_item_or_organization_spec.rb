require "rails_helper"

feature "Volunteer can search for items or orgs", %{
  As a volunteer,
  I want to search for items to donate
  or organizations I know about
  So I can be helpful
} do
  # Acceptance Criteria
  # [X] Volunteer can search for an item by name
  # [X] Volunteer can access search form from orgs index
  # [X] Volunteer can search for an org by name
  # [X] Invalid records should not show up
  # [X] Empty search field incurs error

  scenario "volunteer can search for an organization by its name" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    visit organizations_path

    click_link("Organization")
    fill_in("q_org", with: "Sojourner")
    click_button("org-search-submit")

    expect(page).to have_content(organization.name)
    click_link(organization.name)

    expect(page).to have_content(organization.address)
  end

  scenario "volunteer cannot submit an empty org search form" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    visit organizations_path

    click_button("org-search-submit")

    expect(page).to have_content("Please enter a search term.")
  end

  scenario "volunteer can search for an item" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    visit organizations_path

    fill_in("q_item", with: "Hand")
    click_button("item-search-submit")

    expect(page).to have_content(organization.name)
  end

  scenario "volunteer cannot submit an empty item search form" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    visit organizations_path

    click_button("item-search-submit")

    expect(page).to have_content("Please enter a search term.")
  end

  scenario "volunteer gets relevant results for item search" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    item_2 = FactoryGirl.create(:item, name: "Bloop")
    visit organizations_path

   fill_in("q_item", with: "Hand warmer")
   click_button("item-search-submit")

   expect(page).to_not have_content("Bloop")
  end

  scenario "volunteer gets relevant results for org search" do
    organization = FactoryGirl.create(:organization)
    organization = FactoryGirl.create(:organization, name: "Bloop")
    visit organizations_path

   fill_in("q_org", with: "Sojourner")
   click_button("org-search-submit")

   expect(page).to_not have_content("Bloop")
  end
end