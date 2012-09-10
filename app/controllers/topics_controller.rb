class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :tagged]

  def index
    @topics = Topic.order('created_at desc').page(params[:page]).per(15)
  end

  def show
    @topic = Topic.find(params[:id])
    @replies = @topic.replies
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

  def tagged
    tag = Tag.find_by_name!(params[:tag])
    @topics = tag.topics.order('created_at desc').page(params[:page]).per(15)
    render :index
  end
end