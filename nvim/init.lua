-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- my vimrc

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度
vim.opt.shell = "powershell.exe"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

-- システムの背景設定を取得
if vim.fn.system("defaults read -g AppleInterfaceStyle"):find("Dark") then
  vim.cmd.colorscheme("tokyonight") -- ダークスキーム
else
  vim.cmd.colorscheme("tokyonight-day") -- ライトスキーム
end

-- 背景を透過させる
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])

vim.keymap.set({ "n", "v", "s", "o" }, ";", ":", { noremap = true })
vim.keymap.set({ "n", "v", "s", "o" }, ":", ";", { noremap = true })

vim.api.nvim_create_user_command("EditVimrc", "edit $MYVIMRC", {})
vim.api.nvim_create_user_command("ReloadVimrc", "source $MYVIMRC", {})

-- WSLディストリビューションのリストを取得する関数
local function get_wsl_distro_list()
  -- Windows環境かどうかをチェック
  if vim.fn.has("win32") == 0 then
    return {}
  end

  -- 'wsl --list --quiet' を実行し、結果をリストとして取得
  local output = vim.fn.systemlist("wsl --list --quiet")

  local distros = {}
  for _, line in ipairs(output) do
    -- 💡 修正点: BOM(\239\187\191)、CR(\r)、LF(\n)、NULL文字(\0)を除去
    local distro_name = line
      :gsub("\239\187\191", "") -- UTF-8 BOM
      :gsub("\255\254", "") -- UTF-16 LE BOM
      :gsub("\r", "") -- キャリッジリターン
      :gsub("\n", "") -- ラインフィード
      :gsub("\0", "") -- NULL文字
      :match("^%s*(.-)%s*$") -- 前後の空白を削除

    if distro_name and distro_name ~= "" then
      table.insert(distros, distro_name)
    end
  end

  return distros
end

-- 補完関数
local function wslterm_complete(ArgLead, CmdLine, CursorPos)
  return get_wsl_distro_list()
end

-- ユーザーコマンドの定義
vim.api.nvim_create_user_command("WslTerminal", function(opts)
  local distro_name = opts.fargs[1]
  local command = "wsl -d " .. distro_name
  if #opts.fargs > 1 then
    local extra_args = table.concat(opts.fargs, " ", 2)
    command = command .. " " .. extra_args
  end
  vim.cmd("terminal " .. command)
end, {
  nargs = "*",
  complete = wslterm_complete,
  desc = "Open a terminal with a specific WSL distribution",
})
