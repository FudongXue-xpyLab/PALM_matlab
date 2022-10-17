function varargout = viewtrajectory(varargin)
% VIEWTRAJECTORY M-file for viewtrajectory.fig
%      VIEWTRAJECTORY, by itself, creates a new VIEWTRAJECTORY or raises the existing
%      singleton*.
%
%      H = VIEWTRAJECTORY returns the handle to a new VIEWTRAJECTORY or the handle to
%      the existing singleton*.
%
%      VIEWTRAJECTORY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWTRAJECTORY.M with the given input arguments.
%
%      VIEWTRAJECTORY('Property','Value',...) creates a new VIEWTRAJECTORY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before viewtrajectory_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to viewtrajectory_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help viewtrajectory

% Last Modified by GUIDE v2.5 08-Dec-2011 20:14:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @viewtrajectory_OpeningFcn, ...
                   'gui_OutputFcn',  @viewtrajectory_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before viewtrajectory is made visible.
function viewtrajectory_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to viewtrajectory (see VARARGIN)

% Choose default command line output for viewtrajectory
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes viewtrajectory wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.VT= varargin{1};
guidata(hObject,handles);

n=length(handles.VT.DV);
track=zeros(n,4);
for i=1:n
    track(i,1)=i;
    track(i,2)=handles.VT.DV(i,1).trackInfo(1,1);
    track(i,3)=round(handles.VT.DV(i,1).trackInfo(1,3));
    track(i,4)=round(handles.VT.DV(i,1).trackInfo(1,2));
end

Str='';
for i=1:n;
    str=strcat(num2str(track(i,1)),'-',num2str(track(i,3)),'-',num2str(track(i,4)),'-',num2str(track(i,2)));
    Str=strvcat(Str,str);
end
set(handles.listbox2,'string',Str);
set(handles.listbox2,'value',1);
set(handles.listbox2,'HorizontalAlignment','center')
handles.Str=Str;
step=1.0/(handles.VT.ImageNumber-1);
handles.flag=0;   
handles.t=1;
handles.frame=handles.VT.DV(1,1).trackInfo(1,1);
set(handles.slider6,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',(handles.frame-1)/(handles.VT.ImageNumber-1));
guidata(hObject,handles)
displaytrack(handles)


% --- Outputs from this function are returned to the command line.
function varargout = viewtrajectory_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
handles.t=get(hObject,'Value');
handles.frame=handles.VT.DV(handles.t,1).trackInfo(1,1);
% set(handles.slider6,'value',single((handles.frame-1))/(handles.VT.ImageNumber-1));
handles.flag=0;
guidata(hObject,handles)
displaytrack(handles)


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
j=get(hObject,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
handles.t=get(handles.listbox2,'value');
guidata(hObject,handles)
displaytrack(handles)

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y]=ginput(1);
frame=round(get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1);
handles.trackNumber=0;
for i=1:length(handles.VT.DV)
    for j=1:length(handles.VT.DV(i).trackInfo(:,1))
        xx=handles.VT.DV(i).trackInfo(j,2);
        yy=handles.VT.DV(i).trackInfo(j,3);
        if handles.VT.DV(i).trackInfo(j,1)==frame && sqrt((x-xx)^2+(y-yy)^2)<=3
            handles.trackNumber=i;
            break;
        end
    end
end
if handles.trackNumber>0
    handles.t=handles.trackNumber;
    handles.frame=handles.VT.DV(handles.t).trackInfo(1,1);
    % set(handles.slider6,'value',(handles.frame-1)/(handles.VT.ImageNumber-1));
    set(handles.listbox2,'value',handles.t);
    handles.flag=0;
    guidata(hObject,handles)
    displaytrack(handles)
else
    set(handles.text21,'string','No track is selected!')
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.flag=1;
handles.frame=round(get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1);
displaytrack(handles)
guidata(hObject,handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stopflag;
stopflag=0;
j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
while handles.frame<handles.VT.ImageNumber && stopflag==0
    handles.frame=handles.frame+1;
    % set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));
    displaytrack(handles)
