# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :uuid             not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  confirmation_token :string(128)
#  remember_token     :string(128)      not null
#  company_id         :uuid
#
class User < ApplicationRecord
  rolify
  include Clearance::User
  has_one_attached :avatar
  belongs_to :company
end
