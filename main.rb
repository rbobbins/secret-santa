require 'optparse'
require './lib/santa_shuffler'
require './lib/santa_mailer'
require './lib/person_list_parser'
require 'io/console'


options = {}
OptionParser.new do |opts|
  	opts.banner = "Usage: main.rb [options]"

  	opts.on("-d", "--dry-run", "Prints Santa output w/o actually sending emails") do |dry_run|
    	options[:dry_run] = true
  	end

  	opts.on("-f", "--filepath FILEPATH", "Path to list of recipients, i.e 'guestlist.yml'") do |s|
  		options[:filepath] = s
  	end
    
    opts.on("-u", "--username USERNAME", "GMail username. Required for sending email") do |s|
      options[:username] = s
    end

    opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
    end
end.parse!

if !options[:dry_run]
  if !options[:username]
    puts "Gmail username is required for non dry-run"
    exit(1)
  end

  puts "Enter your GMail password (typing will be hidden):"
  password = STDIN.noecho(&:gets).chomp

  Mail.defaults do
    delivery_method :smtp, {
      :address => 'smtp.gmail.com',
      :port => '587',
      :user_name => options[:username],
      :password => password,
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  end
end

participants_file = File.open(options[:filepath])
participants = PersonListParser.new().parse(file: participants_file)
assignments = SantaShuffler.new().shuffle(participants: participants)
emails = SantaMailer.new().create_emails(assignments: assignments)

if options[:dry_run]
	emails.each { |e| 
    puts "***********"
    puts "TO: #{e.to}"
    puts "SUBJECT: #{e.subject}"
    puts "BODY:\n#{e.body}"
    puts "***********"
  }
else
	emails.each { |e|
    puts "Sending email to #{e.to}"
    e.deliver!
  }
end