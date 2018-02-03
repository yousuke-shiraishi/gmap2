class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show update]
require 'date'

  def search
    if params[:public]
      @user=User.where('name = ? AND birth = ?',params[:name],params[:birth]) if date_valid?(params[:birth])
      @gmaps = @user.joins(:gmaps).where('magic_word = ?',"").map {|user| user.gmaps}.flatten.uniq.reject{|item| item.magic_word != ""}
     render template: 'gmaps/index'
    else
      @user=User.where('email = ?',params[:email])
      @gmaps=@user.joins(:gmaps).where('magic_word = ?',params[:magic_word]).map {|user| user.gmaps}.flatten.uniq.reject{|item| item.magic_word == ""}
      render template: 'gmaps/index'
    end
  end

def edit
end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user
        session[:user_id] = @user.id
        #redirect_to user_path(@user.id)
        redirect_to root_path
      else
        flash[:danger] = 'ログインに失敗しました'
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    return redirect_to new_user_path unless user_params
    current_user.update(user_params)
    redirect_to root_path
  end

  def touroku

    if logged_in? then
      redirect_to new_gmap_path
    else
      redirect_to new_user_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    if params[:user]
      params.require(:user).permit(:id,:user_id,:name, :email, :password, :password_confirmation,:birth ,:image)
    else
      false
    end
  end

  def date_valid?(str)
     str.tr!("０-９","0-9")

if str.include?("年") and str.include?("月") and str.include?("日")
/(\d{4})年(\d{1,2})月(\d{1,2})日/ =~ str

str =[$1,$2,$3]


str=str.join("/")
end
    !! Date.parse(str) rescue false
  end
end
