class ReviewingsController < ApplicationController
  before_action :set_reviewing, only: [:show, :edit, :update, :destroy]

  # GET /reviewings
  # GET /reviewings.json
  def index
    if params[:book_id]
      @book = Book.where(isbn: params[:book_id]).first
      if !@book.nil?
        @reviewings = @book.reviewings        
      end
    end
  end

  # GET /reviewings/1
  # GET /reviewings/1.json
  def show
  end

  # GET /reviewings/new
  def new
    @reviewing = Reviewing.new
  end

  # GET /reviewings/1/edit
  def edit
  end

  # POST /reviewings
  # POST /reviewings.json
  def create
    @reviewing = Reviewing.new(reviewing_params)
    @book = @reviewing.book
    @user = User.find(current_user.id)
    @user.reviewings << @reviewing
    @book.updateRate(@book.id)

    respond_to do |format|
      if @reviewing.save
        format.html { redirect_to book_reviewings_path(@reviewing.book.isbn), notice: 'Reviewing was successfully created.' }
        format.json { render :show, status: :created, location: @reviewing }
      else
        format.html { render :new }
        format.json { render json: @reviewing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviewings/1
  # PATCH/PUT /reviewings/1.json
  def update
    @book = @reviewing.book
    
    respond_to do |format|
      if @reviewing.update(reviewing_params)
        @book.updateRate(@book.id)
        format.html { redirect_to book_reviewings_path(@reviewing.book.isbn), notice: 'Reviewing was successfully updated.' }
        format.json { render :show, status: :ok, location: @reviewing }
      else
        format.html { render :edit }
        format.json { render json: @reviewing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviewings/1
  # DELETE /reviewings/1.json
  def destroy
    @book = @reviewing.book
    
    @reviewing.destroy
    respond_to do |format|
      @book.updateRate(@book.id)
      format.html { redirect_to reviewings_url, notice: 'Reviewing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reviewing
      @reviewing = Reviewing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reviewing_params
      params.require(:reviewing).permit(:book_id, :rate, :review)
    end
end
