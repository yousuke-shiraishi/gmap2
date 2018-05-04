class MembersController < ApplicationController
  before_action :set_member, only: %i[edit show update]

require 'date'

  def search
    if params[:public]
      @member=Member.where('name = ? AND birth = ?',params[:name],params[:birth])
      @gmaps = @member.joins(:gmaps).where('magic_word = ?',"").map {|member| member.gmaps}.flatten.uniq
      render template: 'gmaps/index'
    else
      @gmaps=Gmap.joins(:member).where('magic_word = ? AND magic_word != ? AND email = ?' ,params[:magic_word] ,"",params[:email])
      render template: 'gmaps/index'
    end
  end

  def downloadpdf
    file_name="gmapsの理念.pdf"
    filepath = Rails.root.join('public',file_name)
    stat = File::stat(filepath)
    send_file(filepath, filename: :file_name, length: :stat.size)
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
