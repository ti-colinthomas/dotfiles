local M = {}

-- Function to determine if nvim is active within tmux
function M.is_tmux_active()
  return os.getenv("TMUX") ~= nil
end

-- Function to get the current tmux session name
function M.tmux_session_name()
  local devicons = require"nvim-web-devicons"
  local icon, color = devicons.get_icon("tmux.conf", nil, { default = true })  -- Get the tmux icon
  local handle = io.popen("tmux display-message -p '#S'")  -- Get the current session name
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()
    local session_name = result:gsub("%s+", "")  -- Trim whitespace
    return icon .. " " .. session_name  -- Return the icon followed by the session name
  else
    return icon .. " tmux"  -- Return the icon with a fallback name
  end
end

-- Function to get the current tmux window name
function M.tmux_window_name()
  local handle = io.popen("tmux display-message -p '#W'")  -- Get the current window name
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()
    return result:gsub("%s+", "")  -- Trim whitespace
  else
    return "tmux"
  end
end

return M
