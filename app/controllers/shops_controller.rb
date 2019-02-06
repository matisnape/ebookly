class ShopsController < ApplicationController

  def index
    load_shops

    respond_to do |format|
      format.html
      format.json { render json: @shops }
    end
  end

  def new
    build_shop
  end

  def create
    build_shop

    save_shop or render 'new'
  end

  def show
    load_shop
  end

  def edit
    load_shop
    build_shop
  end

  def update
    load_shop
    build_shop

    save_shop or render 'edit'
  end

  def destroy
    load_shop
    @shop.destroy
    redirect_to shops_path, notice: 'Shop was successfully destroyed.'
  end

  private

  def load_shops
    @shops ||= shop_scope.to_a
  end

  def load_shop
    @shop ||= shop_scope.find_by_slug(params[:slug])
  end

  def build_shop
    @shop ||= shop_scope.build
    @shop.attributes = shop_params
  end

  def save_shop
    if @shop.save
      flash[:success] = 'Shop saved.'
      redirect_to shops_path
    end
  end

  def shop_params
    shop_params = params[:shop]
    shop_params ? shop_params.permit(:name) : {}
  end

  def shop_scope
    Shop.ordered_by_created_at.includes(books: :author)
  end
end
