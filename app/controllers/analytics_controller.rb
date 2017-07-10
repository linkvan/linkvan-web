class AnalyticsController < ApplicationController
  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    if (@user.admin)
      @raw_service_chart_data = Analytic.group(:service).count
      @service_chart_data = []
        .push(@raw_service_chart_data['Shelter'])
        .push(@raw_service_chart_data['Food'])
        .push(@raw_service_chart_data['Medical'])
        .push(@raw_service_chart_data['Hygiene'])
        .push(@raw_service_chart_data['Technology'])
        .push(@raw_service_chart_data['Legal'])
        .push(@raw_service_chart_data['Learning'])
        .push(@raw_service_chart_data['Crisis Lines'])

      @time_chart_data = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      @service_time_chart_data = {
        "Shelter" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        "Food" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        "Medical" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        "Hygiene" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        "Technology" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        "Legal" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        "Learning" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        "Crisis Lines" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      }
      Analytic.order(:time).each do |data|
        time = data.time.localtime
        secs = time.seconds_since_midnight()
        hour = (secs / 3600).floor
        @time_chart_data[hour] += 1
        @service_time_chart_data[data.service][hour] += 1
      end

      puts @service_time_chart_data
    end
  end

  def destroy
  end
end
