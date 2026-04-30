---@type vim.lsp.Config
return {
  cmd = { 'ocamllsp' },
  filetypes = { 'ocaml', 'dune' },
  root_markers = { '*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace' },
}
