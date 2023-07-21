nonOverlap_Antenna_ID = setdiff(1:numVirtualRxAnt,overlapAntenna_ID(:,2));

% virArray_single = phased.URA('Size',[7 86],'ElementSpacing',[lambda/2 lambda/2]);
[virArray_pos_azi,virArray_pos_ele] = meshgrid(85:-1:0,0:6);
virArray_pos = [reshape(virArray_pos_azi,[],1),reshape(virArray_pos_ele,[],1)];
D_nonOverlap = D(nonOverlap_Antenna_ID,:);

DIdx_nonOverlap_sort = zeros(length(D_nonOverlap),1);
for i_D = 1:length(D_nonOverlap)
    DIdx_nonOverlap_sort(i_D) = find(virArray_pos(:,1)==D_nonOverlap(i_D,1) & virArray_pos(:,2)==D_nonOverlap(i_D,2));
end

antAryTopol = struct('D_RX', D_RX, ...
            	'lambda', physconst('LightSpeed')/(TI_Cascade_Antenna_DesignFreq*1e9), ...
            	'numTXAnts', 9, ...
                'DIdx_nonOverlap_sort',DIdx_nonOverlap_sort, ...
                'numTXAnts_full1D',86, ...
                'nonOverlap_Antenna_ID', nonOverlap_Antenna_ID);

num_azimuthBins = 192;
azimuthAxis = linspace(-pi/2,pi/2,num_azimuthBins+1); azimuthAxis = azimuthAxis(1:end-1);

%% beamformOuts Properties
BFPropty = struct('centerFreq', centerFreq*1e9, ...  
    'num_rangeBins', numADCSample, ... 
    'num_azimuthBins', num_azimuthBins, ...
    'num_DopplerBins',1, ...
    'azimuthAxis',azimuthAxis, ...
    'azimuthAxisDeg', azimuthAxis/pi*180);
