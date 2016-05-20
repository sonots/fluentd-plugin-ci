require "rubygems"

# get the gem 'fluentd' line to run ci test with the version
gem_fluentd = File.readlines(ENV['BUNDLE_GEMFILE']).grep(/fluentd/).first.chomp.gsub('"', '\"')
# tweaked Gemfile name on each plugin
GEMFILE_CI = "Gemfile.fluentd_plugin_ci"

specs = Gem::Specification.find_all { |s| s.name =~ /fluent-plugin/ }
failures = []
specs.each do |spec|
  puts "\e[31m\e[43m\e[5mRunning tests for #{spec.name}\e[0m"
  passed = Bundler.with_clean_env do
    system <<"EOF"
echo "cd #{spec.full_gem_path}"
cd #{spec.full_gem_path}
echo 'cp Gemfile #{GEMFILE_CI} && echo "#{gem_fluentd}" >> #{GEMFILE_CI}'
cp Gemfile #{GEMFILE_CI} && echo "#{gem_fluentd}" >> #{GEMFILE_CI}
echo "BUNDLE_GEMFILE=#{GEMFILE_CI} bundle install"
BUNDLE_GEMFILE=#{GEMFILE_CI} bundle install
echo "RUBYLIB=lib:test:$RUBYLIB BUNDLE_GEMFILE=#{GEMFILE_CI} bundle exec rake"
RUBYLIB=lib:test:$RUBYLIB BUNDLE_GEMFILE=#{GEMFILE_CI} bundle exec rake
EOF
  end
  failures << spec.name unless passed
end

failures.each do |name|
  puts "\e[31m#{name} FAILED\e[0m"
end

exit 1 unless failures.empty?
