require 'hoe'

SUPPORTED_VERSIONS = %w[1.8.7-p374 1.9.3-p551 2.0.0-p647 2.1.8 2.2.4 2.3.0]

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

  license 'MIT'

  extra_deps << ['rdoc', '~> 4.0']
end

desc "Generates ri data"
task :generate => :build_ri_data do
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

desc "Builds ri data for each supported ruby version"
task :build_ri_data => SUPPORTED_VERSIONS

desc "Cleans build directories"
task :clean do
  rm_r "data" if File.exists? "data"
  rm_r "pkg" if File.exists? "pkg"
  rm_r "rubies" if File.exists? "rubies"
end

SUPPORTED_VERSIONS.each do |version|
  stripped = version.split("-p")[0]
  minor = stripped[0..-3]
  data_dir = File.expand_path 'data'
  sh "mkdir -p data"

  rdoc_dir = "#{data_dir}/#{minor}"
  destdir = File.expand_path "rubies/#{minor}/destdir"
  srcdir = File.expand_path "rubies/#{minor}"

  task version => "rubies/#{minor}"
  directory "rubies/#{minor}" do
    ftp = "http://ftp.ruby-lang.org/pub/ruby"
    sh "mkdir -p rubies"

    cd "rubies" do
      sh "curl #{ftp}/#{minor}/ruby-#{version}.tar.gz | tar xz"
      sh "mv ruby-#{version} #{minor}"
      cd minor do
        sh "mkdir build"
        sh "mkdir destdir"
        sh "autoconf"

        cd "build" do
          sh "../configure --disable-install-doc --prefix=#{destdir}"
          sh "make -j4 && make install"
        end

        cd "destdir" do
          gem_path = "lib/ruby/gems/*"

          env = {
            "GEM_ROOT" => gem_path,
            "GEM_HOME" => gem_path,
            "GEM_PATH" => gem_path
          }

          cmd = "bin/ruby -S bin/rdoc --all --ri --op #{rdoc_dir} #{srcdir}"

          system env, cmd
        end
      end
    end
  end
end
