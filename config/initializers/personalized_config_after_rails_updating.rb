Rails.application.configure do
    config.assets.paths << "#{Rails}/vendor/assets/fonts"

    config.assets.paths += [
        Rails.root.join('vendor', 'assets', 'fonts')
    ]
    config.assets.paths << "#{Rails}/app/assets/videos"

    config.assets.precompile += [
        'icons.eot',
        'icons.svg',
        'icons.ttf',
        'icons.woff'
    ]
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    # config.assets.enabled = true

    config.active_record.time_zone_aware_types = [:datetime, :time]

    ###########################
    # Changes made to new_framework_defaults.rb from Rails 4.2 to Rails 5.0
    # Enable per-form CSRF tokens. Previous versions had false.
    Rails.application.config.action_controller.per_form_csrf_tokens = true

    # Enable origin-checking CSRF mitigation. Previous versions had false.
    Rails.application.config.action_controller.forgery_protection_origin_check = true

    # Make Ruby 2.4 preserve the timezone of the receiver when calling `to_time`.
    # Previous versions had false.
    ActiveSupport.to_time_preserves_timezone = true

    # Require `belongs_to` associations by default. Previous versions had false.
    Rails.application.config.active_record.belongs_to_required_by_default = true

    # Do not halt callback chains when a callback returns false. Previous versions had true.
    ActiveSupport.halt_callback_chains_on_return_false = false
    # 
    ############################

end
