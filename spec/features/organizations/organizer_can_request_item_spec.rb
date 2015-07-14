require "rails_helper"

feature "organizer can request item for organization", %{
  As an organizer
  I want to post items to my organization’s wishlist
  So that other helpful users will know what we need
} do
  # Acceptance Criteria
  # [X] Organizer can add items to their wishlist using a form.
  # [X] The item is now visible from the organization’s wishlist page.
  # [X] A volunteer user or visitor can see the item,
  #     date added, quantity needed, and an optional
  #     url and description for more information about the item.

  scenario "Organizer can navigate to form for adding new items directly" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    visit new_organization_item_path(organization_id: organization.id)

    find_field("Name")
    find_field("Quantity")
    find_field("Description")
  end

  scenario "Organizer can navigate to wishlist form from org details page" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    click_link(organization.name)

    click_link("Add Items to Wishlist")

    expect(page).to have_content("Add a New Item to
                                #{organization.name}\'s Wishlist")
    find_field("Name")
    find_field("Quantity")
    find_field("Description")
  end

  scenario "Item is visible on org details page when added" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    click_link(organization.name)

    click_link("Add Items to Wishlist")

    fill_in("Name", with: "Hand Warmers")
    fill_in("Quantity", with: "50")
    fill_in("Description", with: "One-use hand warmers.")
    click_button("Create Item")

    expect(page).to have_content("Your item has been added.")
    expect(page).to have_content(organization.address)
    expect(page).to have_content("Hand Warmers")
    expect(page).to have_content("50")
    expect(page).to have_content("One-use hand warmers.")
  end

  scenario "Organizer cannot add invalid item" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    click_link(organization.name)

    click_link("Add Items to Wishlist")

    fill_in("Name", with: "Hand Warmers")
    click_button("Create Item")

    expect(page).to have_content("Quantity can't be blank")
  end

  scenario "Non-organizer cannot see Add Item link on org details page" do
    organization = FactoryGirl.create(:organization)
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit organization_path(id: organization.id)

    expect(page).to_not have_content("Add Items to Wishlist")
  end
end
