require 'spec_helper'

describe 'httpd::config::install_cert' do
  let(:params) {
    {
      :name          => 'httpd/test.site.com.pem',
      :certdir       => '/etc/httpd/certs',
    }
  }

  it 'should install the appropriate cert' do
    contain_file('/etc/httpd/certs/test.site.com.pem').with_present('present')
  end

end
