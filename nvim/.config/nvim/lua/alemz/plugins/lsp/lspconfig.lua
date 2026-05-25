return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"saghen/blink.cmp",
	},
	config = function()
		-- Set up LspAttach autocommand for keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local bufnr = ev.buf
				local client_id = ev.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				local keymap = vim.keymap
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- Enable native completion if available (Neovim 0.11+)
				if vim.lsp.completion and client and client.supports_method("textDocument/completion") then
					vim.lsp.completion.enable(true, client_id, bufnr)
				end

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Set up signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Load blink.cmp and get capabilities
		local blink = require("blink.cmp")
		local capabilities = blink.get_lsp_capabilities()

		-- List of servers to enable
		local servers = {
			"html",
			"ts_ls",
			"cssls",
			"tailwindcss",
			"prismals",
			"astro",
			"pyright",
			"emmet_ls",
			"lua_ls",
		}

		-- Global configuration for all servers (apply blink capabilities)
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Custom configuration for emmet_ls
		vim.lsp.config.emmet_ls = {
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"javascript",
				"typescript",
				"css",
				"sass",
				"scss",
				"less",
				"astro",
			},
		}

		-- Custom configuration for lua_ls
		vim.lsp.config.lua_ls = {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		}

		-- Enable all servers
		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end
	end,
}
