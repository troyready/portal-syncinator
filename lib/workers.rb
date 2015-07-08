module Workers
  require './lib/workers/handle_changes'
  require './lib/workers/handle_change'
  require './lib/workers/trogdir_change_error_worker'
  require './lib/workers/trogdir_change_finish_worker'
end
