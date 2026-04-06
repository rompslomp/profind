class QuotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quote, only: %i[show destroy]

  def index
    @quotes = current_user.quotes.includes(:service).order(created_at: :desc)
  end

  def show
    authorize @quote
  end

  def new
    @service = Service.find(params[:service_id])
    @quote = Quote.new
  end

  def create
    @service = Service.find(params[:service_id])
    @quote = current_user.quotes.build(quote_params.merge(service: @service, status: :pending))

    if @quote.save
      redirect_to @quote, notice: "Your quote request was sent successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @quote
    @quote.destroy!
    redirect_to quotes_path, notice: "Quote request deleted.", status: :see_other
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:message)
  end
end
