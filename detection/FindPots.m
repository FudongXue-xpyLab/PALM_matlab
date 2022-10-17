function [ V ] = FindPots(handles,data_w)
%FINDPOTS Summary of this function goes here
%   Detailed explanation goes here

V = [];
if get(handles.checkbox1,'value')
    BW_area=handles.parameter.detection.Cell_area;
    data1=data_w.*BW_area;
    w=handles.parameter.detection.width;
    if handles.parameter.detection.localmaxima==1
        ImgMax=locmax2d(data1,[w w]);
        [V(:,2), V(:,1), V(:,3)]=find(ImgMax);
    elseif handles.parameter.detection.localmaxima==0
        V=weightedcentrid(data1,w);
    end
end
end

