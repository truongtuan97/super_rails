class UsersController < ApplicationController
  def index
    # @pagy, @users = pagy(User.all.order(created_at: :desc))

    @q = User.order(created_at: :desc).ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true))
  end

  def show
    @user = User.find(params[:id])
  end
end
