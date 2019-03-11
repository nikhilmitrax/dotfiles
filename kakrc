source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/fzf.kak" config %{
  map -docstring 'fzf mode' global normal '<c-p>' ': fzf-mode<ret>'
      set-option global fzf_preview_width '65%'
        evaluate-commands %sh{
        if [ ! -z "$(command -v fd)" ]; then
              echo "set-option global fzf_file_command 'fd . --no-ignore --type f --follow --hidden'"
                fi
        }
}

plug "andreyorst/powerline.kak" %{
  hook -once global WinCreate .* %{
        powerline-theme gruvbox
        powerline-separator arrow
        powerline-format git bufname filetype mode_info line_column position
        powerline-toggle line_column off
  }
}

plug "Delapouite/kakoune-buffers" config %{
  hook global WinDisplay .* info-buffers
  map global user B ':enter-buffers-mode<ret>'              -docstring 'buffers…'
  #map global user B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
  map global user b ': pick-buffers<ret>' -docstring 'interactively pick buffers'

}

plug "andreyorst/smarttab.kak" %{
    hook global BufCreate .* %{set-option global softtabstop 4}
    hook global BufCreate .* expandtab
}
plug "TeddyDD/kakoune-edit-or-dir" %{
    unalias global e edit
    alias global e edit-or-dir
}
eval %sh{kak-lsp --kakoune -s $kak_session}
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
map global normal D <a-i>w* -docstring 'select word and set it up for search'
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

hook global NormalKey y|d|c %{ nop %sh{
      printf %s "$kak_main_reg_dquote" | pbcopy
}}

map global user P '!pbpaste<ret>'
colorscheme gruvbox
map global goto z <esc><c-o> -docstring 'Go to previous cursor position'
map global goto Z <esc><c-i> -docstring 'Go to next cursor position'

set-option global fzf_file_command rg
set-option global fzf_highlighter bat

# Controversial I guess

map global normal s <a-i>
