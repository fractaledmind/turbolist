class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]

  # GET /lists
  def index
    @lists = Current.user.lists
  end

  # GET /lists/1
  def show
  end

  # GET /lists/new
  def new
    @list = Current.user.lists.build
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  def create
    @list = Current.user.lists.build(list_params)

    if @list.save
      redirect_to @list, notice: "List was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      redirect_to @list, notice: "List was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy!
    redirect_to lists_url, notice: "List was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = Current.user.lists.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title, :description, :avatar)
    end
end
