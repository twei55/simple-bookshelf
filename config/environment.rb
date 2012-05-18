# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SimpleBookshelf::Application.initialize!

Encoding.default_external = "UTF-8"

# http://groups.google.com/group/thinking-sphinx/browse_thread/thread/66d0cbef8697dd60/76810ccee253ffe9
ThinkingSphinx.updates_enabled = true
ThinkingSphinx.deltas_enabled  = true
ThinkingSphinx.suppress_delta_output  = true