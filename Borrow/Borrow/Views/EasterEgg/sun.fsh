void main()
{
  const float radius = 0.5;
  vec2 position = v_tex_coord - vec2(0.5, 0.5);
  
  if (length(position) > radius)
  {
    gl_FragColor = vec4(vec3(0.0), 0.0);
    
  }
  else
  {
    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
  }
}

