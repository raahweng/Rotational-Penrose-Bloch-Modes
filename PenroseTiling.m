%Penrose Tiling; gen = number of deflations

function tiles = PenroseTiling(gen)
    tau = 2/(1+sqrt(5));
    l = 10;
    
    %Store Acute and Obtuse Robinson triangles separately
    %n triangles stored in n*3*2 array of vertices in order of handedness
    
    %P2 Sun initial condition
    acute = zeros(10,3,2);
    obtuse = double.empty(0,3,2);

    for i = 1:10
        %Flipping handedness of alternate triangles
        acute(i,3-mod(i,2),1) = cos(2*pi/10*(i-1));
        acute(i,3-mod(i,2),2) = sin(2*pi/10*(i-1));
        acute(i,2+mod(i,2),1) = cos(2*pi/10*i);
        acute(i,2+mod(i,2),2) = sin(2*pi/10*i);
    end
    acute = l*acute;
    
    % %P2 Rhombus initial condition
    % acute = double.empty(0,3,2);
    % obtuse = zeros(2,3,2);
    % a = l*[1,0];
    % b = l*[cos(pi/5),-sin(pi/5)];
    % obtuse(1,1,:) = a;
    % obtuse(1,3,:) = a + b;
    % obtuse(2,1,:) = b;
    % obtuse(2,3,:) = a + b;



    
    %Inflation step(s)
    for g = 1:gen
        
        %Initialise new acute/obtuse arrays
        an = size(acute,1) * 2 + size(obtuse,1);
        on = size(acute,1) + size(obtuse,1);
        anew = zeros(an,3,2);
        onew = zeros(on,3,2);
        ac = 1;
        oc = 1;
        
        %Decomposing acute triangles
        for i = 1:size(acute,1)
            a = acute(i,1,:);
            b = acute(i,2,:);
            c = acute(i,3,:);
            p1 = tau * (a - b) + b;
            p2 = tau * (c - a) + a;
    
            anew(ac,:,:) = [b; p1; p2];
            anew(ac+1,:,:) = [b; c; p2];
            ac = ac + 2;
    
            onew(oc,:,:) = [p1; p2; a];
            oc = oc + 1;
        end
        
        %Decomposing obtuse triangles
        for i = 1:size(obtuse,1)
            a = obtuse(i,1,:);
            b = obtuse(i,2,:);
            c = obtuse(i,3,:);
            p = tau * (b - c) + c;
    
            anew(ac,:,:) = [c; p; a];
            ac = ac + 1;
    
            onew(oc,:,:) = [p; a; b];
            oc = oc + 1;
        end
        
        acute = anew;
        obtuse = onew;
    
    end
    
    
    % %Plot triangles
    % for i = 1:size(acute,1)
    %     plot(polyshape(acute(i,:,1), acute(i,:,2)), "FaceColor","y")
    %     hold on
    % end
    % for i = 1:size(obtuse,1)
    %     plot(polyshape(obtuse(i,:,1), obtuse(i,:,2)), "FaceColor","b")
    %     hold on
    % end
    % 
    % pause
    % hold off
    
    %Plot lattice points
    tiles = round([acute; obtuse], 7);
    tiles = unique([reshape(tiles(:,:,1),1,[]); reshape(tiles(:,:,2),1,[])].', "rows");
    % scatter(tiles(:,1), tiles(:,2))
end