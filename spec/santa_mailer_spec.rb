require 'santa_mailer'

RSpec.describe SantaMailer do
	describe "#create_emails" do
		let(:person1) { Person.new(name: "Person 1", email: "person1@example.com") }
		let(:person2) { Person.new(name: "Person 2", email: "person2@example.com") }

		let(:assignments) {
			[Assignment.new(giver: person1, recipient: person2),
			Assignment.new(giver: person2, recipient: person1)]
		}

		let(:result) { SantaMailer.new().create_emails(assignments: assignments) }
		
		it "creates 1 email per participant" do
			expect(result.count).to eq(2)
		end

		it "includes the recipient name in the body" do
			email1 = result.first
			expect(email1.body).to include("to Person 2")

			email2 = result.last
			expect(email2.body).to include("to Person 1")

		end

		it "addresses the email to the giver" do
			email1 = result.first
			expect(email1.to).to eq(["person1@example.com"])

			email2 = result.last
			expect(email2.to).to eq(["person2@example.com"])

		end
	end
end