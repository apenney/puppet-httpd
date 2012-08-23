require 'spec_helper'

describe 'httpd::config', :type => :class do
  let(:params) {{
    :ssl => 'absent',
    :passenger => 'absent',
    :certificate => '',
    :key => '',
  }}
  let(:hiera_data) { { :collectd_server => '1.2.3.4' } }

  describe 'should set up appropriate firewall rules' do
    it { should contain_firewall('001 apache ports').with_dport([443, 80]) }
  end

  describe 'should set up appropriate configuration' do
    it { should contain_file('/etc/httpd/conf.d/status.conf').with_ensure('present') }
  end

  describe 'should setup collectd' do
    it { should contain_collectd__add_monitor('apache') }
  end

  context 'when ssl is enabled but certificate and key are not' do
    let(:params) {{
      :ssl => 'present',
      :passenger => 'absent',
      :certificate => '',
      :key => '',
    }}
    it 'should fail' do
      expect raise_error(Puppet::Error, /You must pass in either/)
    end
  end
  context 'when ssl is enabled and only certificate is set' do
    let(:params) {{
      :ssl => 'present',
      :passenger => 'absent',
      :certificate => 'httpd/cert.pem',
      :key => '',
    }}
    it 'should fail' do
      expect raise_error(Puppet::Error, /certificate and key parameters must be non-empty/)
    end
  end
  context 'when ssl is enabled and both certificate and key are set' do
    let(:params) {{
      :ssl => 'present',
      :passenger => 'absent',
      :certificate => 'httpd/certs/cert.pem',
      :key => 'httpd/certs/cert.key',
    }}
    it 'should include httpd::config::ssl successfully' do
      should contain_class('httpd::config::ssl').with({
        'certificate' => 'httpd/certs/cert.pem',
        'key'         => 'httpd/certs/cert.key',
      })
    end
  end
end
