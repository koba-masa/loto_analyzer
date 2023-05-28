# frozen_string_literal: true

class LotoResultCreationJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(kind)
    raise ArgumentError, "This kind is not defined.: #{kind}" unless Loto.kinds.key?(kind)

    # TODO: Discordに通知する処理を実装する

    @kind = kind

    lotos = Loto.where(kind: Loto.kinds[@kind]).order(times: 'ASC').includes(:loto_numbers)
    processed_lotos = to_json(lotos)
    create(processed_lotos)
  end

  private

  def to_json(lotos)
    {
      results: lotos.map do |loto|
        {
          times: loto.times,
          lottery_date: loto.lottery_date.strftime('%Y/%m/%d'),
          loto_numbers: loto.loto_numbers.unbouns.map(&:number),
          bounus_loto_number: loto.loto_numbers.bouns[0].number,
        }
      end,
    }.to_json
  end

  def create(processed_lotos)
    FileUtils.mkdir_p(directory_path)

    File.write(file_path, processed_lotos)
  end

  def directory_path
    Settings.jobs.loto_result_creation_job.path
  end

  def file_path
    "#{directory_path}/#{@kind}.json"
  end
end
