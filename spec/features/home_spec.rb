require 'spec_helper'

describe "home page and layout" do
  it "displays the site name" do
    visit "/"
    expect(page).to have_selector("h1", text: "Linopedia: Social Wikis")
  end

  context "header" do
    xit "has link to sign in"

    context "signed in" do
      xit "has link to sign out"
      xit "has link to edit profile"
      xit "has link to account"
    end

    xit "has link to sign up for free account"
  end
end
