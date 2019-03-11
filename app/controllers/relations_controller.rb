class RelationsController < ApplicationController
  before_action :set_user, :set_profile
  before_action :relation_params, :set_relation, only: [:edit, :destroy]

  def index
    authorize @user, :show?
    set_notifications
    @caretaker_relations = @profile.caretaker_relationships.where(state: true)
    @patient_relations = @profile.patient_relationships.where(state: true)
    @pendings = @profile.pending_caretaker_requests.where.not(sender_id: @profile.id)
    @pendings += @profile.pending_patient_requests.where.not(sender_id: @profile.id)
  end

  def edit
    authorize @user, :show?
    @relation.state = true
      if @relation.save
        redirect_to profile_relations_path(@profile),
        notice: "You accepted the relation"
      else
        redirect_to profile_relations_path(@profile),
        alert: "Ops! somthing whent wrong."
      end
  end

  def new_caretaker
    authorize @user, :show?
    @relation = Relation.new
  end

  def create_caretaker
    authorize @user, :show?
    # get email from input
    user_email = set_email[:email]
    # find user for caretaker
    caretaker = User.find_by(email: user_email)
    # handle user not found
    if caretaker.nil?
      redirect_to profile_new_caretaker_path(@profile), alert: "User not found!"
    else
      relation = Relation.new(caretaker_id: caretaker.id, patient_id: @profile.id, state: false, sender_id: @profile.id)
      if relation.save
        redirect_to profile_relations_path(@profile),
        notice: "You added #{caretaker.first_name} as caretaker to #{@profile.first_name}"
      else
        redirect_to profile_new_caretaker_path(profile_id: @profile), alert: "#{caretaker.first_name} is already a caretaker!"
      end
    end
  end

  def new_patient
    authorize @user, :show?
    @relation = Relation.new
  end

  def create_patient
    authorize @user, :show?
    # get email from input
    user_email = set_email[:email]
    # find user for caretaker
    patient = User.find_by(email: user_email)
    # handle user not found
    if patient.nil?
      redirect_to profile_new_patient_path(profile_id: @profile), alert: "User not found!"
    else
      relation = Relation.new(caretaker_id: @profile.id, patient_id: patient.id, state: false, sender_id: patient.id)
      if relation.save
        redirect_to profile_relations_path(@profile),
        notice: "You added #{patient.first_name} as patient to #{@profile.first_name}"
      else
        redirect_to profile_new_patient_path(profile_id: @profile), alert: "#{patient.first_name} is already a patient!"
      end
    end
  end

  def destroy
    authorize @user, :show?
    if @relation.destroy
      redirect_to profile_relations_path(@profile),
      notice: "You deleted that relation."
    else
      redirect_to profile_relations_path(@profile),
      alert: "Ops! somthing whent wrong."
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_profile
    @profile = User.find(params[:profile_id])
  end

  def set_relation
    @relation = Relation.find[params[:id]]
  end

  def set_notifications
    # get all notifications for current user only not dismissed and ordered by date
    @notifications = policy_scope(@user.notifications).where(dismissed: false).order(created_at: :desc)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def relation_params
    params.require(:relation).permit(:id)
  end

  def set_email
    params.require(:relation).permit(:email)
  end
end
