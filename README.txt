= rdoc-data

* http://rdoc.rubyforge.org

== DESCRIPTION:

Core ri data for use with RDoc 2.5 or newer.  This gem is required to use ri
from RDoc 2.5 and newer with Ruby 1.8.7.  ri data for Ruby 1.9.2, 1.9.3 and
2.0.0 are also included for use with JRuby but are not needed for typical
installs of C Ruby.

== FEATURES:

* Core ri data for use with rdoc >= 2.5
* Core ri data for rdoc <= 2.4.3 will still work (if you uninstall 2.5+)
* Does not update ri data for gems (use gem rdoc --all --overwrite --no-rdoc)

== SYNOPSIS:

  $ gem install rdoc-data
  $ rdoc-data --install

== INSTALL:

* sudo gem install rdoc-data

== LICENSE:

(The MIT License)

Copyright (c) 2010 Eric Hodel

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
