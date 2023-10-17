%RotSym with a symmetric normal perturbation to each triangular segment
%with standard deviation 'sigma'

function tiles = Perturb(gen, sigma)
    
    init = [0,0];
    l = 10;
    p = normrnd(0,sigma,0.5*(gen+1)*(gen+2),2);

    for g = 2:gen+1  %radius of decagon; no of points on side
        a = [l*(g-1)/gen*cos(pi/5), l*(g-1)/gen*sin(pi/5)];
        b = [l*(g-1)/gen*cos(2*pi/5), l*(g-1)/gen*sin(2*pi/5)];
        for i = 1:g   %side index
            init = [init; a + (b-a)*i/g + p(0.5*g*(g-1)+i,:)];
        end
    end

    tiles = [];
    rot = [cos(pi/5), sin(pi/5); -sin(pi/5), cos(pi/5)];
    for i = 0:9
        tiles = [tiles; init * (rot^i)];
    end


end