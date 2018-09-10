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
        format.html { flash[:success] = 'Shop created.' }
        format.js   { flash.now[:success] = 'Shop created.' }
        format.json { render json: @shop, status: :created, location: @shop }
      else
        format.html do
          flash[:error] = 'There were some errors with saving:' + @shop.errors.full_messages.join(', ')
          redirect_to action: 'index'
        end
        format.json { render json: @shop.errors, status: :unprocessable_entity }
        format.js   { flash.now[:error] = 'Some error are here: ' + @shop.errors.full_messages.join(', ') }
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
    @shops = Shop.all
    shop.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'Shop was successfully destroyed.'
        redirect_to action: 'index'
      end
      format.json { head :no_content }
      format.js   { flash.now[:notice] = 'Shop was successfully destroyed.' }
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
