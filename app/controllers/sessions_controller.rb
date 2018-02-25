class SessionsController < ApplicationController
  # def new
  # end
  #
  # def create
  #    member = Member.find_by(email: params[:session][:email].downcase)
  #     if member && member.authenticate(params[:session][:password])
  #       # ログイン成功した場合
  #       session[:member_id] = member.id
  #       redirect_to member_path(member.id)
  #     else
  #       flash[:danger] = 'ログインに失敗しました'
  #       redirect_to new_session_path
  #     end
  # end
  #
  # def destroy
  #    session.delete(:member_id)
  #    flash[:notice] = 'ログアウトしました'
  #    redirect_to new_session_path
  # end


def new
  super
end

def create
  super
end

end
