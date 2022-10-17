function varargout = main2(varargin)
% MAIN2 M-file for main2.fig
%      MAIN2, by itself, creates a new MAIN2 or raises the existing
%      singleton*.
%
%      H = MAIN2 returns the handle to a new MAIN2 or the handle to
%      the existing singleton*.
%
%      MAIN2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN2.M with the given input arguments.
%
%      MAIN2('Property','Value',...) creates a new MAIN2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main2

% Last Modified by GUIDE v2.5 31-Aug-2015 17:01:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main2_OpeningFcn, ...
                   'gui_OutputFcn',  @main2_OutputFcn, ...
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


% --- Executes just before main2 is made visible.
function main2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main2 (see VARARGIN)
set(hObject,'Toolbar','none');   
% Choose default command line output for main2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_new_Callback(hObject, eventdata, handles)
% hObject    handle to Open_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global display_flag
display_flag=0;
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
    handles.File=File;
    if ~isempty(File)
        t=strfind(filename,'.tif');
        filebase=filename(1:t-1);
        handles.filebase = filebase;
        handles.pathname = pathname;        
    end
    
    set(findobj('Tag','text5'),'String',File);  
    info=imfinfo(File);
%     info=tifftagsread (File);
    handles.TotalImages=length(info);
    [handles.A,handles.ImageNumber]=tiffread(File,1);
%     A = double(handles.A);
%     handles.A = (A - 99)*1.16*300/16.3;
    set(handles.uipanel9,'visible','on');
    axes(handles.axes1);
    cla reset;
    imshow(handles.A(:,:,1),[]);
    [handles.row,handles.column]=size(handles.A(:,:,1));
    fstr=strcat('Image #:1','/',num2str(handles.ImageNumber));
    set(findobj('Tag','text6'),'String',fstr);
    handles.data_w=[];
    handles.DV=[];
    handles.V=[];
    handles.contrastMax=max(max(handles.A(:,:,1)));
    handles.contrastMin=min(min(handles.A(:,:,1)));
    handles.contrastLow=handles.contrastMin;
    handles.contrastHigh=handles.contrastMax;
    step=0.01;
    set(handles.slider_contrastLow,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',0);
    step=0.02;
    set(handles.slider_contrastHigh,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',1);
    
    filestr=strcat(cd,'\main\Parameters_default.mat');
    flag=0;
    if exist(filestr,'file')
        parameter=importdata('Parameters_default.mat');
        try
            handles.parameter=parameter;
        catch
            flag=1;
        end
    else
        flag=1;
    end
    
    if flag
        handles.parameter.detection.wavelet_threshold=3;
        handles.parameter.detection.wavelet_coefficient=1;
        handles.parameter.detection.MSVST_flag=0;
        handles.parameter.detection.MSVST_mu=0.5;
        handles.parameter.detection.MSVST_sigma=0.5;
        handles.parameter.detection.MSVST_alpha=10;
        handles.parameter.detection.trash_dim=0;
        handles.parameter.detection.Cell_area=[];
        handles.parameter.detection.boundary_threshold=0.7;
        handles.parameter.detection.ROI=[];    
        handles.parameter.detection.localmaxima=0;
        handles.parameter.detection.width=5;
        handles.parameter.tracking.gap=1;
        handles.parameter.tracking.minSR=2;
        handles.parameter.tracking.maxSR=5;
        handles.parameter.linking.neighborhood=4;
        handles.parameter.linking.gap=1;
        handles.parameter.fitting.flag=1;
        handles.parameter.fitting.photonflag=1;
        handles.parameter.fitting.gain=300;
        handles.parameter.fitting.factor=10.5;
        handles.parameter.fitting.sigma=1.3;
        handles.parameter.fitting.pixelsize=100;
        handles.parameter.fitting.fitsize=7;
        handles.parameter.reconstruction.amp=8;
        handles.parameter.reconstruction.maxError=100;
        handles.parameter.reconstruction.minPhoton=0;
        handles.parameter.reconstruction.maxPhoton=5000;
        handles.parameter.reconstruction.maxBg=10;
        handles.parameter.reconstruction.meanBg=0;
        handles.parameter.reconstruction.minSigma=0.5;
        handles.parameter.reconstruction.maxSigma=3;
        handles.parameter.reconstruction.meanSigma=0;
        handles.parameter.prompt_flag=1;
        handles.parameter.driftCorrection=1;
        handles.parameter.display=0;        
    end
    
    handles.parameter.PALM.fitting_flag=0;
    handles.parameter.detection_flag=0;
    handles.parameter.batch=0;
    handles.boundary=[];
    handles.parameter.detection.ROI=[];    
    set(handles.Export_boundary,'enable','on');
    set(handles.Drift_correction,'enable','on');
    handles=ApplyParameters(handles);
    
    set(handles.Load_detection,'enable','on');
    set(handles.Load_tracking,'enable','on');
    set(handles.uipanel1,'visible','on');
    set(handles.slider_image,'visible','off')
    set(handles.text10,'string','')   
    set(handles.Current_figure,'enable','on');
    set(handles.Current_axes,'enable','on');
    set(handles.Wavelet_images,'enable','on');
    set(handles.Save_parameters,'enable','on');
    set(handles.Load_parameters,'enable','on');
    set(handles.Set_parameters,'enable','on');
    set(handles.uitoggletool11,'enable','on');
    set(handles.uipushtool11,'enable','on');
    set(handles.Linking,'enable','on');
    set(handles.Fitting,'enable','on');
    set(handles.Reconstruction,'enable','on');
    set(handles.Adjust_contrast,'enable','on');
    set(handles.One_step_process,'enable','on');
    set(handles.Save_cell_boundary,'enable','on');
    set(handles.Load_cell_boundary,'enable','on');
    guidata(hObject,handles);  
    save('lastfile.mat','pathname','filename');
end

% --- Executes on slider movement.
function slider_image_Callback(hObject, eventdata, handles)
% hObject    handle to slider_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global display_flag
j=get(handles.slider_image,'Value')*(handles.ImageNumber-1)+1;
j=uint16(j);
axes(handles.axes1);
cla;
handles.contrastMax=max(max(handles.A(:,:,j)));
handles.contrastMin=min(min(handles.A(:,:,j)));
imshow(handles.A(:,:,j),[handles.contrastLow handles.contrastHigh]);

if display_flag==0
    V=handles.V;
    if ~isempty(V)
        hold on
        plot(handles.V{j}(:,1),handles.V{j}(:,2),'r*','MarkerSize',2);
    end
    fstr=strcat('Image #:',int2str(j),'/',num2str(handles.ImageNumber));
    set(findobj('Tag','text6'),'String',fstr);
end

if display_flag==1
    N=handles.trackNumber;
    n=length(handles.DV(N,1).trackInfo(:,1));
    sf=handles.DV(N).trackInfo(1,1);
    ef=handles.DV(N).trackInfo(n,1);
    if sf<=j && j<=ef
        hold on
        plot(handles.DV(N).trackInfo(1:(j-sf+1),2),handles.DV(N).trackInfo(1:(j-sf+1),3),'b-','MarkerSize',2)
        plot(handles.DV(N).trackInfo(1,2),handles.DV(N).trackInfo(1,3),'go','MarkerSize',2)
        plot(handles.DV(N).trackInfo(j-sf+1,2),handles.DV(N).trackInfo(j-sf+1,3),'r*','MarkerSize',2)
    end
    fstr=strcat('Image #:',int2str(j),'/',num2str(handles.ImageNumber));
    set(findobj('Tag','text6'),'String',fstr);    
end

if display_flag==2 || display_flag==3
    for i=1:length(handles.FusionV(:,1))
        if handles.FusionV(i,1)==j
            hold on
            plot(handles.FusionV(i,3),handles.FusionV(i,2),'ro','MarkerSize',5)
        end
    end
    fstr=strcat('Image #:',int2str(j),'/',num2str(handles.ImageNumber));
    set(findobj('Tag','text6'),'String',fstr);    
end

guidata(hObject,handles);    


% --- Executes during object creation, after setting all properties.
function slider_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in Find_particles.
function Find_particles_Callback(hObject, eventdata, handles)
% hObject    handle to Find_particles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.data_w)
    handles.data_w(:,:,1)=Detection(handles.A(:,:,1),handles.parameter);
end
handles.V{1}=FindParticles(handles,handles.data_w(:,:,1));

% I=handles.A(:,:,1);
% [row col]=size(I);
% V=handles.V{1};
% t=2;
% for i=1:length(V)
%     x=round(V(i,1));
%     y=round(V(i,2));
%     if y-t>0 && x-t>0 && y+t<row && x+t<col
%         ROI=single(I(y-t:y+t,x-t:x+t));
%         V(i,3)=mean2(ROI);
%     end
% end
% handles.V{1}=V;

axes(handles.axes1);
cla 
imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
hold on
plot(handles.V{1}(:,1),handles.V{1}(:,2),'r*','MarkerSize',2);
hold off
set(handles.slider_image,'visible','off');
maxpeak=round(max(handles.V{1}(:,3)));
handles.maxpeak=maxpeak;
handles.dim=0;
handles.parameter.detection.trashdim=0;
set(handles.slider_dim,'max',1,'min',0,'SliderStep',[0.01 0.05],'value',0);
set(handles.edit7,'string',0);
set(handles.text9,'string',0);
set(handles.text6,'string','Image #:1/1');
set(handles.Save_detection,'enable','on');
set(handles.uipanel11,'visible','on');
set(handles.View_detection,'enable','on');
set(handles.Edit_particle,'enable','on');
set(handles.uipushtool9,'enable','on');
guidata(hObject,handles);    
% length(handles.V{1})
% sum(handles.parameter.detection.Cell_area(:))

function wavelet_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wavelet_threshold as text
%        str2double(get(hObject,'String')) returns contents of wavelet_threshold as a double
handles.parameter.detection.MSVST_flag=0;
threshold=str2double(get(hObject,'String'));
threshold=min(10,threshold);
set(hObject,'string',num2str(threshold));
set(handles.slider_wavelet,'value',threshold);
handles.parameter.detection.wavelet_threshold=threshold;
handles.data_w(:,:,1)=Detection(handles.A(:,:,1),handles.parameter);
axes(handles.axes1);
cla;
imshow(handles.data_w(:,:,1),[]);
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function wavelet_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavelet_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_wavelet_Callback(hObject, eventdata, handles)
% hObject    handle to slider_wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.parameter.detection.MSVST_flag=0;
threshold=get(hObject,'Value');
set(handles.wavelet_threshold,'string',num2str(threshold));
handles.parameter.detection.wavelet_threshold=threshold;
handles.data_w(:,:,1)=Detection(handles.A(:,:,1),handles.parameter);
axes(handles.axes1);
cla ;
imshow(handles.data_w(:,:,1),[]);
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider_wavelet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'max',10,'min',0,'SliderStep',[0.1 0.2],'value',3);

