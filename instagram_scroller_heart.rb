require 'watir'

class InstagramScroller
  def initialize(username, password)
    @username = username
    @password = password
    @browser = Watir::Browser.new(:chrome)
  end

  def scroll_and_heart_posts
    begin
      @browser.goto('https://www.instagram.com/')
      @browser.text_field(name: 'username').set(@username)
      @browser.text_field(name: 'password').set(@password)
      @browser.button(text: 'Log In').click
      @browser.element(class: 'coreSpriteDesktopNavLogoAndWordmark').wait_until_present

      loop do
        puts 'Press enter to scroll or type "stop scroll" to end.'
        input = gets.chomp

        break if input.downcase == 'stop scroll'

        @browser.driver.execute_script('window.scrollBy(0, window.innerHeight);')
        sleep 1
        heart_buttons = @browser.elements(class: 'coreSpriteHeartOpen')
        heart_buttons.each { |button| button.click }
      end

    rescue StandardError => e
      puts "An error occurred: #{e.message}"

    ensure
      @browser.close if @browser
    end
  end
end

print 'Enter your Instagram username: '
username = gets.chomp

print 'Enter your Instagram password: '
password = gets.chomp

instagram_scroller = InstagramScroller.new(username, password)
instagram_scroller.scroll_and_heart_posts
