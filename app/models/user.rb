class User < ActiveRecord::Base
  has_many :user_favorites
  has_many :favorites, through: :user_favorites
end
