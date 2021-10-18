class User < ApplicationRecord
  include Clearance::User 
  has_one_attached :avatar
end
