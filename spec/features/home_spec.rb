require 'spec_helper'

describe "home page and layout" do
  context 'public' do
    before :each do
      visit "/"
    end

    it "displays the site name" do
      expect(page).to have_selector("h1", text: "Linopedia: Social Wikis")
    end

    it "has link to sign up for free account" do
      expect(page).to have_link('Sign up', href: '/users/sign_up')
    end

    it "has link to sign in" do
      expect(page).to have_selector("nav", text: "Sign in")
    end
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

    it "has link to account" do
      expect(page).to have_selector("nav", text: "Account")
    end

    it "login redirects to wikis index" do
      expect(current_path).to eql '/wikis'
    end

    it "home page redirects to wikis index" do
      visit '/'
      expect(current_path).to eql '/wikis'
    end
  end
end
