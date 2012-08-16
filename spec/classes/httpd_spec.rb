require 'spec_helper'

describe 'httpd', :type => :class do
  let(:params) {
    {:ssl => 'absent', :passenger => 'absent', :mod_wsgi => 'absent' }
  }

  context 'when all parameters are absent' do
    let(:params) {
      {:ssl => 'absent', :passenger => 'absent', :mod_wsgi => 'absent' }
    }

    it 'should contain various classes' do
      should contain_class('httpd::install').with({
        'ssl'       => 'absent',
        'passenger' => 'absent',
        'mod_wsgi'  => 'absent',
      })
      should contain_class('httpd::config').with({
        'passenger' => 'absent',
        'ssl'       => 'absent',
      })
      should contain_class('httpd::service')
    end
  end

  context 'when all parameters are present' do
    let(:params) {
      {:ssl => 'present', :passenger => 'present', :mod_wsgi => 'present' }
    }

    it 'should contain various classes' do
      should contain_class('httpd::install').with({
        'ssl'       => 'present',
        'passenger' => 'present',
        'mod_wsgi'  => 'present',
      })
      should contain_class('httpd::config').with({
        'passenger' => 'present',
        'ssl'       => 'present',
      })
      should contain_class('httpd::service')
    end
  end
end
