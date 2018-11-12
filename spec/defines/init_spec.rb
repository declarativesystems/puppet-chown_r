require 'spec_helper'
describe 'chown_r', type: :define do
  let :facts do
    {
      'os' => {
        'family' => 'RedHat'
      }
    }
  end
  context 'with default values for all parameters' do
    let :title do
      '/tmp/test'
    end
    let :params do
      {
        want_user: 'root',
        want_group: 'sys'
      }
    end
    it { should compile }
  end
end
