function handle = plotMesh(mesh, handle)



if exist('handle', 'var') % deletes previous mesh

    delete(handle);

    hold on;  % keep drawing in the same window

    handle = trimesh(mesh.F',mesh.V(1,:)',mesh.V(2,:)',mesh.V(3,:)', 'FaceColor', 'w', 'EdgeColor', 'none', 'AmbientStrength', 0.2, 'FaceLighting', 'phong', 'SpecularStrength', 1.0, 'SpecularExponent', 100);

else % draw for the first time    

    handle = trimesh(mesh.F',mesh.V(1,:)',mesh.V(2,:)',mesh.V(3,:)', 'FaceColor', 'w', 'EdgeColor', 'none', 'AmbientStrength', 0.2, 'FaceLighting', 'phong', 'SpecularStrength', 1.0, 'SpecularExponent', 100);

    set(gcf, 'Color', 'w', 'Renderer', 'OpenGL');

    set(gca, 'Projection', 'perspective');



    max_dimensions = max(mesh.V(1:3,:),[],2); % largest x, largest y, largest z coordinates among all surface points

    min_dimensions = min(mesh.V(1:3,:),[],2); % smallest x, smallest y, smallest z coordinates among all surface points

    bounding_box_dimensions = max_dimensions - min_dimensions; 

    max_box_dimension = max( bounding_box_dimensions );  

    axis(max_box_dimension*[-10 10 -10 10 -10 10]); % ***you may want to adjust the size of the plot here***

    %axis equal;

    %axis off;

    camlight;    

end    



drawnow;