end
guidata(hObject,handles)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stopflag
stopflag=1;
guidata(hObject,handles)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
handles.t=get(handles.listbox2,'value');
t=handles.t;
sf=handles.VT.DV(t,1).trackInfo(1,1);
ef=handles.VT.DV(t,1).trackInfo(end,1);
n=ef-sf+1;
but=1;

if handles.frame==ef && handles.frame<handles.VT.ImageNumber
    handles.frame=handles.frame+1;
    % set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));
    displaytrack(handles)
    while but==1 && handles.frame<=handles.VT.ImageNumber
        [x y but]=ginput(1);
        if but==1
           if handles.frame>ef  
               handles.VT.DV(t,1).trackInfo(n+1,1)=handles.frame;   
               handles.VT.DV(t,1).trackInfo(n+1,2)=round(x);
               handles.VT.DV(t,1).trackInfo(n+1,3)=round(y);
               guidata(hObject,handles)
               displaytrack(handles)
        %        set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));
               handles.frame=handles.frame+1;
               n=n+1;
           end    
        end
    end
elseif handles.frame==sf && handles.frame>1
    handles.frame=handles.frame-1;
    % set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));
    displaytrack(handles)
    while but==1 && handles.frame>=1
        [x y but]=ginput(1);
        if but==1
           if handles.frame<sf  
               handles.VT.DV(t,1).trackInfo(n+1,1)=handles.frame;   
               handles.VT.DV(t,1).trackInfo(n+1,2)=round(x);
               handles.VT.DV(t,1).trackInfo(n+1,3)=round(y);
               [II IX]=sort(handles.VT.DV(t,1).trackInfo(:,1));
               handles.VT.DV(t,1).trackInfo=handles.VT.DV(t,1).trackInfo(IX,:);
               str=strcat(num2str(t),'-',num2str(handles.VT.DV(t,1).trackInfo(1,3)),'-',num2str(handles.VT.DV(t,1).trackInfo(1,2)),'-',num2str(handles.frame));  
               l1=length(handles.Str(t,:));
               l=length(str);
               blank=repmat(' ',1,l1-l);
               str=[str blank];
               handles.Str(t,:)=str;
               set(handles.listbox2,'string',handles.Str);
               guidata(hObject,handles)
               displaytrack(handles)
        %        set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));
               handles.frame=handles.frame-1;
               n=n+1;
           end    
        end
    end
guidata(hObject,handles)
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
handles.t=get(handles.listbox2,'value');
t=handles.t;
sf=handles.VT.DV(t,1).trackInfo(1,1);
ef=handles.VT.DV(t,1).trackInfo(end,1);
n=ef-sf+1;

if n>1
    if handles.frame==ef
        handles.VT.DV(t,1).trackInfo=handles.VT.DV(t,1).trackInfo(1:end-1,:);
        nanflag=1;
        while nanflag
            [nanflag handles.VT.DV(t,1).trackInfo]=checknan(handles.VT.DV(t,1).trackInfo);
        end
        handles.frame=handles.VT.DV(t,1).trackInfo(end,1);
        guidata(hObject,handles)
        displaytrack(handles)
    %     set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));
    elseif handles.frame==sf
        handles.VT.DV(t,1).trackInfo=handles.VT.DV(t,1).trackInfo(2:end,:);
        nanflag=1;
        while nanflag
            [nanflag handles.VT.DV(t,1).trackInfo]=checknan(handles.VT.DV(t,1).trackInfo);
        end
        handles.frame=handles.VT.DV(t,1).trackInfo(1,1);
        str=strcat(num2str(t),'-',num2str(handles.VT.DV(t,1).trackInfo(1,3)),'-',num2str(handles.VT.DV(t,1).trackInfo(1,2)),'-',num2str(handles.frame));  
        l1=length(handles.Str(t,:));
        l=length(str);
        blank=repmat(' ',1,l1-l);
        str=[str blank];
        handles.Str(t,:)=str;
        set(handles.listbox2,'string',handles.Str);
        guidata(hObject,handles)
        displaytrack(handles)
    %     set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));    
    end
