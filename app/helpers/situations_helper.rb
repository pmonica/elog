module SituationsHelper
  def time_since(time)
    secs  = Time.now - time
    mins  = (secs / 60).round
    hours = (mins / 60).round
    days  = (hours / 24).round

    Rails.logger.info(days)
    if days > 0
      "#{days} days"
    elsif hours > 0
      "#{hours} hours"
    elsif mins > 0
      "#{mins} minutes"
    elsif secs >= 0
      "#{secs} seconds"
    end
  end
end
