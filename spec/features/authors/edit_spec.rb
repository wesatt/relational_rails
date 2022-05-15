require 'rails_helper'

RSpec.describe "Authors#edit page" do
  describe "User Story 12, Parent Update (part 2 of 2)" do
    # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
    # When I fill out the form with updated information
    # And I click the button to submit the form
    # Then a `PATCH` request is sent to '/parents/:id',
    # the parent's info is updated,
    # and I am redirected to the Parent's Show page where I see the parent's updated info
    it "can update the Author info" do
      author1 = Author.create!(name: "Stepen King", still_active: true, age: 74)

      visit "/authors/#{author1.id}"

      expect(page).to have_content("Stepen King")

      click_link "Update Author"

      expect(current_path).to eq("/authors/#{author1.id}/edit")

      fill_in(:name, with: 'Stephen King')
      fill_in(:still_active, with: true)
      fill_in(:age, with: 74)
      click_button('Update Author')

      expect(current_path).to eq("/authors/#{author1.id}")
      expect(page).to have_content("Stephen King")
    end
  end
end
