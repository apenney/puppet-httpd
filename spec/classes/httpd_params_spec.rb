require 'spec_helper'

describe 'httpd::params', :type => :class do

  # There are 4 resources in this class currently
  # there should not be any more resources because it is a params class
  it "Should not contain any resources" do
    subject.resources.size.should == 4
  end

end
