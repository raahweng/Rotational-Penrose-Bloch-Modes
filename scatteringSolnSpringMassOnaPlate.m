
function [wInc, wScattered] = scatteringSolnSpringMassOnaPlate(Istar,Xinc,Omega,xx,yy,XIJ,OmegaIJ,MIJ)

    posSor = Xinc;
    numJ = size(XIJ,1);
    

    
    %%%%%%%%%%%%Constructing Matrices
   
    r_ij = ones(size(XIJ,1),size(XIJ,1)); %distance between all objects
    %mScatt = size(objNODES,1);


    for l = 1:numJ
        deltaXij = XIJ(l,1)*ones(1,numJ) - XIJ(:,1)';
        deltaYij = XIJ(l,2)*ones(1,numJ) - XIJ(:,2)';

        [~, r_ij(l,:)] = cart2pol(deltaXij,deltaYij);
    end



    H0H0iOmrij = besselh(0,1,sqrt(Omega)*r_ij)-besselh(0,1,1i*sqrt(Omega)*r_ij);
    H0H0iOmrij(1:(numJ + 1):end) = zeros(numJ,1); %Set diagonal to zero

    %%%%%Forcing coeffs
    
    

    
   Fstar = Omega*Omega*(MIJ.*OmegaIJ.*OmegaIJ./(OmegaIJ.*OmegaIJ - Omega*Omega));
        
    

    FstarBLOCK = ones(numJ,1)*(Fstar.'); %Same along the col
    FstarBLOCK(1:(numJ + 1):end) = zeros(numJ,1);
    
   


        A = eye(numJ) - 1i*diag(Fstar)/(8*Omega) - 1i*FstarBLOCK.*H0H0iOmrij/(8*Omega);


        DeltaXobjInc = XIJ(:,1) - posSor(1)*ones(numJ,1);
        DeltaYobjInc = XIJ(:,2) - posSor(2)*ones(numJ,1);

        [~, r_ijIncObj] = cart2pol(DeltaXobjInc, DeltaYobjInc);

        

        B = Istar*1i*(besselh(0,1,sqrt(Omega)*r_ijIncObj) - besselh(0,1,1i*sqrt(Omega)*r_ijIncObj) )/(8*Omega);
        


        



    %%%%%Performing Scattering simulations 
    wXj = A\B; %Coeffs
    
    mPoints = size(xx,1);
    wScattered = zeros(size(xx)*[1;0]);
    deltaX1Inc = xx - posSor(1)*ones(mPoints);
    deltaX2Inc = yy - posSor(2)*ones(mPoints);

    [~, r_incField] = cart2pol(deltaX1Inc, deltaX2Inc);


    wInc = Istar*1i*(besselh(0,1,sqrt(Omega)*r_incField) - besselh(0,1,1i*sqrt(Omega)*r_incField))/(8*Omega); %initializing with incident field
    %phiInc = zeros(size(wInc));
    %psiInc = zeros(size(wInc));


    for m = 1:numJ
       deltaX1 = xx - XIJ(m,1)*ones(mPoints);
       deltaX2 = yy - XIJ(m,2)*ones(mPoints);
       [~, rField] = cart2pol(deltaX1,deltaX2);

       H0H0iOmrField = besselh(0,1,sqrt(Omega)*rField)-besselh(0,1,1i*sqrt(Omega)*rField);
      


       wScattered = wScattered + (8*Omega)\1i*Fstar(m)*wXj(m)*H0H0iOmrField;
    end
    
end    

    







