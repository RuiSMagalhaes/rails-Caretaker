class Disease < ApplicationRecord
  has_many :user_diseases
  has_many :users, through: :user_diseases
end
