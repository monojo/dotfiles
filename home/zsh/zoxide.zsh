if command -v zoxide &> /dev/null; then
  # change cd to zoxide
    eval "$(zoxide init zsh --cmd cd)"
    eval "$(zoxide init zsh --cmd j --hook pwd)"
fi
