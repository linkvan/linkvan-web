module AnalyticsHelper

  def get_service_data()
    data = [
      Analytic.where(facility: "Shelter").count,
      Analytic.where(facility: "Food").count,
      Analytic.where(facility: "Medical").count,
      Analytic.where(facility: "Hygiene").count,
      Analytic.where(facility: "Technology").count,
      Analytic.where(facility: "Legal").count,
      Analytic.where(facility: "Learning").count,
      Analytic.where(facility: "Crisis Lines").count
    ]
    return data
  end
end
