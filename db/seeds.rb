# This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

# Criar organizacoes de exemplo
mrcc = Organization.create(:name => "MRCC", :country => "Portugal")
comar = Organization.create(:name => "COMAR", :country => "Portugal")
mrccn = Organization.create(:name => "MRCC", :country => "Nigeria")
fake = Organization.create(:name => "FakeOrg", :country => "Brazil")

# Criar utilizadores de exemplo

diogo = User.find_or_create_by!(email: 'diogo@example.com') do |user|
  user.organization = comar
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

nuno = User.find_or_create_by!(email: 'nuno@example.com') do |user|
  user.organization = mrcc
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

paulo = User.find_or_create_by!(email: 'paulo@example.com') do |user|
  user.organization = mrccn
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end


# Criar situacoes de exemplo
primeira = Situation.create(:name => "Homem ao mar", :description => "Este e um evento nacional que esta relacionado com a potencial existencia de um naufrago que caiu ao mar", :level => :local, :sensitivity => :publico)
segunda = Situation.create(:name => "Poluicao no guincho", :description => "Este que esta relacionado com a potencial existencia de poluiacao no Guincho. Coitadinhas das focas.", :level => :local, :sensitivity => :publico)
terceira = Situation.create(:name => "Homicidio no guincho", :description => "Este e um evento Internacional que esta relacionado com um potencial homicidio no guincho", :level => :internacional, :sensitivity => :publico)
quarta = Situation.create(:name => "Terrorismo no guincho", :level => :internacional, :sensitivity => :secreto)

# Criar participacoes de exemplo
primeira.organizations << [mrcc, comar]
segunda.organizations << [mrcc]
terceira.organizations << [mrccn, comar]

# Criar events
evento1 = Event.create(:user => diogo, situation: primeira, sensitivity: :publico, level: :local, title: "O homem caiu ao mar na figueira da foz")
evento2 = Event.create(:user => diogo, situation: primeira, sensitivity: :secreto, level: :local, title: "O morto foi identificado")

evento3 = Event.create(:user => diogo, situation: terceira, sensitivity: :publico, level: :local, title: "Homem matou outro na praca")
evento4 = Event.create(:user => diogo, situation: terceira, sensitivity: :privado, level: :local, title: "Encontrada a arma do crime")

evento5 = Event.create(:user => diogo, situation: quarta, sensitivity: :secreto, level: :local, title: "Foi encontrada uma bomba na praca")

# Criar comments

c = Comment.create(:body => "O homem tinha uma tshirt vermelha", :event => evento1, :user => diogo)
c = Comment.create(:body => "O homem tinha uma mulher feiosa", :event => evento1, :user => diogo, :sensitivity => :secreto)

c = Comment.create(:body => "O homem matou o outro com uma faca", :event => evento3, :user => diogo)
c = Comment.create(:body => "A faca tinha 30 Cms", :event => evento4, :user => diogo)
c = Comment.create(:body => "A faca tinha um cabo metalico", :event => evento4, :user => diogo)
c = Comment.create(:body => "A faca tinha era afiada", :event => evento4, :user => diogo)


c = Comment.create(:body => "A bomba era amarela", :event => evento5, :user => diogo)
