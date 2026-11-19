extends Node3D

# This scene is independent/original. It does not load any original Granny assets.
const AGED_SHADER = preload("res://shaders/aged_surface.gdshader")
const PLAYER_SCRIPT = preload("res://scripts/player.gd")
const PROP_SCRIPT = preload("res://scripts/interactable.gd")

var _player: CharacterBody3D

func _ready() -> void:
    _create_environment()
    _create_room()
    _create_props()
    _create_player()
    _create_hud()

func _material(color: Color, grime: Color, pattern: int, rough: float, metallic: float = 0.0) -> ShaderMaterial:
    var m: ShaderMaterial = ShaderMaterial.new()
    m.shader = AGED_SHADER
    m.set_shader_parameter("base_color", color)
    m.set_shader_parameter("dust_color", grime)
    m.set_shader_parameter("material_kind", pattern)
    m.set_shader_parameter("surface_roughness", rough)
    m.set_shader_parameter("metallic_level", metallic)
    m.set_shader_parameter("pattern_scale", 6.0)
    return m

func _box(parent_node: Node3D, title: String, at: Vector3, size: Vector3, material: Material, target: Node3D = null) -> StaticBody3D:
    var body: StaticBody3D = StaticBody3D.new()
    body.name = title
    body.position = at
    parent_node.add_child(body)
    var shape: BoxShape3D = BoxShape3D.new()
    shape.size = size
    var collision: CollisionShape3D = CollisionShape3D.new()
    collision.shape = shape
    body.add_child(collision)
    var mesh: BoxMesh = BoxMesh.new()
    mesh.size = size
    var visible_mesh: MeshInstance3D = MeshInstance3D.new()
    visible_mesh.mesh = mesh
    visible_mesh.material_override = material
    body.add_child(visible_mesh)
    if target != null:
        body.set_meta("interact_target", target)
    return body

func _create_environment() -> void:
    var world: WorldEnvironment = WorldEnvironment.new()
    world.name = "Cold low-light environment"
    var env: Environment = Environment.new()
    env.background_mode = Environment.BG_COLOR
    env.background_color = Color(0.025, 0.035, 0.05)
    env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    env.ambient_light_color = Color(0.17, 0.22, 0.28)
    env.ambient_light_energy = 0.5
    env.fog_enabled = true
    env.fog_light_color = Color(0.11, 0.17, 0.22)
    env.fog_density = 0.018
    world.environment = env
    add_child(world)
    var light: OmniLight3D = OmniLight3D.new()
    light.name = "Ceiling light"
    light.position = Vector3(0.4, 2.83, 0)
    light.light_color = Color(0.68, 0.82, 1.0)
    light.light_energy = 1.65
    light.omni_range = 10.0
    light.shadow_enabled = true
    add_child(light)
    var lamp_material: StandardMaterial3D = StandardMaterial3D.new()
    lamp_material.albedo_color = Color(0.62, 0.78, 0.95)
    lamp_material.emission_enabled = true
    lamp_material.emission = Color(0.35, 0.52, 0.75)
    _box(self, "Ceiling bulb", Vector3(0.4, 2.86, 0), Vector3(0.22, 0.14, 0.22), lamp_material)

func _create_room() -> void:
    var floor_mat: Material = _material(Color(0.28,0.28,0.30), Color(0.08,0.08,0.095), 1, 0.53)
    var wall_mat: Material = _material(Color(0.42,0.43,0.43), Color(0.14,0.15,0.15), 3, 0.94)
    var ceiling_mat: Material = _material(Color(0.20,0.19,0.19), Color(0.06,0.07,0.08), 1, 0.84)
    var timber: Material = _material(Color(0.39,0.30,0.24), Color(0.10,0.085,0.077), 1, 0.83)
    _box(self, "Wet aged floor", Vector3(0,-0.2,0), Vector3(9,0.4,9), floor_mat)
    _box(self, "Ceiling", Vector3(0,3.05,0), Vector3(9,0.2,9), ceiling_mat)
    _box(self, "North wall", Vector3(0,1.5,4.5), Vector3(9,3,.22), wall_mat)
    _box(self, "South wall", Vector3(0,1.5,-4.5), Vector3(9,3,.22), wall_mat)
    _box(self, "West wall", Vector3(-4.5,1.5,0), Vector3(.22,3,9), wall_mat)
    _box(self, "East wall", Vector3(4.5,1.5,0), Vector3(.22,3,9), wall_mat)
    # Door, old TV and bench are generic props in the original test room.
    _box(self, "Old doorway frame left", Vector3(-0.9,1.2,4.3), Vector3(.18,2.4,.23), timber)
    _box(self, "Old doorway frame right", Vector3(0.9,1.2,4.3), Vector3(.18,2.4,.23), timber)
    _box(self, "Doorway lintel", Vector3(0,2.45,4.3), Vector3(1.98,.17,.23), timber)
    _box(self, "Bench base", Vector3(-3.3,.35,-.25), Vector3(1.2,.7,2.1), timber)
    _box(self, "Old TV cabinet", Vector3(-3.3,.65,2.5), Vector3(1.35,1.3,.7), timber)
    var tv_mat: Material = _material(Color(.15,.15,.16), Color(.04,.04,.05), 0,.45)
    _box(self, "Old CRT screen", Vector3(-3.3,1.55,2.5), Vector3(.8,.63,.45), tv_mat)

