class RepliesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_topic, :only => [:create]

  def create
    @reply = current_user.replies.new params[:reply]
    @reply.topic = @topic
    respond_to do |format|
      if @reply.save
        format.js { render :layout => false }
      else
        format.js { render :layout => false }
      end
    end
  end

  def edit
    @reply = current_user.replies.find(params[:id])
    @return_to = request.referrer
  end

  def update
    @reply = current_user.replies.find(params[:id])
    @return_to = params[:return_to]
    if @reply.update_attributes params[:reply]
      redirect_to @return_to.present? ? "#{@return_to}##{@reply.anchor}" : topic_path(@reply.topic, :anchor => @reply.anchor)
    else
      render :edit
    end
  end

  private

  def find_topic
    @topic = Topic.find params[:topic_id]
  end
end