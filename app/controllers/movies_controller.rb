class MoviesController < ApplicationController
  # PLAIN ACTIVE RECORD
  # def index
  #  breaks if search is not there: params[:search][:query]
  #   query = params.dig(:search, :query)

  #   # @movies = Movie.all
  #   # @movies = @movies.where(title: query) if query.present?

  #   # query is either an empty string or nil
  #   if query.present?
  #     @movies = Movie.where(title: query)
  #   else
  #     @movies = Movie.all
  #   end
  # end

  # CASE INSENSITIVE SEARCH WITH ILIKE
  # def index
  #   @query = params.dig(:search, :query)

  #   # query is either an empty string or nil
  #   if @query.present?
  #     @movies = Movie.where("title ILIKE ?", "%#{@query}%")
  #   else
  #     @movies = Movie.all
  #   end
  # end

  # SEARCHING SEVERAL ATTRIBUTES
  # def index
  #   @query = params.dig(:search, :query)

  #   # query is either an empty string or nil
  #   if @query.present?
  #     sql_query = "title ILIKE :query OR syllabus ILIKE :query"
  #     @movies = Movie.where(sql_query, query: "%#{@query}%")
  #   else
  #     @movies = Movie.all
  #   end
  # end

  # SEARCHING THROUGH ASSOCIATIONS
  # def index
  #   @query = params.dig(:search, :query)

  #   # query is either an empty string or nil
  #   if @query.present?
  #     sql_query = " \
  #       movies.title ILIKE :query \
  #       OR movies.syllabus ILIKE :query \
  #       OR directors.first_name ILIKE :query \
  #       OR directors.last_name ILIKE :query \
  #     "
  #     @movies = Movie.joins(:director).where(sql_query, query: "%#{@query}%")
  #   else
  #     @movies = Movie.all
  #   end
  # end

  # PG FULL TEXT SEARCH
  def index
    @query = params.dig(:search, :query)

    # query is either an empty string or nil
    if @query.present?
      sql_query = " \
        movies.title @@  :query \
        OR movies.syllabus @@  :query \
        OR directors.first_name @@  :query \
        OR directors.last_name @@  :query \
      "
      @movies = Movie.joins(:director).where(sql_query, query: "%#{@query}%")
    else
      @movies = Movie.all
    end
  end
end
