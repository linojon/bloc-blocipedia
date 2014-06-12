class AccountsController < ApplicationController

  def show
    @account = current_user.account
    if @account.stripe_customer
      info = Stripe::Customer.retrieve @account.stripe_customer
      @card = info['cards']['data'].first
    end
  end

end
