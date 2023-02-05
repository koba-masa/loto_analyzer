# frozen_string_literal: true

class WebPage
  def user_agent
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36' # rubocop:disable Layout/LineLength
  end

  def sleep
    sleep(5)
  end

  def get(url)
    driver.navigate.to url
  end

  def driver
    return @driver if @driver.present?

    unless Rails.env.production?
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 180
      @driver = Selenium::WebDriver.for(
        :remote,
        url: 'http://selenium_server:4444',
        desired_capabilities: :chrome,
        http_client: client,
      )
    end
    @driver.manage.timeouts.implicit_wait = 10
    @driver
  end

  def options
    return @options if @options.present?

    @options = Selenium::WebDriver::Chrome::Options.new
    @options.add_argument('--headless')

    @options
  end

  delegate :close, to: :driver

  delegate :quit, to: :driver
end
