# Granny HD / Godot V0.4 — real 40-map HD material build

## Status
- Godot 4.4.1 source has been updated to call the **real PBR material loader** for 8 categories in `godot/scripts/main.gd`.
- The 40 PNG source maps (Albedo, Normal, AO, Metallic and Roughness) are packaged separately as **Granny_HD_Godot_V0_4_Materials.zip** (about 42 MB). They are not checked into GitHub.
- A **self-contained Godot project ZIP**, also provided in the ChatGPT conversation, includes the images under `godot/textures/` and scene source for local editing.
- A further 51 candidate materials (306 maps) are also available as a **separate additional library**, but are **not yet assigned to original Granny APK Texture2D objects**.
- No claim is made that the proprietary original Granny 1.8 APK is modified. This is an **independent original 3D material test room**.
- An Android APK is **not yet validated** for this 40-texture revision.

## Exact material assignments in the runnable original scene

| Surface | `res://textures` folder | Resolution |
|---|---|---|
| Old wooden floor | Floor | 2048 |
| Worn plaster wall | Walls | 2048 |
| Ceiling | Ceiling | 2048 |
| Safe casing | SafeBody | 1024 |
| Safe door | SafeDoor | 1024 |
| Crate body and lid, wood trim | Crate | 1024 |
| Crate straps, metal handle, old-TV shell | CrateMetal | 1024 |
| Rusted panel | SteelPlate | 1024 |

The original maps use metallic in the **R channel** and smoothness in **Alpha**; the updated material ZIP correctly creates separate `Metallic.png` and `Roughness.png` = inverse Alpha.

## Android cloud build from a phone: one-time release asset upload

GitHub Apps/connector can update the text source files, but cannot upload this 42 MB binary archive directly.

1. Download the exact file `Granny_HD_Godot_V0_4_Materials.zip` from this conversation onto your phone. **Do not rename or recompress it.**
2. Open [New GitHub release](https://github.com/Cheems-gta/Granny-HD/releases/new) in a browser; create tag **`v0.4-textures`** on **`main`**.
3. Add the material ZIP as a **release asset**, then publish the release. A public release is needed for the workflow to access the file.
4. Open [V0.4 HD workflow](https://github.com/Cheems-gta/Granny-HD/actions/workflows/godot-hd-android.yml). Publishing the release triggers a build, or manually select **Run workflow**.
5. The new workflow downloads the exact zip, checks SHA-256 and all 40 expected image paths, imports Godot files, builds and uploads an ARM64 debug APK artifact.
6. **Do not download the legacy V0.3 prototype as V0.4**; the legacy workflow is manual-only.

Required SHA-256:
`27dd4f261036d93c832118c302a08298bda56807966bc99a5aad84b2dc9c818f`

The workflow will **fail with a descriptive error** if this asset is missing instead of releasing a fake no-texture build.

## Acceptance criteria
- Real landscape full-screen presentation with no giant bars from portrait-only orientation
- Floor, wall, ceiling, safe, crate and plate genuinely show different PBR PNGs (not procedural stand-ins)
- First person touch movement, camera turn, and USE door/lid interactions work
- Check runtime memory usage of 2K textures on an actual Android device
- Texture naming, original Unity object IDs, and UVs in proprietary Granny 1.8 remain unverified

## Android build source
`.github/workflows/godot-hd-android.yml`
