# Granny HD V0.6 — complete project archive verification

The full independent Godot 4.4.1 prototype is stored as `Granny_HD_Godot_V0_6_Connected_House_Prototype.zip` in the owner's project files. **This file is not yet uploaded to GitHub.** This record documents the precise, verified package to attach to release tag `v0.6-source`.

- ZIP byte length: `150027421` (about 143.08 MiB)
- SHA-256: `db31e5e52e9931e8265bb9f56e4cd76b044ff7fe34f13a4bd73a4eed162c919f`
- Archive entries: `309`
- PBR PNG files: `295` (59 five-map material sets)
- Project entry: `godot/project.godot`
- Main scene: `godot/scenes/main.tscn`
- V0.6 room script: `godot/scripts/room_wing.gd`
- Material gallery: `godot/scripts/material_showcase.gd`
- V0.6 material mapping: `V0_6_OBJECT_MATERIAL_MAPPING.csv`
- Android export preset: `godot/export_presets.cfg`

The archive was inspected and its SHA-256 independently computed; the value matches `.github/workflows/godot-v06-android.yml`. The existing GitHub repository only contains the earlier source code and the V0.6 build workflow; it **does not** include the full V0.6 texture assets until the ZIP is attached to the release.

## Next publication step

1. Open [Create a release](https://github.com/Cheems-gta/Granny-HD/releases/new).
2. Create tag `v0.6-source` on `main`, title `Granny HD V0.6 source materials`.
3. Attach the **unaltered** file `Granny_HD_Godot_V0_6_Connected_House_Prototype.zip` (do not extract or recompress it).
4. Publish the release, then check [V0.6 Android workflow](https://github.com/Cheems-gta/Granny-HD/actions/workflows/godot-v06-android.yml).

This is an independently authored prototype, not the original Granny game or a modified proprietary APK. The ZIP has not been successfully compiled to a tested APK as of this verification.
