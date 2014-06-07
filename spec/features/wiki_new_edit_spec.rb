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
    xit "requires user signed in"
    xit "can edit title, content, and save"
  end
 end
