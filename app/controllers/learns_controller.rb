class LearnsController < ApplicationController
  before_action :set_post, only: [:show, :update]

  # GET /learns
  # GET /learns.json
  def index
    @new_review_num = Post.where(user_id: current_user.id, num_answer: 0).where('next_time < ?', Time.now).count
    @review_num = Post.where(user_id: current_user.id).where('next_time < ?', Time.now).where.not(num_answer: 0).count

    @post = Post.where('next_time < ?', Time.now).order('next_time desc').first
  end

  # GET /learns/1
  # GET /learns/1.json
  def show
  end

  def complete
  end

  # POST /learns
  # POST /learns.json
  def create


    respond_to do |format|
      if @post.save
        if @next_post = Post.where('next_time < ?', Time.now).order('next_time desc').first
          redirect_path = learn_path(@next_post)
        else
          redirect_path = complete_learns_path
        end

        format.html { redirect_to redirect_path, notice: "次回は #{after_time} です。" }
        format.json { render :show, status: :created, location: @learn }
      else
        format.html { render :new }
        format.json { render json: @learn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learns/1
  # PATCH/PUT /learns/1.json
  def update
    understand_lv = params[:understand_lv].to_i
    if understand_lv == 3
      @post.num_correct = @post.num_correct + 1
    end


    since_val = next_time[@post.num_answer][understand_lv]
    @post.next_time = Time.now.since(since_val)

    if since_val >= 86400
      after_time = "#{since_val / 86400}日後"
    else
      after_time = "#{since_val / 60}分後"
    end

    @post.num_answer = @post.num_answer + 1

    respond_to do |format|
      if @post.save
        if @next_post = Post.where('next_time < ?', Time.now).order('next_time desc').first
          redirect_path = learn_path(@next_post)
        else
          redirect_path = complete_learns_path
        end

        format.html { redirect_to redirect_path, notice: "次回は #{after_time} です。" }
        format.json { render :show, status: :ok, location: redirect_path }
      else
        format.html { render :edit }
        format.json { render json: @learn.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def next_time

      next_time = [
        [ 3.minutes, 30.minutes, 1.days, 1.days ], #余裕0
        [ 3.minutes, 30.minutes, 1.days, 3.days ], #余裕1
        [ 3.minutes, 30.minutes, 1.days, 6.days ], #余裕2
        [ 3.minutes, 30.minutes, 1.days, 16.days ], #余裕3
        [ 3.minutes, 30.minutes, 1.days, 30.days ], #余裕4
        [ 3.minutes, 30.minutes, 1.days, 60.days ], #余裕5
        [ 3.minutes, 30.minutes, 1.days, 120.days ] #余裕6
      ]

      return next_time
    end
end
