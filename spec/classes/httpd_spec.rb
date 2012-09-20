require 'spec_helper'

describe 'httpd', :type => :class do

  context 'when all parameters are absent' do
    let(:params) {
      {:ssl         => 'absent',
       :passenger   => 'absent',
       :mod_wsgi    => 'absent',
       :certificate => '',
       :key         => '',
       :subscribes  => '',
       :requires    => '',
      }
    }

    it 'should contain various classes' do
      should contain_class('httpd::install').with({
        'ssl'       => 'absent',
        'passenger' => 'absent',
        'mod_wsgi'  => 'absent',
      })
      should contain_class('httpd::config').with({
        'passenger'   => 'absent',
        'ssl'         => 'absent',
        'certificate' => '',
        'key'         => '',
      })
      should contain_class('httpd::service').with({
        'subscribes' => '',
        'key'        => '',
      })
    end
  end

  context 'when all parameters are present' do
    let(:params) {
      {:ssl         => 'present',
       :passenger   => 'present',
       :mod_wsgi    => 'present',
       :certificate => 'test.com.cert',
       :key         => 'test.com.key',
       :subscribes  => 'File[/tmp]',
       :requires    => 'File[/]',
      }
    }

    it 'should contain various classes' do
      should contain_class('httpd::install').with({
        'ssl'       => 'present',
        'passenger' => 'present',
        'mod_wsgi'  => 'present',
      })
      should contain_class('httpd::config').with({
        'passenger'   => 'present',
        'ssl'         => 'present',
        'certificate' => 'test.com.cert',
        'key'         => 'test.com.key',
      })
      should contain_class('httpd::service')
    end
  end
end
