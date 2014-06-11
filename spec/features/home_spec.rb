require 'spec_helper'

describe "home page and layout" do
  it "displays the site name" do
    visit "/"
    expect(page).to have_selector("h1", text: "Linopedia: Social Wikis")
  end

  context "header" do
    it "has link to sign in" do
      visit "/"
      expect(page).to have_selector("nav", text: "Sign in")
    end

    context "signed in" do
      before :each do
        user = create(:user)
        sign_in user
      end

      it "has link to sign out" do
        expect(page).to have_selector("nav", text: "Sign out")
      end

      it "has link to edit profile" do
        expect(page).to have_selector("nav", text: "Profile")
      end

      it "has link to upgrade account" do
        expect(page).to have_selector("nav", text: "Upgrade Now!")
      end

      it "login redirects to wikis index" do
        expect(current_path).to eql '/wikis'
      end

      it "home page redirects to wikis index" do
        visit '/'
        expect(current_path).to eql '/wikis'
      end
    end

    context "signed in with premium acct" do
      before :each do
        user = create(:premium_user)
        sign_in user
      end

      it "has link to account" do
        expect(page).to have_selector("nav", text: 'Account')
      end
    end

    xit "has link to sign up for free account"
  end
end
