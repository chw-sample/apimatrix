config = YAML.load_file("#{Rails.root}/config/apimatrix.yml")[Rails.env]
ApiKey = config["key"]
ApiSecret = config["secret"]
ApiCallback = config["callback"]