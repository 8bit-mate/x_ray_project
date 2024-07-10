class Admin::PostsController < ApplicationController
  include AdministrableController

  before_action :set_post, only: %i[show edit update destroy publish]

  # GET /posts or /posts.json
  def index
    @q = Post.all.includes([:rich_text_translations]).ransack(params[:q], auth_object: :admin)
    @q.sorts = "created_at desc" if @q.sorts.blank?
    @pagy, @posts = pagy(@q.result, items: 4, anchor_string: 'data-turbo-stream="true"')
  end

  def publish
    @post.published = true
    @post.save

    redirect_to admin_posts_url, notice: "Post #{@post.title} was published."
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new

    update_post

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    update_post

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def update_post
    @post.published = post_params[:published]

    @post.title_en = post_params[:title_en]
    @post.title_ru = post_params[:title_ru]

    I18n.with_locale(:en) { @post.body = post_params[:body_en] }
    I18n.with_locale(:ru) { @post.body = post_params[:body_ru] }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(
      :published,
      :title_en,
      :title_ru,
      :body_en,
      :body_ru
    )
  end
end
