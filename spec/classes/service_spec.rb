require 'spec_helper'

describe 'httpd::service', :type => :class do
  let(:params) {
    {:subscribes => 'File["/etc/httpd/conf.d/status.conf"]', :requires => '' }
  }

  it 'should ensure the service is running and started at boot' do
    should contain_service('httpd').with({
      'ensure' => 'true',
      'enable' => 'true',
      'subscribe' => 'File["/etc/httpd/conf.d/status.conf"]',
    })
  end
end
