Rails.application.config.di_config = YAML.load_file(Rails.root.join('config', 'config.yml'))[Rails.env] 
