require 'mail'

class SantaMailer
	def create_emails(assignments:)
		assignments.map { |a|
			Mail.new do
				from 'santa@thenorthpole.com'
				to a.giver.email
				subject 'A message from the North Pole'
				body File.read("#{Dir.pwd}/lib/email_template.txt").gsub("[RECIPIENT_NAME]", a.recipient.name).gsub("[GIVER_NAME]", a.giver.name)
			end
		}
	end
end