require 'santa_shuffler'
require 'person'
require 'assignment'

RSpec.describe SantaShuffler do
	describe "#shuffle" do
		let(:person1) { Person.new(name: "Person 1", email: "person1@example.com") }
		let(:person2) { Person.new(name: "Person 2", email: "person2@example.com") }
		let(:person3) { Person.new(name: "Person 3", email: "person3@example.com") }

		let(:result) { SantaShuffler.new().shuffle(participants: [person1, person2, person3]) }

		it "does not assign any person to get themself a gift" do
			result.each { |assignment|
				expect(assignment.giver).not_to eq(assignment.recipient)
			}
		end
	end
end