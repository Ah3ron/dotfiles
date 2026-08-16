return {
  -- Добавление парсера Treesitter для подсветки синтаксиса
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "qmljs" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          -- Фильтрация на уровне обработчика
          handlers = {
            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
              -- Оставляем только ошибки (Severity 1)
              -- Варнинги (Severity 2) будут игнорироваться
              local filtered = {}
              for _, diagnostic in ipairs(result.diagnostics) do
                if diagnostic.severity == 1 then
                  table.insert(filtered, diagnostic)
                end
              end
              result.diagnostics = filtered
              vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end,
          },
        },
      },
    },
  },

  -- Настройка форматирования
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        qml = { "qmlfmt" },
      },
    },
  },

  -- Настройка автодополнения и иконок (опционально)
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      -- Дополнительные настройки cmp, если нужны
    end,
  },
}
