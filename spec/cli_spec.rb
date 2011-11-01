require 'spec_helper'

module Playup
  describe CLI do

    it '#foo' do
      CLI.foo.should == 'bar'
    end

  end
end