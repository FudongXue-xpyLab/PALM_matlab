function DV=track(movieInfo,handles)
  
    %% Detection results: movieInfo
%
%For a movie with N frames, movieInfo is a structure array with N entries.
%Every entry has the fields xCoord, yCoord, zCoord (if 3D) and amp.
%If there are M features in frame i, each one of these fields in
%moveiInfo(i) will be an Mx2 array, where the first column is the value
%(e.g. x-coordinate in xCoord and amplitude in amp) and the second column
%is the standard deviation. If the uncertainty is unknown, make the second
%column all zero.
%
%This is the automatic output of detectSubResFeatures2D_StandAlone, which
%is called via the accompanying "scriptDetectGeneral"
%This file is part of u-track.
%
%    u-track is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%    u-track is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with u-track.  If not, see <http://www.gnu.org/licenses/>.
%
%Copyright Jaqaman 01/08
%--------------------------------------------------------------------------

%% Cost functions

%Frame-to-frame linking
costMatrices(1).funcName = 'costMatLinearMotionLink';

%Gap closing, merging and splitting
costMatrices(2).funcName = 'costMatLinearMotionCloseGaps';

%--------------------------------------------------------------------------

%% Kalman filter functions

%Memory reservation
kalmanFunctions.reserveMem = 'kalmanResMemLM';

%Filter initialization
kalmanFunctions.initialize = 'kalmanInitLinearMotion';

%Gain calculation based on linking history
kalmanFunctions.calcGain = 'kalmanGainLinearMotion';

%--------------------------------------------------------------------------

%% General tracking parameters

%Gap closing time window
gapCloseParam.timeWindow = handles.parameter.tracking.gap;

%Flag for merging and splitting
gapCloseParam.mergeSplit = 1;

%Minimum track segment length used in the gap closing, merging and
%splitting step
gapCloseParam.minTrackLen = 1;

%--------------------------------------------------------------------------

%% Cost function specific parameters: Frame-to-frame linking

%Flag for linear motion
parameters.linearMotion = 1;

%Search radius lower limit

parameters.minSearchRadius = handles.parameter.tracking.minSR;

%Search radius upper limit

parameters.maxSearchRadius = handles.parameter.tracking.maxSR;

%Standard deviation multiplication factor
parameters.brownStdMult = 3;

%Flag for using local density in search radius estimation
parameters.useLocalDensity = 1;

%Number of past frames used in nearest neighbor calculation
parameters.nnWindow = gapCloseParam.timeWindow;

%Store parameters for function call
costMatrices(1).parameters = parameters;
clear parameters

%--------------------------------------------------------------------------

%% Cost cunction specific parameters: Gap closing, merging and splitting

%Same parameters as for the frame-to-frame linking cost function
parameters.linearMotion = costMatrices(1).parameters.linearMotion;
parameters.useLocalDensity = costMatrices(1).parameters.useLocalDensity;
parameters.maxSearchRadius = costMatrices(1).parameters.maxSearchRadius;
parameters.minSearchRadius = costMatrices(1).parameters.minSearchRadius;
parameters.brownStdMult = costMatrices(1).parameters.brownStdMult*ones(gapCloseParam.timeWindow,1);
parameters.nnWindow = costMatrices(1).parameters.nnWindow;

%Gap length (frames) at which f(gap) (in search radius definition) reaches its
%plateau
parameters.timeReachConfB = 2 ;

%Amplitude ratio lower and upper limits
parameters.ampRatioLimit = [0.5 4];

%Minimum length (frames) for track segment analysis
parameters.lenForClassify = 2;

%Standard deviation multiplication factor along preferred direction of
%motion
parameters.linStdMult = 3*ones(gapCloseParam.timeWindow,1);

%Gap length (frames) at which f'(gap) (in definition of search radius
%parallel to preferred direction of motion) reaches its plateau
parameters.timeReachConfL = gapCloseParam.timeWindow;

