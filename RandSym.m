%Generates 'points' uniformly random points within a triangular segment,
%and flips/rotates to fill out decagon

function tiles = RandSym(points)
        
    l = 10;
    tiles = [];
    
    %generate initial triangle
    init = [];
    a = [10*sin(pi/10), 10*cos(pi/10)];
    b = [10*sin(-pi/10), 10*cos(-pi/10)];
    c = [0,0];
    for p = 1:points
        r = rand(2,1);
        w1 = min(r);
        x = max(r);
        w2 = x - w1;
        w3 = 1 - w1;
        init = [init; w1*a + w2*b + w3*c];
    end
    
    v = [cos(pi/10); sin(pi/10)];
    Q = eye(2) - 2*v*v.';
    temp = init;
    temp = [temp; init*Q];
    
    rot = [cos(2*pi/5), sin(2*pi/5); -sin(2*pi/5), cos(2*pi/5)];
    
    for i = 1:5
        tiles = [tiles; temp];
        temp = temp * rot;
    end

end