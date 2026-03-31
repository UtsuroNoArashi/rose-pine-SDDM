# ABOUT
This is a (WIP) custom theme for SDDM.

## Colorscheme
By default the Rosé Pine theme is used (the `main` variant precisely),
but it can be easely changed, as many other properties. 
See: [`Customization`](#customization) for more details.

## Customization
The theme uses several config values, listed below. 
These can be modified at liking to obtain the look desired.

the following is a list of such properties with a brief explaination of each.
* `Backgrounds`: the path to the wallpaer. *Note:* the `path` must be accessible by sddm. For instance, something like `~/Pictures/wallpaper` won't work.

* `Variant`: if not null, it should specify the Rosé Pine variant to use.
Accepted values are `main, moon, dawn`, all other values are discarded and `main` will be used.

* `DeclareTheme`: set this to true to create a new theme, by providing a value for the following:
    - `NewBase`: the primary color (eg. background color for the wallpaer)
    - `NewSurface`: the secondary color 
    - `NewOverlay`: the tertiary color 
    - `NewText`: the texts color 
    - `NewSubtle`: the placeholder color 
    - `NewAccent`, `NewAccent2`, `NewAccent3`: the accent colors


# ToDos
1. Add a toolbar for session selection. keyboar layout, power menu and eventually the virtual keyboard.
2. The clock: both time and date should be displayed. Also, on hover an alternative time and date format should be displayed if defined in config.
3. The actural login form: one or more of the following should be possible.
    * Classic user and password text fields  + login button
    * userSelector (ComboBox) + password text field + login button
    * As above but the password text field is presented in an overlay panel
    * All the above decided by some config option
4. Details and optimizations 
5. Make it editable by [rose-pine-desktop-shell](https://github.com/UtsuroNoArashi/rose-pine-desktop-shell.git) once it get released.
