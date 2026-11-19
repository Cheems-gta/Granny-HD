# Granny HD Mobile

**Current build path: Godot 4.4.1** — free, open-source, no Unity license necessary.

[**Open Godot Android APK builds**](https://github.com/Cheems-gta/Granny-HD/actions/workflows/godot-android.yml)

The active Android prototype lives in [`godot/`](./godot/). It is an **original standalone 3D test room**, not the original Granny game or a modified APK.

## Godot v0.3 features

- Original dark room with procedural weathered materials
- Mobile first-person touch movement and camera
- Interactive safe and wooden crate
- Metal panel, old television, and test furnishings
- Android ARM64 debug APK exported with Godot CI

**Cloud build status is not confirmed until the Godot Actions run succeeds.** If successful, download the `GrannyHD-Godot-Android-Debug` artifact and extract the APK from it. It needs no GitHub Actions secrets and no Unity activation.

The earlier `Assets/`, `Packages/` and `ProjectSettings/` folders are the archived **Unity** experiment. They are not part of the current Godot build. The original 2K candidate textures have not been uploaded to this public repository; the Godot v0.3 room uses **procedurally generated stand-in materials**.

See [Godot project instructions](./godot/README.md) for the exact workflow and touch controls. Do not publish extracted copyrighted game assets or any secrets.
