class GmapsController < ApplicationController
  before_action :set_gmap, only: %i[edit show update]
  before_action :authenticate_member!, only: %i[new edit update destroy]
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
    @gmap = current_member.gmaps.build(gmap_params)
    render :new if @gmap.invalid?
  end


  # POST /gmaps
  # POST /gmaps.json
  def create
    @gmap = Gmap.new(gmap_params)
  #  @gmap.image.retrieve_from_cache! params[:cache][:icreated_atmage]
    @gmap.member_id = current_member.id # 現在ログインしているmemberのidをpictureのmember_idカラムに挿入する。
    #キャッシュから画像を復元する
  #  GmapstoMailer.gmapto_mail(@gmap.member).deliver
    respond_to do |format|
      if @gmap.save
        flash[:success] = "マーカーを作るのに成功しました"
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @gmap }
      else
        flash[:danger] = "マーカーを作るのに失敗しました"
        format.html { render :new}
        format.json { render json: @gmap.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy_images
    @gmap = Gmap.find(params[:q])
    #@gmap = Gmap.find(params[:marker])
    @gmap.destroy if (@gmap.member_id == current_member.id)
    #binding.pry
    #render json: success if (@gmap.member_id == current_member.id)
    render json: {gmap:  @gmap} if @gmap.destroyed?
   end
  # PATCH/PUT /gmaps/1
  # PATCH/PUT /gmaps/1.json
  def update
    respond_to do |format|
      if @gmap.update(gmap_params)
        format.html { redirect_to @gmap,flash[:success] =  'Gmapデータがアップデートされました' }
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
     @gmap.destroy #if (@gmap.member == current_member) and (Time.now - @gmap.created_at > 1.minutes)
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
