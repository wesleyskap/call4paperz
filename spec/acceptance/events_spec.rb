require File.dirname(__FILE__) + '/acceptance_helper'

feature "Events", %q{
  In order to open call for papers
  As an user
  I want to add events
} do

  context "Viewing events" do
    scenario "While not logged in, I should be able to view events" do
      Factory(:event)
      visit '/events'
      page.should have_content 'GURU-SP'
      page.should have_no_content 'Sign in'
    end

    scenario "While not logged in, I should be able to view specific details about an event" do
      Factory(:event)

      visit '/events'

      click_link "Show"

      page.should have_content 'GURU-SP'
      page.should have_no_content 'Sign in'
    end

    scenario "While not logged in, I should not be able to create events" do
      visit '/events'
      click_link 'New Event'
      page.should have_content 'Sign in'
    end
  end

  context "Creating events" do
    scenario "I can create an event" do
      sign_in

      visit '/events'
      click_link 'New Event'

      fill_in "Name", :with => 'GURU-SP'
      fill_in 'Description', :with => '50th meeting'

      click_button "Create Event"

      page.should have_content "GURU-SP"
      page.should have_content 'Event was successfully created.'
      page.should have_no_content "Error(s)"
    end

    scenario "While registering, I can't register an event without a name" do
      sign_in

      visit '/events'
      click_link 'New Event'

      fill_in 'Description', :with => '50th meeting'

      click_button "Create Event"

      page.should have_no_content 'Event was successfully created.'
      page.should have_content "Name can't be blank"
    end

    scenario "While registering, I can't register an event without a name" do
      sign_in

      visit '/events'
      click_link 'New Event'

      fill_in 'Name', :with => 'GURU-SP'

      click_button "Create Event"

      page.should have_no_content 'Event was successfully created.'
      page.should have_content "Description can't be blank"
    end
  end
end
