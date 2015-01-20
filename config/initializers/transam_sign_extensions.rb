# Technique caged from http://stackoverflow.com/questions/4460800/how-to-monkey-patch-code-that-gets-auto-loaded-in-rails
Rails.configuration.to_prepare do
  Asset.class_eval do
    include TransamSignAsset
    set_rgeo_factory_for_column(:geometry,  RGeo::Geographic.spherical_factory(:srid => 4326))
  end
end
