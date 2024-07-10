class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @q = Post.published.includes([:rich_text_translations]).ransack(params[:q])
    @q.sorts = "created_at desc" if @q.sorts.blank?
    @pagy, @posts = pagy(@q.result, items: 5, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.friendly.find(params[:id])
  end
end
