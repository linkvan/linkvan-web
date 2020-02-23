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
end
