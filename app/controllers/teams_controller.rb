class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:authorize_user, :show, :edit, :update, :destroy, :invite, :inviting, :leave]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy, :invite, :inviting, :leave]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    @user = current_user
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @user = User.find(current_user.id)
    @user.team = @team
    @user.save
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Leave team
  def leave
    @user = current_user
    @user.team = nil
    @user.save
    @team.destroy if @team.users.empty?

    respond_to do |format|
      format.html { redirect_to '/users/me', notice: 'You have left the team.' }
      format.json { render :show, status: :ok, location: @user }
    end
  end

  def leaderboard
    @user = current_user
    @teams = Team.by_score
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    def authorize_user
      unless @team.id == current_user.team_id
        flash[:error] = "You do not have permission."
        redirect_to users_me_path(current_user), notice: "Access denied."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :image_url)
    end
end
