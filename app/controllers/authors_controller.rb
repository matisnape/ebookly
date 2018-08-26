class AuthorsController < ApplicationController
  def index
    @authors = Author.all
    @author = Author.new
    respond_to do |format|
      format.html
      format.json { render json: @authors }
    end
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

  def show
    author
  end

  def edit
    author
  end

  def update
    author
    if author.update_attributes(author_params)
      flash[:success] = "Author was successfully updated"
      redirect_to authors_path
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    @author = Author.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to @authors, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end

  def author
    @author = Author.find(params[:id])
  end
end
