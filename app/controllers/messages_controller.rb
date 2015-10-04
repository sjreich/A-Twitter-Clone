class MessagesController < ApplicationController

  before_action :message_author, only: [:destroy, :edit, :update]
  before_action :logged_in, only: [:new, :create]

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      flash[:success] = "A new message!  Wowwee!"
      redirect_to @message
    else
      flash[:danger] = @message.errors.full_messages
      render 'new'
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(message_params)
      flash[:success] = "Message updated"
      redirect_to @message
    else
      flash[:danger] = @message.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = "Message went bye-bye"
    redirect_to messages_url
  end

  def message_params
    params.require(:message).permit(:content)
  end

  private
    def message_author
      @message = Message.find(params[:id])
      if current_user != @message.user && !current_user.try(:admin?)
        flash[:danger] = "You can only edit/delete your own posts"
        redirect_to current_user
      end
    end

    def logged_in
      if current_user == nil
        redirect_to login_url
        flash[:danger] = "You can't write messages until you log in"
      end
    end

end
