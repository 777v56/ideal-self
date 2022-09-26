class User::RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update , :edit]

  def show
    @user = User.find(params[:id])
    @record = Record.new
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    from = @month.beginning_of_month.beginning_of_day
    to = @month.end_of_month.end_of_day
    @records = @user.records.where(input_date: from..to).order("input_date ASC")
    @filter_records = []
    @records.each_with_index do |record, i|
      #byebug
      if i == 0
        next
      end
      if record[:weight].blank?
        record[:weight] = @records[i-1][:weight]
      end
      if record[:fat].blank?
        record[:fat] = @records[i-1][:fat]
      end
      if record[:muscle].blank?
        record[:muscle] = @records[i-1][:muscle]
      end
      if record[:waist].blank?
        record[:waist] = @records[i-1][:waist]
      end
     @filter_records.push(record)
    end
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
