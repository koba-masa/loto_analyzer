# frozen_string_literal: true

module Results
  class Loto
    def initialize(kind)
      @kind = kind
    end

    def directory_path
      "#{Settings.jobs.loto_result_creation_job.path}/#{@kind}"
    end
  end
end
