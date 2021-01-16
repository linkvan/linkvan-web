module ApplicationHelper
  TIMEZONE = "Pacific Time (US & Canada)".freeze

  def lastUpdate
    displayDate(
      [
        Facility.order(updated_at: :desc).first.updated_at,
        Notice.order(updated_at: :desc).first&.updated_at
      ].reject(&:nil?).max
    ).strftime("%b %-d, %Y")
  end

  def displayDate(date)
    date.in_time_zone(TIMEZONE)
  end
end
