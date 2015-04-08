class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy, :disable]

  # GET /prices
  def index
    @prices = Price.all
  end

  # GET /prices/1/edit
  def edit
  end

  def list
    respond_to do |format|
      format.json {render json: PRICES}
    end
  end

  def randomize
    Price.randomize params[:type], params[:number].to_i, params[:init_time], params[:end_time]
    redirect_to prices_path(params), notice: 'Prices was successfully randomized.'  
  end

  def next
    @price = Price.next
    Log.new_log
    respond_to do |format|
      format.json {render json: @price}
    end
  end

  def disable
    @price.enabled = false
    @price.save!
    render json: @price
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

  def reorder_missed
    Price.reorder_missed
    redirect_to prices_path, notice: 'Prices were successfully reordered.'
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
