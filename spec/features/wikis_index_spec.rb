require 'spec_helper'

describe "/wikis index" do
  let!(:user) { create :user }
  let!(:wikis) { 1.upto(5) { user.wikis << create(:wiki) } }

  context "public" do
    it "displays list of the public wikis" do
      visit "/wikis"
      expect(page).to have_content( "Page 1")
      expect(page).to have_content( "Page 5")
    end
    xit "doesnt show private wikis"
  end

  context "signed in" do
    xit "displays public wikis"
    xit "displays my wikis"
    xit "has button to create new wiki"
  end

  context "signed in my wikis" do
    xit "can edit"
    xit "can delete"
    xit "can export"
    xit "can change collaborators"
  end
end
