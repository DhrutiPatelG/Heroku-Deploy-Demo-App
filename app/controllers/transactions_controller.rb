class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @product = Product.all
    @currency = Currency.all
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to users_display_transactions_path
    else
      render :new
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:quantity, :product_id, :currency_id, :user_id)
  end
end
