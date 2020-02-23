# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

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
end