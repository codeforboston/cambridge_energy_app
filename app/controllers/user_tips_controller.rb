class UserTipsController < ApplicationController
  before_action :set_user_tip, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, except: [:index]

  # GET /user_tips
  # GET /user_tips.json
  def index
    @user_tips = policy_scope(UserTip)
  end

  # GET /user_tips/1
  # GET /user_tips/1.json
  def show
  end

  # GET /user_tips/new
  def new
    @user_tip = UserTip.new
  end

  # GET /user_tips/1/edit
  def edit
  end

  # POST /user_tips
  # POST /user_tips.json
  def create
    @user_tip = UserTip.new(user_tip_params)
    respond_to do |format|
      if @user_tip.save
        if @user_tip.result == "Disliked"
          Tip.next_tip(current_user)
        end
        format.js {}
      else
      end
    end
  end

  # PATCH/PUT /user_tips/1
  # PATCH/PUT /user_tips/1.json
  def update
    respond_to do |format|
      if @user_tip.update(user_tip_params)
        format.html { redirect_to @user_tip, notice: 'User tip was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_tip }
      else
        format.html { render :edit }
        format.json { render json: @user_tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_tips/1
  # DELETE /user_tips/1.json
  def destroy
    @user_tip.destroy
    respond_to do |format|
      format.html { redirect_to user_tips_url, notice: 'User tip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_tip
      @user_tip = UserTip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_tip_params
      params.require(:user_tip).permit(:user_id, :tip_id, :result, :feedback)
    end
end
