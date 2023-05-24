# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "paperwasp"; then
  new_window "admin"
  run_cmd "cd ~/work/research-admin-svelte && clear"

  new_window "app"
  select_window "app"
  run_cmd "cd ~/work/research-app-rn && clear"

  new_window "api"
  select_window "api"
  run_cmd "cd ~/work/research-api && clear"

  new_window "shells"
  select_window "shells"

  select_pane 1
  run_cmd "cd ~/work/research-admin-svelte && clear"

  split_h 55
  select_pane 2
  run_cmd "cd ~/work/research-api && clear"

  split_h 33
  select_pane 3
  run_cmd "cd ~/work/research-app-rn && clear"

  split_v 70
  select_pane 4
  run_cmd "cd ~/work/research-app-rn && clear"

  select_window "admin"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
