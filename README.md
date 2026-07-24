<div align="center">

<img src="bin/iconLarge.png" alt="Foxhole AutoClicker logo" width="150">

# Foxhole AutoClicker

**Tabbed-out hotkeys for [Foxhole](https://www.foxholegame.com/) — single-action autoclickers that are allowed by the game's TOS.**

![Version](https://img.shields.io/badge/version-2.1.0-2d7dd2)
&nbsp;
![Platform](https://img.shields.io/badge/platform-Windows-0078d6?logo=windows&logoColor=white)
&nbsp;
![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v1.1-334f6f)

<img src="images/main-gui.png" alt="Main GUI" width="240">
&nbsp;&nbsp;
<img src="images/change-keybinds.png" alt="Change Keybinds page" width="300">

</div>

## About

Foxhole AutoClicker is a small AutoHotkey program that provides hotkeys which work **while tabbed out** — you can use your mouse and keyboard freely while they're active. Every hotkey is a single-action autoclicker custom-made for Foxhole and permitted under the game's Terms of Service.

## Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Default keybinds](#default-keybinds)
  - [Changing keybinds](#changing-keybinds)
- [Running without the GUI](#running-without-the-gui)
- [Troubleshooting](#troubleshooting)
- [Changelog](#changelog)
- [Contact](#contact)
- [Credits](#credits)

## Features

| Hotkey | What it does |
| --- | --- |
| **Spam Left Click at location** | Simulates clicks at the spot where you pressed the hotkey. **Holds Shift down** the whole time it spams (for pulling full stacks) and releases it when you toggle off. |
| **Hold W / Hold S** | Holds forward / backward movement. **Hold W** also spams your **Open Gate** key so gates open automatically as you run through them. |
| **Hold Right Click** | For rotating cranes, binoculars, and aiming. |
| **Hold Left Click** | For harvesters and building. |
| **Spam Left Building** | Build with a hammer/shovel/etc. without your character turning as the mouse moves. |
| **Auto Arty Reloader** | Spams reload (R) + left click to keep an artillery piece firing and reloading. |
| **Auto Border Base Camping** | Spams E. |

> **Note:** Spam Left Click, Auto Arty Reloader, and Auto Border Base Camping use real key/click input, so keep Foxhole focused while using them. The remaining hotkeys work while tabbed out.

## Installation

This program requires [AutoHotkey **v1.1**](https://www.autohotkey.com/download/ahk-install.exe) — install it first.

Then download the program from the [Releases page](https://github.com/metroshica/Foxhole-AutoClicker/releases) on the right-hand side of this page. Grab the most recent release — a zip file named `FoxholeAutoClicker` — and drag the folder inside anywhere on your PC. To launch the GUI, double-click the **Foxhole AutoClicker** file.

## Usage

Launch the GUI, then press **Start Hotkeys**. Use **Suspend Hotkeys** to pause them and **Close Hotkeys** to stop them entirely.

### Default keybinds

| Key | Action |
| --- | --- |
| `F2` | Spam Left Click at location (holds Shift) |
| `F3` | Hold W |
| `F4` | Hold S |
| `F5` | Spam Left Building |
| `F6` | Hold Right Click |
| `F7` | Hold Left Click |
| `9` | Auto Arty Reloader |
| `0` | Auto Border Base Camping |
| `F9` | Suspend Hotkeys |
| `F10` | Exit Hotkeys |

### Changing keybinds

Click **Change Keybinds** in the GUI. Each row shows its current key on a button — click that key, then press the key or key combination of your choice (press **Esc** to cancel). Modifiers and extra keys (Shift, Alt, mouse buttons, etc.) all work. **Reset Defaults** restores every bind to the defaults above.

Changes are saved to `bin/KeyBindings.ini` and persist between sessions. Restart the hotkeys from the GUI for changes to take effect.

## Changelog

**v2.1.0** - **New hotkey: Auto-Conc (default `\`)** — automates submitting concrete to a building from a pallet. It presses V, waits, left-clicks to deposit, and repeats; works tabbed out like the other click hotkeys, with a rebindable keycap and a hover tooltip in the Change Keybinds menu. **Spam Left Click (F2) now actually holds Shift in-game.** It presses a real Shift key for the whole spam and releases it on toggle-off (previously the game often ignored the held modifier); keep Foxhole focused while using it. **GUI redesign:** centered layout with grouped buttons, larger centered logo, bold title with version tag, the new logo as the window/tray icon, and the Maximize button disabled. **Change Keybinds page overhaul:** every bind shows its current key on a clickable "keycap" button that updates instantly when you rebind, pressing Esc now cancels a rebind (it used to blank the key), added a **Reset Defaults** button, and renamed "View Keybinds" to "Open Config File". Start/Suspend/Close now show a brief confirmation message.

**v2.0** - Added two new hotkeys: Auto Arty Reloader (default `9`, spams R + left click) and Auto Border Base Camping (default `0`, spams E), each with its own button in the Change Keybinds menu. New 2.0 logo. Note: these two hotkeys send to the focused window (keep Foxhole focused), unlike the tabbed-out hotkeys.

**v1.3** - F2 (Spam Left Click) now holds Shift while spamming. Hold W (F3) now also spams a configurable "Open Gate" key (default N) the whole time W is held, so gates open automatically as you run through - set the key with the GUI's "Set In-Game Open Gate Key (Hold W)" button or in `bin/KeyBindings.ini` under `[Keys] Open Gate Key`. All keybinds now fall back to their defaults if missing from the ini, so an old KeyBindings.ini won't break the hotkeys.

**v1.2** - Now allows you to use the Shift key while W/S hotkeys are active, which was previously impossible. This means you can now type capital letters and more. Some shift key presses may miss, and the character will stop holding W/S for about half a second on tab out, but it is still a significant improvement.

**v1.1** - Adds the "Spam Left Building" key. This key allows you to build with a hammer/shovel/etc without your character changing direction when your mouse moves.

**v1.0** - Initial release.

## Running without the GUI

The program is essentially two AutoHotkey scripts — one for the GUI and one for the Foxhole hotkeys. The GUI just makes it easy to set keybinds and start/stop the hotkeys. You can stop or suspend either script from the system tray in the bottom-right of your taskbar.

- **Skip the GUI:** the Foxhole hotkey script lives in the `bin` folder as `FoxholeHotkeys`. Double-click it to launch, or right-click → *Create shortcut* to pin it to your taskbar.
- **Set keybinds by hand:** for AutoHotkey users, `bin/FoxholeHotkeysManual` is a manual version of the script. Right-click → *Edit* it to set keybinds directly; instructions are in the script's comments.

## Troubleshooting

- **A hotkey does nothing in-game.** Spam Left Click, Auto Arty Reloader, and Auto Border Base Camping send real input to the focused window — make sure Foxhole is focused when using them.
- **Keybind changes aren't applied.** Restart the hotkeys from the GUI after changing a bind; changes only load on start.

## Contact

Have a question, bug, or feature request? [Open an issue](https://github.com/metroshica/Foxhole-AutoClicker/issues) on this repo.

## Credits

This is a fork of the original [Foxhole AutoClicker by Tommythebold](https://github.com/Tommythebold/Foxhole-AutoClicker). Big thanks to Tommythebold for creating and maintaining the original tool that this builds on.
