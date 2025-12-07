return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Set up Spotify logo color (Spotify green)
    vim.api.nvim_set_hl(0, "SpotifyGreen", { fg = "#1DB954" })

    -- Mode symbols (emojis)
    local mode_symbols = {
      ["n"] = "👀",
      ["i"] = "✍️ ",
      ["v"] = "👁️ ",
      ["V"] = "👁️ ",
      [""] = "👁️ ",
      ["c"] = "⌘ ",
      ["t"] = "💻",
      ["R"] = "✏️ ",
    }

    -- Spotify integration with cross-platform support
    local cached_spotify = ""
    local spotify_update_count = 0

    local function get_spotify_track()
      -- Only fetch from Spotify every 50 calls (every 10 seconds at 200ms timer)
      spotify_update_count = spotify_update_count + 1
      if spotify_update_count % 50 ~= 0 then
        return cached_spotify
      end

      -- Detect platform
      local handle
      if vim.fn.has("mac") == 1 then
        -- macOS: Use osascript to get Spotify info
        handle = io.popen(
          'osascript -e \'tell application "Spotify" to if it is running then artist of current track & " - " & name of current track\' 2>/dev/null'
        )
      else
        -- Linux (Arch/Omarchy): Use playerctl for Spotify
        handle = io.popen(
          "playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null")
      end

      if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" and not result:match("^%s*$") then
          -- Remove newlines and keep only ASCII printable characters
          local clean = result:gsub("[\r\n]", ""):gsub("[^\32-\126]", "")
          cached_spotify = "%#SpotifyGreen#󰓇%* " .. clean
        else
          cached_spotify = ""
        end
      else
        cached_spotify = ""
      end

      return cached_spotify
    end

    -- Custom mode component with emoji symbols
    local function mode_with_symbol()
      local mode = vim.fn.mode()
      local symbol = mode_symbols[mode] or "🔹"
      return symbol
    end

    -- Update lualine periodically for Spotify updates
    local timer = vim.loop.new_timer()
    timer:start(
      0,
      200,
      vim.schedule_wrap(function()
        require("lualine").refresh()
      end)
    )

    -- Create custom Spotify component with proper highlight group
    local spotify_component = {
      get_spotify_track,
      color = function()
        -- Get the current colorscheme's background for lualine_z
        local colors = require("lualine.themes." .. (vim.g.colors_name or "auto"))
        if colors and colors.normal and colors.normal.c then
          return { bg = colors.normal.c.bg, fg = colors.normal.c.fg }
        end
        return {}
      end,
    }

    -- Customize lualine sections
    opts.sections = opts.sections or {}
    opts.sections.lualine_a = { mode_with_symbol, "mode" }
    opts.sections.lualine_z = {
      {
        function()
          return "󰥔 " .. os.date("%H:%M")
        end,
      },
      spotify_component,
    }

    return opts
  end,
}
