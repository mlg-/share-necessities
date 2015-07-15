require "rails_helper"

feature "Organizer can invite other organizers to their org", %{
  As an organizer
  I want to invite other people from my organization
  So we can all manage our wishlist together
} do
  # Acceptance Criteria:
  # [X] Organizer can navigate to invitation form
  # [X] Organizer can invite a non-user
  # [X] Organizer can invite an existing user
  # [X] After being invited, organizer can see organization page and
  #    add or interact with wishlist items.

  scenario "Organizer can navigate to invitation form" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    click_link("#{organization.name}")

    click_link("Edit Organization Settings")

    expect(page).to have_content("Invite Organizers")
    expect(page).to have_content("Send invitation")
  end

  scenario "Organizer can send an invitation and be sent back to the settings." do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    click_link("#{organization.name}")

    click_link("Edit Organization Settings")

    fill_in("First name", with: "Ruth")
    fill_in("Last name", with: "Ginsburg")
    fill_in("user_email", with: "notoriousrbg@mailinator.com")
    click_button("Send an invitation")

    expect(page).to have_content("An invitation email has been sent
                                  to notoriousrbg@mailinator.com")
    expect(page).to have_content("Edit #{organization.name}'s
                                  Information and Settings")
  end

  scenario "Invited user joins and can now edit organization's info" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    click_link("#{organization.name}")

    click_link("Edit Organization Settings")

    fill_in("First name", with: "Gloria")
    fill_in("Last name", with: "Steinem")
    fill_in("user_email", with: "equalityetc@mailinator.com")
    click_button("Send an invitation")

    expect(page).to have_content("An invitation email has been sent
                                  to equalityetc@mailinator.com")
    click_link("Sign Out")

    expect(ActionMailer::Base.deliveries.last.body).to have_content("link below")
    link = ActionMailer::Base.deliveries.last.body.match(/<a href="([\S]+)">/)
    visit "#{link[1]}"

    expect(page).to have_content("Set your password")

    fill_in("user_password", with: "passwordpassword")
    fill_in("user_password_confirmation", with: "passwordpassword")
    click_button("Set my password")

    expect(page).to have_content("Your password was set successfully.
                                  You are now signed in.")
    expect(page).to have_content(organization.name)
    expect(organization.organizers.count).to eq(2)

    click_link(organization.name)
    click_link("Edit Organization Settings")

    expect(page).to have_content("Edit #{organization.name}'s Information and Settings")
  end

  scenario "Organizer can invite existing user to be an organizer" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization
    user = FactoryGirl.create(:user)

    sign_in_as(organizer.user)

    click_link("#{organization.name}")

    click_link("Edit Organization Settings")

    fill_in("First name", with: user.first_name)
    fill_in("Last name", with: user.last_name)
    fill_in("user_email", with: user.email)
    click_button("Send an invitation")

    expect(page).to have_content("This organizer has been added")
    expect(organization.organizers.count).to eq(2)
  end
end

