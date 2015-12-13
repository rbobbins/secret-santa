require 'mail'

class SantaMailer
	def create_emails(assignments:)
		assignments.map { |a|
			Mail.new do
				from 'santa@thenorthpole.com'
				to a.giver.email
				subject 'A message from the north pole'
				body "Give a gift to #{a.recipient.name}"
			end
		}
	end
end