require "rubygems"

specs = Gem::Specification.find_all { |s| s.name =~ /fluent-plugin/ }

passes = specs.map do |spec|
  puts "\e[31m\e[43m\e[5mRunning tests for #{spec.name}\e[0m"

  system <<"EOF"
cd #{spec.full_gem_path}
BUNDLE_GEMFILE=Gemfile bundle
RUBYLIB=lib:test:$RUBYLIB BUNDLE_GEMFILE=Gemfile bundle exec rake
EOF
end

exit 1 unless passes.all?
