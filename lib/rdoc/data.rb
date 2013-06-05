require 'rdoc'
require 'rdoc/ri/paths'
require 'fileutils'
require 'find'

class RDoc::Data

  VERSION = '4.0.1'

  class Error < RuntimeError
  end

  def self.process_args args
    options = {}

    if args.empty? or args.include? '--help' or
       not args.include? '--install' then
      puts "Usage: #{$0} [--verbose] [--dryrun] --install"
      puts
      puts "Installs updated ruby #{RUBY_VERSION} system ri data (core + stdlib)"
      exit 1
    elsif args.include? '--verbose' then
      options[:verbose] = true
    elsif args.include? '--dryrun' then
      options[:dryrun] = true
    end

    options
  end

  def self.run argv = ARGV
    options = process_args argv

    data = new options

    if options[:dryrun] then
      data.extend FileUtils::DryRun
    elsif options[:verbose] then
      data.extend FileUtils::Verbose
    else
      data.extend FileUtils
    end

    data.run
  rescue Error => e
    abort e.message
  end

  def initialize options
    data_dir = Gem.datadir('') || File.expand_path('../../../data', __FILE__)
    @source = File.join data_dir, RUBY_VERSION

    unless File.exist? @source then
      supported = Dir[File.join(data_dir, '*')].map do |dir|
        dir.sub File.join(data_dir, ''), ''
      end.sort

      raise Error, "Your ruby version #{RUBY_VERSION} is not supported, " \
                   "only #{supported.join ', '}"
    end

    @destination = RDoc::RI::Paths.system_dir
  end

  def run
    cd @source do
      files = Dir[File.join('**', '*.ri{d,}')]

      files.each do |file|
        dest_file = File.join @destination, file
        dest_dir = File.dirname dest_file

        mkdir_p dest_dir
        install file, dest_dir, :mode => 0644
      end
    end
  end

end

