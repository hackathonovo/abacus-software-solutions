class RescuersController < ApplicationController
  before_action :set_rescuer, only: [:show, :edit, :update, :destroy]

  # GET /rescuers
  # GET /rescuers.json
  def index
    if not params[:search].nil?
      search = Rescuer.search do
        keywords params[:search]
        paginate :page => params[:page], :per_page => 15
      end

      @rescuers = search.results
    else
      @rescuers = Rescuer.all.page params[:page]
    end
  end

  # GET /rescuers/1
  # GET /rescuers/1.json
  def show
  end

  # GET /rescuers/new
  def new
    @rescuer = Rescuer.new
  end

  # GET /rescuers/1/edit
  def edit
  end

  # POST /rescuers
  # POST /rescuers.json
  def create
    @rescuer = Rescuer.new(rescuer_params)

    respond_to do |format|
      if @rescuer.save
        format.html { redirect_to @rescuer, notice: 'Rescuer was successfully created.' }
        format.json { render :show, status: :created, location: @rescuer }
      else
        format.html { render :new }
        format.json { render json: @rescuer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rescuers/1
  # PATCH/PUT /rescuers/1.json
  def update
    respond_to do |format|
      if @rescuer.update(rescuer_params)
        format.html { redirect_to @rescuer, notice: 'Rescuer was successfully updated.' }
        format.json { render :show, status: :ok, location: @rescuer }
      else
        format.html { render :edit }
        format.json { render json: @rescuer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rescuers/1
  # DELETE /rescuers/1.json
  def destroy
    @rescuer.destroy
    respond_to do |format|
      format.html { redirect_to rescuers_url, notice: 'Rescuer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rescuer
      @rescuer = Rescuer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rescuer_params
      params.require(:rescuer).permit(:first_name, :last_name, :availability, :phone_number, :address_home, :home_latitude, :home_longitude, :address_work, :work_latitude, :work_longitude, :level, :push_token, :specialty_ids => [])
    end
end
