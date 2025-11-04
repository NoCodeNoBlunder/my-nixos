-- TODO dont load frecency lazyily
return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },

			-- Firefox algo for frequently and recently accessed files
			{ "nvim-telescope/telescope-frecency.nvim" },
		},
		config = function()
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				--

				-- TODO: This is nice but breaks gra show code action
				defaults = {
					-- layout_strategy = 'horizontal',  -- side-by-side preview
					layout_config = {
						horizontal = {
							width = 0.90, -- 90% of the screen width
							height = 0.8, -- 80% of the screen height
							-- prompt_position = 'top',
							preview_width = 0.5, -- preview pane width
						},
					},
				},

				pickers = {
					lsp_references = {
						path_display = { "smart" },
						-- override how paths are displayed for this picker
						-- path_display = function(_, path)
						-- 	local git_root = get_git_root() or vim.loop.cwd()
						-- 	return relative_to(path, git_root)
						-- end,
						show_line = false,
						-- TODO: what this do?
						-- trim_text =
					},
				},

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					---@module 'frecency'
					---@type FrecencyOpts
					frecency = {
						show_scores = false,
						auto_validate = true,
						bootstrap = true,
						enable_prompt_mappings = true,
						matcher = "fuzzy", -- experimental
						db_safe_mode = true,
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "frecency")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			-- TODO autocomplete should put () for functions
			local extensions = require("telescope").extensions
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			-- TODO: write custom function to now show absolute paths
			vim.keymap.set("n", "<leader>sc", builtin.lsp_incoming_calls, { desc = "[S]earch [I]ncoming" })
			-- vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "[ ] Find existing buffers" })

			-- Frecency (project recent files)
			vim.keymap.set("n", "<leader>sF", function()
				-- extensions.frecency.frecency({ workspace = "CWD", path_display = { "shorten" } })
				extensions.frecency.frecency({ workspace = "CWD" })
			end, { desc = "[S]earch [F]recency (project)" })

			local function get_git_root()
				local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					git_root = nil -- If not in a Git repo, fallback to default behavior
				end
				return git_root
			end

			local function find_files_in_git_root()
				local git_root = get_git_root()
				if git_root == nil then
					git_root = nil -- If not in a Git repo, fallback to default behavior
				end
				require("telescope.builtin").find_files({
					cwd = git_root,
				})
			end

			vim.keymap.set("n", "<leader><leader>", find_files_in_git_root, { desc = "Find in Project Root" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
