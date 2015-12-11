function mesh = loadMesh(filestr)
% loads a polygon mesh from <filestr>
% mesh can be either in OBJ or OFF format
    
fprintf(1, '\nReading %s..\n', filestr);
file = fopen( strtrim( filestr ), 'rt');
if file == -1
    warning(['Could not open mesh file: ' filestr]);
    mesh = [];
    return;
end
mesh.filename = strtrim( filestr );

if strcmp( filestr(end-3:end), '.off')
    fgetl(file);
    line = strtrim(fgetl(file));
    [token,line] = strtok(line);
    numverts = eval(token);
    [token,line] = strtok(line);
    numfaces = eval(token);
    curvert = 0;
    curface = 0;
    mesh.V = zeros( 3, numverts, 'single' );
    mesh.F = zeros( 3, numfaces, 'single' );
    
    data = dlmread(filestr, ' ', 2, 0);
    data = data(1:numverts+numfaces, :);
    mesh.V(1:3, 1:numverts) = data(1:numverts, 1:3)';
    mesh.F(1:3, 1:numfaces) = data(numverts+1:numverts+numfaces, 2:4)' + 1;
elseif strcmp( filestr(end-3:end), '.obj')
    mesh.V = zeros(3, 10^6, 'single');
    mesh.F = zeros(3, 5*10^6, 'uint32');
    v = 0;
    f = 0;
    
    while(~feof(file))
        line_type = fscanf(file,'%c',2);
        switch line_type(1)
            case '#'
                line = fgets(file);
            case 'v'
                if line_type(2) == 'n'
                    vn = vn + 1;
                    normal  = fscanf(file, '%f%f%f');
                    mesh.Nv(:, vn) = normal;
                elseif isspace( line_type(2) )
                    v = v + 1;
                    point = fscanf(file, '%f%f%f');
                    mesh.V(:, v) = point;
                else
                    fgets(file);
                end
            case 'f'
                f = f + 1;
                face = fscanf(file, '%u%u%u');
                mesh.F(:, f) = face;
            otherwise        
                if isspace(line_type(1))
                    fseek(file, -1, 'cof');
                    continue;
                end
                fprintf('last string read: %c%c %s', line_type(1), line_type(2), fgets(file));                
                fclose(file);                
                error('only triangular obj meshes are supported with vertices or faces.');
        end
    end
    
    mesh.V = mesh.V(:, 1:v);
    mesh.F = mesh.F(:, 1:f);   
end

fclose(file);

end
