class GmapsController < ApplicationController
  before_action :set_gmap, only: %i[edit show update]
  before_action :authenticate_member!, only: %i[new edit update destroy]

  def index
    @gmaps = Gmap.where(magic_word: '')
  end

  def show; end

  def new
    if params[:back]
      @gmap = current_member.gmaps.build(gmap_params)
    else
      @gmap = Gmap.new
    end
  end

  def edit; end

  def check
    @gmap = current_member.gmaps.build(gmap_params)
    render :new if @gmap.invalid?
  end

  def create
    @gmap = current_member.gmaps.build(gmap_params)
    respond_to do |format|
      if @gmap.save
        flash[:success] = 'マーカーを作るのに成功しました'
        format.html { redirect_to root_path }
      else
        flash[:danger] = 'マーカーを作るのに失敗しました'
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @gmap.update(gmap_params)
        format.html { redirect_to @gmap, flash[:success] = 'Gmapデータがアップデートされました' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @gmap = current_member.gmaps.find(params[:q])
      @gmap.destroy
      @status = 200
    else
      @status = 400
    end
    render json: { gmap: @gmap }, status: @status
  end

  private

  def set_gmap
    @gmap = current_member.gmaps.find(params[:id])
  end

  def gmap_params
    params.require(:gmap).permit(:title, :coment,
                                 :magic_word, :latitude, :longitude, :image)
  end
end
