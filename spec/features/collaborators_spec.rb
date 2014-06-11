require 'spec_helper'

describe "/wikis/dogs/collaborations" do
  let!(:owner) { create :user_with_wikis }
  let!(:wiki) { owner.wikis.first }
  let!(:collaborator) { create :user}
  let!(:other_user) { create :user }

  it "only accessible by owner" do
    sign_in other_user
    visit "/wikis/#{wiki.to_param}/collaborators"
    expect(page).to have_content 'not authorized'
  end

  context "signed in" do
    before :each do
      wiki.collaborations.create(user_id: collaborator.id, role: 'collaborator')
      sign_in owner
      visit "/wikis/#{wiki.to_param}/collaborators"
    end

    it "shows list of users" do
      expect(page).to have_content(owner.name)
      expect(page).to have_content(collaborator.name)
      expect(page).to have_content(other_user.name)
    end

    it "shows non collaborators unchecked" do
      checkbox = page.find "#collaborator_#{other_user.id}"
      expect(checkbox).to_not be_checked
    end

    it "shows current collaborators checked" do
      checkbox = page.find "#collaborator_#{collaborator.id}"
      expect(checkbox).to be_checked
    end

    it "shows owner as checked disabled" do
      checkbox = page.find "#collaborator_#{owner.id}"
      expect(checkbox).to be_checked
      expect(checkbox).to be_disabled
    end

    it "can check collaborators and update" do
      checkbox = page.find "#collaborator_#{other_user.id}"
      checkbox.set true
      expect {
        click_button("Share Wiki")
      }.to change(wiki.collaborators, :count).by(1)
    end

    it "can uncheck collaborators and update" do
      checkbox = page.find "#collaborator_#{collaborator.id}"
      checkbox.set false
      expect {
        click_button("Share Wiki")
      }.to change(wiki.collaborators, :count).by(-1)
    end

    xit "can sort list by name"
    xit "can sort list by email"
    xit "can sort list by access check"

  end
end
