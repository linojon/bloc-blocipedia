require 'spec_helper'

describe "/wikis index" do
  let!(:user) { create :user_with_wikis }

  context "as public" do
    before :each do
      visit '/wikis'
    end

    it "displays list of the public wikis" do
      expect(page).to have_content( user.wikis[0].title )
      expect(page).to have_content( user.wikis[1].title )
    end
    it "doesnt show private wikis" do
      expect(page).to have_no_content( user.wikis[2].title )
    end
    it "doesnt have link to create new wiki" do
      expect(page).to have_no_content("New Wiki")
    end
  end

  context "signed in" do
    before :each do
      sign_in user
      visit '/wikis'
    end

    it "displays public wikis" do
      expect(page).to have_content( user.wikis[0].title )
      expect(page).to have_content( user.wikis[1].title )
    end

    it "has button to create new wiki" do
      expect(page).to have_link("New Wiki")
    end

    context "my wikis" do
      it "is in list" do
        expect(page).to have_content( user.wikis[2].title )
      end
      xit "can edit"
      xit "can delete"
      xit "can export"
      xit "can change collaborators"
    end
  end
end
