require 'spec_helper'

describe "sign up" do
  before :each do
    visit '/users/sign_up'

    fill_in 'Name', with: 'Jonathan'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'secretsecret'
    fill_in 'Password confirmation', with: 'secretsecret'
  end

  it "takes user name, password, email" do
    click_on 'Sign up'
    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(current_url).to include '/wikis'
  end

  it "creates a free account" do
    expect {
      click_on 'Sign up'
    }.to change(User, :count).by(1)
    expect(User.last.account.level).to eql 'free'
  end
end
