class RescueActionAreaRescuersController < ApplicationController
  before_action :set_rescuer, only: [:show, :edit, :update, :destroy]
  before_action :set_rescue_action
  before_action :set_rescue_action_area

  # GET /rescue_action_area_rescuers
  # GET /rescue_action_area_rescuers.json
  def index
    @rescue_action_area_rescuers = @rescue_action_area.rescuers
  end

  # GET /rescue_action_area_rescuers/new
  def new
    @rescuer = nil
  end

  # POST /rescue_action_area_rescuers
  # POST /rescue_action_area_rescuers.json
  def create
    @rescue_action_area.rescuers << Rescuer.find(params[:rescue_action_area_rescuer][:rescuer])

    respond_to do |format|
      if @rescue_action_area.save
        format.html { redirect_to rescue_action_area_rescuers_url(@rescue_action, @rescue_action_area), notice: 'Rescue action area rescuer was successfully created.' }
        format.json { render :show, status: :created, location: @rescue_action_area_rescuer }
      else
        format.html { render :new }
        format.json { render json: @rescue_action_area_rescuer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rescue_action_area_rescuers/1
  # DELETE /rescue_action_area_rescuers/1.json
  def destroy
    @rescue_action_area.rescuers.delete(@rescuer)
    respond_to do |format|
      format.html { redirect_to rescue_action_area_rescuers_url(@rescue_action, @rescue_action_area), notice: 'Rescue action area rescuer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rescuer
      @rescuer = Rescuer.find(params[:id])
    end

    def set_rescue_action
      @rescue_action = RescueAction.find(params[:rescue_action_id])
    end

    def set_rescue_action_area
      @rescue_action_area = RescueActionArea.find(params[:area_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rescue_action_area_rescuer_params
      params.fetch(:rescue_action_area_rescuer, {})
    end
end
