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
inem = Organization.create(:name => "INEM", :country => "Brazil")

# Criar utilizadores de exemplo

diogo = User.find_or_create_by!(email: 'diogo@example.com') do |user|
  user.organization = comar
  user.clearance = :secreto
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

nuno = User.find_or_create_by!(email: 'nuno@example.com') do |user|
  user.organization = mrcc
  user.clearance = :privado
  user.role = :p2
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

adilson = User.find_or_create_by!(email: 'adilson@example.com') do |user|
  user.organization = inem
  user.clearance = :secreto
  user.role = :p3
  user.password = 'change'
  user.password_confirmation = 'change'
  user.confirm!
end

# Criar situacoes de exemplo
primeira = Situation.create(:user => adilson, :organization => adilson.organization, :name => "Homem ao mar", :description => "Este e um evento nacional que esta relacionado com a potencial existencia de um naufrago que caiu ao mar no brazil", :level => :local, :sensitivity => :publico)
segunda = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Poluicao no guincho", :description => "Este que esta relacionado com a potencial existencia de poluiacao no Guincho. Coitadinhas das focas.", :level => :national, :sensitivity => :publico)
terceira = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Homicidio no guincho", :description => "Este e um evento Internacional que esta relacionado com um potencial homicidio no guincho", :level => :national, :sensitivity => :privado)
quarta = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Terrorismo no guincho", :level => :international, :sensitivity => :secreto)
quinta = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Navio Empanado", :level => :international, :sensitivity => :privado)
sexta = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Navio Afundado", :level => :national, :sensitivity => :secreto)
setima = Situation.create(:user => diogo, :organization => diogo.organization, :name => "Apanha de ostras", :level => :local, :sensitivity => :privado)

# Criar participacoes de exemplo
primeira.organizations << [inem]
segunda.organizations << [comar, mrcc]
terceira.organizations << [mrcc, comar]
quarta.organizations << [mrccn, comar]
quinta.organizations << [mrccn, inem, comar]
sexta.organizations << [comar]
setima.organizations << [mrcc, comar]


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
