class Fave < ActiveRecord::Base
  has_many :user_faves
  has_many :users through: :user_faves
end
