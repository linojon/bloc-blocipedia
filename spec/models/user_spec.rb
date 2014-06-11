require 'spec_helper'

describe User do
  it { should have_many(:wikis).through(:collaborations) }

  it "finds role_for wiki" do
    user = create :user_with_wikis
    wiki = user.wikis.first
    expect(user.role_for(wiki)).to eql 'owner'
  end

  it "creates free account on create" do
    user = User.create email: 'foo@example.com', password: 'secretsecret', password_confirmation: 'secretsecret'
    expect(user.account).to_not be_nil
    expect(user.account.level).to eql 'free'
  end
end
