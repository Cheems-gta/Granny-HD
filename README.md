## V0.6 — connected rooms, 59 PBR material sets (Android cloud build)

The latest full original Godot project ZIP is **Granny_HD_Godot_V0_6_Connected_House_Prototype.zip** (295 PNGs). The zip must be uploaded as an asset on a public Release with tag `v0.6-source` before cloud compilation, because the large textures are not committed to GitHub.

- [中文：手机构建 V0.6 APK 的步骤](./godot/V06_ANDROID_BUILD_CN.md)
- [V0.6 Android cloud-build workflow](./.github/workflows/godot-v06-android.yml)
- [GitHub Actions builds](https://github.com/Cheems-gta/Granny-HD/actions/workflows/godot-v06-android.yml)

**Current status:** workflow committed; APK build and device execution unverified. This is an independent prototype, not the proprietary original Granny APK.

---

# Granny HD Mobile — Godot 4.4.1

This repository hosts an **independent, original Android 3D material-test project** (not a modified proprietary Granny APK).

## Current development: V0.4 real-HD textures

The main Godot source now uses StandardMaterial3D with **Albedo, Normal, AO, Metallic and Roughness PNG maps** for eight categories: floor, walls, ceiling, safe casing, safe door, wooden crate, crate metal and rusted metal plate. It includes Android landscape controls, an original room and simple safe/crate interactions.

**The 40 large PNGs are not committed to GitHub yet.** The full-source ZIP with all textures and the 40-PNG material ZIP were supplied directly in the ChatGPT conversation. GitHub code alone cannot display the finished materials until the release asset is uploaded.

**Build a real-texture Android APK:** Follow the [mobile-friendly V0.4 build instructions](./godot/README_V0_4_HD_BUILD.md), then use the [V0.4 HD Android workflow](https://github.com/Cheems-gta/Granny-HD/actions/workflows/godot-hd-android.yml).

This workflow strictly verifies the texture archive SHA-256 and all 40 maps before generating an APK. A build without the real images is not treated as a V0.4 HD build.

## Original-game mapping limitation

The previous Granny 1.8 APK was only inspected at container-file level. Its Texture2D object IDs, Unity Material references and original UV layouts have **not** been resolved, so the original game assets have **not** been replaced. There is a separate library of 51 additional **candidate** materials for future authorized mapping.

## Project and history
- `godot/`: active Godot test project
- `godot/scripts/material_library.gd`: texture-based PBR loader
- `godot/scripts/main.gd`: independent material-test room and interactive props
- `godot/README_V0_4_HD_BUILD.md`: V0.4 full instructions
- `.github/workflows/godot-hd-android.yml`: actual-texture Android cloud build
- `.github/workflows/godot-android.yml`: old V0.3 source-only prototype; manual only
- `Assets/`, `Packages/`, `ProjectSettings/`: archived Unity source-only experiment

Only upload original or appropriately licensed assets; no proprietary Granny game files or access credentials are included here.
