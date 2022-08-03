class UsersController < ApplicationController

	def show
    @user = current_user
  end

  def display_transactions
    @transactions = current_user.transactions
  end

end
