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

    if Rails.env.production?
      @driver = Selenium::WebDriver.for(
        :chrome,
        options:,
      )
    else
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 180
      @driver = Selenium::WebDriver.for(
        :remote,
        url: "http://#{ENV.fetch('TEST_SELENIUM_SERVER', nil)}:4444",
        capabilities: [options],
        http_client: client,
      )
    end
    @driver.manage.timeouts.implicit_wait = 10
    @driver
  end

  def options
    return @options if @options.present?

    @options = Selenium::WebDriver::Options.chrome
    @options.add_argument('--headless')
    @options
  end

  def parse_by_css_selector(sourse, css_selector)
    documents = Nokogiri::HTML.parse(sourse)
    documents.css(css_selector)
  end

  delegate :close, to: :driver

  delegate :quit, to: :driver
end
