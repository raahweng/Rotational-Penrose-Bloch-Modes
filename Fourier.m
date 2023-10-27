%Runs single simulation and outputs fft2 of data.

function fourier = Fourier(Omega)

    %% Build lattice
    X = 1.0;
    Y = 1.0;
    
    %%%%%%%%%%%%%%%%%% Construction of Lattice
    a = 1; %magnitude of lattice vectors
    thetaBasis = 2*pi/5;
    
    a1Un = a*[cos(thetaBasis) sin(thetaBasis)];
    a2Un = a*[-cos(thetaBasis) sin(thetaBasis)];
    
    a1 = a*[X*cos(thetaBasis) Y*sin(thetaBasis)];   %scaled lattice basis x direction
    a2 = a*[-X*cos(thetaBasis) Y*sin(thetaBasis)]; 
    
    
    %% Specify objects in fundamental cell
     X1J = X*[0];
     Y1J = Y*[0];
     Omega1J = 4*pi*[1];%,1];
     M1J = [10];%,1];
     
     P = size(X1J,1);
     
    %% Specify frequency range of interest
    
    % Omega = 0.68455;
    
    %0.602007 RotSym Fabry Perot
    %0.68455 Penrose
    
    %% Specify resolution of scattering computation
    resolution = 200;  %100
     
    XIJ = unique(PenroseTiling(5), "rows");
    
    % for i = 1:size(XIJ(:,1))
    %     if norm(XIJ(i,:))) > 10) | norm(XIJ(i,:)) < 8)
    %         XIJ(i,:) = [];
    %     end
    % end
    % XIJ(norm([XIJ(:,1), XIJ(:,2)]) > 10 | norm([XIJ(:,1), XIJ(:,2)]) < 8) = [];
    
    % k = boundary(XIJ, 0.96);
    % XIJ = unique(XIJ(k,:), "rows");
    
    
    % temp = XIJ;
    % temp(:,2) = temp(:,2) + 2*10*cos(pi/10);
    % XIJ = unique(cat(1, XIJ, temp), "rows");
    
    %Get rid of mass at 0 because causes Hankel singularity??
    % XIJ(XIJ(:,1)==0 & XIJ(:,2)==0,:) = [];
    
    
    
    OmegaIJ = ones(size(XIJ(:,1))) * Omega1J;    %change both of these?
    MIJ = ones(size(XIJ(:,1))) * M1J;
    
    Xinc = 10*[sin(-pi/10),cos(-pi/10)]'; %Position of monopole source term
    Istar = 1; %Strength of monopole source term
    
    % figure; %plot crystal
    % hold on;
    % % plot(cent(1,:), cent(2,:), 'bo')
    % plot(XIJ(:,1), XIJ(:,2), 'gx')
    % 
    % plot(Xinc(1), Xinc(2), 'rs')
    % % plot(SuperCellCent1(1), SuperCellCent1(2), 'gs')
    % axX = xlim;
    % axY = ylim;
    % xlim(axX+2.5*[-1,1])
    % ylim(axY+2.5*[-1,1])
    % axis equal
    axXlim = [-20, 20];
    axYlim = [-20,20]; %Gets xlim and ylim for boundary of the scatterering simulation
    hold off
    
    
    x = linspace(axXlim(1), axXlim(2), resolution);
    y = linspace(axYlim(1), axYlim(2), resolution);
    [xx, yy] = meshgrid(x, y);
    
    w_incs = cell(1);
    w_scatts = cell(1);
    xxs = cell(1);
    yys = cell(1);
    
    
    
    % Perform scattering simulation
    [w_inc, w_scatt] = scatteringSolnSpringMassOnaPlate(Istar,Xinc,Omega,xx,yy,XIJ,OmegaIJ,MIJ);
    
    % Plotting
    W_incs = {};
    W_scatts = {};
    X = {};
    Y = {};
    for n = 1:size(w_incs,1) 
        W_incs{n} = w_incs{n,1};
        W_scatts{n} = w_scatts{n,1};
        X{n} = xxs{n,1};
        Y{n} = yys{n,1};
    end    
    
    data = [];
    XX = [];
    YY = [];
    
    for i = 1:5
    
        % figure;%(0 + idx); hold on
        % hold on
        U = w_inc + w_scatt;
        
        n = 200;
        rmax = 15;
        t1 = -pi/10 + i*2*pi/5;
        t2 = 3*pi/10 + i*2*pi/5;
        
        r = repelem(linspace(0,rmax,n), n);
        theta = repmat(linspace(t1, t2, n), 1,n);
        [sx, sy] = pol2cart(theta,r);
        sector = interp2(xx,yy,U,sx,sy);
        
        r = linspace(0,rmax,n);
        theta = linspace(t1, t2, n);
        [r,theta] = meshgrid(r,theta);
        SX = r.*cos(theta);
        SY = r.*sin(theta);
        XX = [XX; SX];
        YY = [YY; SY];
        SZ = griddata(sx,sy,sector,SX,SY);
    
        data = [data; SZ];
        
        % surf(SX, SY, abs(SZ));
        % colorbar
        % % viscircles([XIJ(:,1),XIJ(:,2)],0.1*ones(size(XIJ(:,1))),'EnhanceVisibility',true,'LineWidth',2.0,'Color','w');
        % title(['\Omega =', num2str(Omega) ,' (Hz)'])
        % shading interp
        % colormap jet;
        % axis tight
        % axis equal
        % 
        % % axis off
        % colorbar off
    
    
    end
    
    % surf(XX, YY, abs(data));
    % colorbar
    % % viscircles([XIJ(:,1),XIJ(:,2)],0.1*ones(size(XIJ(:,1))),'EnhanceVisibility',true,'LineWidth',2.0,'Color','w');
    % title(['\Omega =', num2str(Omega) ,' (Hz)'])
    % shading interp
    % colormap jet;
    % axis tight
    % axis equal
    % 
    % % axis off
    % colorbar off
    
    
    
    fourier = fft2(data);
    thetas = angle(XX(:,end) + 1i*YY(:,end));
    % plot(thetas,real(fourier(:,end)))
    % hold on
    % plot(thetas,imag(fourier(:,end)))
    
    % surf(XX, YY, imag(fourier));

end