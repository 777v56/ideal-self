class User::RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update , :edit]

  def show
    @user = User.find(params[:id])
    @record = Record.new
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @records = @user.records.where(input_date: @month.all_month).order("input_date ASC")
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id # user_idの情報はフォームからはきていないので、deviseのメソッドを使って「ログインしている自分のid」を代入
    if @record.save
      redirect_to record_path(current_user.id), notice: "記録しました。"
    else
      flash[:alert] = "記録に失敗しました。"
      render record_path(current_user.id)
    end
  end

  def edit
    @user = current_user
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.user_id = current_user.id
    @record.update(record_params)
    redirect_to record_path(current_user.id), notice:  "更新しました。"
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to record_path(current_user.id), notice: "削除しました。"
  end

  private

  def record_params
    params.require(:record).permit(:weight, :fat, :input_date, :waist, :muscle)
  end

  def ensure_correct_user
    @record = Record.find(params[:id])
    unless @record.user == current_user
      redirect_to user_path(current_user.id), notice: "権限がありません。"
    end
  end

end
