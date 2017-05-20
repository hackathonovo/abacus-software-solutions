class FeedItemsController < ApplicationController
  before_action :set_feed_items
  before_action :set_feed_item, only: [:show, :edit, :update, :destroy]

  # GET rescue_actions/1/feed_items
  def index
    @feed_items = @rescue_action.feed_items
  end

  # GET rescue_actions/1/feed_items/1
  def show
  end

  # GET rescue_actions/1/feed_items/new
  def new
    @feed_item = @rescue_action.feed_items.build
  end

  # GET rescue_actions/1/feed_items/1/edit
  def edit
  end

  # POST rescue_actions/1/feed_items
  def create
    @feed_item = @rescue_action.feed_items.build(feed_item_params)

    if @feed_item.save
      redirect_to([@feed_item.rescue_action, @feed_item], notice: 'Feed item was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT rescue_actions/1/feed_items/1
  def update
    if @feed_item.update_attributes(feed_item_params)
      redirect_to([@feed_item.rescue_action, @feed_item], notice: 'Feed item was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE rescue_actions/1/feed_items/1
  def destroy
    @feed_item.destroy

    redirect_to rescue_action_feed_items_url(@rescue_action)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed_items
      @rescue_action = RescueAction.find(params[:rescue_action_id])
    end

    def set_feed_item
      @feed_item = @rescue_action.feed_items.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feed_item_params
      params.require(:feed_item).permit(:text, :author)
    end
end
