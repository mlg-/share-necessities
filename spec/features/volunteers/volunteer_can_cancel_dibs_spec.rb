require "rails_helper"

feature "Volunteer can cancel their dibs on an item", %{
  As a volunteer
  I want to cancel my fulfillment of an item
  Because I couldn’t find what the organization needed
} do
  # Acceptance Criteria
  # [X] Volunteer can cancel any of their items
  # [X] Volunteer must be signed in
  # [X] The item must be returned to the organization’s wishlist
  #      and visible on the page
  # [X] The item must no longer appear in the volunteer’s items

  scenario "Volunteer must be signed in to cancel dibs" do
    visit dibs_path

    expect(page).to have_content("sign in or sign up")
  end

  scenario "Volunter can cancel their items" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    volunteer = FactoryGirl.create(:user)

    sign_in_as(volunteer)

    visit organization_path(organization.id)

    fill_in("Quantity", with: 1)
    click_button("I'll get this!")

    click_link("My Items (1)")

    click_button("I can no longer provide this item.")

    expect(page).to have_content("This item has been removed
                                  from your list and returned
                                  to #{organization.name}'s wishlist.")

    expect(Item.find(item.id).quantity).to eq(item.quantity)
    expect(page).to_not have_content(item.name)

    visit organization_path(organization.id)

    expect(page).to have_content(item.name)
    expect(page).to have_content(item.quantity)
    expect(page).to_not have_content(item.quantity - 1)
  end
end
