# DeadlockTaunt

AutoHotkey v2 script that automatically sends a taunt in Deadlock chat when an Infernus (can be changed to your character + voicelines) kill appears in the kill feed.

## How it works

The script watches a specific pixel on your screen. When the Infernus kill feed icon color is detected, it opens chat and types a random taunt message.

## Setup

1. Install [AutoHotkey v2](https://www.autohotkey.com/)
2. Run `colorpicker.ahk` — hover over the Infernus kill feed icon in-game to find the exact pixel coordinates and color
3. Update `PIXEL_X`, `PIXEL_Y`, and `TARGET_COLOR` in `infernustext.ahk` with those values
4. Run `infernustext.ahk`

## Configuration

Edit the top of `infernustext.ahk`:

| Variable | Default | Description |
|---|---|---|
| `PIXEL_X` / `PIXEL_Y` | `343`, `286` | Screen coordinate to watch | (Should be changed using colorpicker.ahk. This is infernus specific!!!)
| `TARGET_COLOR` | `0xE54E3A` | Infernus icon color (red-orange) |
| `COLOR_TOLERANCE` | `0` | How much color can vary and still match |
| `POLL_INTERVAL` | `500` | How often to check the pixel (ms) |
| `TAUNT_COOLDOWN` | `5000` | Minimum time between taunts (ms) |

## Hotkeys

- **F10** — toggle the script on/off

## Adding taunts

Edit the `taunts` array in `infernustext.ahk`. Add or remove lines freely, just keep the commas.

## Files

- `infernustext.ahk` — main script
- `colorpicker.ahk` — helper to find pixel coordinates and color values
