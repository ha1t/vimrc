return {
  "sindrets/diffview.nvim",
  -- Gitディレクトリ内のファイルを開いたときにロードする
  ft = { "gitcommit", "gitrebase" },
  -- または、特定のコマンドが実行されたときにロードする
  cmd = { "DiffviewOpen" },
}
