# Discord Rich Presence for Qt Creator 20

Discord Rich Presence plugin for Qt Creator, updated to work with **Qt
Creator 20**.

This fork keeps the original plugin functionality while adding
compatibility changes for newer Qt Creator APIs and live tracking of the
currently active editor.

> **Tested configuration:** Qt Creator **20.0.2**, Qt **6.11.2 MSVC 2022
> x64**, Windows x64.

![](screenshots/demo_cycle_20fps.gif?raw=true)

## What this fork changes

-   Qt Creator 20 compatibility
-   C++20 build configuration
-   Qt 6.11 / MSVC 2022 x64 support
-   Qt Creator 20 compatible plugin metadata
-   Live tracking of the active editor
-   Discord presence updates automatically when switching files
-   Displays information about the current file, project, and recognized
    file type
-   Resets the per-file editing timer when the active file changes
-   Includes `build_windows_msvc.bat` for an easier Windows build

## Recognized File Types

  -----------------------------------------------------------------------
  Category                            Extensions
  ----------------------------------- -----------------------------------
  Qt/QMake                            `.pro` `.pri` `.ui` `.qrc` `.qml`
                                      `.qss`

  C/C++                               `.cpp` `.hpp` `.cxx` `.hxx` `.cc`
                                      `.hh` `.c` `.h` `.i`

  Other Langs                         `.py` `.rb` `.rs` `.js` `.css`
                                      `.html` `.lua` `.java` `.asm`

  Data & Text                         `.json` `.xml` `.txt` `.md`

  Misc                                `.gitignore` `Makefile`
                                      `CMakeLists.txt`
  -----------------------------------------------------------------------

## Requirements

The Qt Creator 20 version of this fork has been tested on **Windows
x64** with:

-   Qt Creator 20.0.2
-   Qt 6.11.2 --- MSVC 2022 x64
-   Qt Creator Plugin Development files
-   Visual Studio 2022 Build Tools
-   MSVC v143 x64/x86 build tools
-   Windows SDK
-   CMake
-   Discord desktop client

Other versions or platforms may work, but they have not been tested by
this fork's maintainer.

## Building on Windows

### 1. Install Qt

Using the Qt Maintenance Tool, install:

-   **Qt 6.11.2 → MSVC 2022 x64**
-   the **Qt Creator Plugin Development** component

Do not install only the `Qt Insight Tracker` MSVC package. The complete
Qt MSVC 2022 x64 package is required.

A typical Qt installation used by the build script is:

``` text
C:\Qt\6.11.2\msvc2022_64
```

### 2. Install MSVC Build Tools

Install Visual Studio 2022 Build Tools with **Desktop development with
C++**.

The installation should include MSVC v143 and a Windows SDK.

### 3. Build the plugin

Open **x64 Native Tools Command Prompt for VS 2022**, go to the
repository directory, and run:

``` bat
build_windows_msvc.bat
```

If your Qt or Qt Creator installation is in a different location, adjust
the paths used by the build script or provide the appropriate CMake
paths for your system.

After a successful build, the plugin DLL should be generated under:

``` text
build\lib\qtcreator\plugins\CuteDiscordPresence.dll
```

## Running the plugin without installing it

Close any existing Qt Creator instance and launch Qt Creator with the
generated plugin directory:

``` bat
"C:\Qt\Tools\QtCreator\bin\qtcreator.exe" -pluginpath "C:\path\to\qtcreator-plugin-discord-presence\build\lib\qtcreator\plugins"
```

Replace `C:\path\to\qtcreator-plugin-discord-presence` with the actual
repository location.

You can also add `-temporarycleansettings` (or `-tcs`) while testing:

``` bat
"C:\Qt\Tools\QtCreator\bin\qtcreator.exe" -pluginpath "C:\path\to\qtcreator-plugin-discord-presence\build\lib\qtcreator\plugins" -tcs
```

After Qt Creator starts, check **Help → About Plugins** and verify that
**Cute Discord Presence** is loaded.

Keep the Discord desktop client running. Open a project and switch
between source files in Qt Creator; the Rich Presence should update
automatically.

## Manual CMake build

You can also build without the helper script:

``` bat
cmake -S . -B build -DCMAKE_PREFIX_PATH="C:\Qt\6.11.2\msvc2022_64;C:\Qt\Tools\QtCreator"
cmake --build build --config RelWithDebInfo
```

The exact Qt Creator development package path may differ depending on
your Qt installation.

## Troubleshooting

### `QtCreatorConfig.cmake` could not be found

Install the **Qt Creator Plugin Development** component using the Qt
Maintenance Tool and make sure CMake can find the Qt Creator development
package.

### `std::type_identity` or similar C++ errors

This fork requires **C++20**. The included `CMakeLists.txt` is
configured accordingly.

### `Value "...-qtc20" for key "Version" has invalid format`

Qt Creator requires a numeric plugin version. The plugin metadata must
use a value such as:

``` json
"Version": "1.0.2"
```

Release/tag names may still contain a suffix such as `v1.0.2-qtc20`; the
plugin metadata itself should remain numeric.

### Discord says `Not Currently Editing Anything`

This fork includes updated Qt Creator 20 editor tracking. Make sure you
are using the modified Qt Creator 20 build from this repository and that
an editor file is actually open.

## Upstream, Credits and License

This repository is a **fork** of
[eduardoc7/qtcreator-plugin-discord-presence](https://github.com/eduardoc7/qtcreator-plugin-discord-presence).

The original plugin, its previous work, assets, and contributions belong
to their respective authors and contributors. This fork primarily
provides compatibility changes for Qt Creator 20 and newer build
requirements.

Original README credit preserved:

-   [@PsychedelicShayna](https://github.com/PsychedelicShayna)

Please also see the upstream repository's commit history for the
complete contributor history.

This fork keeps the original project's **GNU General Public License v3.0
(GPL-3.0)**. See the [`LICENSE`](LICENSE) file for the full license
text.

## Upstream support

If you find this project useful, consider supporting the upstream
maintainer:

`<a href="https://buymeacoffee.com/eduardocorg" target="_blank">`{=html}`<img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174">`{=html}`</a>`{=html}
