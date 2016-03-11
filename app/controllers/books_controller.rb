class BooksController < ApplicationController
  before_action :set_shelf, only: [:create, :move_book, :remove_book]
  before_action :set_book, only: [:create, :edit, :update, :destroy, :set_shelf]

  # GET /books
  # GET /books.json
  def index
    if !params[:search_key].blank?
      user_ip = request.remote_ip # assuming user is accessing from a valid IP address
      @books_result = GoogleBooks.search(params[:search_key], {:count => 12}, user_ip)
      @books = @books_result.reject {|book| book.isbn.nil? || book.image_link.blank? }
    else
      @books = current_user.books if user_signed_in?
    end
    if user_signed_in?
      @shelves = current_user.shelves
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @shelf.books << @book if !@shelf.books.include? @book

    respond_to do |format|
      if @shelf.user.reviewings.where(book_id: @book).empty?
        format.html { redirect_to new_book_reviewing_path(@book), notice: 'Already in shelf.'}
        format.json { render json: @book.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to books_path(search_key: params[:search_key]), notice: 'Book was successfully added to shelf.', search_key: params[:search_key] }
        format.json { render :index, status: :created, location: @book }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_book
    @book = @shelf.books.find(params[:id])
    @shelf.books.delete(@book)

    respond_to do |format|
      format.html { redirect_to shelves_path, notice: 'Book was successfully removed from shelf.' }
      format.json { render :index, status: :created, location: @shelf }
    end
  end

  def move_book
    @book = @shelf.books.find(params[:id])
    @shelf.books.delete(Book.find(params[:id]))
    @new_shelf = Shelf.find(params[:to_shelf_id])
    @new_shelf.books << @book

    respond_to do |format|
      format.html { redirect_to shelves_path, notice: 'Book was successfully removed from shelf.' }
      format.json { render :show, location: @shelf }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.where(isbn: params[:book_isbn]).first
      if @book.nil?
        @book = Book.new
        user_ip = request.remote_ip
        @result = GoogleBooks.search(params[:book_isbn], {:count => 1}, user_ip)
        @book.isbn = @result.isbn
        @book.title = @result.title
        @book.image_link = @result.image_link
        @book.published_date = @result.published_date
        @book.authors = @result.authors
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn)
    end

    def set_shelf
      if params[:shelf_id]
        @shelf = Shelf.find(params[:shelf_id])
      else
        if !current_user.books.include? @book
          @shelf = Shelf.where(name: 'Leídos').first
        else 
          @shelf = @book.shelves.where(user_id: current_user.id)
        end
      end
    end

end
