require 'spec_helper'

describe "account" do
  let(:user) { create :user }
  let(:premium_user) { create :premium_user }

  context "show free account" do
    before :each do
      sign_in user
      visit "/account"
    end

    it "shows Free level" do
      expect(page).to have_selector('h3 + p', text: 'Free')
    end

    it "can upgrade to premium account" do
      within(".navbar") { click_on 'Account' }
      expect(page).to have_link('Upgrade Now!')
    end
  end

  context "show premium account" do
    before :each do
      sign_in premium_user
      Stripe::Customer.stub(:retrieve).and_return( 'cards' => { 'data' => [{ 'type' => 'Visa', 'last4' => '1234', 'exp_month' => '12', 'exp_year' => '2015' }] } )
      visit "/account"
    end

    it "shows Premium level" do
      expect(page).to have_selector('h3 + p', text: 'Premium')
    end

    it "shows credit card info" do
      expect(page).to have_content('Type: Visa')
      expect(page).to have_content('Last 4 digits: 1234')
      expect(page).to have_content('Expires: 12/2015')
    end
  end

  # Requires capybara javascript and mock the Stripe service
  # context "premium account create", js: true do
  #   xit "submits credit card charges" do
  #   xit "enabled premium when charge goes through"
  #   xit "does not enable premium when charge fails"
  # end
end