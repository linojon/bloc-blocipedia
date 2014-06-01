require 'spec_helper'

describe Collaboration do
  it { should belong_to :user }
  it { should belong_to :wiki }
  it { should ensure_inclusion_of(:role).in_array(%w(owner collaborator)) }
end
