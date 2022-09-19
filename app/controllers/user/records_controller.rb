class User::RecordsController < ApplicationController

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
      flash[:notice] = "記録しました"
      redirect_to record_path(current_user.id)
    else
      flash[:alert] = "記録に失敗しました"
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
    flash[:notice] = "更新しました"
    redirect_to record_path(current_user.id)
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    flash[:notice] = "削除しました"
    redirect_to record_path(current_user.id)
  end

  private

  def record_params
    params.require(:record).permit(:weight, :fat, :input_date, :waist, :muscle)
  end

end
