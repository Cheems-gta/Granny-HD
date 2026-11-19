shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx, cull_back;

uniform vec4 base_color : source_color = vec4(0.24, 0.22, 0.22, 1.0);
uniform vec4 dust_color : source_color = vec4(0.13, 0.12, 0.12, 1.0);
uniform float pattern_scale = 6.0;
uniform float metallic_level = 0.0;
uniform float surface_roughness = 0.85;
uniform int material_kind = 0;

float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}
float noised(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f*f*(3.0-2.0*f);
    return mix(mix(hash21(i), hash21(i+vec2(1.0,0.0)), u.x),
        mix(hash21(i+vec2(0.0,1.0)), hash21(i+vec2(1.0,1.0)), u.x), u.y);
}
float fbm(vec2 p) {
    float v=0.0;
    float a=0.5;
    for (int i=0;i<4;i++) {
        v += a*noised(p);
        p *= 2.05;
        a *= 0.5;
    }
    return v;
}
void fragment() {
    vec2 u=UV*pattern_scale;
    float weather=fbm(u*2.0);
    float streak=fbm(vec2(u.x*0.75,u.y*6.0));
    float tint_mix=clamp(0.08+weather*0.72,0.0,1.0);
    vec3 col=mix(dust_color.rgb,base_color.rgb,tint_mix);
    if (material_kind==1) {
        // Grain and aged grain scratches in wood.
        float grain=fbm(vec2(u.x*0.6,u.y*13.0));
        float seams=1.0-smoothstep(0.012,0.038,fract(u.x*0.55));
        col *= 0.69+grain*0.55;
        col *= 1.0-seams*0.37;
    } else if (material_kind==2) {
        // Rust and old paint flecks.
        float rust=fbm(u*4.0);
        col=mix(col,vec3(0.26,0.12,0.068),smoothstep(0.53,0.75,rust)*0.54);
    } else if (material_kind==3) {
        // Weathered plaster with damp areas.
        col*=0.78+streak*0.35;
    } else {
        // Stone/concrete, mottled with dirt.
        col*=0.82+fbm(u*5.0)*0.3;
    }
    ALBEDO=clamp(col,vec3(0.015),vec3(0.95));
    METALLIC=metallic_level;
    ROUGHNESS=clamp(surface_roughness+(weather-0.5)*0.13,0.12,1.0);
}
