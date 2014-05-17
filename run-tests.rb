require "rubygems"

specs = Gem::Specification.find_all { |s| s.name =~ /fluent-plugin/ }

passes = specs.map do |spec|
  puts "\e[31m\e[43m\e[5mRunning tests for #{spec.name}\e[0m"

  Bundler.with_clean_env do
    system <<"EOF"
cd #{spec.full_gem_path}
echo "bundle install"
bundle install
echo "RUBYLIB=lib:test:$RUBYLIB bundle exec rake"
RUBYLIB=lib:test:$RUBYLIB bundle exec rake
EOF
  end
end

exit 1 unless passes.all?
