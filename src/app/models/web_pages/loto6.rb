class WebPages::Loto6 < WebPage
  def url
    'https://www.mizuhobank.co.jp/retail/takarakuji/check/loto/loto6/index.html'
  end

  def times
    times = driver.find_element(:css, 'table.typeTK thead tr th:nth-child(2)').text
    m = Regexp.new('第([0-9]{1,})回').match(times)
    raise NoMatchingPatternError if m.nil? || m[1].nil?

    m[1]
  end
end
