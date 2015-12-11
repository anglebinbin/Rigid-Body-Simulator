function mesh = rbfReconstruction(input_point_cloud_filename, epsilon)
% surface reconstruction with an implicit function f(x,y,z) computed
% through RBF interpolation of the input surface points and normals
% input: filename of a point cloud, parameter epsilon
% output: reconstructed mesh

% load the point cloud
data = load(input_point_cloud_filename)';
points = data(1:3, :);
normals = data(4:6, :);

% construct a 3D NxNxN grid containing the point cloud
% each grid point stores the implicit function value
% set N=16 for quick debugging, use *N=64* for reporting results
N = 64;
max_dimensions = max(points(1:3,:),[],2); % largest x, largest y, largest z coordinates among all surface points
min_dimensions = min(points(1:3,:),[],2); % smallest x, smallest y, smallest z coordinates among all surface points
bounding_box_dimensions = max_dimensions - min_dimensions; % compute the bounding box dimensions of the point cloud
grid_spacing = max( bounding_box_dimensions ) / (N-9); % each cell in the grid will have the same size
[X,Y,Z] = meshgrid( min_dimensions(1)-grid_spacing*4:grid_spacing:max_dimensions(1)+grid_spacing*4, ...
                    min_dimensions(2)-grid_spacing*4:grid_spacing:max_dimensions(2)+grid_spacing*4, ...
                    min_dimensions(3)-grid_spacing*4:grid_spacing:max_dimensions(3)+grid_spacing*4 );                
fprintf('Constructed grid with %d x %d x %d points and spacing %f\n', size(X,1), size(X,2), size(X,3), grid_spacing);
IF = zeros( size(X) ); % this is your implicit function - fill it with correct values!

n = size(points, 2);
M = zeros(2 * n, 2 * n);
w = zeros(2 * n, 1);
d = zeros(2 * n, 1);
c = [points, points + epsilon * normals]; 

for i = 1: 2 * n
    for j = 1: 2 * n
        M(i, j) = sum((norm(c(:, i) - c(:, j)))^3);
    end
end

d(n + 1: 2 * n, 1) = epsilon;

w = M \ d;

for i = 1: numel(X)
    p(1:3, 1:2*n) = 0;
    p(1, :) = X(i);
    p(2, :) = Y(i);
    p(3, :) = Z(i);
    IF(i) = sum(w .* ((sqrt(sum((p - c).^2))).^3)');
end

[mesh.F, mesh.V] = isosurface(X, Y, Z, IF, 0);
mesh.F = mesh.F';
mesh.V = mesh.V';
