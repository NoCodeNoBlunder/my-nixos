-- This does not work as formatoptions is overriden later on
-- vim.opt.formatoptions = "jtcrql"
-- vim.opt.formatoptions:remove("o")

-- Neovide config
if vim.g.neovide then
	-- Font setup with anti-aliasing OFF and full hinting
	vim.o.guifont = "FiraMono_Nerd_Font_Mono:h14:#e-alias:#h-full"

	-- Neovide appearance and behavior
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_confirm_quit = true

	-- Cursor animation
	vim.g.neovide_cursor_animation_length = 0.10
	-- vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_vfx_particle_density = 15.0
	vim.g.neovide_cursor_vfx_particle_speed = 10.0
	vim.g.neovide_cursor_trail_size = 0.25
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_smooth_blink = true
	vim.g.neovide_cursor_antialiasing = true -- For cursor effect only

	-- Scroll animation
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_scroll_animation_far_lines = 1

	-- Window padding
	vim.g.neovide_padding_top = 2
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 2
	vim.g.neovide_padding_left = 0

	-- Space between lines
	vim.opt.linespace = 5

	-- Hide Mouse when typing
	vim.g.neovide_hide_mouse_when_typing = true

	-- Text Gamma and Contrast
	vim.g.neovide_text_gamma = 0.0
	vim.g.neovide_text_contrast = 0.8

	-- Input options
	vim.g.neovide_input_use_logo = true
	vim.g.neovide_input_macos_option_key_is_meta = true

	-- Fullscreen toggle
	vim.g.neovide_fullscreen = true

	-- Performance tuning
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_no_idle = false

	-- Optional profiler
	vim.g.neovide_profiler = false

	-- Hotkey Zooming

	-- Default scale factor
	vim.g.neovide_scale_factor = 1.0

	-- Function to change scale factor
	local function change_scale(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
	end

	-- Presentation mode toggle
	local presentation_mode = false
	local function toggle_presentation_mode()
		presentation_mode = not presentation_mode
		if presentation_mode then
			vim.g.neovide_scale_factor = 2.0
			vim.o.number = false
			vim.o.laststatus = 0
			vim.o.showtabline = 0
		else
			vim.g.neovide_scale_factor = 1.0
			vim.o.number = true
			vim.o.laststatus = 2
			vim.o.showtabline = 2
		end
	end

	-- TODO: How to get keymappings to work
	-- -- Key mappings
	-- vim.keymap.set("n", "<C-+>", function()
	-- 	change_scale(0.1)
	-- end, { desc = "Zoom In" })
	-- vim.keymap.set("n", "<C-->", function()
	-- 	change_scale(-0.1)
	-- end, { desc = "Zoom Out" })
	-- vim.keymap.set("n", "<C-P>", toggle_presentation_mode, { desc = "Toggle Presentation Mode" })
end
