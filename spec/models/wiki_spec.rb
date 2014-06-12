require 'spec_helper'

describe Wiki do
  it { should have_many(:collaborators).through(:collaborations) }
  it { should validate_uniqueness_of :title }

  let!(:user) { create :user_with_wikis }
  let(:wiki) { user.wikis.first }

  it "has owner through collaboratons" do
    expect(wiki.owner).to eql user    
  end

  it "cannot be private if owner is not premium" do
    wiki.private = true
    wiki.valid?
    expect(wiki.private).to be_false
  end

  describe "private" do
    let!(:premium_user) { create :premium_user}
    let(:premium_wiki) { premium_user.wikis.first }

    it "can be private if owner is premium" do
      premium_wiki.private = true
      premium_wiki.valid?
      expect(premium_wiki.private).to be_true
    end

    it "scope not_private" do
      wikis = Wiki.not_private
      puts wikis.map &:private
      expect(wikis.count).to eql 2 # one each user, premium_user
      expect(
        wikis.all? {|w| w.private }
      ).to be_false
    end

    it "scope private" do
      wikis = Wiki.is_private
      expect(wikis.count).to eql 1
      expect(wikis.first.private).to be_true
    end
  end
end
