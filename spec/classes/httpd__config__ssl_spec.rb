require 'spec_helper'

describe 'httpd::config::ssl', :type => :class do
  let(:params) {{
    :certificate => 'test.com.cert',
    :key => 'test.com.key',
  }}

  describe 'should call appropriate defines' do
    it { should contain_httpd__config__install_cert('test.com.cert') }
    it { should contain_httpd__config__install_cert('test.com.key') }
  end

end
