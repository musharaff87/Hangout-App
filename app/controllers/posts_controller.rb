class PostsController < ApplicationController
    #before_action :authenticate_user!
  
    def index
      @posts = Post.all
    end

    def new
        @post = Post.new
      end
      
  
    def create
    @post = Post.new(post_params)
    @post.user = current_user

    @post.save
    puts "success submission"
  
    if @post.save
      redirect_to root_path, notice: "Post created successfully."
    else
      render :new
    end
  end
  
  private
  
  def post_params
    #params.require(:post).permit(:content)
    params.require(:post).permit(:content, :image)
  end
  end
  
  
