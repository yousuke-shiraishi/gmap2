class GmapsController < ApplicationController
  before_action :login_validate, only: %i[new edit show]
  before_action :set_gmap, only: %i[edit show update]
  # GET /gmaps
  # GET /gmaps.json
  require 'date'
  def index
    @gmaps = Gmap.where(magic_word: "")
  end

  # GET /gmaps/1
  # GET /gmaps/1.json
  def show
  end

  # GET /gmaps/new
  def new
     if params[:back]
     @gmap = Gmap.new(gmap_params)
     else
     @gmap = Gmap.new
     end
  end

  # GET /gmaps/1/edit
  def edit
  end
  def check
    #@gmap = Gmap.new(gmap_params)
    @gmap = current_user.gmaps.build(gmap_params)
    render :new if @gmap.invalid?
  end


  # POST /gmaps
  # POST /gmaps.json
  def create
    @gmap = Gmap.new(gmap_params)
  #  @gmap.image.retrieve_from_cache! params[:cache][:icreated_atmage]
    @gmap.user_id = current_user.id # 現在ログインしているuserのidをpictureのuser_idカラムに挿入する。
    #キャッシュから画像を復元する
  #  GmapstoMailer.gmapto_mail(@gmap.user).deliver
    # 省略
     #@gmap.user=current_user

    respond_to do |format|
      if @gmap.save
        #format.html { redirect_to @gmap, notice: 'Gmap was successfully created.' }
        format.html { redirect_to root_path notice: 'Gmap was successfully created.' }
        format.json { render :show, status: :created, location: @gmap }
      else
        format.html { render :new }
        format.json { render json: @gmap.errors, status: :unprocessable_entity }
      end
    end
  end
   def destroy_images
     @gmap = Gmap.find_by(params[:marker])
     @gmap.destroy if (@gmap.user == current_user)
     render json: success if (@gmap.user == current_user)
   end
  # PATCH/PUT /gmaps/1
  # PATCH/PUT /gmaps/1.json
  def update
    respond_to do |format|
      if @gmap.update(gmap_params)
        format.html { redirect_to @gmap, notice: 'Gmap was successfully updated.' }
        format.json { render :show, status: :ok, location: @gmap }
      else
        format.html { render :edit }
        format.json { render json: @gmap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gmaps/1
  # DELETE /gmaps/1.json
  def destroy
     @gmap = Gmap.find_by(params[:marker])
     @gmap.destroy #if (@gmap.user == current_user) and (Time.now - @gmap.created_at > 1.minutes)
  end

  def login_validate
    #  if !logged_in?
    #     redirect_to new_session_path
    if session[:user_id]
      begin
        @user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    redirect_to new_session_path unless @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gmap
      @gmap = Gmap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gmap_params
      params.require(:gmap).permit(:title, :coment, :magic_word, :latitude, :longitude,:image)
    end


end
