require "rails_helper"

feature "Volunteer can see organization's wishlists", %{
  As a volunteer, I want to find out what food pantries,
  shelters, and human service organizations near me
  actually need so that I can donate or buy those things
  and be a helpful human being!
} do

  # Acceptance Criteria
  # [X] Volunteer can see index of all organizations,
  #      paginated and ordered alphabetically.
  # [X] Volunteer can click on an organization’s name
  #      to be taken to their wishlist page.
  # [X] Volunteer can browse organizations and wishlists
  #      without being signed in.

  scenario "Volunteer can see a list of all organizations" do
    org_1 = FactoryGirl.create(:organization)
    org_2 = FactoryGirl.create(:organization)
    org_3 = FactoryGirl.create(:organization)

    visit "/"

    click_link("a volunteer, and I want to help")

    expect(page).to have_content("All Organizations")
    expect(page).to have_content(org_1.name)
    expect(page).to have_content(org_2.name)
    expect(page).to have_content(org_3.name)
  end

  scenario "Volunteer can see organizations listed alphabetically" do
    org_1 = FactoryGirl.create(:organization, name: "A Name")
    org_2 = FactoryGirl.create(:organization, name: "Yep Yep Yep")
    org_3 = FactoryGirl.create(:organization, name: "Cool Place")

    visit "/"

    click_link("a volunteer, and I want to help")

    expect(page.body.index(org_1.name)).to be < page.body.index(org_2.name)
    expect(page.body.index(org_2.name)).to be > page.body.index(org_3.name)
  end

  scenario "No more than 20 organizations show on one page" do
    21.times do
      FactoryGirl.create(:organization)
    end

    visit organizations_path

    expect(page).to_not have_content(Organization.last.name)
  end

  scenario "Volunteer can navigate to an organization's details and wishlist" do
    org = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: org)

    visit organizations_path

    click_link(org.name)

    expect(page).to have_content(org.address)
    expect(page).to have_content(org.city)
    expect(page).to have_content("All Wishlist Items")
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.quantity)
    expect(page).to_not have_content("Edit Organization Settings")
  end
end