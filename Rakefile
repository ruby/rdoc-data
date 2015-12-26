require 'hoe'

hoe = Hoe.spec 'rdoc-data' do
  developer 'Eric Hodel', 'drbrain@segment7.net'
  developer 'Zachary Scott', 'mail@zzak.io'

  clean_globs.push 'data'

  spec_extras[:post_install_message] = <<-EOF
rdoc-data is only required for C ruby 1.8.7 or 1.9.1.

rdoc-data is required for JRuby.

To install ri data for RDoc 4.0+ run:

  rdoc-data --install

  EOF

  extra_deps     << ['rdoc', '~> 4.0']
end

desc "Generates ri data"
task :generate => [:install_rdoc, :build_ri_data] do
  files = Dir['data/**/*.ri']
  hoe.spec.files += files # #files is not cached, so we must assign

  dirs = nil
  cd 'data' do dirs = Dir['*'] end

  hoe.spec.description << "\n\nIncludes data for #{dirs.join ', '}"
end

task :gem => :generate

path = "pkg/#{hoe.spec.full_name}"
task path => :generate do
  cp_r 'data', path
end

desc "Installs RDoc in multiruby"
task :install_rdoc do
  rdoc_gem_path = ENV['RDOC_GEM'] || abort(<<-ABORT)
Specifiy the path to the rdoc gem to use as RDOC_GEM
  ABORT

  sh 'multigem', 'install', rdoc_gem_path, '--no-rdoc', '--no-ri'
end

desc "Builds ri data for each multiruby install"
task :build_ri_data => [:data] do
  data_dir = File.expand_path 'data'

  Dir[File.expand_path('~/.multiruby/build/*')].each do |dir|
    build_name   = File.basename dir
    install_name = build_name.sub 'ruby-', ''
    data_name    = install_name.sub(/-p\d+/, '')

    rdoc_bin_path =
      File.expand_path "~/.multiruby/install/2.0.0-p195/bin/rdoc"

    rdoc_dir = "#{data_dir}/#{data_name}"

    next if File.exist? rdoc_dir

    cd dir do
      sh rdoc_bin_path, '--all', '--ri', '--op', rdoc_dir, '.'
    end
  end
end

directory 'data'

# vim: syntax=Ruby
