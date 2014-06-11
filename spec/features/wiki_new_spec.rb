require 'spec_helper'

describe "/wikis new" do
  let(:user) { create :user }

  it "requires user signed in" do
    visit "/wikis/new"
    expect(page).to have_content("not authorized")
  end

  context "signed in" do
    before :each do
      sign_in user
      visit "/wikis/new"
    end

    it "can input title, content, and save" do
      fill_in 'Title', with: 'Hello'
      fill_in 'Content', with: 'Hello world.'
      expect {
        click_button 'Create Wiki'
      }.to change(Wiki, :count).by(1)
      expect(user.wikis.count).to eql 1
    end

    it "can input markdown content" do
      fill_in 'Title', with: 'Hello'
      fill_in 'Content', with: '# Hello world.'
      click_button 'Create Wiki'
      wiki = user.wikis.first
      visit "/wikis/#{wiki.to_param}"
      expect(page).to have_selector('h1', text: 'Hello world')
    end

    xit "can preview"

    xit "cannot make private" do
      expect(page).to_not have_selector( "input#wiki_private")
    end

    it "requires title and doesnt save" do
      click_button 'Create Wiki'
      expect(page).to have_content "Error creating wiki"
      expect(page).to have_selector( "#wiki_title + span", text: "can't be blank")
    end

    context "with Premium acct" do
      xit "can make private"
    end
  end
 end
