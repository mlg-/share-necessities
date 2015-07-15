require "rails_helper"

feature "Volunteer can promise an item when logged in", %{
  As a volunteer
  I want to call dibs on an item that an organization needs
  So that they know I will get it for them
} do

  scenario "Volunteer is asked to log in or sign up before calling dibs" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)

    visit organization_path(organization.id)

    click_link("I'll get this!")

    expect(page).to have_content("Please sign in or sign up before
                                  promising an item.")
  end
end