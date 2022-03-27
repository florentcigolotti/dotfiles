local dap = require('dap')
local utils = require('florentc.utils')

-- Global settings

utils.map('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<cr>')
utils.map('n', '<leader>dc', '<cmd>lua require("dap").continue()<cr>')
utils.map('n', '<leader>dn', '<cmd>lua require("dap").step_over()<cr>')
utils.map('n', '<leader>di', '<cmd>lua require("dap").step_into()<cr>')
utils.map('n', '<leader>do', '<cmd>lua require("dap").step_out()<cr>')
utils.map('n', '<leader>da', '<cmd>lua require("dap").close()<cr>') -- Debug Abort
utils.map('n', '<leader>dh', '<cmd>lua require("dapui").eval()<cr>')

-- vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpoint', {text='⭕', texthl='', linehl='', numhl=''})

-- Python

dap.adapters.python = {
  type = 'executable';
  command = 'python'; -- As we are in poetry virtualenv
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "behave_user",
    module = "behave",
    -- args = {"-D", "env=dev-standalone", "tests/features/protocols/grid/iec-61850-goose.feature", "-n", "Center Grid IEC-61850 Goose properties, variables, tags"},
    args = {"-D", "env=qa-center3", "tests/features/protocols/s7.feature"},
    -- args = {"-D", "env=dev-standalone"},
    -- pythonPath = function()
    --   local cwd = vim.fn.getcwd()
    --   return cwd .. '/bin/python'
    -- end,
    cwd = '/Users/florentc/projects/sentryo-labs/e2e-system-tests',
    console = 'integratedTerminal',
  },
  {
    type = 'python',
    request = 'launch',
    name = "dyn-test-launcher",
    program = '${file}',
    -- args = {"run", "qa-center3", "--disable-setup-center-cli"},
    args = {"run", "qa-center3", "--bypass-setup-center"},
    cwd = '/Users/florentc/projects/sentryo-labs/e2e-system-tests',
    console = 'integratedTerminal',
  },
}

-- Golang

dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = {nil, stdout},
    args = {"dap", "-l", "127.0.0.1:" .. port},
    detached = true
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print('dlv exited with code', code)
    end
  end)
  assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require('dap.repl').append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(
    function()
      callback({type = "server", host = "127.0.0.1", port = port})
    end,
    100)
end

-- Or if in any case I prefer to manually run the server
-- `dlv dap -l 127.0.0.1:38697 --log --log-output="dap"`
-- dap.adapters.go = {
--   type = "server",
--   host = "127.0.0.1",
--   port = 38697,
-- }

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "go",
    name = "Debug (go.mod)",
    request = "launch",
    program = "./${relativeFileDirname}",
    args = {"ls"},
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  },
}

-- Chrome for JS/TS

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/projects/others/vscode-chrome-debug/out/src/chromeDebug.js"} -- TODO adjust
}

dap.configurations.javascript = { -- change this to javascript if needed
    {
        type = "chrome",
        name = "Cypress",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
        skipFiles = {"cypress_runner.js"},
        urlFilter = "http://localhost*",
    }
}
dap.configurations.typescript = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    }
}