else
    set(handles.listbox2,'value',t);
    pushbutton12_Callback(hObject, eventdata, handles)        
    guidata(hObject,handles)
end
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
handles.t=get(handles.listbox2,'value');
t=handles.t;
sf=handles.VT.DV(t,1).trackInfo(1,1);
ef=handles.VT.DV(t,1).trackInfo(end,1);
but=1;
while but==1 && handles.frame<=ef && handles.frame>=sf
    [x,y,but]=ginput(1);
    if but==1
        handles.VT.DV(t,1).trackInfo(handles.frame-sf+1,1)=handles.frame;   
        handles.VT.DV(t,1).trackInfo(handles.frame-sf+1,2)=round(x);
        handles.VT.DV(t,1).trackInfo(handles.frame-sf+1,3)=round(y);
        displaytrack(handles)
        handles.frame=handles.frame+1;   
    end
    guidata(hObject,handles)
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
n=length(handles.VT.DV);
handles.t=n+1;
but=1;
i=1;
while but==1 && handles.frame<=handles.VT.ImageNumber
    [x,y,but]=ginput(1);
    if but==1
        handles.VT.DV(n+1,1).trackInfo(i,1)=handles.frame;    
        handles.VT.DV(n+1,1).trackInfo(i,2)=round(x);
        handles.VT.DV(n+1,1).trackInfo(i,3)=round(y);
        displaytrack(handles)
        if i==1
            str=strcat(num2str(n+1),'-',num2str(handles.VT.DV(n+1,1).trackInfo(i,3)),'-',num2str(handles.VT.DV(n+1,1).trackInfo(i,2)),'-',num2str(handles.frame));  
            handles.Str=strvcat(handles.Str,str);
            set(handles.listbox2,'string',handles.Str);
            set(handles.listbox2,'value',n+1);
        end 
        handles.frame=handles.frame+1;
        if handles.frame<=handles.VT.ImageNumber
            displaytrack(handles)
            % set(handles.slider6,'value',single((handles.frame-1.0))/(handles.VT.ImageNumber-1));    
        end
        i=i+1;
    end
guidata(hObject,handles)
end

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
handles.t=get(handles.listbox2,'value');
t=handles.t;
n=length(handles.VT.DV);
II=1:n;
IX=(II(:)~=t);
handles.VT.DV=handles.VT.DV(IX,1);
n=length(handles.VT.DV);
track=zeros(n,4);
for i=1:n
    track(i,1)=i;
    track(i,2)=handles.VT.DV(i,1).trackInfo(1,1);
    track(i,3)=round(handles.VT.DV(i,1).trackInfo(1,3));
    track(i,4)=round(handles.VT.DV(i,1).trackInfo(1,2));
end

Str='';
for i=1:n;
    str=strcat(num2str(track(i,1)),'-',num2str(track(i,3)),'-',num2str(track(i,4)),'-',num2str(track(i,2)));
    Str=strvcat(Str,str);
end

set(handles.listbox2,'string',Str);
set(handles.listbox2,'HorizontalAlignment','center')
handles.Str=Str;
handles.flag=0;   
if t==1
    handles.t=1;
else
    handles.t=t-1;
end
set(handles.listbox2,'value',handles.t);
handles.frame=handles.VT.DV(handles.t,1).trackInfo(1,1);
% set(handles.slider6,'value',(handles.frame-1.0)/(handles.VT.ImageNumber-1));
guidata(hObject,handles)
displaytrack(handles)

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt={'Enter the gap to merge:','Enter the search radius to merge:'};
defans={'5','10'};
info = inputdlg(prompt, 'Input for process...!', 1, defans);
if ~isempty(info)
gap=str2double(info(1));
SR=str2double(info(2));

