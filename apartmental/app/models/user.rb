class User < ActiveRecord::Base
  has_many :user_faves
  has_many :faves, through: :user_faves
end
