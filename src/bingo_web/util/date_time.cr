module BingoWeb
  module Util
    extend self

    def maybe_parse_date_time(time_string)
      Time::Format::ISO_8601_DATE_TIME.parse(time_string)
    end
  end
end
