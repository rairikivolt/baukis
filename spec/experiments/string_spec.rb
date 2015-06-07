require 'spec_helper'

describe String do
  describe '#<<' do
    xit '文字の追加' do
      s = "ABC"
      s << "D"
      expect(s.size).to eq(4)
    end

    xexample 'adding nil' do
      pending('調査中')
      s = "ABC"
      s << nil
    end

    example 'nil cant be added', :exception do
      s = "ABC"
      expect {s << nil}.to raise_error(TypeError)
    end

  end
end
