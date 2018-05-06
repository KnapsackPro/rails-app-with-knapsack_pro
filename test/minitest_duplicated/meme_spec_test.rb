require 'test_helper'

# Duplicate name of the class so we can run 2 similar test files.
# Minitest requires unique name in describe if you duplicated test file.
MemeDuplicated = Meme

describe MemeDuplicated do
  before do
    @meme = Meme.new
  end

  describe "when asked about cheeseburgers" do
    it "must respond positively" do
      @meme.i_can_has_cheezburger?.must_equal "OHAI!"
    end
  end

  describe "when asked about blending possibilities" do
    it "won't say no" do
      @meme.will_it_blend?.wont_match /^no/i
    end
  end
end
