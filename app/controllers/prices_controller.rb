class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]

  # GET /prices
  def index
    @prices = Price.all
  end


  # GET /prices/1/edit
  def edit
  end

  def randomize
    Price.randomize params[:type], params[:number].to_i, params[:init_time], params[:end_time]
    redirect_to prices_path(params), notice: 'Prices was successfully randomized.'  
  end

  def next
    @price = Price.next_price

    respond_to do |format|
      format.json {render json: @price}
    end
  end

  # PATCH/PUT /prices/1
  def update
    if @price.update(price_params)
      redirect_to @price, notice: 'Price was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /prices/1
  def destroy
    @price.destroy
    redirect_to prices_url, notice: 'Price was successfully destroyed.'
  end

  def delete_all
    Price.destroy_all
    redirect_to prices_path, notice: 'Prices were successfully destroyed.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def price_params
      params.require(:price).permit(:type, :enabled, :time)
    end

end
