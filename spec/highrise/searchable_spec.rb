require 'spec_helper'
module Searchable
describe Highrise::Searchable do
  class TestClass < Highrise::Base; include Highrise::Searchable; end
  subject { TestClass.new }
  
  it_should_behave_like "a searchable class", TestClass, "testclass"
end
end