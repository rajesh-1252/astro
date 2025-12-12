require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "^node_modules/",
      "node_modules",
      "^%.git/", -- Ensure .git is ignored
    },
    -- Add an explicit find command to bypass this issue
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "--glob=!node_modules",
      "--glob=!.git",
    },
  },
}
return {}
