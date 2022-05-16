require 'rails_helper'

RSpec.describe "Authors new page" do
  describe "User Story 11, Parent Creation (part 2 of 2)" do
    # When I fill out the form with a new parent's attributes:
    # And I click the button "Create Parent" to submit the form
    # Then a `POST` request is sent to the '/parents' route,
    # a new parent record is created,
    # and I am redirected to the Parent Index page where I see the new Parent displayed.
    it "can create a new Author via form" do
      visit "/authors/new"

      fill_in('Name', with: 'Stephen King')
      select("true", from: :still_active)
      fill_in(:age, with: 74)
      click_button('Create Author')

      expect(current_path).to eq("/authors")
      expect(page).to have_content("Stephen King")
    end
  end
end
