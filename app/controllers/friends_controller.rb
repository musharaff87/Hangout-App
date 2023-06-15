class FriendsController < ApplicationController

    def index
      @available_users = User.where.not(id: current_user.id)
      @friends = current_user.friends #where(status: "accepted")
      @friend_requests = current_user.friend_requests #where(status: "pending")
    end

    def create
      friend = User.find(params[:user_id])
      current_user.send_friend_request(friend)
      redirect_to friends_path, notice: "Friend request sent."
    end

=begin
    def accept
      friend = User.find(params[:id])
      friendship = current_user.friendships.find_by(friend_id: friend.id)
      name = params[:name]
      puts name
      puts params[:id]
      #current_user.update(my_friends: name)

     
      my_friends = current_user.my_friends || [] # Initialize as an empty array if nil
      puts my_friends
      my_friends << name # Append the new name to the list

      current_user.update(my_friends: my_friends.to_json)


      redirect_to friends_path, notice: "Friend request accepted."
    
    end
  
    def decline
      friend = User.find(params[:friend_id])
      current_user.decline_friend_request(friend)
      redirect_to friends_path, notice: "Friend request declined."
    end
=end

def accept
  friend = User.find(params[:id])
  #puts "Testingg"
  #puts friend
  current_user.accept_friend_request(friend)
  @friend_requests = current_user.friend_requests
  redirect_to friends_path, notice: "Friend request accepted."
end



def decline
  friend = User.find(params[:id])
  current_user.decline_friend_request(friend)
  redirect_to friends_path, notice: "Friend request declined."
end
end
