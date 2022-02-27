class PlansController < ApplicationController

  def index
    @plans = Plan.order("#{params[:column]} #{params[:sort]}")
    @all_day = { true: "○", false: "×" }
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plans_params)
    if @plan.save
      redirect_to root_path, flash: { notice: "スケジュールを作成しました" }
    else
      render 'new'
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @all_day = { true: "○", false: "×" }
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plans_params)
      redirect_to root_path, flash: { notice: "スケジュールを更新しました" }
    else
      render 'edit'
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    if @plan.destroy
      flash[:notice] = "スケジュールを削除しました"
    else
      flash[:alert] = "スケジュールを削除できませんでした"
    end
    redirect_to root_path

  end

  private

  def plans_params
    params.require(:plan).permit(
      :title, 
      :start_date, 
      :end_date, 
      :all_day, 
      :memo
    )
  end

end
