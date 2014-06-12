require 'spec_helper'

describe Wiki do
  it { should have_many(:collaborators).through(:collaborations) }
  it { should validate_uniqueness_of :title }

  let(:user) { create :user_with_wikis }
  let(:wiki) { user.wikis.first }

  it "has owner through collaboratons" do
    expect(wiki.owner).to eql user    
  end

  it "can be private if owner is premium" do
    wiki.private = true
    wiki.valid?
    expect(wiki.private).to be_false

    user.account.level = 'premium'
    user.account.save
    wiki.reload
    wiki.private = true
    wiki.valid?
    expect(wiki.private).to be_true
  end
end
