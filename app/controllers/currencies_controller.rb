class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy, :show]

  def index
    @currencies = Currency.all
    require 'net/http'
    require 'json'
    @url = 'https://api.coinmarketcap.com/v1/ticker/'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @portfolio_currency = JSON.parse(@response)
    @profit_loss = 0
  end

  def show
    @currencies = Currency.name
  end

  def new
    @currency = Currency.new
  end

  def edit
  end

  def create
    @currency = Currency.new(currency_params)

    respond_to do |format|
      if @currency.save
        format.html { redirect_to currencies_path, notice: 'Currency was successfully created.' }
        format.json { render :show, status: :created, location: @currency }
      else
        format.html { render :new }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to @currency, notice: 'Currency was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency }
      else
        format.html { render :edit }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @currency.destroy
    respond_to do |format|
      format.html { redirect_to currencies_url, notice: 'Currency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_currency
      @currency = Currency.find(params[:id])
    end

    def currency_params
      params.require(:currency).permit(:symbol, :user_id, :invested_at, :amount_owned, :name)
    end

    def correct_user
      @correct = current_user.currencies.find_by(id: params[:id])
      redirect_to currencies_path, notice: "You can only edit your own portfolio." if @correct.nil?
    end
end
