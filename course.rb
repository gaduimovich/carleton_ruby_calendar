class Course
  def initialize(name, data)
    @name = name
    @term = data[0]
    @crm = data[1]
    @status = data[2]
    @instructor = data[3]
    @grade_mode = data[4]
    @credits = data[5]
    @level = data[6]
    @campus = data[7]
    @type = data[8]
    @times = data[9]
    @days = data[10]
    @where = data[11]
    @range = data[12]
    @schedule_type = data[13]
    @instructors = data[14]
  end

  def print()
    puts @name
    puts @times
    puts @days
  end

end
