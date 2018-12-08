class Api::V1::AuthorsController < Api::V1::BaseController
  def index
    load_authors
  end

  def create
    load_authors
    build_author

    return api_error(status: :unprocessable_entity, errors: @author.errors) unless @author.valid?

    @author.save
    render(
      json: Api::V1::AuthorSerializer.new(@author).to_json,
      status: :created,
      location: api_v1_author_path(@author.id)
    )
  end

  def show
    load_author

    render(json: Api::V1::AuthorSerializer.new(@author).to_json)
  end

  def update
    load_author
    build_author

    return api_error(status: :unprocessable_entity, errors: @author.errors) unless @author.valid?

    @author.save
    render(
      json: Api::V1::UserSerializer.new(user).to_json,
      status: 200,
      location: api_v1_user_path(user.id),
      serializer: Api::V1::UserSerializer
    )
  end

  def destroy
    load_author

    if !@author.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def load_authors
    @authors ||= author_scope.to_a

    render(
      json: ActiveModel::ArraySerializer.new(
        @authors,
        each_serializer: Api::V1::AuthorSerializer,
        root: 'authors',
        meta: meta_attributes(@authors)
      )
    )
  end

  def load_author
    @author ||= author_scope.find(params[:id])
  end

  def build_author
    @author ||= author_scope.build
    @author.attributes = author_params
  end

  def author_params
    author_params = params[:author]
    author_params ? author_params.permit(:first_name, :last_name) : {}
  end

  def author_scope
    Author.all
  end
end
