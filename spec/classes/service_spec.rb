require 'spec_helper'

describe 'httpd::service', :type => :class do

  it 'should ensure the service is running and started at boot' do
    should contain_service('httpd').with({
      'ensure' => 'true',
      'enable' => 'true',
    })
  end
end
