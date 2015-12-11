function plotMesh(mesh, style, color, az, el)

h = trimesh(mesh.F',mesh.V(1,:)',mesh.V(2,:)',mesh.V(3,:)', 'FaceColor', color, 'EdgeColor', 'none', 'AmbientStrength', 0.2, 'FaceLighting', 'phong', 'SpecularStrength', 1.0, 'SpecularExponent', 100);
set(gcf, 'Color', [1 1 0.9], 'Renderer', 'OpenGL');
set(gca, 'Projection', 'perspective');
axis equal;
axis off;

% adjust the view and camera when needed
view(3);
camtarget([0 0 0]);
camlight;




