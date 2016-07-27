class TeamsController < ApplicationController
  before_action :set_team, only: [:authorize_user, :show, :edit, :update, :destroy, :invite, :inviting, :leave]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy, :leave]

  # GET /teams
  # GET /teams.json
  def index
    @teams = policy_scope(Team)
    @user = current_user
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
    authorize @team
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    authorize @team
    current_user.update team: @team

    respond_to do |format|
      if @team.persisted?
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
    current_user.update team: nil
    @team.destroy if @team.users.empty?

    respond_to do |format|
      format.html { redirect_to '/users/me', notice: 'You have left the team.' }
      format.json { render :show, status: :ok, location: current_user }
    end
  end

  def leaderboard
    authorize Team, :leaderboard?
    @user = current_user
    @teams = policy_scope(Team).by_score
  end

  def accept_or_decline
    authorize Team, :accept_or_decline?
    if invite_params[:accept]
      accept_invite
    elsif invite_params[:decline]
      decline_invite
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    def authorize_user
      authorize @team
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :image_url)
    end

    def invite_params
      params.permit(:decline, :accept)
    end

    def accept_invite
      if current_user.invited_by_id
        current_user.accept_invite
        @team = current_user.team
        flash[:notice] = "You have joined #{current_user.team.name}!"
        redirect_to team_path(@team)
      elsif current_user.team
        redirect_to team_path(current_user.team)
      else
        redirect_to :root
      end
    end

    def decline_invite
      if current_user.invited_by_id
        flash[:notice] = "#{current_user.inviter_team.name} will be sorry to hear it!"
        current_user.decline_invite
      end

      redirect_to :root
    end
end
