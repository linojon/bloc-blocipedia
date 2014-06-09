require 'spec_helper'

describe User do
  it { should have_many(:wikis).through(:collaborations) }

  it "finds role_for wiki" do
    user = create :user_with_wikis
    wiki = user.wikis.first
    expect(user.role_for(wiki)).to eql 'owner'
  end
end
