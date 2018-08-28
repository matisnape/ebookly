class ShopsController < ApplicationController
  def index
    @shops = Shop.all
    @shop = Shop.new
    respond_to do |format|
      format.html
      format.json { render json: @shops }
    end
  end

  def create
    @shops = Shop.all
    @shop = Shop.new(shop_params)
    respond_to do |format|
      if @shop.save
        flash.now[:success] = 'Shop created.'
        format.html
        format.js
        format.json { render json: @shop, status: :created, location: @shop }
      else
        format.html { render action: 'index', notice: 'Some errors are here' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    shop
  end

  def edit
    shop
  end

  def update
    shop
    if shop.update_attributes(shop_params)
      flash[:success] = "Shop was successfully updated"
      redirect_to shops_path
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    shop.destroy
    flash[:notice] = 'Shop was successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to action: 'index' }
      format.json { head :no_content }
      format.js
     end
  end

  private

  def shop_params
    params.require(:shop).permit(:name)
  end

  def shop
    @shop = Shop.find_by_slug(params[:slug])
  end
end