% --- Executes on button press in Process_next_frames.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to Process_next_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Track.
function Track_Callback(hObject, eventdata, handles)
% hObject    handle to Track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.parameter.prompt_flag
    prompt={'Enter the gap closing time window:','Enter the min search radius:','Enter the max search radius:'};
    defans={num2str(handles.parameter.tracking.gap),...
        num2str(handles.parameter.tracking.minSR),num2str(handles.parameter.tracking.maxSR)};
    info = inputdlg(prompt, 'Input for process...!', 1, defans);
    if ~isempty(info)
        handles.parameter.tracking.gap=str2double(info{1});
        handles.parameter.tracking.minSR=str2double(info{2});
        handles.parameter.tracking.maxSR=str2double(info{3});
    else
        return
    end
end
handles.data_wavelet=[];
pause(eps)
set(handles.text10,'string','');
global display_flag
display_flag=0;
for i=1:handles.ImageNumber
    n=length(handles.V{i}(:,1));
    for j=1:n
        movieInfo(i,1).xCoord(j,1)=handles.V{i}(j,1);
        movieInfo(i,1).xCoord(j,2)=0.1;
        movieInfo(i,1).yCoord(j,1)=handles.V{i}(j,2);
        movieInfo(i,1).yCoord(j,2)=0.1;
        movieInfo(i,1).amp(j,1)=handles.V{i}(j,3);
        movieInfo(i,1).amp(j,2)=0;
    end
end
DV=track(movieInfo,handles);
[row,column]=size(handles.A(:,:,1));
tracknum=length(DV);
r=1;
for i=1:tracknum
    n=length(DV(i).trackInfo(:,1));
    for k=1:n
        j=DV(i,1).trackInfo(k,1);
        rbar=DV(i,1).trackInfo(k,3);
        cbar=DV(i,1).trackInfo(k,2);
        if isnan(rbar)==0 && round(rbar)>r && round(cbar)>r && round(rbar)+r<=row && round(cbar)+r<=column          
            DV(i,1).trackInfo(k,4)=mean2(handles.A(round(rbar-r):round(rbar+r),round(cbar-r):round(cbar+r),j));
        else
            DV(i,1).trackInfo(k,4)=NaN;   
            DV(i,1).trackInfo(k,6:8)=0;
        end
    end
end
handles.DV=DV;
set(handles.Save_tracking,'enable','on');
set(handles.Load_std_tracking,'enable','on');
set(handles.Birth_and_death,'enable','on');
set(handles.uipanel18,'visible','off');
set(handles.View_detection,'enable','on');
set(handles.Edit_particle,'enable','on');
set(handles.View_tracking,'enable','on');
set(handles.Select_track,'enable','on');
set(handles.uipushtool10,'enable','on');
set(handles.Particle_number,'enable','on');
set(handles.Particle_intensity,'enable','on');
set(handles.Particle_velocity,'enable','on');
set(handles.Life_time,'enable','on');
set(handles.Particle_path,'enable','on');
set(handles.Particle_displacement,'enable','on');
set(handles.text10,'string','Tracking finished!');
guidata(hObject,handles)

% --- Executes on button press in Process_next_frames.
function Process_next_frames_Callback(hObject, eventdata, handles)
% hObject    handle to Process_next_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'Enter the number of image frames you want to process:'};
defans={num2str(handles.TotalImages)};
info = inputdlg(prompt, 'Input for process...!', 1, defans);

if ~isempty(info)
    number=str2double(info);
    [handles.A,handles.ImageNumber]=tiffread(handles.File,[1 number]);
%     A = double(handles.A);
%     handles.A = (A - 99)*1.16*300/16.3;
%     pause(eps)
    if handles.ImageNumber>1;
       set(handles.slider_image,'visible','on');
       step=1.0/(handles.ImageNumber-1);
       set(handles.slider_image,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',0);
    else
       set(handles.slider_image,'visible','off');
    end  
    set(handles.text10,'string','Particle detection ...')
    handles.V=[];
    axes(handles.axes1)
    if handles.parameter.display==1
        mywaitbar(0,handles.axes2,'');
    end
    [row column]=size(handles.A(:,:,1));
    handles.data_w=[];
    % handles.data_wavelet=uint16(zeros(row,column,handles.ImageNumber));
    handles.data_wavelet=uint16(zeros(row,column,1));
    for i=1:handles.ImageNumber  

        data_w=Detection(handles.A(:,:,i),handles.parameter);
        handles.data_wavelet(:,:,1)=uint16(data_w);
        handles.V{i}=FindParticles(handles,data_w);
        IX=handles.V{i}(:,3)>handles.parameter.detection.trash_dim;
        handles.V{i}=handles.V{i}(IX,:);
        
        if handles.parameter.display==1
        cla(handles.axes1);
        imshow(handles.A(:,:,i),[handles.contrastLow handles.contrastHigh]);
        hold on
        plot(handles.V{i}(:,1),handles.V{i}(:,2),'r*','MarkerSize',2);
        hold off
        mywaitbar(i/handles.ImageNumber,handles.axes2,[num2str(floor(i/handles.ImageNumber*100)),'%']);
        set(handles.slider_image,'value',(i-1)/(handles.ImageNumber-1));
        end 
        pause(eps)
        fstr=strcat('Image #:',num2str(i),'/',num2str(handles.ImageNumber));
        set(findobj('Tag','text6'),'String',fstr);   
    end
    set(handles.Load_std_detection,'enable','on');
    set(handles.View_detection,'enable','on');
    set(handles.Edit_particle,'enable','on');
    set(handles.Particle_number,'enable','on');
    set(handles.Particle_intensity,'enable','on');
    set(handles.text10,'string','Detection finished!');   
    handles.parameter.detection_flag=1;
    guidata(hObject,handles)
else
    return
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global display_flag
if ~isempty(handles.DV)
    set(handles.text10,'string','Left-click to select a track!'); 
    [x, y]=ginput(1);
    frame=round(get(handles.slider_image,'Value')*(handles.ImageNumber-1)+1);
    handles.trackNumber=0;
    for i=1:length(handles.DV)
        for j=1:length(handles.DV(i).trackInfo(:,1))
            xx=handles.DV(i).trackInfo(j,2);
            yy=handles.DV(i).trackInfo(j,3);
            if handles.DV(i).trackInfo(j,1)==frame && sqrt((x-xx)^2+(y-yy)^2)<=3
                handles.trackNumber=i;
                break;
            end
        end
    end
    if handles.trackNumber>0
        set(handles.text10,'string','')
        display_flag=1;
        axes(handles.axes1);
        cla;
        frame=handles.DV(handles.trackNumber).trackInfo(1,1);
        imshow(handles.A(:,:,frame),[]);
        hold on
        plot(handles.DV(handles.trackNumber).trackInfo(1,2),handles.DV(handles.trackNumber).trackInfo(1,3),'go','MarkerSize',2);
        set(handles.slider_image,'value',(frame-1)/(handles.ImageNumber-1));
        fstr=strcat('Image #:',num2str(frame),'/',num2str(handles.ImageNumber));
        set(findobj('Tag','text6'),'String',fstr);    
        guidata(hObject,handles)
        set(handles.text10,'string','');
    else
        set(handles.text10,'string','No track is selected!')
    end
else
    set(handles.text10,'string','There is no track!')
    return
end
 

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global display_flag
display_flag=0;
axes(handles.axes1);
cla reset;
imshow(handles.A(:,:,1),[]);
hold on
plot(handles.V{1}(:,1),handles.V{1}(:,2),'r*','MarkerSize',2);
hold off
set(handles.slider_image,'value',0);
fstr=strcat('Image #:1','/',num2str(handles.ImageNumber));
set(findobj('Tag','text6'),'String',fstr);    
guidata(hObject,handles)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global display_flag
if display_flag~=3
    display_flag=2;
end
V=handles.FusionV;
if ~isempty(V)
    v=get(handles.listbox1,'value');
    frame=V(v,1);
    axes(handles.axes1);
    cla;
    imshow(handles.A(:,:,frame),[]);
    fstr=strcat('Image #:',num2str(frame),'/',num2str(handles.ImageNumber));
    set(findobj('Tag','text6'),'String',fstr);
    x=(frame-1)/(handles.ImageNumber-1);
    set(handles.slider_image,'value',x);
    hold on
    plot(V(v,3),V(v,2),'ro','MarkerSize',5);  
else
    return
end

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox1
if get(hObject,'Value')
    [W2 W3 A3]=waveletTransform(handles.A(:,:,1),1,3);
    threshold=str2double(get(handles.edit5,'string'))*mean2(A3);
    level=threshold/65535;                                  
    BW_area=AreaDetect(uint16(A3),level);   
%     BW_area=im2bw(uint16(A3),level); 
%     BW_area=bwareaopen(BW_area,1000);
    B=bwboundaries(BW_area,'noholes');
    handles.boundary=B{1};
    handles.parameter.detection.Cell_area=BW_area;
    axes(handles.axes1);
    cla 
    imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
    hold on
    plot(handles.boundary(:,2),handles.boundary(:,1));
    hold off
else
    handles.parameter.detection.Cell_area=[];
    axes(handles.axes1);
    cla 
    imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
end
guidata(hObject,handles)
    
% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.DV)
    set(handles.text10,'string','');    
    viewtrajectory(handles);
