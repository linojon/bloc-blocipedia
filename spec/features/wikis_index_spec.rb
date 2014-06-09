require 'spec_helper'

describe "/wikis index" do
  let!(:user) { create :user_with_wikis }
  let!(:other_user) { create :user_with_wikis }
  let(:public_wikis) { Wiki.where(private: false) }
  let(:private_wikis) { Wiki.where(private: true) }
 
  context "as public" do

    before :each do
      visit '/wikis'
    end

    it "displays list of the public wikis" do
      public_wikis.each do |wiki|
        expect(page).to have_content( wiki.title )
      end
    end

    it "cannot edit" do
      expect(page).to_not have_link("edit", href: "/wikis/#{public_wikis.first.to_param}/edit")
    end

    xit "cannot delete"
    xit "cannot change collaborators"

    it "doesnt show private wikis" do
      expect(page).to have_no_content( private_wikis.first.title )
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
      public_wikis.each do |wiki|
        expect(page).to have_content( wiki.title )
      end
    end

    it "has button to create new wiki" do
      expect(page).to have_link("New Wiki")
    end

    context "owned wikis" do
      let(:my_wiki) { user.wikis.first }

      it "can edit" do
        expect(page).to have_link("edit", href: "/wikis/#{my_wiki.to_param}/edit")
      end

      xit "can change collaborators"
    end

    context "collaborating wikis" do
      let(:other_wiki) { other_user.wikis.first }

      before :each do
        create :collaboration, user: user, wiki: other_wiki
        visit '/wikis'
      end

      it "is in list" do
        expect(page).to have_content( other_wiki.title )
      end

      it "can edit" do
        expect(page).to have_link("edit", href: "/wikis/#{other_wiki.to_param}/edit")
      end

      xit "cannot change collaborators"
    end
  end
end
