class SearchController < ApplicationController
  def index
    if params[:query].present?
      @books = Book.search_by_title(params[:query])
    else
      @books = Book.all
    end
  end
end
