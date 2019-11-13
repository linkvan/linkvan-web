# require File.join(Rails.root, 'app/jobs/facilities_static_generator_job.rb')

if defined?(Rails::Server)
  Rails.application.config.after_initialize do
    # Generates the static file '/facilities.json'.
    FacilitiesStaticGeneratorJob.new.perform
  end
end
