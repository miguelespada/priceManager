class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]

  # GET /prices
  def index
    @prices = Price.all.order_by(:time.asc)
  end


  # GET /prices/1/edit
  def edit
  end

  def randomize
    init_time = parse_time(params[:init_time])
    end_time = parse_time(params[:end_time])
    Price.randomize params[:number].to_i, init_time, end_time
    redirect_to prices_path(params), notice: 'Prices was successfully randomized.'  
  end

  def next_price
    Price.all.order_by(:time.asc).each do |price|
      if price.time <= DateTime.now
        @price = price
        break
      end
    end

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

    def parse_time time_string
      init_hour = time_string.split(':')[0].to_i
      init_minute = time_string.split(':')[1].to_i
      Time.now.change({ hour: init_hour, min: init_minute, sec: 0 })
    end
end