handles.t=get(handles.listbox2,'value');
trackend(1,1)=handles.VT.DV(handles.t,1).trackInfo(end,1);
trackend(1,2)=handles.VT.DV(handles.t,1).trackInfo(end,2);
trackend(1,3)=handles.VT.DV(handles.t,1).trackInfo(end,3);
possibletrack=[];
p=1;
for i=1:length(handles.VT.DV)
    trackstart(1,1)=handles.VT.DV(i,1).trackInfo(1,1);
    trackstart(1,2)=handles.VT.DV(i,1).trackInfo(1,2);
    trackstart(1,3)=handles.VT.DV(i,1).trackInfo(1,3);
    if trackstart(1,1)>trackend(1,1) &&trackstart(1,1)-trackend(1,1)<=gap && sqrt((trackstart(1,2)-trackend(1,2))^2+(trackstart(1,3)-trackend(1,3))^2)<=SR
        possibletrack(p,1)=i;
        p=p+1;
    end
end

if ~isempty(possibletrack)
[Selection,ok] = listdlg('ListString',num2str(possibletrack(:,1)));
if ok==1
    t1=possibletrack(Selection,1);    
    sf1=handles.VT.DV(handles.t,1).trackInfo(1,1);
    ef1=handles.VT.DV(handles.t,1).trackInfo(end,1);
    sf2=handles.VT.DV(t1,1).trackInfo(1,1);
    ef2=handles.VT.DV(t1,1).trackInfo(end,1);
    n1=ef1-sf1+1;
    n2=ef2-sf2+1;
    n=n1+n2;
    gap=sf2-ef1-1;
    if sf2>ef1
        if gap>0
            handles.VT.DV(handles.t,1).trackInfo(n1+1:n1+gap,1)=ef1+gap;
            handles.VT.DV(handles.t,1).trackInfo(n1+1:n1+gap,2:end)=NaN;
            handles.VT.DV(handles.t,1).trackInfo(n1+gap+1:n+gap,:)=handles.VT.DV(t1,1).trackInfo(1:end,:);
        else
        handles.VT.DV(handles.t,1).trackInfo(n1+1:n,:)=handles.VT.DV(t1,1).trackInfo(1:end,:);    
        end
    set(handles.listbox2,'value',t1);
    pushbutton12_Callback(hObject, eventdata, handles)    
    set(handles.listbox2,'value',handles.t);
    handles.frame=sf1;
    displaytrack(handles)
    guidata(hObject,handles);
    else
        set(handles.text21,'string','Impossible to merge!');
    end
   
else
    return
end
else
    set(handles.text21,'string','No possible track to merge!');
    return
end
else 
    return
end

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
handles.frame=round(j);
handles.t=get(handles.listbox2,'value');
t=handles.t;
n=length(handles.VT.DV);
l=length(handles.VT.DV(t,1).trackInfo(:,1));
if l>=2
sf=handles.VT.DV(handles.t,1).trackInfo(1,1);
T=handles.VT.DV(handles.t,1).trackInfo;

handles.VT.DV(handles.t,1).trackInfo=T(1:(handles.frame-sf+1),:);
handles.VT.DV(n+1,1).trackInfo=T((handles.frame-sf+2):end,:);

if ~isempty(handles.VT.DV(n+1,1).trackInfo) && ~isempty(handles.VT.DV(handles.t,1).trackInfo)
    nanflag=1;
    while nanflag
        [nanflag handles.VT.DV(t,1).trackInfo]=checknan(handles.VT.DV(t,1).trackInfo);
    end
    nanflag=1;
    while nanflag
        [nanflag handles.VT.DV(n+1,1).trackInfo]=checknan(handles.VT.DV(n+1,1).trackInfo);
    end
    if ~isempty(handles.VT.DV(n+1,1).trackInfo)
        str=strcat(num2str(n+1),'-',num2str(round(handles.VT.DV(n+1,1).trackInfo(1,3))),'-',num2str(round(handles.VT.DV(n+1,1).trackInfo(1,2))),'-',num2str(handles.frame+1));  
        handles.Str=strvcat(handles.Str,str);
        set(handles.listbox2,'string',handles.Str);
        guidata(hObject,handles)
    end
