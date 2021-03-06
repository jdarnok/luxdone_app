VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end
# RSpec.configure do |config|
#   # Add VCR to all tests
#   config.around(:each) do |example|
#     options = example.metadata[:vcr] || {}
#     if options[:record] == :skip
#       VCR.turned_off(&example)
#     else
#       name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(/\./,'/').gsub(/[^\w\/]+/, '_').gsub(/\/$/, '')
#       VCR.use_cassette(name, options, &example)
#     end
#   end
# end