class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

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

  # POST /bills
  # POST /bills.json
  def create
    @bill = current_or_guest_user.bills.new(bill_params)
    @bill.unit = Unit.new(bill_unit_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
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

    def bill_unit_params
      allowed_params[:units]
    end

    def bill_params
      extracted_date = allowed_params.except(:units)
      # The following parses dates such as 1/28/2015 into the proper date format
      extracted_date["bill_received(1i)"] = Date._parse(extracted_date["bill_received"])[:mon].to_s
      extracted_date["bill_received(2i)"] = Date._parse(extracted_date["bill_received"])[:mday].to_s
      extracted_date["bill_received(3i)"] = Date._parse(extracted_date["bill_received"])[:mon].to_s
      extracted_date.delete("bill_received")
      extracted_date
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_params
      params.require(:bill).permit(:bill_received, :amount, :units => [:number_occupants])
    end
end
