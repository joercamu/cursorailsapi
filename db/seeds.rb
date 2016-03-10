# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email:"joercamu@gmail.com",uid:"lkn2lk2jn3423k4jnb234",provider:"facebook")
object = MyObject.create(
	title:"llaves de carro",
	description:"me encontre en el restaurante la niebla en el km18 unas lleves de un carro toyota",
	user:user)