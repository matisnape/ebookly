class AuthorsController < ApplicationController
  def index
    @authors = Author.all
    @author = Author.new
  end

  def create
    @authors = Author.all
    @author = Author.new(author_params)
    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author created.' }
        format.js
        format.json { render json: @author, status: :created, location: @author }
      else
        format.html { render action: "new" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author = Author.destroy(params[:id])
    redirect_to authors_path
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end

  def author
    @author = Author.find(params[:id])
  end
end
