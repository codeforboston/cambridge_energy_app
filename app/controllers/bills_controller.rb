class BillsController < ApplicationController
  before_action :set_bill, only: [:authorize_user, :show, :edit, :update, :destroy]
  before_action :authorize_user, only: [ :show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.all
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  #GET /bills/comparison
  def comparison
    @comparison_bills = Bill.joins(:unit).where('units.number_occupants' => current_or_guest_user.unit.number_occupants || 1).order(:amount)
    @most_recent_bill_id = current_or_guest_user.bills.last.id

    respond_to do |format|
      format.html
      format.json { render json: { current_user_id: current_or_guest_user.id, comparison_bills: @comparison_bills.as_json(), most_recent_bill_id: @most_recent_bill_id} }
    end
  end


  # POST /bills
  # POST /bills.json
  def create
    @bill = current_or_guest_user.bills.new(bill_params)
    @bill.unit = Unit.new(bill_unit_params)
    #current_or_guest_user.update(@bill.unit) if current_or_guest_user.unit.nil?

    respond_to do |format|
      if @bill.save
        current_or_guest_user.unit_id = @bill.unit.id
        current_or_guest_user.save!
        format.html { redirect_to '/graph/index' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def authorize_user
      unless @bill.user_id == current_user.id
        flash[:error] = "You do not have permission."
        redirect_to users_me_path(current_user), notice: "Access denied."
      end
    end

    def bill_unit_params
      allowed_params[:units]
    end

    def bill_params
      allowed_params.except(:units)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_params
      params.require(:bill).permit(:bill_received, :amount, :units => [:number_occupants])
    end
end
