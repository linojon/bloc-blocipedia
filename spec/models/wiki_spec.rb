require 'spec_helper'

describe Wiki do
  it { should have_many(:collaborators).through(:collaborations) }
  it { should validate_uniqueness_of :title }
end
