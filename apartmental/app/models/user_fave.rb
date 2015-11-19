class UserFave < ActiveRecord::Base
  belongs_to :user
  belongs_to :fave
end
