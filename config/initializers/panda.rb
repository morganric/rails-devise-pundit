
Panda.configure(YAML.load_file(Rails.root.join("config/panda.yml"))[Rails.env])
# Panda.configure(YAML.load_file(Rails.root.join("config/panda.yml"))[Rails.env])

# Panda.configure((ENV['PANDASTREAM_URL'] || YAML::load_file(File.join(File.dirname(FILE),"..", "panda.yml"))[Rails.env]))

