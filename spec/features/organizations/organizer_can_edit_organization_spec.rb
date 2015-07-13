require "rails_helper"

feature "Organizer can edit an organization's details", %{
  As an organizer,
  I want to edit my organization’s information
  To keep volunteers informed of any changes
} do
  # Acceptance Criteria
  # [X] (Only) Organizer can edit organization information
  # [X] Changes are reflected on the organization’s profile page.
  # [] Invalid changes are not permitted

  scenario "user cannot access organization's edit page" do
    user = FactoryGirl.create(:user)
    organization = FactoryGirl.create(:organization)

    sign_in_as(user)

    visit edit_organization_path(organization)

    expect(page).to have_content("You do not have permission to
                                  access this page.")
  end

  scenario "organizer can access organization's edit page" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    visit edit_organization_path(organization)

    expect(page).to have_content(organization.name)
    expect(page).to have_selector("input#organization_address[value=\"#{organization.address}\"]")
    expect(page).to have_selector("input#organization_city[value=\"#{organization.city}\"]")
    find_button("Update Organization")
  end

  scenario "organizer can edit organization's information" do
    organizer = FactoryGirl.create(:organizer)

    sign_in_as(organizer.user)

    visit edit_organization_path(organizer.organization)

    fill_in("Phone", with: "617-442-9322")
    click_button("Update Organization")

    expect(page).to have_content("Your organization has been updated.")
    expect(page).to have_content("617-442-9322")
  end

  scenario "user cannot enter invalid information" do
    organizer = FactoryGirl.create(:organizer)

    sign_in_as(organizer.user)

    visit edit_organization_path(organizer.organization)

    fill_in("Address", with: "")
    click_button("Update Organization")

    expect(page).to have_content("Address can't be blank")
  end
end
