require 'spec_helper'

describe 'httpd::site' do
  let(:params) {
    {
      :name      => 'test.site.com',
      :template  => 'httpd/generic-template.conf.erb',
      :passenger => 'present',
      :ssl       => 'present',
    }
  }

  it 'should ensure the httpd class is included' do
    contain_class('httpd').with({
      'ssl'       => 'present',
      'passenger' => 'present',
      'mod_wsgi'  => 'present',
    })
  end

  context 'when ensure is present' do
    let(:params) { {:ensure => 'present' }}
    it 'should ensure that the vhost conf is in place' do
      contain_file('/etc/httpd/conf.d/test.site.com.conf').with_present('present')
    end
  end

  context 'when ensure is absent' do
    let(:params) { {:ensure => 'absent' }}
    it 'should ensure that the vhost conf is not in place' do
      contain_file('/etc/httpd/conf.d/test.site.com.conf').with_present('absent')
    end
  end

end