end
else
    set(handles.text21,'string','The track has only one point!')
end
% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% fstr=strcat(handles.VT.pathname,handles.VT.filebase,'_Tracking_checked.mat');
fstr=strcat(handles.VT.pathname,handles.VT.filebase,'_Tracking.mat');
handles.DV=handles.VT.DV;
handles.V=handles.VT.V;
handles.ImageNumber=handles.VT.ImageNumber;
handles.A=handles.VT.A;
handles.DV=handles.VT.DV;
handles.parameter=handles.VT.parameter;
handles.VT.A=[];
save(fstr);

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'Enter the fps of movie:'};
defans={'10'};
info = inputdlg(prompt, 'Input for process...!', 1, defans);
if ~isempty(info)
fps=str2double(info);
colorLoop = [0 0 0; 1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
fstr=strcat(handles.VT.pathname,handles.VT.filebase,'_tracking result.avi');
mov = avifile(fstr,'fps',fps,'quality',100,'compression','none');
axes(handles.axes3)
for i=1:handles.VT.ImageNumber
    cla
    imshow(handles.VT.A(:,:,i),[],'Border','tight','InitialMagnification',800)
    for j=1:length(handles.VT.DV)
        sf=handles.VT.DV(j).trackInfo(1,1);
        ef=handles.VT.DV(j).trackInfo(end,1);
        if sf<=i && ef>=i
           hold on 
           plot(handles.VT.DV(j).trackInfo(i-sf+1,2),handles.VT.DV(j).trackInfo(i-sf+1,3),'color',colorLoop(mod(j-1,7)+1,:),'Marker','o','MarkerSize',5);
           plot(handles.VT.DV(j).trackInfo(1:i-sf+1,2),handles.VT.DV(j).trackInfo(1:i-sf+1,3),'-','color',colorLoop(mod(j-1,7)+1,:));
        end
    end
    F = getframe(gca);
    mov = addframe(mov,F.cdata);
    fstr=strcat('Image #:',num2str(i),'/',num2str(handles.VT.ImageNumber));
    set(findobj('Tag','text20'),'String',fstr);
    set(handles.slider6,'value',(i-1)/(handles.VT.ImageNumber-1));
    pause(eps)
end
mov=close(mov);
else
    return
end

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.t=get(handles.listbox2,'value');
handles.frame=handles.VT.DV(handles.t,1).trackInfo(1,1);
% set(handles.slider6,'value',(handles.frame-1.0)/(handles.VT.ImageNumber-1));
displaytrack(handles)
guidata(hObject,handles)

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.t=get(handles.listbox2,'value');
handles.frame=handles.VT.DV(handles.t,1).trackInfo(end,1);
% set(handles.slider6,'value',(handles.frame-1.0)/(handles.VT.ImageNumber-1));
displaytrack(handles)
guidata(hObject,handles)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% sort by y,x,frame
DV=handles.VT.DV;
[a b]=size(DV);
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
handles.VT.DV=DV;

n=length(handles.VT.DV);
track=zeros(n,4);
for i=1:n
    track(i,1)=i;
    track(i,2)=handles.VT.DV(i,1).trackInfo(1,1);
    track(i,3)=round(handles.VT.DV(i,1).trackInfo(1,3));
    track(i,4)=round(handles.VT.DV(i,1).trackInfo(1,2));
end

Str='';
for i=1:n;
str=strcat(num2str(track(i,1)),'-',num2str(track(i,3)),'-',num2str(track(i,4)),'-',num2str(track(i,2)));
Str=strvcat(Str,str);
end
set(handles.listbox2,'string',Str);
set(handles.listbox2,'value',1);
set(handles.listbox2,'HorizontalAlignment','center')
handles.Str=Str;
step=1.0/(handles.VT.ImageNumber-1);
handles.flag=0;   
handles.t=1;
handles.frame=handles.VT.DV(1,1).trackInfo(1,1);
set(handles.slider6,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',(handles.frame-1)/(handles.VT.ImageNumber-1));
guidata(hObject,handles)
displaytrack(handles)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=get(handles.listbox2,'value');
trackInfo=[];
for i=1:length(handles.VT.DV(t,1).trackInfo(:,1))
    trackInfo(i,1:3)=handles.VT.DV(t,1).trackInfo(i,1:3);
    x=round(handles.VT.DV(t,1).trackInfo(i,2));
    y=round(handles.VT.DV(t,1).trackInfo(i,3));
    frame=handles.VT.DV(t,1).trackInfo(i,1);
    ROI=handles.VT.A(y-2:y+2,x-2:x+2,frame);
    trackInfo(i,4)=mean2(ROI);
end
axes(handles.axes3);
cla reset
plot(trackInfo(:,1),trackInfo(:,4),'b-');
axis off

if exist('lastfile.mat','file')
P=importdata('lastfile.mat');
pathname=P.pathname;
else
pathname=cd;    
end
[filename, pathname] = uiputfile( ...
    {'*.xls','ALL XLS-Files(*.xls)'; ...
       '*.mat', 'All MAT-Files (*.mat)'
        '*.*','All Files (*.*)'}, ...
    'Save Data File',pathname);
if isequal([filename,pathname],[0,0])
    return
else
filestr=fullfile(pathname,filename);
if strfind(filestr,'.mat')
save(filestr,'trackInfo');
elseif strfind(filestr,'.xls')
    a=length(trackInfo(:,1));
    str={'T','Xp','Yp','Intensity'};
    xlswrite(filestr,str,'A1:D1');
    xlswrite(filestr,trackInfo,strcat('A2:D',num2str(a+1)));
else
    error('Wrong file name!')
end
end


% --- Executes on button press in pushbutton21.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('lastfile.mat','file')
P=importdata('lastfile.mat');
pathname=P.pathname;
else
pathname=cd;    
end
[filename, pathname] = uigetfile( ...
    {'*.tif;*.tiff', 'All TIF-Files (*.tif,*.tiff)'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Image File',pathname);
if isequal([filename,pathname],[0,0])
    return
else
    File = fullfile(pathname,filename);
    handles.T = tiffread(File);
end
guidata(hObject,handles)

n=length(handles.VT.A(1,1,:));
handles.VT.A1=handles.VT.A;
[row column]=size(handles.T);
handles.VT.A2=zeros(row,column,n);
for i=1:n
    handles.VT.A2(:,:,i)=handles.T;
end
handles.VT.A=handles.VT.A2;
handles.t=get(handles.listbox2,'Value');
handles.frame=handles.VT.DV(handles.t,1).trackInfo(1,1);
handles.flag=0;
handles.flag_ex=1;
guidata(hObject,handles)
displaytrack(handles)

% --- Executes on button press in pushbutton22.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'flag_ex')
    warndlg('You should load tubeness image first!','!! Warning !!')
return
end  
if handles.flag_ex==1
    handles.flag_ex=0;
    handles.VT.A=handles.VT.A1;
else
    handles.flag_ex=1;
    handles.VT.A=handles.VT.A2;
end
guidata(hObject,handles)
displaytrack(handles)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stopflag;
stopflag=0;
prompt={'Enter the fps of movie:'};
defans={'10'};
info = inputdlg(prompt, 'Input for process...!', 1, defans);
if ~isempty(info)
    fps=str2double(info);
    t=handles.t;
    fstr=strcat(handles.VT.pathname,handles.VT.filebase,'_track_',num2str(t),'_result.avi');
    mov = avifile(fstr,'fps',fps,'quality',100,'compression','none');
    j=get(handles.slider6,'Value')*(handles.VT.ImageNumber-1)+1;
    handles.frame=round(j);
    while handles.frame<handles.VT.ImageNumber && stopflag==0
        handles.frame=handles.frame+1;
        displaytrack(handles)
        F=getframe(gca);
        mov=addframe(mov,F.cdata);
    end
    mov=close(mov);
end
guidata(hObject,handles)
