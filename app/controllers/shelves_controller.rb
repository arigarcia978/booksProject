class ShelvesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shelf, only: [:show, :edit, :update, :destroy, :remove_book]

  # GET /shelves
  # GET /shelves.json
  def index
    @shelves = Shelf.where(user_id: current_user.id)
  end

  # GET /shelves/1
  # GET /shelves/1.json
  def show
    @shelves = Shelf.where(user_id: current_user.id) - [@shelf]
  end

  # GET /shelves/new
  def new
    @shelf = Shelf.new
  end

  # GET /shelves/1/edit
  def edit
    if @shelf.name == 'Leídos'
      respond_to do |format|
        format.html { redirect_to shelves_url, notice: 'Cannot edit shelf Leídos.' }
      end
    end
  end

  # POST /shelves
  # POST /shelves.json
  def create
    @shelf = Shelf.new(shelf_params)

    respond_to do |format|
      if @shelf.save
        format.html { redirect_to shelves_path, notice: 'Shelf was successfully created.' }
        format.json { render :index, status: :created, location: @shelf }
      else
        format.html { render :new }
        format.json { render json: @shelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shelves/1
  # PATCH/PUT /shelves/1.json
  def update
    respond_to do |format|
      if @shelf.update(shelf_params)
        format.html { redirect_to shelves_path, notice: 'Shelf was successfully updated.' }
        format.json { render :show, status: :ok, location: @shelf }
      else
        format.html { render :edit }
        format.json { render json: @shelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shelves/1
  # DELETE /shelves/1.json
  def destroy
    respond_to do |format|
      if @shelf.name == 'Leídos'
        format.html { redirect_to shelves_url, notice: 'Cannot destroy shelf Leídos.' }
      else 
        @shelf.destroy
        format.html { redirect_to shelves_url, notice: 'Shelf was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shelf
      @shelf = Shelf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shelf_params
      params.require(:shelf).permit(:user_id, :name)
    end
end
