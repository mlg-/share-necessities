require "rails_helper"

feature "organizer can edit wishlist item for organization", %{
  As an organizer
  I want to delete items from my wishlist
  Because we don’t need them anymore
} do
  # Acceptance criteria
  # [X] Item can be edited by organizer
  # [ ] Organizer cannot edit another organization’s wishlist items
  # [ ] Changes are reflected on wish list page

  scenario "Organizer can navigate to item edit form from org page" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization
    item_1 = FactoryGirl.create(:item, organization: organization)
    item_2 = FactoryGirl.create(:raincoat, organization: organization)

    sign_in_as(organizer.user)

    visit organization_path(id: organization.id)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    click_link("item-#{item_1.id}-edit")

    expect(page).to have_content("Edit Hand Warmers on
                                 #{organization.name}'s Wishlist")
  end

  scenario "Organizer can submit a valid change to the item" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization
    item_1 = FactoryGirl.create(:item, organization: organization)
    item_2 = FactoryGirl.create(:raincoat, organization: organization)

    sign_in_as(organizer.user)

    visit organization_path(id: organization.id)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    click_link("item-#{item_1.id}-edit")

    fill_in("Quantity", with: 100)
    click_button("Update Item")

    expect(page).to have_content("Hand warmers has been edited.")
  end

  scenario "One organizer cannot edit another organization's items" do
    organization = FactoryGirl.create(:organization)
    not_that_orgs_organizer = FactoryGirl.create(:organizer)
    FactoryGirl.create(:item, organization: organization)

    sign_in_as(not_that_orgs_organizer.user)

    visit organization_path(id: organization.id)

    expect(page).to_not have_content("Edit")
  end

  scenario "A user unaffiliated with an organization cannot edit items" do
    organization = FactoryGirl.create(:organization)
    unaffiliated_user = FactoryGirl.create(:user)
    FactoryGirl.create(:item, organization: organization)

    sign_in_as(unaffiliated_user)

    visit organization_path(id: organization.id)

    expect(page).to_not have_content("Edit")
  end
end
