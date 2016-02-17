
class Authenticator
  def initialize(mechanize)
    @mechanize = mechanize
  end

  def login(studentNumber, pin)
    @mechanize.get('https://central.carleton.ca/prod/twbkwbis.P_WWWLogin') do |page|
      loginPage = page.form_with(:action => '/prod/twbkwbis.P_ValLogin') do |form|
        form.sid  = studentNumber
        form.PIN = pin
      end.submit
    end
  end
end
