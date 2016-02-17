require "mechanize"
require "./authenticator"
require "./calendar_fetcher"
require './course'


class CarletonCalendar
	def initialize(student_number, pin)
	    @mechanize = Mechanize.new { |agent|
	      agent.user_agent_alias = 'Mac Safari'
	    }
	    authenticator = Authenticator.new(@mechanize)
	    authenticator.login(student_number, pin)
	 end

	 def start()

			year = ""
			term = ""

			puts "Enter the year of the calendar you want: "
			while line = gets.chomp
				puts "Enter the year of the calendar you want: "
			  if (line =~ /\A\d{4}\z/) then
			  	year << line
					break
				end
			end

			puts "Enter the Semester(Winter, Summer, Fall):"
			while line = gets.chomp
				puts "Enter the Semester(Winter, Summer, Fall):"
				if (line =~ /(Winter|Summer|Fall)/) then
					term << line
					break
				end
			end

			calendar = CalendarFetcher.new(@mechanize)
			courses = calendar.fetch_calendar(year, term)

			unless courses.empty? then
				courses.each do |item|
					item.print()
				end
			else
				puts "Nothing to See"
			end

	 end

end

if ARGV.length == 2 then
	if ARGV[0] =~ /^[0-9]*$/ && ARGV[1] =~ /^[0-9]*$/ then
		carl = CarletonCalendar.new(ARGV.shift, ARGV.shift)
		carl.start()
	else
		puts "Try Again: student_number pin"
	end
else
    puts "Restart with more Args!"
end
