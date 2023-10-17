%Periodic tiling with 'gen' concentric equally spaced decagons; the ith decagon contains i
%masses on each side

function tiles = RotSym(gen)
    
    tiles = [];
    l = 10;
    for g = 1:gen+1  %radius of decagon; no of points on side
        for t = 1:10   %vertex index
            a = [l*(g-1)/gen*cos(t*pi/5), l*(g-1)/gen*sin(t*pi/5)];
            b = [l*(g-1)/gen*cos((t+1)*pi/5), l*(g-1)/gen*sin((t+1)*pi/5)];
            for i = 1:g   %side index
                tiles = [tiles; a + (b-a)*i/g];
        end
    end

end