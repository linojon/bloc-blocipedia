require 'spec_helper'

describe "/wikis index" do
  let!(:user) { create :user_with_wikis }

  context "as public" do
    it "displays list of the public wikis" do
      visit "/wikis"
      expect(page).to have_content( user.wikis[0].title )
      expect(page).to have_content( user.wikis[1].title )
    end
    it "doesnt show private wikis" do
      visit "/wikis"
      expect(page).to have_no_content( user.wikis[2].title )
    end
  end

  context "signed in" do
    xit "displays public wikis"
    xit "displays my wikis"
    xit "has button to create new wiki"
  end

  context "as signed in my wikis" do
    xit "can edit"
    xit "can delete"
    xit "can export"
    xit "can change collaborators"
  end
end
