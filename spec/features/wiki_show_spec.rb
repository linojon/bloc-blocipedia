require 'spec_helper'

describe "/wikis/dogs show" do
  let(:user) { create :user }
  let(:wiki) { create :wiki }

  before :each do
    user.wikis << wiki
  end

  context "render" do
    before :each do
      visit "/wikis/#{wiki.to_param}"
    end

    it "shows title" do
      expect(page).to have_content(wiki.title)
    end

    it "shows wiki with formatted markdown content" do
      # factory content = "**MyText**"
      expect(page).to have_selector('strong', text: 'MyText')
    end

    it "uses friendly url" do
      expect(wiki.to_param).to eql wiki.title.gsub(' ','-').downcase
    end
  end

  context "as public" do
    before :each do
      visit '/'
      Capybara.current_session.driver.header 'Referer', page.current_url
    end
     
    it "flash error not found wikis" do
      visit "/wikis/666"
      expect(page).to have_content 'not found'
    end

    it "flash error on private wikis" do
      pwiki = create :wiki, private: true
      visit "/wikis/#{pwiki.to_param}"
      expect(page).to have_content 'not authorized'
    end
  end

  context "as collaborator" do
    xit "shows edit button"
  end

  context "as owner" do
    xit "shows delete button"
  end
end
