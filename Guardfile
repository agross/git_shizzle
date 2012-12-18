notification :ruby_gntp

guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard 'rspec',
  :all_on_start => true,
  :all_after_pass => false,
  :notification => false,
  :cli => "--format documentation --tag ~@draft" do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})
    watch('spec/spec_helper.rb') { "spec" }
end
