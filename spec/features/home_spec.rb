require 'spec_helper'

describe "home page" do
  it "displays the site name" do
    visit "/"
    expect(page).to have_selector("h1", text: "Linopedia: Social Wikis")
  end
end
