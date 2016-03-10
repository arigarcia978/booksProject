class BooksController < ApplicationController
  before_action :set_shelf, only: [:create, :move_book, :remove_book]
  before_action :set_book, only: [:create, :edit, :update, :destroy, :set_shelf]

  # GET /books
  # GET /books.json
  def index
    @books = GoogleBooks.search(params[:search_key], {:count => 12})
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

    respond_to do |format|
      if @shelf.books.include? @book
        format.html { redirect_to new_book_reviewing_path(@book), notice: 'Already in shelf.'}
        format.json { render json: @book.errors, status: :unprocessable_entity }
      else
        @shelf.books << @book
        format.html { redirect_to new_book_reviewing_path(@book), notice: 'Book was successfully added to shelf.' }
        format.json { render :show, status: :created, location: @book }
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
      format.html { redirect_to @shelf, notice: 'Book was successfully removed from shelf.' }
    end
  end

  def move_book
    @book = @shelf.books.find(params[:id])
    @shelf.books.delete(Book.find(params[:id]))
    @new_shelf = Shelf.find(params[:to_shelf_id])
    @new_shelf.books << @book

    respond_to do |format|
      format.html { redirect_to @shelf, notice: 'Book was successfully removed from shelf.' }
      format.json { render :show, location: @shelf }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.where(isbn: params[:book_isbn]).first
      if @book.nil?
        @book = Book.new(isbn: params[:book_isbn])
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
