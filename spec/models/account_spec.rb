require 'spec_helper'

describe Account do
  let(:free) { create :free_account }
  let(:premium) { create :premium_account }

  it "premium?" do
    expect(free.premium?).to be_false
    expect(premium.premium?).to be_true
  end

end
