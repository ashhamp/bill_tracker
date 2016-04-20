class BillsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bills = Bill.where(user: current_user).order(:next_due_date)
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)

    @start_due_date = params[:bill][:start_due_date]
    @bill.next_due_date = @start_due_date
    @bills = Bill.where(user: current_user)

    if @bill.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Bill added successfully!"
          redirect_to bills_path
        end
        format.json { render json: { bill: @bill } }
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = @bill.errors.full_messages.join(". ")
          render :index
        end
        @errors = @bill.errors.full_messages.join(". ")
        format.json { render json: { error: @errors } }
      end
    end
  end

  def show

    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])

    if @bill.update_attributes(bill_params)
      flash[:notice] = "Bill updated successfully!"
      redirect_to bill_path(@bill)
    else
      flash[:error] = @bill.errors.full_messages.join(". ")
      render :show
    end
  end

  private

  def bill_params
    params.require(:bill).permit(
      :nickname,
      :url,
      :start_due_date,
      :recurring_amt,
      :one_time,
      :next_due_date,
    ).merge(user: current_user)
  end
end
