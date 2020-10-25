module ApplicationHelper
  def lastUpdate
    [
      Facility.order(updated_at: :desc).first.updated_at,
      Notice.order(updated_at: :desc).first&.updated_at
    ].reject(&:nil?).max.strftime("%b %-d, %Y")
  end
end
