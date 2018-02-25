class MembersController < ApplicationController
  before_action :set_member, only: %i[edit show update]
require 'date'
  def search
    if params[:public]
  #    binding.pry
      @member=Member.where('name = ? AND birth = ?',params[:name],params[:birth])
    #  binding.pry
      @gmaps = @member.joins(:gmaps).where('magic_word = ?',"").map {|member| member.gmaps}.flatten.uniq.reject{|item| item.magic_word != ""}
      render template: 'gmaps/index'
    else
      @member=Member.where('email = ?',params[:email])
      @gmaps=@member.joins(:gmaps).where('magic_word = ?',params[:magic_word]).map {|member| member.gmaps}.flatten.uniq.reject{|item| item.magic_word == ""}
      render template: 'gmaps/index'
    end
  end

  def touroku
    if member_signed_in? then
      redirect_to new_gmap_path
    else
      redirect_to new_member_session_path
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

end
