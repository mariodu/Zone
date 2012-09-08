class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @topics = Topic.page(params[:page]).per(10).order('created_at desc')
  end

  def show
    @topic = Topic.find(params[:id])
    @replies = @topic.replies.page(params[:page]).per(20)
    @reply = current_user.replies.new :topic => @topic if current_user
  end

  def new
    @topic = current_user.topics.new
  end


  def create
    @topic = current_user.topics.new(params[:topic])
    if @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  def edit
    @topic = current_user.topics.find(params[:id])
  end

  def update
    @topic = current_user.topics.find(params[:id])
    @topic.set_edited_at
    if @topic.update_attributes params[:topic]
      redirect_to @topic
    else
      render :edit
    end
  end
end