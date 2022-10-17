function varargout = Batch_process(varargin)
% BATCH_PROCESS M-file for Batch_process.fig
%      BATCH_PROCESS, by itself, creates a new BATCH_PROCESS or raises the existing
%      singleton*.
%
%      H = BATCH_PROCESS returns the handle to a new BATCH_PROCESS or the handle to
%      the existing singleton*.
%
%      BATCH_PROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_PROCESS.M with the given input arguments.
%
%      BATCH_PROCESS('Property','Value',...) creates a new BATCH_PROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Batch_process_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Batch_process_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Batch_process

% Last Modified by GUIDE v2.5 06-Dec-2011 16:54:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Batch_process_OpeningFcn, ...
                   'gui_OutputFcn',  @Batch_process_OutputFcn, ...
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


% --- Executes just before Batch_process is made visible.
function Batch_process_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Batch_process (see VARARGIN)

% Choose default command line output for Batch_process
handles.output = hObject;
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
    handles.parameter.prompt_flag=0;
    handles.parameter.driftCorrection=1;
    handles.parameter.display=0;
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Batch_process wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Batch_process_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=uigetdir();
if path~=0
    handles.pathname=[path,'\'];
    set(handles.edit1,'string',path);
    str=strcat(path,'\','*.tif');
    files=dir(str);
    n=length(files);
    filestr=cell(1,n);
    for i=1:n
        filename=files(i).name;
        filestr{i}=filename;
    end
    set(handles.listbox1,'string',filestr);
    handles.filestr=filestr;
end
guidata(hObject,handles)

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.tif;*.tiff', 'All TIF-Files (*.tif,*.tiff)'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Image File','MultiSelect', 'on');
if isequal([filename,pathname],[0,0])
    return
else
    handles.pathname=pathname;
    set(handles.edit1,'string',pathname);
    set(handles.listbox1,'string',filename);
    if ~iscell(filename)
        filename={filename};
    end
    handles.filestr=filename;
end
guidata(hObject,handles)

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.parameter]=Parameters(handles.parameter);
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Batch_process_files(handles);

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
