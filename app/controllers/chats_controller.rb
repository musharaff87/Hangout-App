class ChatsController < ApplicationController
  def chatpage
    @friends = current_user.friends
  end
end
