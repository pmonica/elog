 # This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Criar organizacoes de exemplo
orgadmin = Organization.create(:name => "ADMIN", :active => true, :country => "International")
orgadmin.organization =orgadmin
crimgo_org = Organization.create(:name => "CRIMGO Team", :active => true, :country => "International", :organization => orgadmin)


# Criar administrador
  user = CreateAdminService.new.call
  user.name = "Admin"
  user.organization = orgadmin
  user.clearance = :Secret
  user.role = :admin
  user.save!


