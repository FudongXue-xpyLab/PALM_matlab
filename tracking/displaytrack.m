function displaytrack(handles)
t=handles.t;
j=handles.frame;
axes(handles.axes3);
cla;
imshow(handles.VT.A(:,:,j),[]);

if handles.flag==0
    sf=handles.VT.DV(t,1).trackInfo(1,1);
    ef=handles.VT.DV(t,1).trackInfo(end,1);
    if sf<=j && j<=ef
        y=round(handles.VT.DV(t,1).trackInfo(j-sf+1,3));
        x=round(handles.VT.DV(t,1).trackInfo(j-sf+1,2));
        hold on
        plot(handles.VT.DV(t,1).trackInfo(1:(j-sf+1),2),handles.VT.DV(t,1).trackInfo(1:(j-sf+1),3),'b-','MarkerSize',2)
        plot(handles.VT.DV(t,1).trackInfo(1,2),handles.VT.DV(t,1).trackInfo(1,3),'go','MarkerSize',2)     
        text(double(handles.VT.DV(t,1).trackInfo(1,2)+1),double(handles.VT.DV(t,1).trackInfo(1,3)+1),num2str(t),'fontsize',8,'color','r');
        plot(handles.VT.DV(t,1).trackInfo(j-sf+1,2),handles.VT.DV(t,1).trackInfo(j-sf+1,3),'r*','MarkerSize',5)
        if ~isnan(x)
            I=handles.VT.A(y,x,j);    
            fstr=strcat('Track:',num2str(t),'--','Y:',num2str(y),'--','X:',num2str(x),'--','I:',num2str(I));
            set(handles.text21,'string',fstr);
        end
    else
        set(handles.text21,'string','');
    end
end

if handles.flag==1
    colorLoop = [0 0 0; 1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
    set(handles.text21,'string','');
    for i=1:length(handles.VT.DV);    
        sf=handles.VT.DV(i,1).trackInfo(1,1);
        ef=handles.VT.DV(i,1).trackInfo(end,1);
        if sf<=j && j<=ef
            hold on
            plot(handles.VT.DV(i,1).trackInfo(1:(j-sf+1),2),handles.VT.DV(i,1).trackInfo(1:(j-sf+1),3),'color',colorLoop(mod(i-1,7)+1,:),'MarkerSize',2)
            plot(handles.VT.DV(i,1).trackInfo(1,2),handles.VT.DV(i,1).trackInfo(1,3),'go','MarkerSize',2)
        %     text(handles.VT.DV(i,1).trackInfo(1,2)+2,handles.VT.DV(i,1).trackInfo(1,3)+2,num2str(i),'fontsize',8,'color','r');
            plot(handles.VT.DV(i,1).trackInfo(j-sf+1,2),handles.VT.DV(i,1).trackInfo(j-sf+1,3),'r*','MarkerSize',2)    
        end
    end
end
fstr=strcat('Image #:',num2str(j),'/',num2str(handles.VT.ImageNumber));
set(findobj('Tag','text20'),'String',fstr);
set(handles.slider6,'value',single((handles.frame-1))/(handles.VT.ImageNumber-1));
pause(eps)