require("auto-session").setup({
  log_level = "error",
  post_restore_cmds = { 'silent !kill -s SIGWINCH $PPID' }
})
