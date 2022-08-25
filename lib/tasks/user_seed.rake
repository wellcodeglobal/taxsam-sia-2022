# frozen_string_literal: true

namespace :user do
  desc 'User and Roles'
  task seed: :environment do
    Company.destroy_all
    User.destroy_all

    company = Company.find_or_initialize_by(
      name: "Taxsam",
      codename: 'TXSM',
      slug: "txsm",
      address: "Sudirman Park"
    )
    company.save!

    user = User.find_or_initialize_by(email: "admin@taxsam.co")
    user.password = "password"
    user.company = company
    user.save!
    user.add_role :admin
    user.add_role :super_admin


    company = Company.find_or_initialize_by(
      name: "Wellcode",
      codename: 'WG',
      slug: "wellcode",
      address: "Sudirman Park"
    )
    company.save!

    user = User.find_or_initialize_by(email: "admin@wellcode.io")
    user.password = "password"
    user.company = company
    user.save!
    user.add_role :admin
    user.add_role :super_admin
  end
end