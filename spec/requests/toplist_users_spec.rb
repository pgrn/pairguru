require "rails_helper"

describe "User toplist requests", type: :request do
  describe "the user toplist" do
    it "displays the correct heading" do
      visit "/toplist/users"
      expect(page).to have_selector("h1", text: "Top commenters")
      expect(page).to have_selector("h4", text: "(from this time last week to now)")
    end
  end
end
