require 'spec_helper'

describe 'httpd::install', :type => :class do

  describe 'should install appropriate packages' do
    context 'defaults' do
      let(:params) {
        {:ssl => 'absent', :passenger => 'absent', :mod_wsgi => 'absent'}
      }
      it {
        should contain_package('httpd').with_ensure('present')
        should contain_package('mod_ssl').with_ensure('absent')
        should contain_package('mod_wsgi').with_ensure('absent')
        should contain_package('passenger').with_ensure('absent')
      }
    end

    context 'with ssl => present' do
      let(:params) {
        {:ssl => 'present', :passenger => 'absent', :mod_wsgi => 'absent'}
      }
      it { should contain_package('mod_ssl').with_ensure('present') }
    end

    context 'with mod_wsgi => present' do
      let(:params) {
        {:ssl => 'absent', :passenger => 'absent', :mod_wsgi => 'present'}
      }
      it { should contain_package('mod_wsgi').with_ensure('present') }
    end

    context 'with passenger => present' do
      let(:params) {
        {:ssl => 'absent', :passenger => 'present', :mod_wsgi => 'absent'}
      }
      it { should contain_package('passenger').with_ensure('present') }
    end
  end
end
