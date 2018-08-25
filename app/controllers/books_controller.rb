class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @shops = Shop.all.sort_by(&:name)
    @authors = Author.all.sort_by(&:last_name)
    respond_to do |format|
      format.html
      format.json { render json: @books }
    end
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @books, notice: 'Book created.' }
        format.js
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = Book.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to @books, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def book_params
    params.require(:book).permit( :title, :author_id, :shop_id )
  end

  def book
    @book = Book.find(params[:id])
  end
end
