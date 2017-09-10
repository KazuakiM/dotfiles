Host github.com
  AddKeysToAgent      yes
  Hostname            github.com
  IdentityFile        ~/.ssh/id_rsa
  KeepAlive           yes
  LocalCommand        tmux rename-window %n
  PermitLocalCommand  yes
  ServerAliveInterval 30
  User                KazuakiM
