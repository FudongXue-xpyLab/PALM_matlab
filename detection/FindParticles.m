function V=FindParticles(handles,data_w)
% V=FindParticles(handles,data_w)
% 2017.12.01

% handles.parameter.detection.size=0;
% if handles.parameter.detection.size>0
%     BW=logical(data_w>0);
%     [L,num]=bwlabel(BW);
%     STATS=regionprops(L,'Area');
%     for i=1:num
%         if STATS(i).Area>handles.parameter.detection.size
%             L(L==i)=1;
%         else
%             L(L==i)=0;
%         end
%     end
%     data_w=data_w.*L;
% end
V=[];
if get(handles.checkbox1,'value')   

    BW_area=handles.parameter.detection.Cell_area;
    data1=data_w.*BW_area;
    if get(handles.radiobutton3,'value')
        w=str2double(get(handles.edit8,'string'));
        ImgMax=locmax2d(data1,[w w]);
        [V(:,2) V(:,1) V(:,3)]=find(ImgMax);
    elseif get(handles.radiobutton4,'value')
        w=str2double(get(handles.edit9,'string'));
        V=weightedcentrid(data1,w);
    end
else
    handles.ROI=handles.parameter.detection.ROI;
    if ~isempty(handles.ROI)
        data1=data_w.*handles.ROI;
    else
        data1=data_w;
    end
    if get(handles.radiobutton3,'value')
        w=str2double(get(handles.edit8,'string'));
        ImgMax=locmax2d(data1,[w w]);
        [V(:,2) V(:,1) V(:,3)]=find(ImgMax);
    elseif get(handles.radiobutton4,'value')
        w=str2double(get(handles.edit9,'string'));
        V=weightedcentrid(data1,w);
    end
end