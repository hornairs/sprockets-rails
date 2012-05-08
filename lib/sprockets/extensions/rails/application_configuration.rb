module Rails
  class Application
    class Configuration < ::Rails::Engine::Configuration
      attr_accessor :assets, :asset_host, :asset_paths, :asset_path
      def initialize_with_assets(*args)
        initialize_without_assets(*args)
        @assets = ActiveSupport::OrderedOptions.new
        @assets.enabled                  = false
        @assets.paths                    = []
        @assets.precompile               = [ Proc.new{ |path| !/\.(js|css)$/.match(File.extname(path)) },
                                             /(?:\/|\\|\A)application\.(css|js)$/ ]
        @assets.prefix                   = "/assets"
        @assets.version                  = ''
        @assets.debug                    = false
        @assets.compile                  = true
        @assets.digest                   = false
        @assets.manifest                 = nil
        @assets.cache_store              = [ :file_store, "#{root}/tmp/cache/assets/" ]
        @assets.js_compressor            = nil
        @assets.css_compressor           = nil
        @assets.initialize_on_precompile = true
        @assets.logger                   = nil
      end
      alias_method_chain :initialize, :assets

      def paths_with_assets
        paths = paths_without_assets
        paths.app.assets    "app/assets"   , :glob => "*"
        paths.vendor.assets "vendor/assets", :glob => "*"
        paths
      end
      alias_method_chain :paths, :assets
    end
  end
end
