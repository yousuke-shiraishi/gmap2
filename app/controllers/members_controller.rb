class MembersController < ApplicationController
  before_action :set_member, only: :show

  def search
    if params[:public]
      @member = Member.where('name = ? AND birth = ?', params[:name], params[:birth])
      @gmaps = @member.joins(:gmaps).where('magic_word = ?', '').map(&:gmaps).flatten.uniq
    else
      @gmaps = Gmap.joins(:member).where('magic_word = ? AND magic_word != ? AND email = ?' ,params[:magic_word] ,"",params[:email])
    end
    render 'gmaps/index'
  end

  def downloadpdf
    file_name = 'gmapsの理念.pdf'
    filepath = Rails.root.join('public', file_name)
    stat = File.stat(filepath)
    send_file(filepath, filename: file_name, length: stat.size)
  end

  def show; end

  def dispatching
    if member_signed_in?
      redirect_to new_gmap_path
    else
      redirect_to new_member_session_path
    end
  end

  private

  def set_member
    @member = current_member
  end
end