else
    set(handles.text10,'string','There is no track!')
    return
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
handles.parameter.detection.boundary_threshold=str2double(get(hObject,'String'));
if get(handles.checkbox1,'value')
    [W2 W3 A3]=waveletTransform(handles.A(:,:,1),1,3);
    threshold=str2double(get(handles.edit5,'string'))*mean2(A3);
    level=threshold/65535;   
%     BW_area=im2bw(uint16(A3),level); 
%     BW_area=bwareaopen(BW_area,1000);
    BW_area=AreaDetect(uint16(A3),level);   
    B=bwboundaries(BW_area,'noholes');
    handles.boundary=B{1};
    handles.parameter.detection.Cell_area=BW_area;
    axes(handles.axes1);
    cla 
    imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
    hold on
    plot(handles.boundary(:,2),handles.boundary(:,1));
    hold off
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Select_ROI.
function Select_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to Select_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)\
handles.parameter.detection.ROI=roipoly();
ROI=handles.parameter.detection.ROI;
B=bwboundaries(ROI,'noholes');
handles.boundary=B{1};
axes(handles.axes1);
cla 
imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
hold on
plot(handles.boundary(:,2),handles.boundary(:,1));
hold off
guidata(hObject,handles)


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_wavelet.
function popupmenu_wavelet_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_wavelet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_wavelet
handles.parameter.detection.MSVST_flag=0;
coefficient=get(handles.popupmenu_wavelet,'value');
handles.parameter.detection.wavelet_coefficient=coefficient;
handles.data_w(:,:,1)=Detection(handles.A(:,:,1),handles.parameter);
axes(handles.axes1);
cla ;
imshow(handles.data_w(:,:,1),[]);
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenu_wavelet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
if ~isempty(handles.V)
    set(handles.text10,'string','')    
    dim=min(str2double(get(hObject,'String')),handles.maxpeak);
    set(handles.edit7,'string',num2str(dim));
    handles.dim=dim;
    handles.parameter.detection.trash_dim=dim;
    set(handles.slider_dim,'value',dim/handles.maxpeak);
    set(handles.text9,'string',num2str(dim/handles.maxpeak));
    IX=handles.V{1}(:,3)>dim;
    handles.Vnew{1}=handles.V{1}(IX,:);
    axes(handles.axes1);
    cla 
    imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
    hold on
    plot(handles.Vnew{1}(:,1),handles.Vnew{1}(:,2),'r*','MarkerSize',2);
    hold off
else
    set(handles.text10,'string','You must perform detection first!')
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_dim_Callback(hObject, eventdata, handles)
% hObject    handle to slider_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if ~isempty(handles.V)
    set(handles.text10,'string','')
    j=get(hObject,'Value');
    j=j-rem(j,0.01);
    set(handles.slider_dim,'value',j);
    set(handles.text9,'string',num2str(j));
    dim=round(j*handles.maxpeak);
    set(handles.edit7,'string',num2str(dim));
    handles.dim=dim;
    handles.parameter.detection.trash_dim=dim;
    IX=handles.V{1}(:,3)>dim;
    handles.Vnew{1}=handles.V{1}(IX,:);
    axes(handles.axes1);
    cla 
    imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
    hold on
    plot(handles.Vnew{1}(:,1),handles.Vnew{1}(:,2),'r*','MarkerSize',2);
    hold off
else
    set(handles.text10,'string','You must perform detection first!')
end
guidata(hObject,handles)
% length(handles.Vnew{1})

% --- Executes during object creation, after setting all properties.
function slider_dim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Find_particles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Find_particles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Clear_ROI.
function Clear_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to Clear_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.parameter.detection.ROI=[];
handles.boundary=[];
guidata(hObject,handles)

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text10,'string','Left-click to add a particle, Right-click to delete a particle, Any Other Key to exit!')
but=1;
while but==1 || but==3
    [x y but]=ginput(1);
    if but==1
        frame=round(get(handles.slider_image,'Value')*(handles.ImageNumber-1)+1);
        n=length(handles.V{frame}(:,1));
        handles.V{frame}(n+1,1)=x;
        handles.V{frame}(n+1,2)=y;
        handles.V{frame}(n+1,3)=handles.A(round(y),round(x),frame);
        axes(handles.axes1);
        cla 
        imshow(handles.A(:,:,frame),[handles.contrastLow handles.contrastHigh]);
        hold on
        plot(handles.V{frame}(:,1),handles.V{frame}(:,2),'r*','MarkerSize',2);
        guidata(hObject,handles)
    end
    if but==3
        frame=round(get(handles.slider_image,'Value')*(handles.ImageNumber-1)+1);
        n=length(handles.V{frame}(:,1));
        p=[];
        for i=1:n
            xx=handles.V{frame}(i,1);
            yy=handles.V{frame}(i,2);
            if sqrt((xx-x)^2+(yy-y)^2)<3
                p=i;
                break;
            end
        end
        if isempty(p)
           set(handles.text10,'string','No particle is selected!')
        else
           set(handles.text10,'string','Left-click to add a particle, Right-click to delete a particle, Any Other Key to exit!') 
        I=1:n;
        IX=(I~=p);
        handles.V{frame}=handles.V{frame}(IX,:);
        axes(handles.axes1);
        cla 
        imshow(handles.A(:,:,frame),[handles.contrastLow handles.contrastHigh]);
        hold on
        plot(handles.V{frame}(:,1),handles.V{frame}(:,2),'r*','MarkerSize',2);
        guidata(hObject,handles)
        end
    end
end
set(handles.text10,'string','') 


% --------------------------------------------------------------------
function Save_roi_Callback(hObject, eventdata, handles)
% hObject    handle to Save_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton14_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Save_detection_Callback(hObject, eventdata, handles)
% hObject    handle to Save_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstr=strcat(handles.pathname,handles.filebase,'_Detection.mat');
save(fstr);

% --------------------------------------------------------------------
function Save_tracking_Callback(hObject, eventdata, handles)
% hObject    handle to Save_tracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstr=strcat(handles.pathname,handles.filebase,'_Tracking.mat');
save(fstr);

% --------------------------------------------------------------------
function Load_roi_Callback(hObject, eventdata, handles)
% hObject    handle to Load_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton26_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Load_detection_Callback(hObject, eventdata, handles)
% hObject    handle to Load_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstr=strcat(handles.pathname,handles.filebase,'_Detection.mat');
if exist(fstr,'file')
    P=importdata(fstr);
else
    [filename, pathname] = uigetfile( ...
        {'*.mat', 'All MAT-Files (*.mat)'; ...
            '*.*','All Files (*.*)'}, ...
        'Select Mat File');
    if isequal([filename,pathname],[0,0])
        return
    else
        File = fullfile(pathname,filename);
        if ~isempty(File)  
            P=importdata(File);
        end
    end
