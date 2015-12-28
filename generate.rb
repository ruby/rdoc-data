require 'rdoc'
require 'pathname'

options = RDoc::Options.new

options.op_dir = ARGV[0]
options.root = Pathname(ARGV[1])

rdoc = RDoc::RDoc.new
rdoc.options = options

options.files = rdoc.parse_dot_doc_file(ARGV[1], File.join(ARGV[1], ".document"))

options.setup_generator 'ri'

RDoc::RDoc.new.document options
