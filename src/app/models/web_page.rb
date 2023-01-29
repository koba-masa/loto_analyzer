require 'open-uri'

class WebPage
  def user_agent
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'
  end

  def url
    raise NotImplementedError
  end

  def sleep
    sleep(5)
  end

  def get
    URI.open(url, 'User-Agent' => user_agent)
  end
end
