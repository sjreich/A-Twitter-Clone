class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:loudspeaker_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).loudspeaker
    current_user.unfollow(user)
    redirect_to user
  end

end
