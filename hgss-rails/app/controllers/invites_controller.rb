class InvitesController < ApplicationController
  before_action :set_invites
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  # GET rescue_actions/1/invites
  def index
    @invites = @rescue_action.invites
  end

  # GET rescue_actions/1/invites/1
  def show
  end

  # GET rescue_actions/1/invites/new
  def new
    @invite = @rescue_action.invites.build
  end

  # GET rescue_actions/1/invites/1/edit
  def edit
  end

  # POST rescue_actions/1/invites
  def create
    @invite = @rescue_action.invites.build(invite_params)

    if @invite.save
      redirect_to([@invite.rescue_action, @invite], notice: 'Invite was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT rescue_actions/1/invites/1
  def update
    if @invite.update_attributes(invite_params)
      redirect_to([@invite.rescue_action, @invite], notice: 'Invite was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE rescue_actions/1/invites/1
  def destroy
    @invite.destroy

    redirect_to rescue_action_invites_url(@rescue_action)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invites
      @rescue_action = RescueAction.find(params[:rescue_action_id])
    end

    def set_invite
      @invite = @rescue_action.invites.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invite_params
      params.require(:invite).permit(:rescuer_id, :status)
    end
end
