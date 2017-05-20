class RescueActionAreasController < ApplicationController
  before_action :set_rescue_action_area, only: [:show, :edit, :update, :destroy]

  # GET /rescue_action_areas
  # GET /rescue_action_areas.json
  def index
    @rescue_action_areas = RescueActionArea.all
  end

  # GET /rescue_action_areas/1
  # GET /rescue_action_areas/1.json
  def show
  end

  # GET /rescue_action_areas/new
  def new
    @rescue_action_area = RescueActionArea.new
  end

  # GET /rescue_action_areas/1/edit
  def edit
  end

  # POST /rescue_action_areas
  # POST /rescue_action_areas.json
  def create
    @rescue_action_area = RescueActionArea.new(rescue_action_area_params)

    respond_to do |format|
      if @rescue_action_area.save
        format.html { redirect_to @rescue_action_area, notice: 'Rescue action area was successfully created.' }
        format.json { render :show, status: :created, location: @rescue_action_area }
      else
        format.html { render :new }
        format.json { render json: @rescue_action_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rescue_action_areas/1
  # PATCH/PUT /rescue_action_areas/1.json
  def update
    respond_to do |format|
      if @rescue_action_area.update(rescue_action_area_params)
        format.html { redirect_to @rescue_action_area, notice: 'Rescue action area was successfully updated.' }
        format.json { render :show, status: :ok, location: @rescue_action_area }
      else
        format.html { render :edit }
        format.json { render json: @rescue_action_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rescue_action_areas/1
  # DELETE /rescue_action_areas/1.json
  def destroy
    @rescue_action_area.destroy
    respond_to do |format|
      format.html { redirect_to rescue_action_areas_url, notice: 'Rescue action area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rescue_action_area
      @rescue_action_area = RescueActionArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rescue_action_area_params
      params.require(:rescue_action_area).permit(:rescue_action_id, :name)
    end
end
