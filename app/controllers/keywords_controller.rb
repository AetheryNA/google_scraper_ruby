class KeywordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_keyword, only: %i[ show edit update destroy ]

  # GET /keywords
  def index
    @keywords = Keyword.all
    @keyword = Keyword.new
  end

  # GET /keywords/1
  def show
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords
  def create
    # @keyword = Keyword.new(keyword_params)

    # if @keyword.save
    #   redirect_to @keyword, notice: "Keyword was successfully created."
    # else
    #   render :new, status: :unprocessable_entity
    # end

    keywords_parse_csv
  end

  # PATCH/PUT /keywords/1
  def update
    if @keyword.update(keyword_params)
      redirect_to @keyword, notice: "Keyword was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /keywords/1
  def destroy
    @keyword.destroy
    redirect_to keywords_url, notice: "Keyword was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def keyword_params
      params.fetch(:keyword, {})
    end

    def keywords_form
      @keyword_form = KeywordsForm.new(current_user)
    end

    def keywords_parse_csv
      keywords_form.save(params[:keyword][:keywords_file])
    end
end
