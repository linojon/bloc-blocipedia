require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the WikisHelper. For example:
#
# describe WikisHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe WikisHelper do
  describe "markdown" do
    it "formats basic markdown" do
      text = 
%Q{# Header
This is **bold** text

}
      html = 
%Q{<h1>Header</h1>

<p>This is <strong>bold</strong> text</p>
}
      expect(helper.markdown(text)).to eql(html)
    end
  end
end
