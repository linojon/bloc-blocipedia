require 'spec_helper'

describe "/wikis edit" do
  let(:user) { create :user_with_wikis }
  let(:wiki) { user.wikis.first }

  it "requires user signed in" do
    visit "/wikis/#{wiki.to_param}/edit"
    expect(page).to have_content("not authorized")
  end

  context "signed in" do
    before :each do
      sign_in user
      visit "/wikis/#{wiki.to_param}/edit"
    end

    it "can edit title, content, and save" do
      expect(page).to have_field('Title', with: wiki.title )
      #expect(page).to have_field('Content', with: wiki.content )
      fill_in 'Title', with: 'Hello Title'
      #fill_in 'Content', with: 'Hello world.'
      find('#wiki_content', visible: false).set('Hello world.')
      click_button 'Update Wiki'
      expect(page).to have_content('Hello Title')
      expect(page).to have_content('Hello world.')
    end

    it "can delete if owner" do
      expect(page).to have_link "Delete"
    end

  end
 end
