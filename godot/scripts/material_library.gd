extends RefCounted

# Maps are extracted from the original Granny HD source material ZIP.
# Godot textures: Albedo / Normal / AO / Metallic / Roughness.
# Missing maps intentionally show bright magenta rather than silently using fake HD.
static func from_pack(material_name: String, tile: Vector2 = Vector2.ONE) -> StandardMaterial3D:
    var base: String = "res://textures/%s/" % material_name
    var mat: StandardMaterial3D = StandardMaterial3D.new()
    mat.resource_name = "HD_" + material_name
    mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
    mat.texture_repeat = BaseMaterial3D.TEXTURE_REPEAT_ENABLED
    mat.uv1_scale = Vector3(tile.x, tile.y, 1.0)
    mat.roughness = 1.0
    mat.metallic = 1.0

    var albedo: Texture2D = _get(base + "Albedo.png")
    if albedo == null:
        push_error("GRANNY HD MISSING REAL TEXTURE: " + base + "Albedo.png")
        mat.albedo_color = Color(1.0, 0.0, 0.7)
        return mat
    mat.albedo_texture = albedo

    var normal: Texture2D = _get(base + "Normal.png")
    if normal != null:
        mat.normal_enabled = true
        mat.normal_texture = normal
        mat.normal_scale = 0.65

    var ao: Texture2D = _get(base + "AO.png")
    if ao != null:
        mat.ao_enabled = true
        mat.ao_texture = ao
        mat.ao_light_affect = 0.35

    var metallic: Texture2D = _get(base + "Metallic.png")
    if metallic != null:
        mat.metallic_texture = metallic
        mat.metallic_texture_channel = BaseMaterial3D.TEXTURE_CHANNEL_RED
    else:
        mat.metallic = 0.0

    var roughness: Texture2D = _get(base + "Roughness.png")
    if roughness != null:
        mat.roughness_texture = roughness
        mat.roughness_texture_channel = BaseMaterial3D.TEXTURE_CHANNEL_RED
    else:
        mat.roughness = 0.8
    return mat

static func _get(path: String) -> Texture2D:
    if not ResourceLoader.exists(path):
        return null
    return load(path) as Texture2D
