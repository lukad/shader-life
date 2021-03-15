uniform vec2 size;

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position;
}
#endif

#ifdef PIXEL
float get(Image tex, vec2 texture_coords, int x, int y)
{
    vec2 coords = texture_coords + 1.0 / size * vec2(x, y);
    return Texel(tex, coords).r;
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    float current = get(tex, texture_coords, 0, 0);
    int alive = int(floor(current));
    float neighbors = floor(get(tex, texture_coords, -1,  1)) +
                    floor(get(tex, texture_coords, -1,  0)) +
                    floor(get(tex, texture_coords, -1, -1)) +
                    floor(get(tex, texture_coords,  0, -1)) +
                    floor(get(tex, texture_coords,  0,  1)) +
                    floor(get(tex, texture_coords,  1, -1)) +
                    floor(get(tex, texture_coords,  1,  0)) +
                    floor(get(tex, texture_coords,  1,  1));
    
    if (alive == 1 && (neighbors == 3 || neighbors == 2))
    {
        return vec4(1.0, 1.0, 1.0, 1.0);
    }

    if (neighbors == 3)
    {
        return vec4(1.0, 1.0, 1.0, 1.0);
    }

    current = max(current - 0.2, 0.0);

    return vec4(current, current, current, 1.0);

}
#endif
