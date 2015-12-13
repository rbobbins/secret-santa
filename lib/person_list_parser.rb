require 'yaml'
require_relative 'person'

class PersonListParser
	def parse(file:)
		people = YAML.load(file)["people"]
		people.map { |person_hash| Person.new(name: person_hash["name"], email: person_hash["email"]) }
	end
end