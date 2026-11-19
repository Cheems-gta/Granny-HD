# Granny HD Mobile — original material test prototype

This is a **standalone Unity 2021.3.11f1 Android prototype**, not a modified Granny game. It uses original test-room geometry, a safe, a crate, a metal plate, and a first-person controller.

## Current GitHub version

The original 46 MB texture bundle is **not included** because it could not be uploaded through the connected text-file interface. Until it is added, the scene uses clearly labelled **flat placeholder materials**. This repository does not contain any unpacked copyrighted game assets or Unity license.

For full candidate PBR textures, you can add the PNGs later under `Assets/GrannyHD/Textures/<MaterialName>/Albedo.png` for each of: Floor, Walls, Ceiling, SafeBody, SafeDoor, Crate, CrateMetal, SteelPlate. These are user-created replacement textures, not original game resources.

## Cloud build

Workflow: `.github/workflows/android-apk.yml`. It runs on commits to `main` or by manual dispatch. It uses GameCI / Unity Builder with Unity 2021.3.11f1, Android ARM64, and IL2CPP.

A valid Unity license must first be configured as the GitHub Actions **repository secret** `UNITY_LICENSE`. Never commit license text, passwords, `.ulf` files, or other secrets to a public repository. The cloud workflow intentionally stops with a readable message if this secret is missing.

When a build succeeds, download artifact `GrannyHD-Android-Prototype` from the relevant GitHub Actions run. This repository has **not been tested through Unity yet**. The first run is expected to reveal any missing prerequisites or compile errors.

## Controls

On phone: left screen drag to move, right screen drag to look, USE to open/close safe door or crate lid. On PC: WASD + mouse, E to interact.

## Copyright and publication

Do not publish the original Granny APK, its extracted copyrighted resources, or a modified APK as though you own them. This is a standalone technical demonstration and must use original or authorized assets.
