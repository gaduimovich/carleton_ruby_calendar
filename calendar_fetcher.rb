
class CalendarFetcher
  def initialize(mechanize)
    @mechanize = mechanize
  end

  def fetch_calendar(year, term)
    term_in = year;
    case term
    when "Winter"
      term_in.concat("10")
    when "Summer"
      term_in.concat("20")
    when "Fall"
      term_in.concat("30")
    else
      puts "Error no such term\n"
    end

    calendar = @mechanize.post("https://central.carleton.ca/prod/bwskfshd.P_CrseSchdDetl", "term_in" => term_in)

    calendar.search("table.plaintable td.pldefault").each do |n|
      if n.text.strip == "You are not currently registered for the term." then
        return []
      end
    end

    class_names = []
    data = []

    calendar.search("table.datadisplaytable th.ddtitle").each do |name|
     class_names.push(name.text.strip)
   end

   calendar.search("table.datadisplaytable tr").each do |tr|
     tr.search("td.dddefault").each do |td|
      data.push(td.text.strip)
    end
  end

  courses = []  
  counter = 0
  class_names.each do |name|
   courses.push(Course.new(name, data[counter..counter+14]))
   counter += 15
 end

 return courses
end
end
