class Api::V1::AuthorsController < Api::V1::BaseController
  def index
    load_authors
    build_author

    respond_to do |format|
      format.html
      format.json { render json: @authors }
    end
  end

  def create
    load_authors
    build_author

    respond_to do |format|
      if @author.save
        format.html { flash.now[:success] = 'Author created.' }
        format.js
        format.json { render json: @author, status: :created, location: @author }
      else
        format.html { render action: "new" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    load_author
  end

  def edit
    load_author
  end

  def update
    load_author
    build_author

    if @author.save
      flash[:success] = "Author was successfully updated"
      redirect_to @authors
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    load_author
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_path, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
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
      redirect_to @author
    end
  end

  def author_params
    author_params = params[:author]
    author_params ? author_params.permit(:first_name, :last_name) : {}
  end

  def author_scope
    Author.all
  end
end
