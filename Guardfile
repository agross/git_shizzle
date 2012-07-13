notification :growl

guard 'rspec', :version => 2,
  :all_after_pass => false,
  :all_on_start => true,
  :cli => "-d --format doc --tag ~@draft" do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})
    watch('spec/spec_helper.rb')  { "spec" }
end

guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
