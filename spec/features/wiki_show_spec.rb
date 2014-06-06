require 'spec_helper'

describe "/wikis/dogs show" do
  let(:user) { create :user }
  let(:wiki) { create :wiki }

  before :each do
    user.wikis << wiki
  end

  context "render" do
    before :each do
      visit "/wikis/#{wiki.id}"
    end

    it "shows title" do
      expect(page).to have_content(wiki.title)
    end

    xit "shows wiki with formatted markdown content"
    xit "uses friendly url"
  end

  context "as public" do
    it "flash error not found wikis" do
      visit '/'
      Capybara.current_session.driver.header 'Referer', page.current_url
      visit "/wikis/666"
      expect(page).to have_content 'not found'
    end

    xit "flash error on private wikis" 
  end

  context "as collaborator" do
    xit "shows edit button"
  end

  context "as owner" do
    xit "shows delete button"
  end
end
