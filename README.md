# dotfiles

## Requirements
- Ubuntu 22.04
- Regolith v2.0 (https://regolith-desktop.com)

## Setup
- [Display] Set scaling to 200%.
- [Browser] Download 1Password browser extenstion and sign in.
- [Dotfiles] Install git.
- [Dotfiles] Clone https://github.com/derrickdominic/dotfiles to ~/dotfiles.
- [Mouse] Turn off natural scrolling.
- [Mouse] Increase touchpad speed.
- [Network] `gsettings set org.gnome.nm-applet disable-connected-notifications "true"`.
- [Network] `gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"`.
- [Emacs] M-x package-refresh-contents.
- [Emacs] M-x package-install-selected-packages.
- [Regolith] Install i3xrocks-battery.
- [Regolith] Remove regolith-i3-base-launchers (defaults).
- [Regolith] Remove regolith-i3-gaps-partial (defaults).
- [Regolith] Remove regolith-i3-i3xrocks (defaults).
- [Regolith] Remove regolith-i3-navigation (defaults).
- [Regolith] Remove regolith-i3-resize (defaults).
- [Regolith] Remove regolith-i3-workspace-config (defaults).
- [Terminal] Create a new profile called "Monokai".
- [Terminal] Clone https://github.com/0xcomposure/monokai-gnome-terminal and run install.sh to update the "Monokai" profile to the Monokai color scheme.
- [Terminal] Set the "Monokai" profile as thedefault.
- [i3] Clone https://github.com/rkashapov/i3blocks-pomodoro to ~/repo.
- [i3] Install i3xrocks-volume.

## Differences from stock Regolith v2.0
- [i3] Change window navigation/move keybindings to j/k/l/semicolon.
- [i3] Change alternate workspace navigation keybindings to j/semicolon.
- [i3] Change scratchpad keybindings to Minus.
- [i3] Reduce default gap to 0.
- [i3] Change horizontal split keybinding to h.
- [i3] Start Emacs daemon on startup.
- [i3] Add e keybinding to start an Emacs client.
- [Regolith] Set desktop and lockscreen wallpapers to one of the 22.04 wallpapers.
- [i3] Add Pomodoro blocklet to bar.
- [i3] Add volume blocklet to bar.