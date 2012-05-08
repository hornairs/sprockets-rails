module ActionController
  class Railtie < Rails::Railtie
    initializer "action_controller.set_asset_configs", :before => "action_controller.set_configs" do |app|
      options = app.config.action_controller
      options.asset_path           ||= app.config.asset_path
      options.asset_host           ||= app.config.asset_host
    end
  end
end
