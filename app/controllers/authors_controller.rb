class AuthorsController < ApplicationController
  def index
    load_authors

    respond_to do |format|
      format.html
      format.json { render json: @authors }
    end
  end

  def new
    build_author
  end

  def create
    build_author

    save_author or render 'new'
  end

  def show
    load_author
  end

  def edit
    load_author
    build_author
  end

  def update
    load_author
    build_author

    save_author or render 'edit'
  end

  def destroy
    load_author
    @author.destroy
    redirect_to authors_path, notice: 'Author was successfully destroyed.'
  end

  private

  def load_authors
    @authors ||= author_scope.to_a
  end

  def load_author
    @author ||= author_scope.find(params[:id])
  end

  def build_author
    @author ||= author_scope.build
    @author.attributes = author_params
  end

  def save_author
    if @author.save
      flash[:success] = 'Author saved.'
      redirect_to authors_path
    end
  end

  def author_params
    author_params = params[:author]
    author_params ? author_params.permit(:first_name, :last_name) : {}
  end

  def author_scope
    Author.all.includes(:books)
  end
end
