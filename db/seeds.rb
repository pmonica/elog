# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

mrcc = Organization.create(:name => "MRCC", :country => "Portugal")
comar = Organization.create(:name => "COMAR", :country => "Portugal")
mrccn = Organization.create(:name => "MRCC", :country => "Nigeria")
fake = Organization.create(:name => "FakeOrg", :country => "Brazil")

primeira = Situation.create(:name => "Homem ao mar", :description => "Esta e nacional")
segunda = Situation.create(:name => "Poluicao no guincho", :description => "Esta e local mrcc")
terceira = Situation.create(:name => "Homicidio no guincho", :description => "Esta internacional")
quarta = Situation.create(:name => "Terrorismo no guincho")

primeira.organizations << [mrcc, comar]
segunda.organizations << [mrcc]
terceira.organizations << [mrccn, comar]