%Maximum angle between the directions of motion of two linear track
%segments that are allowed to get linked
parameters.maxAngleVV = 90;

%Store parameters for function call
costMatrices(2).parameters = parameters;
clear parameters

%--------------------------------------------------------------------------

%% additional input

%saveResults
% saveResults.dir = 'D:\My Documents\MATLAB\nature\example\'; %directory where to save input and output
% saveResults.filename = 'testTracking.mat'; %name of file where input and output are saved
saveResults = 0; %don't save results

%verbose
verbose = 1;

%problem dimension
probDim = 2;

%--------------------------------------------------------------------------

%% tracking function call

[tracksFinal,kalmanInfoLink,errFlag] = trackCloseGapsKalman(movieInfo,...
    costMatrices,gapCloseParam,kalmanFunctions,probDim,saveResults,verbose,handles);

%--------------------------------------------------------------------------

%% Output variables

%The important output variable is tracksFinal, which contains the tracks

%It is a structure array where each element corresponds to a compound
%track. Each element contains the following fields:
%           .tracksFeatIndxCG: Connectivity matrix of features between
%                              frames, after gap closing. Number of rows
%                              = number of track segments in compound
%                              track. Number of columns = number of frames
%                              the compound track spans. Zeros indicate
%                              frames where track segments do not exist
%                              (either because those frames are before the
%                              segment starts or after it ends, or because
%                              of losing parts of a segment.
%           .tracksCoordAmpCG: The positions and amplitudes of the tracked
%                              features, after gap closing. Number of rows
%                              = number of track segments in compound
%                              track. Number of columns = 8 * number of
%                              frames the compound track spans. Each row
%                              consists of
%                              [x1 y1 z1 a1 dx1 dy1 dz1 da1 x2 y2 z2 a2 dx2 dy2 dz2 da2 ...]
%                              NaN indicates frames where track segments do
%                              not exist, like the zeros above.
%           .seqOfEvents     : Matrix with number of rows equal to number
%                              of events happening in a track and 4
%                              columns:
%                              1st: Frame where event happens;
%                              2nd: 1 - start of track, 2 - end of track;
%                              3rd: Index of track segment that ends or starts;
%                              4th: NaN - start is a birth and end is a death,
%                                   number - start is due to a split, end
%                                   is due to a merge, number is the index
%                                   of track segment for the merge/split.


%% save files
%     plotTracks2D(tracksFinal, [], '1', [],  1, 1, VH.A{1});   % visualization
%     plotTracks2D(tracksFinal, [], '2', [],  0, 1, []);
%     tracksFinal1=tracksFinal;
a=length(tracksFinal);
j=1;
% DV = cell(a,1);
for i=1:a
    [m, n]=size(tracksFinal(i,1).tracksFeatIndxCG);
    if m==1
        stf=tracksFinal(i,1).seqOfEvents(1,1);
        enf=tracksFinal(i,1).seqOfEvents(2,1);
        DV(j,1).trackInfo(1:n,1)=stf:enf;      % track frame           
        DV(j,1).trackInfo(1:n,2)=tracksFinal(i,1).tracksCoordAmpCG(1,1:8:((n-1)*8+1));    % x
        DV(j,1).trackInfo(1:n,3)=tracksFinal(i,1).tracksCoordAmpCG(1,2:8:((n-1)*8+2));    % y
        DV(j,1).trackInfo(1:n,4)=0;                                                       % z 还未计算            
        DV(j,1).trackInfo(1:n,5)=tracksFinal(i,1).tracksCoordAmpCG(1,4:8:((n-1)*8+4));    % peak value  
        DV(j,1).trackInfo(1:n,6)=tracksFinal(i,1).tracksCoordAmpCG(1,5:8:((n-1)*8+5));    % sx
        DV(j,1).trackInfo(1:n,7)=tracksFinal(i,1).tracksCoordAmpCG(1,6:8:((n-1)*8+6));    % sy
        DV(j,1).trackInfo(1:n,8)=tracksFinal(i,1).tracksCoordAmpCG(1,8:8:((n-1)*8+8));    % s(peak value)  未计算，现在为0；
        j=j+1;
    end
    if m>1
        T=tracksFinal(i,1).seqOfEvents;
        [tracksFinal(i,1).seqOfEvents(:,3),IX]=sort(tracksFinal(i,1).seqOfEvents(:,3));   % sort by track number
        for k=1:2*m
            tracksFinal(i,1).seqOfEvents(k,1:2)=T(IX(k),1:2);
            tracksFinal(i,1).seqOfEvents(k,4)=T(IX(k),4);            
        end
        for k=1:m
            minf=min(tracksFinal(i,1).seqOfEvents(:,1));                
            stf=tracksFinal(i,1).seqOfEvents(2*k-1,1);
            enf=tracksFinal(i,1).seqOfEvents(2*k,1);                          
            s=stf-minf;       % 起始位置
            l=enf-stf+1;      % 持续帧数  

%                 if tracksFinal(i,1).seqOfEvents(2*k-1,4)>0;
%                     l=l-1;
%                 end
%                 if tracksFinal(i,1).seqOfEvents(2*k,4)>0
%                     l=l-1;
%                 end
            DV(j,1).trackInfo(:,1)=stf:(stf+l-1);      % track frame                              
            DV(j,1).trackInfo(:,2)=tracksFinal(i,1).tracksCoordAmpCG(k,(s*8+1):8:((l+s-1)*8+1));    % x
            DV(j,1).trackInfo(:,3)=tracksFinal(i,1).tracksCoordAmpCG(k,(s*8+2):8:((l+s-1)*8+2));    % y
            DV(j,1).trackInfo(:,4)=0;                                                             % z 还未计算            
            DV(j,1).trackInfo(:,5)=tracksFinal(i,1).tracksCoordAmpCG(k,(s*8+4):8:((l+s-1)*8+4));    % peak value  
            DV(j,1).trackInfo(:,6)=tracksFinal(i,1).tracksCoordAmpCG(k,(s*8+5):8:((l+s-1)*8+5));    % sx
            DV(j,1).trackInfo(:,7)=tracksFinal(i,1).tracksCoordAmpCG(k,(s*8+6):8:((l+s-1)*8+6));    % sy
            DV(j,1).trackInfo(:,8)=tracksFinal(i,1).tracksCoordAmpCG(k,(s*8+8):8:((l+s-1)*8+8));    % background           
            j=j+1;         
        end                         
     end
end
    
% check if first or last point is nan
for i=1:length(DV)
nanflag=1;
while nanflag
    [nanflag DV(i,1).trackInfo]=checknan(DV(i,1).trackInfo);
end
end

%帧数太少的去掉
% T=DV;
% DV=[];
% [a b]=size(T);
% j=1;
% for i=1:a
%     m=length(T(i,1).trackInfo(:,1));
%     if m>=1             % ignore vesicle exists less than # frams
%         DV(j,1).trackInfo=T(i,1).trackInfo;
%         j=j+1;
%     end
% end
    
% sort DV by y,x,frame
a=length(DV);
for i=1:a;
   XX(i,1)=DV(i,1).trackInfo(1,3);
end  
[XX IX]=sort(XX);
T=DV;
for i=1:a;
   DV(i,1).trackInfo=T(IX(i,1),1).trackInfo;
   XX(i,1)=DV(i,1).trackInfo(1,2);
end

[XX IX]=sort(XX);
T=DV;
for i=1:a;
   DV(i,1).trackInfo=T(IX(i,1),1).trackInfo;
   XX(i,1)=DV(i,1).trackInfo(1,1);
end

[XX IX]=sort(XX);
T=DV;
for i=1:a;
   DV(i,1).trackInfo=T(IX(i,1),1).trackInfo;
end
   