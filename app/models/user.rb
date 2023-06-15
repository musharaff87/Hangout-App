class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  scope :all_except, -> (user) { where.not(id: user) }  
  
  after_create_commit { broadcast_append_to "users" }

  has_many :messages

  
  has_many :posts


  #validates :name, presence: true

  #attr_accessor :name, :about


  has_many :friendships, dependent: :destroy
  #has_many :friends, through: :friendships
  has_many :requested_friendships, foreign_key: :friend_id, class_name: 'Friendship', dependent: :destroy
  #has_many :friend_requests, through: :requested_friendships, source: :user

  
  has_many :friends, -> { merge(Friendship.accepted) }, through: :friendships, source: :friend
  has_many :friend_requests, -> { merge(Friendship.pending) }, through: :requested_friendships, source: :user
  #has_many :friends, -> { Friendship.accepted }, through: :friendships, source: :friend
  #has_many :friend_requests, -> { Friendship.pending }, through: :requested_friendships, source: :user


  def send_friend_request(friend)
    friendships.create(friend: friend, status: 'pending')
    puts "friend request sent"
  end
  
  def accept_friend_request(friend)
    #friendships.create(friend: friend)
    #friendship = requested_friendships.find_by(user_id: friend.id)
    friendship = requested_friendships.find_by(user_id: friend.id)
    friendships.create(friend: friend, status: 'accepted') if friendship
    friendship.update(status: 'accepted')
    #friendships.create(friend: friend)
    #friendship.destroy
    
  end

  def decline_friend_request(friend)
    friendship = requested_friendships.find_by(user_id: friend.id)
    friendship.destroy
  end


end
