class RescueActionsController < ApplicationController
  before_action :set_rescue_action, only: [:show, :edit, :update, :destroy]
  layout :layout, only: [:new, :edit, :create]

  # GET /rescue_actions
  # GET /rescue_actions.json
  def index
    if not params[:search].nil?
      search = RescueAction.solr_search do
        keywords params[:search]
        paginate :page => params[:page], :per_page => 15
      end

      @rescue_actions = search.results
    else
      @rescue_actions = RescueAction.all.page params[:page]
    end
  end

  # GET /rescue_actions/1
  # GET /rescue_actions/1.json
  def show
  end

  # GET /rescue_actions/new
  def new
    @rescue_action = RescueAction.new()
  end

  # GET /rescue_actions/1/edit
  def edit
  end

  # POST /rescue_actions
  # POST /rescue_actions.json
  def create
    @rescue_action = RescueAction.new(rescue_action_params)

    respond_to do |format|
      if @rescue_action.save
        format.html { redirect_to @rescue_action, notice: 'Rescue action was successfully created.' }
        format.json { render :show, status: :created, location: @rescue_action }
      else
        format.html { render :new }
        format.json { render json: @rescue_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rescue_actions/1
  # PATCH/PUT /rescue_actions/1.json
  def update
    respond_to do |format|
      if @rescue_action.update(rescue_action_params)
        format.html { redirect_to @rescue_action, notice: 'Rescue action was successfully updated.' }
        format.json { render :show, status: :ok, location: @rescue_action }
      else
        format.html { render :edit }
        format.json { render json: @rescue_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rescue_actions/1
  # DELETE /rescue_actions/1.json
  def destroy
    @rescue_action.destroy
    respond_to do |format|
      format.html { redirect_to rescue_actions_url, notice: 'Rescue action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rescue_action
      @rescue_action = RescueAction.find(params[:id])
    end

    def layout
      "wide_application"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rescue_action_params
      params.require(:rescue_action).permit(:lead_id, :kind, :start_position_latitude, :start_position_longitude, :description)
    end
end
