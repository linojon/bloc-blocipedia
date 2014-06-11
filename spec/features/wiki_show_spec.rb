require 'spec_helper'

describe "/wikis/dogs show" do
  let(:user) { create :user_with_wikis }
  let(:wiki) { user.wikis.not_private.first }

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
      pwiki = user.wikis.is_private.first
      visit "/wikis/#{pwiki.to_param}"
      expect(page).to have_content 'not authorized'
    end
  end

  context "as collaborator" do
    let(:collaborator) { create :user }

    before :each do
      wiki.collaborations.create user_id: collaborator.id, role: 'collaborator'
      sign_in collaborator
      visit "/wikis/#{wiki.to_param}"
    end

    it "shows edit button" do
      expect(page).to have_link "Edit"
    end
  end

  context "as owner" do
    let(:user) { create :user_with_wikis }
    before :each do
      sign_in user
      visit "/wikis/#{wiki.to_param}"
    end

    it "shows edit button" do
      expect(page).to have_link "Edit"
    end
  end
end