end
set(handles.uipanel11,'visible','on');
set(handles.slider_image,'visible','on');
handles.V=P.handles.V;
handles.parameter=P.handles.parameter;
handles=ApplyParameters(handles);
handles.boundary=P.handles.boundary;
handles.ImageNumber=P.handles.ImageNumber;
handles.A=P.handles.A;
step=1.0/(handles.ImageNumber-1);
if step>0 && step<1
    set(handles.slider_image,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',0);
end
fstr=strcat('Image #:1','/',num2str(handles.ImageNumber));
set(findobj('Tag','text6'),'String',fstr);    
axes(handles.axes1)
% cla
% imshow(handles.A(:,:,1),[]);
hold on
plot(handles.V{1}(:,1),handles.V{1}(:,2),'r*','MarkerSize',2);
set(handles.Save_detection,'enable','on');
set(handles.Load_std_detection,'enable','on');
set(handles.View_detection,'enable','on');
set(handles.Edit_particle,'enable','on');
set(handles.Particle_number,'enable','on');
set(handles.Particle_intensity,'enable','on');
set(handles.uipushtool9,'enable','on');
guidata(hObject,handles)

% --------------------------------------------------------------------
function Load_tracking_Callback(hObject, eventdata, handles)
% hObject    handle to Load_tracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstr=strcat(handles.pathname,handles.filebase,'_Tracking.mat');
if exist(fstr,'file')
    P=importdata(fstr);
else
    [filename, pathname] = uigetfile( ...
        {'*.mat', 'All MAT-Files (*.mat)'; ...
            '*.*','All Files (*.*)'}, ...
        'Select Mat File');
    if isequal([filename,pathname],[0,0])
        return
    else
        File = fullfile(pathname,filename);
        if ~isempty(File)  
            P=importdata(File);
        end
    end
end
set(handles.uipanel11,'visible','on');
set(handles.uipanel18,'visible','off');
set(handles.slider_image,'visible','on');
handles.V=P.handles.V;
handles.ImageNumber=P.handles.ImageNumber;
handles.A=P.handles.A;
handles.DV=P.handles.DV;
handles.parameter=P.handles.parameter;
handles.parameter.prompt_flag=1;
handles=ApplyParameters(handles);
handles.boundary=P.handles.boundary;
step=1.0/(handles.ImageNumber-1);
set(handles.slider_image,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',0);
fstr=strcat('Image #:1','/',num2str(handles.ImageNumber));
set(findobj('Tag','text6'),'String',fstr);   
axes(handles.axes1)
% cla
% imshow(handles.A(:,:,1),[]);
hold on
plot(handles.V{1}(:,1),handles.V{1}(:,2),'r*','MarkerSize',2);
set(handles.Save_detection,'enable','on');
set(handles.Save_tracking,'enable','on');
set(handles.Load_std_tracking,'enable','on');
set(handles.Load_std_detection,'enable','on');
set(handles.Birth_and_death,'enable','on');
set(handles.View_detection,'enable','on');
set(handles.Edit_particle,'enable','on');
set(handles.View_tracking,'enable','on');
set(handles.Select_track,'enable','on');
set(handles.uipushtool9,'enable','on');
set(handles.uipushtool10,'enable','on');
set(handles.Particle_number,'enable','on');
set(handles.Particle_intensity,'enable','on');
set(handles.Particle_velocity,'enable','on');
set(handles.Life_time,'enable','on');
set(handles.Particle_path,'enable','on');
set(handles.Particle_displacement,'enable','on');
guidata(hObject,handles)

% --------------------------------------------------------------------
function Comparison_Callback(hObject, eventdata, handles)
% hObject    handle to Comparison (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_std_detection_Callback(hObject, eventdata, handles)
% hObject    handle to Load_std_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstr=strcat(handles.pathname,handles.filebase,'_Detection_checked.mat');
if exist(fstr,'file')
    P=importdata(fstr);
else
    if exist('lastfile.mat','file')
        P=importdata('lastfile.mat');
        pathname=P.pathname;
    else
        pathname=cd;    
    end
    [filename, pathname] = uigetfile( ...
        {'*.mat', 'All MAT-Files (*.mat)'; ...
            '*.*','All Files (*.*)'}, ...
        'Select Mat File',pathname);
    if isequal([filename,pathname],[0,0])
        return
    else
        File = fullfile(pathname,filename);
        if ~isempty(File)  
            P=importdata(File);
        end
    end
end

stdV=P.handles.V;
V=handles.V;
N0=0;
N1=0;
TPN=0;
set(handles.text10,'string','Comparing detection result ...')
mywaitbar(0,handles.axes2,'');
for i=1:length(stdV)
    mywaitbar(i/length(stdV),handles.axes2,[num2str(floor(i/length(stdV)*100)),'%']);
    n0=length(stdV{i}(:,1));
    n1=length(V{i}(:,1));
    N0=N0+n0;
    N1=N1+n1;
    V{i}(:,4)=0;
    stdV{i}(:,4)=0;
    for j=1:n0
        x1=stdV{i}(j,1);
        y1=stdV{i}(j,2);
        for k=1:n1
            x2=V{i}(k,1);
            y2=V{i}(k,2);
            if sqrt((x1-x2)^2+(y1-y2)^2)<=3 && V{i}(k,4)==0
                TPN=TPN+1;
                stdV{i}(j,4)=1;
                V{i}(k,4)=1;
                break;
            end
        end
    end
end

set(handles.text10,'string','Comparing finished!')
FPN=N1-TPN;
TPR=TPN/N0;
FPR=FPN/N0;
s1=['Total number:',num2str(N0)];
s2=['Detection number:',num2str(N1)];
s3=['True positive number:',num2str(TPN)];
s4=['False positive number:',num2str(FPN)];
s5=['True positive rate:',num2str(TPR)];
s6=['False positive rate:',num2str(FPR)];
msgbox({s1,s2,s3,s4,s5,s6},'Result');


% --------------------------------------------------------------------
function Load_std_tracking_Callback(hObject, eventdata, handles)
% hObject    handle to Load_std_tracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fstr=strcat(handles.pathname,handles.filebase,'_Tracking_checked.mat');
if exist(fstr,'file')
    P=importdata(fstr);
else
    if exist('lastfile.mat','file')
        P=importdata('lastfile.mat');
        pathname=P.pathname;
    else
        pathname=cd;    
    end
    [filename, pathname] = uigetfile( ...
        {'*.mat', 'All MAT-Files (*.mat)'; ...
            '*.*','All Files (*.*)'}, ...
        'Select Mat File',pathname);
    if isequal([filename,pathname],[0,0])
        return
    else
        File = fullfile(pathname,filename);
        if ~isempty(File)  
            P=importdata(File);
        end
    end
end

stdDV=P.handles.DV;
DV=handles.DV;
N0=length(stdDV);
N1=length(DV);
TPN=0;
mywaitbar(0,handles.axes2,'');
set(handles.text10,'string','Comparing tracking result ...')
for i=1:N0
    mywaitbar(i/N0,handles.axes2,[num2str(floor(i/N0*100)),'%']);
    track0(1,1:3)=stdDV(i,1).trackInfo(1,1:3);
    track0(2,1:3)=stdDV(i,1).trackInfo(end,1:3);
    for j=1:N1
        track1(1,1:3)=DV(j,1).trackInfo(1,1:3);
        track1(2,1:3)=DV(j,1).trackInfo(end,1:3);
        sdist=sqrt((track0(1,2)-track1(1,2))^2+(track0(1,3)-track1(1,3))^2);
        edist=sqrt((track0(2,2)-track1(2,2))^2+(track0(2,3)-track1(2,3))^2);
        if track0(1,1)==track1(1,1) && track0(2,1)==track1(2,1) && sdist<=3 && edist<=3
            TPN=TPN+1;
            break;
        end
    end
end
set(handles.text10,'string','Comparing finished!')
FPN=N1-TPN;
TPR=TPN/N0;
FPR=FPN/N0;
s1=['Total number:',num2str(N0)];
s2=['Detection number:',num2str(N1)];
s3=['True positive number:',num2str(TPN)];
s4=['False positive number:',num2str(FPN)];
s5=['True positive rate:',num2str(TPR)];
s6=['False positive rate:',num2str(FPR)];
msgbox({s1,s2,s3,s4,s5,s6},'Result')

% --------------------------------------------------------------------
function Open_last_Callback(hObject, eventdata, handles)
% hObject    handle to Open_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('lastfile.mat','file')
    set(handles.text10,'string','')    
    P=importdata('lastfile.mat');
    filename=P.filename;
    pathname=P.pathname;
    File=strcat(P.pathname,P.filename);
    global display_flag
    display_flag=0;
    handles.File=File;
    t=strfind(filename,'.tif');
    filebase=filename(1:t-1);
    handles.filebase = filebase;
    handles.pathname = pathname;        
    set(findobj('Tag','text5'),'String',File);  
    info=imfinfo(File);
%     info=tifftagsread(File);
    handles.TotalImages=length(info);
    [handles.A,handles.ImageNumber]=tiffread(File,1);
    set(handles.uipanel9,'visible','on');
    axes(handles.axes1);
    cla reset;
    imshow(handles.A(:,:,1),[]);
    [handles.row,handles.column]=size(handles.A(:,:,1));
    fstr=strcat('Image #:1','/',num2str(handles.ImageNumber));
    set(findobj('Tag','text6'),'String',fstr);
    handles.data_w=[];
    handles.contrastMax=max(max(handles.A(:,:,1)));
    handles.contrastMin=min(min(handles.A(:,:,1)));
    handles.contrastLow=handles.contrastMin;
    handles.contrastHigh=handles.contrastMax;
    step=0.01;
    set(handles.slider_contrastLow,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',0);
    step=0.02;
    set(handles.slider_contrastHigh,'max',1.0,'min',0,'SliderStep',[step 5*step],'value',1);
    % handles.ROI=[];
    % handles.ROI1=[];
    handles.DV=[];
    handles.V=[];
    % handles.dim=0;
    
    filestr=strcat(cd,'\main\Parameters_default.mat');
    flag=0;
    if exist(filestr,'file')
        parameter=importdata('Parameters_default.mat');
        try
            handles.parameter=parameter;
        catch
            flag=1;
        end
    else
        flag=1;
    end
    
    if flag
        handles.parameter.detection.wavelet_threshold=3;
        handles.parameter.detection.wavelet_coefficient=1;
        handles.parameter.detection.MSVST_flag=0;
        handles.parameter.detection.MSVST_mu=0.5;
        handles.parameter.detection.MSVST_sigma=0.5;
        handles.parameter.detection.MSVST_alpha=10;
        handles.parameter.detection.trash_dim=0;
        handles.parameter.detection.Cell_area=[];
        handles.parameter.detection.boundary_threshold=0.7;
        handles.parameter.detection.ROI=[];    
        handles.parameter.detection.localmaxima=0;
        handles.parameter.detection.width=5;
        handles.parameter.tracking.gap=1;
        handles.parameter.tracking.minSR=2;
        handles.parameter.tracking.maxSR=5;
        handles.parameter.linking.neighborhood=4;
        handles.parameter.linking.gap=1;
        handles.parameter.fitting.flag=1;
        handles.parameter.fitting.photonflag=1;
        handles.parameter.fitting.gain=300;
        handles.parameter.fitting.factor=10.5;
        handles.parameter.fitting.sigma=1.3;
        handles.parameter.fitting.pixelsize=100;
        handles.parameter.fitting.fitsize=7;
        handles.parameter.reconstruction.amp=8;
        handles.parameter.reconstruction.maxError=100;
        handles.parameter.reconstruction.minPhoton=0;
        handles.parameter.reconstruction.maxPhoton=5000;
        handles.parameter.reconstruction.maxBg=10;
        handles.parameter.reconstruction.meanBg=0;
        handles.parameter.reconstruction.minSigma=0.5;
        handles.parameter.reconstruction.maxSigma=3;
        handles.parameter.reconstruction.meanSigma=0;
        handles.parameter.prompt_flag=1;
        handles.parameter.driftCorrection=1;
        handles.parameter.display=0;
    end
    
    handles.parameter.detection_flag=0;
    handles.parameter.PALM.fitting_flag=0;
    handles.parameter.batch=0;
    handles.boundary=[];
    handles.parameter.detection.ROI=[];    
    set(handles.Export_boundary,'enable','on');
    set(handles.Drift_correction,'enable','on');
    handles=ApplyParameters(handles);

    set(handles.Load_detection,'enable','on');
    set(handles.Load_tracking,'enable','on');
    set(handles.uipanel1,'visible','on');
    set(handles.slider_image,'visible','off')
    set(handles.Current_figure,'enable','on');
    set(handles.Current_axes,'enable','on');
    set(handles.Wavelet_images,'enable','on');
    set(handles.Save_parameters,'enable','on');
    set(handles.Load_parameters,'enable','on');
    set(handles.Set_parameters,'enable','on');
    set(handles.uitoggletool11,'enable','on');
    set(handles.uipushtool11,'enable','on');
    set(handles.Linking,'enable','on');
    set(handles.Fitting,'enable','on');
    set(handles.Reconstruction,'enable','on');
    set(handles.Adjust_contrast,'enable','on');
    set(handles.One_step_process,'enable','on');
    set(handles.Save_cell_boundary,'enable','on');
    set(handles.Load_cell_boundary,'enable','on');
    P=[];
    guidata(hObject,handles)
else
    msgbox('No last file exist!','Attention!')
    return
end


% --------------------------------------------------------------------
function Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Birth_and_death_Callback(hObject, eventdata, handles)
% hObject    handle to Birth_and_death (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:length(handles.DV)
    Bir(i,1)=handles.DV(i,1).trackInfo(1,1);
    Dead(i,1)=handles.DV(i,1).trackInfo(end,1);
end

T=1:handles.ImageNumber;
Birth(:,1)=hist(Bir,T);
Death(:,1)=hist(Dead,T);

if ~isempty(handles.parameter.detection.Cell_area)
    Area=nnz(handles.parameter.detection.Cell_area);
elseif ~isempty(handles.parameter.detection.ROI)
    Area=nnz(handles.parameter.detection.ROI);
else
    Area=nnz(handles.A(:,:,1)>=0);
end

set(handles.Last_analysis_data,'enable','on');
handles.lastdata=[];
handles.lastdata(:,1)=Birth;
handles.lastdata(:,2)=Death;
handles.lastdata(1,3)=Area;
guidata(hObject,handles)

figure;
subplot(1,2,1);
Birth(1,1)=0;
bar(Birth)
title('Birth rate')
xlabel('Time(frame)')
ylabel('Events')
subplot(1,2,2);
Death(end,1)=0;
bar(Death)
title('Death rate')
xlabel('Time(frame)')
ylabel('Events')


% --- Executes on button press in MSVST.
function MSVST_Callback(hObject, eventdata, handles)
% hObject    handle to MSVST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=single(handles.A(:,:,1));
[out,M]=Gauss2D(A,1);
ImgMax=locmax2d(out,[5 5]);
[y x]=find(ImgMax>0);
[row column]=size(A);
n=1;
for i=1:length(y)
    if x(i)>2 && x(i)<=column-2 && y(i)>2 && y(i)<=row-2
       ROI=A(y(i)-2:y(i)+2,x(i)-2:x(i)+2);
       ROI=ROI(:);
       data(n,2)=median(ROI);
       data(n,1)=(median(abs(ROI-median(ROI)))/0.6745)^2;
       n=n+1;
    end
end
IX=data(:,1)>0 & data(:,2)>0;
data=data(IX,:);
[alpha,sigma,SE1,SE]=MMrse(data,0.5);
alpha=max(alpha,1);
handles.parameter.detection.MSVST_alpha=round(alpha);
    
if handles.parameter.prompt_flag
    prompt={'Enter mu:','Enter sigma:','Enter alpha:'};
    defans={num2str(handles.parameter.detection.MSVST_mu),num2str(handles.parameter.detection.MSVST_sigma),num2str(handles.parameter.detection.MSVST_alpha)};
    info = inputdlg(prompt, 'Input for process...!', 1, defans);
    if ~isempty(info)
        handles.parameter.detection.MSVST_flag=1;
        handles.parameter.detection.MSVST_mu=str2double(info(1));
        handles.parameter.detection.MSVST_sigma=str2double(info(2));
        handles.parameter.detection.MSVST_alpha=str2double(info(3));
    else
        return
    end
end
mu=round(mean2(handles.A(:,:,1))*handles.parameter.detection.MSVST_mu);
sigma=round(std2(handles.A(:,:,1))*handles.parameter.detection.MSVST_sigma);
handles.data_w(:,:,1) = msvstB3Denoisep (single(handles.A(:,:,1)), 0.01, 3, 2, mu, sigma, handles.parameter.detection.MSVST_alpha, 1, 0, 1, 1);
axes(handles.axes1);
cla;
imshow(handles.data_w(:,:,1),[]);
guidata(hObject,handles)


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
handles.parameter.detection.width=num2str(get(handles.edit8,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
handles.parameter.detection.width=num2str(get(handles.edit9,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
if get(hObject,'Value')
    set(handles.edit9,'enable','on');
    set(handles.edit8,'enable','off');
else
    set(hObject,'value',1);
end
handles.parameter.detection.localmaxima=0;
handles.parameter.detection.width=num2str(get(handles.edit8,'string'));
guidata(hObject,handles)

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
if get(hObject,'Value')
    set(handles.edit8,'enable','on');
    set(handles.edit9,'enable','off');
else
    set(hObject,'value',1);
end
handles.parameter.detection.localmaxima=1;
handles.parameter.detection.width=num2str(get(handles.edit8,'string'));
guidata(hObject,handles)

% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_new_file_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Open_new_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Open_new_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function uipushtool9_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton20_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function Detection_Callback(hObject, eventdata, handles)
% hObject    handle to Detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Tracking_Callback(hObject, eventdata, handles)
% hObject    handle to Tracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function View_tracking_Callback(hObject, eventdata, handles)
% hObject    handle to View_tracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton15_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Select_track_Callback(hObject, eventdata, handles)
% hObject    handle to Select_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton5_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function View_detection_Callback(hObject, eventdata, handles)
% hObject    handle to View_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton6_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Edit_particle_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_particle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton20_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function Fusion_detection_Callback(hObject, eventdata, handles)
% hObject    handle to Fusion_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton11_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Gaussian_fitting_Callback(hObject, eventdata, handles)
% hObject    handle to Gaussian_fitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton10_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Exocytosis_Callback(hObject, eventdata, handles)
% hObject    handle to Exocytosis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool10_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton5_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function Current_figure_Callback(hObject, eventdata, handles)
% hObject    handle to Current_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile( ...
    {'*.bmp', 'All BMP-Files (*.bmp)'; ...
        '*.*','All Files (*.*)'}, ...
    'Save Image File');
if isequal([filename,pathname],[0,0])
    return
else
    filestr=fullfile(pathname,filename);
    F=getframe(gcf);
    imwrite(F.cdata,filestr);
end

% --------------------------------------------------------------------
function Current_axes_Callback(hObject, eventdata, handles)
% hObject    handle to Current_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile( ...
    {'*.bmp', 'All BMP-Files (*.bmp)'; ...
        '*.*','All Files (*.*)'}, ...
    'Save Image File');
if isequal([filename,pathname],[0,0])
    return
else
    filestr=fullfile(pathname,filename);
    F=getframe(gca);
    imwrite(F.cdata,filestr);
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Wavelet_images_Callback(hObject, eventdata, handles)
% hObject    handle to Wavelet_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.data_wavelet)
    tiffwrite(handles.data_wavelet);
    set(handles.text10,'string','')
elseif ~isempty(handles.data_w)
    tiffwrite(handles.data_w);
    set(handles.text10,'string','')
else
    set(handles.text10,'string','No wavelet images exist!')
    return
end

% --------------------------------------------------------------------
function Detection_based_Callback(hObject, eventdata, handles)
% hObject    handle to Detection_based (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Tracking_based_Callback(hObject, eventdata, handles)
% hObject    handle to Tracking_based (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Particle_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to Particle_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DV=handles.DV;
tracknum=length(DV);
ParticleVelocity=[];
n=1;
for i=1:tracknum
    nanflag=1;
    while nanflag
        [nanflag DV(i,1).trackInfo]=fillnan(DV(i,1).trackInfo);
    end
    l=length(DV(i,1).trackInfo(:,1));
    for j=1:l-1
        ParticleVelocity(n,1)=sqrt((DV(i,1).trackInfo(j+1,2)-DV(i,1).trackInfo(j,2))^2+(DV(i,1).trackInfo(j+1,3)-DV(i,1).trackInfo(j,3))^2);
        n=n+1;
    end
end
figure;
hist(ParticleVelocity,50);
title('Histogram of particle velocity')
xlabel('Velocity(pixel/frame)')
ylabel('Events')
handles.lastdata=ParticleVelocity;
set(handles.Last_analysis_data,'enable','on');
guidata(hObject,handles)

% --------------------------------------------------------------------
function Life_time_Callback(hObject, eventdata, handles)
% hObject    handle to Life_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DV=handles.DV;
tracknum=length(DV);
ParticleLifetime=[];
for i=1:tracknum
    ParticleLifetime(i,1)=length(DV(i,1).trackInfo(:,1));
end
figure;
hist(ParticleLifetime,20);
title('Histogram of particle life time')
xlabel('Life time(frame)')
ylabel('Events')
handles.lastdata=ParticleLifetime;
set(handles.Last_analysis_data,'enable','on');
guidata(hObject,handles)

% --------------------------------------------------------------------
function Particle_path_Callback(hObject, eventdata, handles)
% hObject    handle to Particle_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DV=handles.DV;
tracknum=length(DV);
ParticlePath=[];
for i=1:tracknum
    nanflag=1;
    while nanflag
        [nanflag DV(i,1).trackInfo]=fillnan(DV(i,1).trackInfo);
    end
    ParticlePath(i,1)=0;
    l=length(DV(i,1).trackInfo(:,1));
    for j=1:l-1
        ParticlePath(i,1)=ParticlePath(i,1)+sqrt((DV(i,1).trackInfo(j+1,2)-DV(i,1).trackInfo(j,2))^2+(DV(i,1).trackInfo(j+1,3)-DV(i,1).trackInfo(j,3))^2);
    end
end
figure;
hist(ParticlePath,50);
title('Histogram of particle path')
xlabel('Path(pixel)')
ylabel('Events')
handles.lastdata=ParticlePath;
set(handles.Last_analysis_data,'enable','on');
guidata(hObject,handles)

% --------------------------------------------------------------------
function Particle_displacement_Callback(hObject, eventdata, handles)
% hObject    handle to Particle_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DV=handles.DV;
tracknum=length(DV);
ParticleDisplacement=[];
for i=1:tracknum
    nanflag=1;
    while nanflag
        [nanflag DV(i,1).trackInfo]=fillnan(DV(i,1).trackInfo);
    end
    ParticleDisplacement(i,1)=sqrt((DV(i,1).trackInfo(end,2)-DV(i,1).trackInfo(1,2))^2+(DV(i,1).trackInfo(end,3)-DV(i,1).trackInfo(1,3))^2)/length(DV(i,1).trackInfo(:,1));
end
figure;
hist(ParticleDisplacement,50);
title('Histogram of particle mean displacement')
xlabel('Mean displacement(pixel/frame)')
ylabel('Events')
handles.lastdata=ParticleDisplacement;
set(handles.Last_analysis_data,'enable','on');
guidata(hObject,handles)

% --------------------------------------------------------------------
function Particle_number_Callback(hObject, eventdata, handles)
% hObject    handle to Particle_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ParticleNumber=[];
for i=1:handles.ImageNumber
    ParticleNumber(i,1)=length(handles.V{i});
end
figure;
plot(ParticleNumber,'b-');
axis([1 handles.ImageNumber 1 max(ParticleNumber)+5])
Psmooth=smooth(ParticleNumber);
hold on
plot(Psmooth,'r-')
title('Particle number vs time');
xlabel('Time(frame)')
ylabel('Particle number')
hold off
handles.lastdata=ParticleNumber;
set(handles.Last_analysis_data,'enable','on');
guidata(hObject,handles)

% --------------------------------------------------------------------
function Particle_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to Particle_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ParticleIntensity=[];
n=1;
for i=1:handles.ImageNumber
    for j=1:length(handles.V{i})
        ParticleIntensity(n,1)=handles.V{i}(j,3);
        n=n+1;
    end
end
figure;
hist(ParticleIntensity,50);
title('Histogram of particle intensity')
xlabel('Intensity')
ylabel('Events')
set(handles.Last_analysis_data,'enable','on');
handles.lastdata=ParticleIntensity;
guidata(hObject,handles)


% --------------------------------------------------------------------
function STA_Callback(hObject, eventdata, handles)
% hObject    handle to STA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Option_Callback(hObject, eventdata, handles)
% hObject    handle to Option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Save_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile( ...
    {'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, ...
    'Save Mat File');
if isequal([filename,pathname],[0,0])
    return
else
    parameter=handles.parameter;
    filestr=fullfile(pathname,filename);
    save(filestr,'parameter');
end

% --------------------------------------------------------------------
function Load_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Load_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Mat File');
if isequal([filename,pathname],[0,0])
    return
else
    filestr=fullfile(pathname,filename);
    parameter=importdata(filestr);
    handles.parameter=parameter;
end
handles=ApplyParameters(handles);
guidata(hObject,handles)

function handles=ApplyParameters(handles)
set(handles.wavelet_threshold,'string',num2str(handles.parameter.detection.wavelet_threshold));
set(handles.slider_wavelet,'value',handles.parameter.detection.wavelet_threshold);
set(handles.popupmenu_wavelet,'value',handles.parameter.detection.wavelet_coefficient);
set(handles.edit5,'string',num2str(handles.parameter.detection.boundary_threshold));   
if ~isempty(handles.parameter.detection.Cell_area)
    set(handles.checkbox1,'value',1);
    [W2 W3 A3]=waveletTransform(handles.A(:,:,1),1,3);
    threshold=str2double(get(handles.edit5,'string'))*mean2(A3);
    level=threshold/65535;                                  
    BW_area=AreaDetect(uint16(A3),level);   
    B=bwboundaries(BW_area,'noholes');
    handles.boundary=B{1};
    axes(handles.axes1);
    cla 
    imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
    hold on
    plot(handles.boundary(:,2),handles.boundary(:,1));
    hold off
    handles.parameter.detection.Cell_area=BW_area;
else
    set(handles.checkbox1,'value',0);
    ROI=handles.parameter.detection.ROI;
    if ~isempty(ROI)
        B=bwboundaries(ROI,'noholes');
        handles.boundary=B{1};
        axes(handles.axes1);
        cla 
        imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
        hold on
        plot(handles.boundary(:,2),handles.boundary(:,1));
        hold off
    end
end
try
    if handles.parameter.detection.localmaxima==1
        set(handles.radiobutton3,'value',1);
        set(handles.edit8,'enable','on');
        set(handles.edit9,'enable','off');
        set(handles.edit8,'string',num2str(handles.parameter.detection.width));
    else
        set(handles.radiobutton4,'value',1);
        set(handles.edit9,'enable','on');
        set(handles.edit8,'enable','off');
        set(handles.edit9,'string',num2str(handles.parameter.detection.width));    
    end
catch ME
    handles.parameter.detection.localmaxima=0;
    handles.parameter.detection.width=5;
    set(handles.radiobutton4,'value',1);
    set(handles.edit9,'enable','on');
    set(handles.edit8,'enable','off');
    set(handles.edit9,'string',num2str(handles.parameter.detection.width));    
end
if handles.parameter.driftCorrection==1
    set(handles.Drift_correction,'checked','on');
else
    set(handles.Drift_correction,'checked','off');
end

% --------------------------------------------------------------------
function Batch_Callback(hObject, eventdata, handles)
% hObject    handle to Batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Process_single_Callback(hObject, eventdata, handles)
% hObject    handle to Process_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Process_directory_Callback(hObject, eventdata, handles)
% hObject    handle to Process_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Set_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Set_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.parameter]=Parameters(handles.parameter);
handles=ApplyParameters(handles);
guidata(hObject,handles);


% --------------------------------------------------------------------
function uipushtool11_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text10,'string','Press Any Key to continue!');
pause;


% --------------------------------------------------------------------
function uitoggletool11_OffCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.parameter.prompt_flag=1;
guidata(hObject,handles);

% --------------------------------------------------------------------
function uitoggletool11_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.parameter.prompt_flag=0;
guidata(hObject,handles);


% --------------------------------------------------------------------
function Last_analysis_data_Callback(hObject, eventdata, handles)
% hObject    handle to Last_analysis_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
    lastdata=handles.lastdata;
    filestr=fullfile(pathname,filename);
    if strfind(filestr,'.mat')
    save(filestr,'lastdata');
    elseif strfind(filestr,'.xls')
        xlswrite(filestr,lastdata);
    %     a=length(lastdata(:,1));
    %     b=length(lastdata(1,:));
    %     if b==1
    %         xlswrite(filestr,lastdata,strcat('A1:A',num2str(a)));
    %     elseif b==2
    %        xlswrite(filestr,lastdata,strcat('A1:B',num2str(a))); 
    %     elseif b==3
    %        xlswrite(filestr,lastdata,strcat('A1:C',num2str(a))); 
    %     end
    else
        error('Wrong file name!')
    end
end


% --------------------------------------------------------------------
function Parameter2_Callback(hObject, eventdata, handles)
% hObject    handle to Parameter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Option_1_Callback(hObject, eventdata, handles)
% hObject    handle to Option_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Bleach_compensation_Callback(hObject, eventdata, handles)
% hObject    handle to Bleach_compensation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tf=strcmp(get(hObject,'checked'), 'off');
if tf==1
    set(hObject,'checked','on');    
    handles.parameter.bleach=1;
    set(handles.text10,'string','Bleach cpmpensation enabled!')
else
    set(hObject,'checked','off');   
    handles.parameter.bleach=0;    
    set(handles.text10,'string','Bleach cpmpensation disabled!')
end
guidata(hObject,handles);

% --------------------------------------------------------------------
function Drift_correction_Callback(hObject, eventdata, handles)
% hObject    handle to Drift_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tf=strcmp(get(hObject,'checked'), 'off');
if tf==1
    set(hObject,'checked','on');    
    handles.parameter.drift=1;
    set(handles.text10,'string','Drift correction enabled!')
else
    set(hObject,'checked','off');   
    handles.parameter.drift=0;  
    set(handles.text10,'string','Drift correction disabled!')
end
guidata(hObject,handles);

% --------------------------------------------------------------------
function Gaussian_fitting_flag_Callback(hObject, eventdata, handles)
% hObject    handle to Gaussian_fitting_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tf=strcmp(get(hObject,'checked'), 'off');
if tf==1
    set(hObject,'checked','on');    
    handles.parameter.fitting_flag=1;
    set(handles.text10,'string','Gaussian fitting enabled!')
else
    set(hObject,'checked','off');   
    handles.parameter.fitting_flag=0; 
    set(handles.text10,'string','Gaussian fitting disabled!')
end
guidata(hObject,handles);


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
cmd=get(hObject,'currentkey');
switch cmd
    case {'a'}    
        j=round(get(handles.slider_image,'Value')*(handles.ImageNumber-1)+1);
        if j>=2
        j=j-1;
        set(handles.slider_image,'Value',(j-1)/(handles.ImageNumber-1));
        slider_image_Callback(hObject, eventdata, handles);
        end        
    case {'d'}    
        j=round(get(handles.slider_image,'Value')*(handles.ImageNumber-1)+1);
        if j<=handles.ImageNumber-1
        j=j+1;
        set(handles.slider_image,'Value',(j-1)/(handles.ImageNumber-1));
        slider_image_Callback(hObject, eventdata, handles);
        end
%     case {'q'}   
%         Intensity_vs_time_Callback(hObject, eventdata, handles)
%     case {'s'}      
%         j=get(handles.listbox1,'value');
%         if j<length(handles.FusionV)
%         j=j+1;
%         set(handles.listbox1,'value',j);
%         listbox1_Callback(hObject, eventdata, handles)
%         end
%     case {'w'}    
%         j=get(handles.listbox1,'value');
%         if j>1
%         j=j-1;
%         set(handles.listbox1,'value',j);
%         listbox1_Callback(hObject, eventdata, handles)
%         end
%     case {'e'}
%         Intensity_vs_time_docking_Callback(hObject, eventdata, handles)
%     case {'f'}
%         Intensity_vs_time_docking_new_Callback(hObject, eventdata, handles)
%     case {'e'}
%         Intensity_vs_time_docking_new1_Callback(hObject, eventdata, handles)
%     case {'delete'}
%         Delete_Callback(hObject, eventdata, handles); 
end
        


% --------------------------------------------------------------------
function PALM_Callback(hObject, eventdata, handles)
% hObject    handle to PALM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Linking_Callback(hObject, eventdata, handles)
% hObject    handle to Linking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.parameter.prompt_flag
    prompt={'Enter neighborhood (1, 4 or 8):','Enter gap:'};
    defans={num2str(handles.parameter.linking.neighborhood),num2str(handles.parameter.linking.gap)};
    info = inputdlg(prompt, 'Input for process...!', 1, defans);
    if ~isempty(info)
        handles.parameter.linking.neighbor=str2double(info(1));
        handles.parameter.linking.gap=str2double(info(2));
    else
        return
    end
end
handles.data_w1=handles.data_w(:,:,1);
handles.data_w=[];
handles.data_w=handles.data_w1;
handles.data_w1=[];
handles=PALM_linking_new(handles);
guidata(hObject,handles)
fstr=strcat(handles.pathname,handles.filebase,'_Tracking_main.mat');
set(handles.text10,'string','Saving ...')
pause(0.1)
save(fstr);
set(handles.Save_tracking,'enable','on')   
set(handles.Birth_and_death,'enable','on');
set(handles.View_detection,'enable','on');
set(handles.Edit_particle,'enable','on');
set(handles.View_tracking,'enable','on');
set(handles.Select_track,'enable','on');
set(handles.Particle_number,'enable','on');
set(handles.Particle_intensity,'enable','on');
set(handles.Particle_velocity,'enable','on');
set(handles.Life_time,'enable','on');
set(handles.Particle_path,'enable','on');
set(handles.Particle_displacement,'enable','on');
set(handles.text10,'string','PALM linking finished!')

% --------------------------------------------------------------------
function Fitting_with_CPU_Callback(hObject, eventdata, handles)
% hObject    handle to Fitting_with_CPU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.parameter.prompt_flag
    prompt={'Enter lucky threshold (0 for no lucky):','Enter EMccd gain:','Enter sigma:','Enter pixel size:','Enter fitting size:'};
    defans={'0','300','1.3','100','7'};
    info = inputdlg(prompt, 'Input for process...!', 1, defans);
    if ~isempty(info)
        lucky=str2double(info(1));
        gain=str2double(info(2));
        sigma=str2double(info(3));
        a=str2double(info(4));
        fitl=(str2double(info(5))-1)/2;
    else
        return
    end
else
    lucky=0;
    gain=300;
    sigma=1.3;
    a=100;
    fitl=3;
end
handles=PALM_fitting(handles,lucky,gain,sigma,a,fitl);
handles.parameter.PALM.fitting_flag=1;
guidata(hObject,handles)
fstr=strcat(handles.pathname,handles.filebase,'_Fitting_main.mat');
save(fstr);
set(handles.text10,'string','Gaussian fitting finished!')

% --------------------------------------------------------------------
function Reconstruction_Callback(hObject, eventdata, handles)
% hObject    handle to Reconstruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.parameter.prompt_flag
    prompt={'Enter amplification for reconstruction:','Enter max position error:','Enter min sum photons:','Enter max sum photons:','Enter max background photons:','Enter mean background photons:',...
        'Enter min sigma:','Enter max sigma:','Use mean sigma:','Drift correction:'};
    defans={num2str(handles.parameter.reconstruction.amp),num2str(handles.parameter.reconstruction.maxError),num2str(handles.parameter.reconstruction.minPhoton),...
        num2str(handles.parameter.reconstruction.maxPhoton),num2str(handles.parameter.reconstruction.maxBg),num2str(handles.parameter.reconstruction.meanBg),...
        num2str(handles.parameter.reconstruction.minSigma),num2str(handles.parameter.reconstruction.maxSigma),num2str(handles.parameter.reconstruction.meanSigma),num2str(handles.parameter.driftCorrection)};
    info = inputdlg(prompt, 'Input for process...!', 1, defans);
    if ~isempty(info)
        handles.parameter.reconstruction.amp=str2double(info(1));
        handles.parameter.reconstruction.maxError=str2double(info(2));
        handles.parameter.reconstruction.minPhoton=str2double(info(3));
        handles.parameter.reconstruction.maxPhoton=str2double(info(4));
        handles.parameter.reconstruction.maxBg=str2double(info(5));
        handles.parameter.reconstruction.meanBg=str2double(info(6));
        handles.parameter.reconstruction.minSigma=str2double(info(7));
        handles.parameter.reconstruction.maxSigma=str2double(info(8));
        handles.parameter.reconstruction.meanSigma=str2double(info(9));
        handles.parameter.driftCorrection=str2double(info(10));
    else
        return
    end
end
PALM_reconstruction(handles);
set(handles.text10,'string','Recontruction finished!')
guidata(hObject,handles)


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Fitting_Callback(hObject, eventdata, handles)
% hObject    handle to Fitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.parameter.prompt_flag
    prompt={'Enter EMccd gain:','Enter conversion factor','Enter sigma:','Enter pixel size:','Enter fitting size:','Enter fitting flag:','Enter photon flag:'};
    defans={num2str(handles.parameter.fitting.gain),num2str(handles.parameter.fitting.factor),num2str(handles.parameter.fitting.sigma),...
        num2str(handles.parameter.fitting.pixelsize),num2str(handles.parameter.fitting.fitsize),num2str(handles.parameter.fitting.flag),num2str(handles.parameter.fitting.photonflag)};
    info = inputdlg(prompt, 'Input for process...!', 1, defans);
    if ~isempty(info)
        handles.parameter.fitting.gain=str2double(info(1));
        handles.parameter.fitting.factor=str2double(info(2));
        handles.parameter.fitting.sigma=str2double(info(3));
        handles.parameter.fitting.pixelsize=str2double(info(4));
        handles.parameter.fitting.fitsize=str2double(info(5));
        handles.parameter.fitting.flag=str2double(info(6));
        handles.parameter.fitting.photonflag=str2double(info(7));
    else
        return
    end
end
if handles.parameter.fitting.flag==1
    handles=PALM_fitting_GPU(handles);
elseif handles.parameter.fitting.flag==2
    handles=PALM_fitting_CPU(handles);
elseif handles.parameter.fitting.flag==3  
    handles=PALM_fitting_ANN(handles);
elseif handles.parameter.fitting.flag==4  
    handles=PALM_fitting_iPALM(handles);
else
    return
end
handles.parameter.PALM.fitting_flag=1;
fstr=strcat(handles.pathname,handles.filebase,'_Fitting_main.mat');
A=handles.A;
DV=handles.DV;
V=handles.V;
handles.A=[];
handles.DV=[];
handles.V=[];
set(handles.text10,'string','Saving ...')
pause(0.1)
save(fstr,'handles','-v7.3');
handles.DV=DV;
handles.A=A;
handles.V=V;
guidata(hObject,handles)
set(handles.text10,'string','Fitting finished!')


% --------------------------------------------------------------------
function Adjust_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to Adjust_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.uipanel18,'visible'),'off')
    set(handles.uipanel18,'visible','on');
    set(handles.Adjust_contrast,'checked','on');
else
    set(handles.uipanel18,'visible','off');
    set(handles.Adjust_contrast,'checked','off');
end


% --- Executes on slider movement.
function slider_contrastLow_Callback(hObject, eventdata, handles)
% hObject    handle to slider_contrastLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
v=get(hObject,'Value');
handles.contrastLow=handles.contrastMin+v*(handles.contrastMax-handles.contrastMin);
if handles.contrastLow>=handles.contrastHigh
   handles.contrastLow=handles.contrastHigh-10; 
   v=double(handles.contrastLow)/double((handles.contrastMax-handles.contrastMin));
   set(handles.slider_contrastLow,'value',v);
end
guidata(hObject,handles)
slider_image_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider_contrastLow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_contrastLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_contrastHigh_Callback(hObject, eventdata, handles)
% hObject    handle to slider_contrastHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
v=get(hObject,'Value');
handles.contrastHigh=handles.contrastMin+v*(handles.contrastMax-handles.contrastMin);
if handles.contrastHigh<=handles.contrastLow
   handles.contrastHigh=handles.contrastLow+10;
   v=double(handles.contrastHigh)/double((handles.contrastMax-handles.contrastMin));
   set(handles.slider_contrastHigh,'value',v);
end
guidata(hObject,handles)
slider_image_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider_contrastHigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_contrastHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Contrast_reset.
function Contrast_reset_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.contrastLow=handles.contrastMin;
handles.contrastHigh=handles.contrastMax;
set(handles.slider_contrastLow,'value',0)
set(handles.slider_contrastHigh,'value',1)
guidata(hObject,handles)
slider_image_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function Save_as_template_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Save_as_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
j=get(handles.listbox1,'Value');
track=handles.FusionV(j,4);
t2=handles.FusionV(j,1);
cy=handles.FusionV(j,2);
cx=handles.FusionV(j,3);
t1=handles.DV(track).trackInfo(1,1);
t3=handles.DV(track).trackInfo(end,1);
if cy>9 && cx>9 && cy+9<=handles.row && cx+9<=handles.column     
    for i=1:t3-t1+1
        A(:,:,i)=handles.A(cy-9:cy+9,cx-9:cx+9,t1+i-1);
    end
end
TDir=[cd,'\templates','\*.tif'];
temsum=length(dir(TDir))+1;
fstr=strcat(cd,'\templates\template_',num2str(temsum),'.tif');
tiffwrite(A,fstr);


% --------------------------------------------------------------------
function Export_boundary_Callback(hObject, eventdata, handles)
% hObject    handle to Export_boundary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Boundary=handles.boundary;
if ~isempty(Boundary)
    [filename, pathname] = uiputfile( ...
        {'*.xls','ALL XLS-Files(*.xls)'; ...
           '*.mat', 'All MAT-Files (*.mat)'
            '*.*','All Files (*.*)'}, ...
        'Save Data File');
    if isequal([filename,pathname],[0,0])
        return
    else
        filestr=fullfile(pathname,filename);
        if strfind(filestr,'.mat')
            save(filestr,'Boundary');
        elseif strfind(filestr,'.xls')
            xlswrite(filestr,Boundary);
        end
    end
else
   set(handles.text10,'string','No boundary exist!') 
end

% --------------------------------------------------------------------
function uitoggletool12_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.parameter.display=1;
guidata(hObject,handles);


% --------------------------------------------------------------------
function uitoggletool12_OffCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.parameter.display=0;
guidata(hObject,handles);


% --------------------------------------------------------------------
function One_step_process_Callback(hObject, eventdata, handles)
% hObject    handle to One_step_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Process_next_frames_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
if  handles.parameter.detection_flag==0
    return
end
handles.parameter.prompt_flag=0;
Linking_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
Fitting_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
Reconstruction_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.parameter.prompt_flag=1;
guidata(hObject,handles)


% --------------------------------------------------------------------
function Load_cell_boundary_Callback(hObject, eventdata, handles)
% hObject    handle to Load_cell_boundary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.mat', 'All MAT-Files (*.mat)'
        '*.*','All Files (*.*)'}, ...
    'Save Data File',handles.pathname);
if isequal([filename,pathname],[0,0])
    return
else
    filestr=fullfile(pathname,filename);
    P=importdata(filestr);
    handles.boundary=P.boundary;
    if length(P.BW_area)>1
       handles.parameter.detection.Cell_area=P.BW_area;
       handles.parameter.detection.ROI=[];
       set(handles.checkbox1,'value',1);
    else
       handles.parameter.detection.Cell_area=[];
       handles.parameter.detection.ROI=P.ROI;
       set(handles.checkbox1,'value',0);
    end
    axes(handles.axes1);
    cla 
    imshow(handles.A(:,:,1),[handles.contrastLow handles.contrastHigh]);
    hold on
    plot(handles.boundary(:,2),handles.boundary(:,1));
    hold off
    guidata(hObject,handles)
end

% --------------------------------------------------------------------
function Save_cell_boundary_Callback(hObject, eventdata, handles)
% hObject    handle to Save_cell_boundary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
boundary=handles.boundary;
if get(handles.checkbox1,'value')
    BW_area=handles.parameter.detection.Cell_area;
    ROI=0;
else
    BW_area=0;
    ROI=handles.parameter.detection.ROI;
end
str=strcat(handles.pathname,handles.filebase,'_Cell_boundary.mat');
save(str,'boundary','BW_area','ROI');


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Batch_process_Callback(hObject, eventdata, handles)
% hObject    handle to Batch_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Batch_process;


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

% --------------------------------------------------------------------
function Fitting_with_ANN_Callback(hObject, eventdata, handles)
% hObject    handle to Fitting_with_ANN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=ANN_fitting(handles);
handles.parameter.PALM.fitting_flag=1;
guidata(hObject,handles)
fstr=strcat(handles.pathname,handles.filebase,'_Fitting_main.mat');
save(fstr);
set(handles.text10,'string','Gaussian fitting finished!')


% --------------------------------------------------------------------
function ANN_Callback(hObject, eventdata, handles)
% hObject    handle to ANN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ANN_gui_Callback(hObject, eventdata, handles)
% hObject    handle to ANN_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ANN_gui;


% --------------------------------------------------------------------
function Select_neural_network_Callback(hObject, eventdata, handles)
% hObject    handle to Select_neural_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.mat', 'All MAT-Files (*.mat)'
        '*.*','All Files (*.*)'}, ...
    'Open Data File');
if isequal([filename,pathname],[0,0])
    return
else
    filestr=fullfile(pathname,filename);
end
save('Network_default.mat','filestr');


% --- Executes when uipanel9 is resized.
function uipanel9_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
