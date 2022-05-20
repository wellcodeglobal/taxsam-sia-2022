# frozen_string_literal: true

namespace :user do
  desc 'User and Roles'
  task seed: :environment do
    company = Company.find_or_initialize_by(
      name: "Taxsam",
      codename: 'TXSM',
      slug: "txsm",
      address: "Sudirman Park"
    )
    company.save!

    user = User.find_or_initialize_by(email: "admin@wellcode.io")
    user.password = "password"
    user.company = company

    user.save!

    user = User.find_or_initialize_by(email: "admin@taxsam.co")
    user.password = "password"
    user.company = company

    user.save
  end
end