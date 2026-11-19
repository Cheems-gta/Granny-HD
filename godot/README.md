# Granny HD Mobile — Godot prototype v0.3

## Status
This is an **original standalone test room** built in Godot 4.4.1. It is **not a rebuilt/unpacked Granny APK**. The first version uses procedural aged surfaces rather than the previously created 2K PNG materials, which are not yet uploaded to the public repository.

## What's included
- First-person CharacterBody3D controller for Android touch and PC WASD/mouse
- Original 3D test room, safe door opening, crate lid opening, metal plate, old TV, wooden bench
- Procedurally weathered shader surfaces, low blue lighting, dark indoor atmosphere
- Godot Android export preset for an **ARM64 debug APK**
- Cloud workflow: .github/workflows/godot-android.yml

## Android builds from a phone
1. Open the repository **Actions** tab.
2. Select **Godot Android APK (no Unity license)**.
3. Run the workflow or open the newest run after a commit.
4. On success, open **Artifacts** → **GrannyHD-Godot-Android-Debug**.
5. Download the zip and extract the APK on your phone before installing.

**No Unity account, Unity license, or GitHub repository secrets are needed** for this debug-only Godot build. The build container provides an Android debug keystore. This is not signed for Google Play distribution.

## Testing controls
- Phone: drag the **left** side to move, **right** side to turn, **USE** to open or close safe/crate when close
- Desktop: WASD/mouse/E
- The test project is an empty-room prototype; there is no Granny enemy, full house, objectives, or gameplay

## Repository layout
- `godot/project.godot`: Godot project config
- `godot/scenes/main.tscn`: main scene
- `godot/scripts/*.gd`: scene, controller, and interaction
- `godot/shaders/*.gdshader`: procedural materials
- `godot/export_presets.cfg`: Android export preset
- `.github/workflows/godot-android.yml`: CI build

## Next steps
1. Get a successful debug APK from Actions; fix real build logs if failed
2. Test controls and interactions on Android
3. Import the previously created original HD candidate PNGs
4. Only later consider a separate larger scene, using original/authorized assets
