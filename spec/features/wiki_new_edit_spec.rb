require 'spec_helper'

describe "/wikis new and edit" do
  let(:user) { create :user }

  before :each do
    sign_in user
  end

  context "new" do
    before :each do
      visit "/wikis/new"
    end

    xit "requires user signed in"

    it "can input title, content, and save" do
      fill_in 'Title', with: 'Hello'
      fill_in 'Content', with: 'Hello world.'
      expect {
        click_button 'Create Wiki'
      }.to change(Wiki, :count).by(1)
    end

    xit "can input markdown content"
    xit "can preview"
    xit "can make private with Premium acct"
    xit "shows validation errors and doesnt save"
  end

  context "edit" do
    let(:wiki) { create :wiki }

    before :each do
      visit "/wikis/#{wiki.id}/edit"
    end

    xit "requires user signed in"

    it "can edit title, content, and save" do
      expect(page).to have_field('Title', with: 'Wiki 1')
      expect(page).to have_field('Content', with: '**MyText**')
      fill_in 'Title', with: 'Hello Title'
      fill_in 'Content', with: 'Hello world.'
      click_button 'Update Wiki'
      expect(page).to have_content('Hello Title')
      expect(page).to have_content('Hello world.')
    end
  end
 end
