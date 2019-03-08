class RelationsController < ApplicationController
  before_action :set_user, :set_profile

  def new_caretaker
    authorize @user, :show?
    @relation = Relation.new
  end

  def create_caretaker
    authorize @user, :show?
    # get email from input
    user_email = set_params[:email]
    # find user for caretaker
    caretaker = User.find_by(email: user_email)
    # handle user not found
    redirect_to profile_new_caretaker_path(profile_id: @profile), alert: "User not found!" if caretaker.nil?
    relation = Relation.new(caretaker_id: caretaker.id, patient_id: @profile.id, state: false)
    if relation.save
      redirect_to profile_path(@profile),
      notice: "You added #{caretaker.first_name} as caretaker to #{@profile.first_name}"
    else
      redirect_to profile_new_caretaker_path(profile_id: @profile), alert: "#{caretaker.first_name} is already a caretaker!"
    end
  end

  def new_patient
    authorize @user, :show?
    @relation = Relation.new
  end

  def create_patient
    authorize @user, :show?
    # get email from input
    user_email = set_params[:email]
    # find user for caretaker
    patient = User.find_by(email: user_email)
    # handle user not found
    redirect_to profile_new_patient_path(profile_id: @profile), alert: "User not found!" if patient.nil?
    relation = Relation.new(caretaker_id: @profile.id, patient_id: patient.id, state: false)
    if relation.save
      redirect_to profile_path(@profile),
      notice: "You added #{patient.first_name} as patient to #{@profile.first_name}"
    else
      redirect_to profile_new_patient_path(profile_id: @profile), alert: "#{patient.first_name} is already a patient!"
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_profile
    @profile = User.find(params[:profile_id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def set_params
    params.require(:relation).permit(:email)
  end
end
