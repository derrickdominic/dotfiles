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
- [Network] Install net-tools (for ipconfig).
- [Emacs] M-x package-refresh-contents.
- [Emacs] M-x package-install-selected-packages.
- [i3] Clone https://github.com/rkashapov/i3blocks-pomodoro to ~/repo.
- [i3] Remove regolith-i3-base-launchers (defaults).
- [i3] Remove regolith-i3-gaps-partial (defaults).
- [i3] Remove regolith-i3-i3xrocks (defaults).
- [i3] Remove regolith-i3-navigation (defaults).
- [i3] Remove regolith-i3-resize (defaults).
- [i3] Remove regolith-i3-workspace-config (defaults).
- [i3] Install i3xrocks-battery.
- [i3] Install i3xrocks-rofication.
- [i3] Install i3xrocks-volume.
- [i3] Install i3xrocks-weather.
- [Terminal] Create a new profile called "Monokai".
- [Terminal] Clone https://github.com/0xcomposure/monokai-gnome-terminal and run install.sh to update the "Monokai" profile to the Monokai color scheme.
- [Terminal] Set the "Monokai" profile as thedefault.
- [Bluetooth] Install blueman (Bluetooth on systray).

## Differences from stock Regolith v2.0
- [i3] Change window navigation/move keybindings to j/k/l/semicolon.
- [i3] Change alternate workspace navigation keybindings to j/semicolon.
- [i3] Change scratchpad keybindings to Minus.
- [i3] Reduce default gap to 0.
- [i3] Change horizontal split keybinding to h.
- [i3] Start Emacs daemon on startup.
- [i3] Add e keybinding to start an Emacs client.
- [i3] Add Pomodoro blocklet to bar.
- [i3] Add volume blocklet to bar.
- [i3] Add weather blocklet to bar.
- [Regolith] Set desktop and lockscreen wallpapers to one of the 22.04 wallpapers.
