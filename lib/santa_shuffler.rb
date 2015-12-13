require 'set'

class SantaShuffler
	def shuffle(participants:)
		participants.shuffle!

		assignments = participants.each_with_index.map { |person, index|
			giver = person
			recipient = nil
			if person == participants.last
				recipient = participants.first
			else
				recipient = participants[index + 1]
			end

			Assignment.new(giver: giver, recipient: recipient)
		}
		Set.new assignments
	end
end