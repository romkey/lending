class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :fulfill, :return, :cancel]
  before_action :authenticate_user!

#  load_and_authorize_resource

  # GET /loans
  # GET /loans.json
  def index
    unless current_user.present?
      raise ActionController::RoutingError.new('Not Found')
    end

    if current_user.admin?
      @loans = Loan.all
    else
      @loans = current_user.loans
    end

    if params.has_key?(:overdue)
      @loans = @loans.where('due_at IS NOT NULL AND due_at < ?', Time.now).order(due_at: :desc)
    end

    if params.has_key?(:new_loans)
      @loans = @loans.where('fulfilled_at IS NULL').order(created_at: :desc)
    end

    if params.has_key?(:returned)
      @loans = @loans.where('returned_at IS NOT NULL').order(created_at: :desc)
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    if current_user != @loan.user && !current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # GET /loans/new
  def new
    unless current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    end

    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(params.permit(:item_id))

    item = @loan.item
    item.status = :on_loan
    item.save!

    @loan.user = current_user
    @loan.requested_at = Time.now

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def fulfill
    @loan.fulfilled_at = Time.now
    @loan.due_at = @loan.fulfilled_at + @loan.item.max_loan_days.days

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully fulfilled.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def return
    @loan.returned_at = Time.now

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully returned.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    item = @loan.item
    item.status = :available
    item.save

    @loan.returned_at = Time.now

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully cancelled.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    if current_user != @loan.user && !current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    end

    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:user_id, :item_id, :requested_at, :fulfilled_at, :returned_at, :status)
    end
end
