# Making the Most of BDD, Part 2
# https://webuild.envato.com/blog/making-the-most-of-bdd-part-2/
require 'rails_helper'
RSpec.describe Withdrawal::RequestForm, :type => :model do
  subject(:form) { Withdrawal::RequestForm.new(user, params, request_forensics)}
  let(:user) { User.make!(:earnings_balance => Money.new(800_00)) }
  before do
    allow(Withdrawal::DefaultWithdrawalAccount).to receive(:default_for_user).with(user).and_return(default_account)
  end
  describe '#save' do
    context 'successful save' do
      context 'and the author has chosen to user their default account' do
        let(:default_account) { mock_default_account('paypal')}
        let(:params) { any_valid_params.merge(:user_default_account => true, :service => 'skrill')}
        it "create a withdrawal based on the default account" do
          expect(form.save).to be true
          expect(Withdrawal.last.payment_service).to eq('paypal')
        end
      end
      context 'and the author has not chosen to user their default account' do
        let(:default_account) { mock_default_account('paypal')}
        let(:params) { any_valid_params.merge(:user_default_account => false, :service => 'skrill')}
        it "create a withdrawal based on the form parameters entered by the user" do
          expect(form.save).to be true
          expect(Withdrawal.last.payment_service).to eq('skrill')
        end
      end
    end
  end
  def any_valid_params
    {
      :type => 'single_fixed',
      :amount => '500',
      :service => 'paypal',
      :paypal_email_address => 'test@envato.com',
      :paypal_email_address_confirmation => 'test@envato.com',
      :skrill_email_address => 'test2@envato.com',
      :skrill_email_address_confirmation => 'test2@envato.com',
      :taxable_australian_resident => true,
      :hobbyist => true
    }
  end
  def mock_default_account(payment_service)
    mock_mode(Withdrawal::DefaultWithdrawalAccount, :user => user, :payment_service => payment_service, :payment_email_address => 'me@here.com', :swift_detail => nil)
  end
end
