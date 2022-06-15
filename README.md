# dotfiles

## Requirements
- Ubuntu 22.04
- Regolith v2.0 (https://regolith-desktop.com)

## Setup
- [Display] Set scaling to 200%.
- [Browser] Download 1Password browser extenstion and sign in.
- [Dotfiles] Install git.
- [Dotfiles] Clone derrickdominic/dotfiles.git from github.com.
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

## Differences from stock Regolith v2.0
- [i3] Change window navigation/move keybindings to j/k/l/semicolon.
- [i3] Change alternate workspace navigation keybindings to j/semicolon.
- [i3] Change scratchpad keybindings to Minus.
- [i3] Reduce default gap to 0.
- [i3] Change horizontal split keybinding to h.
- [i3] Start Emacs daemon on startup.
- [i3] Add e keybinding to start an Emacs client.
- [Regolith] Set desktop and lockscreen wallpapers to one of the 22.04 wallpapers.