func _create_props() -> void:
    var safe_outer: Material = _material(Color(.33,.38,.40), Color(.08,.09,.09), 2,.53,.64)
    var safe_inner: Material = _material(Color(.28,.29,.31), Color(.10,.10,.11), 2,.43,.82)
    var wood: Material = _material(Color(.42,.30,.19), Color(.12,.08,.06), 1,.77)
    var metal: Material = _material(Color(.28,.25,.23), Color(.08,.06,.05), 2,.58,.67)
    var plate: Material = _material(Color(.32,.29,.28), Color(.14,.09,.06), 2,.52,.75)
    var safe: Node3D = Node3D.new()
    safe.name = "Interactive safe"
    safe.set_script(PROP_SCRIPT)
    safe.position = Vector3(-2.3,0,2.35)
    add_child(safe)
    _box(safe,"Safe box",Vector3(0,.86,0),Vector3(1.2,1.68,.85),safe_outer,safe)
    var safe_hinge: Node3D = Node3D.new()
    safe_hinge.name = "Safe door hinge"
    safe_hinge.position = Vector3(-.55,.86,-.5)
    safe.add_child(safe_hinge)
    _box(safe_hinge,"Safe door",Vector3(.55,0,0),Vector3(1.1,1.49,.1),safe_inner,safe)
    _box(safe_hinge,"Safe handle",Vector3(.91,0,-.12),Vector3(.12,.17,.11),metal,safe)
    safe.set("hinge",safe_hinge)
    safe.set("open_angle",-105.0)
    var crate: Node3D = Node3D.new()
    crate.name = "Interactive wooden crate"
    crate.set_script(PROP_SCRIPT)
    crate.position = Vector3(1.55,0,2.32)
    add_child(crate)
    _box(crate,"Crate body",Vector3(0,.51,0),Vector3(1.3,1.02,.95),wood,crate)
    _box(crate,"Left iron band",Vector3(-.55,.51,-.49),Vector3(.09,1.02,.09),metal,crate)
    _box(crate,"Right iron band",Vector3(.55,.51,-.49),Vector3(.09,1.02,.09),metal,crate)
    var lid_hinge: Node3D = Node3D.new()
    lid_hinge.name = "Crate lid hinge"
    lid_hinge.position = Vector3(0,1.05,.46)
    crate.add_child(lid_hinge)
    _box(lid_hinge,"Crate lid",Vector3(0,0,-.46),Vector3(1.35,.09,1.02),wood,crate)
    crate.set("hinge",lid_hinge)
    crate.set("hinge_axis",Vector3.RIGHT)
    crate.set("open_angle",-75.0)
    _box(self,"Rusted metal panel",Vector3(2.95,1.25,4.28),Vector3(1.55,1.5,.11),plate)
    _box(self,"Panel left bracket",Vector3(2.20,1.25,4.15),Vector3(.07,1.62,.2),metal)
    _box(self,"Panel right bracket",Vector3(3.70,1.25,4.15),Vector3(.07,1.62,.2),metal)

func _create_player() -> void:
    _player = CharacterBody3D.new()
    _player.name = "Player"
    _player.set_script(PLAYER_SCRIPT)
    _player.position = Vector3(0,.12,-2.8)
    _player.rotation.y = PI
    var cap: CapsuleShape3D = CapsuleShape3D.new()
    cap.radius = .28
    cap.height = 1.7
    var capsule: CollisionShape3D = CollisionShape3D.new()
    capsule.shape = cap
    capsule.position = Vector3(0,.85,0)
    _player.add_child(capsule)
    add_child(_player)

func _create_hud() -> void:
    var canvas: CanvasLayer = CanvasLayer.new()
    canvas.name = "Touch controls"
    add_child(canvas)
    var root: Control = Control.new()
    root.set_anchors_preset(Control.PRESET_FULL_RECT)
    root.mouse_filter = Control.MOUSE_FILTER_IGNORE
    canvas.add_child(root)
    var header: Label = Label.new()
    header.text = "Granny HD  |  GODOT TEST ROOM  |  Original procedural materials"
    header.position = Vector2(18,14)
    root.add_child(header)
    var guide: Label = Label.new()
    guide.text = "Left: move  |  Right: look  |  USE: safe / crate"
    guide.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
    guide.offset_left = 16
    guide.offset_top = -46
    guide.offset_right = 500
    guide.offset_bottom = -12
    root.add_child(guide)
    var crosshair: Label = Label.new()
    crosshair.text = "+"
    crosshair.set_anchors_preset(Control.PRESET_CENTER)
    crosshair.offset_left = -8
    crosshair.offset_top = -12
    crosshair.offset_right = 20
    crosshair.offset_bottom = 22
    crosshair.add_theme_font_size_override("font_size",25)
    root.add_child(crosshair)
    var use_button: Button = Button.new()
    use_button.text = "USE"
    use_button.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
    use_button.offset_left = -136
    use_button.offset_top = -124
    use_button.offset_right = -24
    use_button.offset_bottom = -30
    use_button.pressed.connect(func() -> void: _player.call("try_interact"))
    root.add_child(use_button)
