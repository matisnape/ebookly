class BooksController < ApplicationController
  def index
    load_books

    respond_to do |format|
      format.html
      format.json { render json: @books }
    end
  end

  def new
    build_book
    @book.build_author

    load_authors
    load_shops
  end

  def create
    load_authors
    load_shops

    @book = Book.new(book_params)
    save_book or render 'new'
  end

  def show
    load_book
  end

  def edit
    load_book
    build_book

    load_authors
    load_shops
  end

  def update
    load_book
    build_book

    load_authors
    load_shops

    save_book or render 'edit'
  end

  def destroy
    load_book
    @book.destroy
    redirect_to books_path, notice: 'Book was successfully destroyed.'
  end

  private

  def load_books
    @books ||= book_scope.to_a
  end

  def load_book
    @book ||= book_scope.find(params[:id])
  end

  def build_book
    @book ||= book_scope.build
    @book.attributes = book_params
  end

  def save_book
    if @book.save
      flash[:success] = 'Book saved.'
      redirect_to books_path
    end
  end

  def book_params
    book_params = params[:book]
    book_params ? book_params.permit(:title, :shop_id, :author_id, author_attributes: [ :first_name, :last_name ]) : {}
  end

  def book_scope
    Book.all
  end

  def load_authors
    @authors ||= Author.all.sort_by(&:last_name)
  end

  def load_shops
    @shops ||= Shop.all.sort_by(&:name)
  end
end
