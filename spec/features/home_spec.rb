require 'spec_helper'

describe "home page and layout" do
  it "displays the site name" do
    visit "/"
    expect(page).to have_selector("h1", text: "Linopedia: Social Wikis")
  end

  context "header" do
    it "has link to sign in" do
      visit "/"
      expect(page).to have_selector("header", text: "Sign in")
    end

    context "signed in" do
      before :all do
        sign_in_as_a_valid_user
      end

      it "has link to sign out" do
        expect(page).to have_selector("header", text: "Sign out")
      end

      xit "has link to edit profile" do
        expect(page).to have_selector("header", text: "Profile")
      end

      xit "has link to account"
      xit "login redirects to wikis index"

    end

    xit "has link to sign up for free account"
  end
end
