function varargout = Parameters(varargin)
% PARAMETERS M-file for Parameters.fig
%      PARAMETERS, by itself, creates a new PARAMETERS or raises the existing
%      singleton*.
%
%      H = PARAMETERS returns the handle to a new PARAMETERS or the handle to
%      the existing singleton*.
%
%      PARAMETERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETERS.M with the given input arguments.
%
%      PARAMETERS('Property','Value',...) creates a new PARAMETERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Parameters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Parameters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Parameters

% Last Modified by GUIDE v2.5 02-Dec-2017 10:07:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Parameters_OpeningFcn, ...
                   'gui_OutputFcn',  @Parameters_OutputFcn, ...
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


% --- Executes just before Parameters is made visible.
function Parameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Parameters (see VARARGIN)
% Choose default command line output for Parameters
handles.output = hObject;
handles.parameter=varargin{1};
% Update handles structure
guidata(hObject, handles);
SetParameters(handles);
uiwait(gcf);

% UIWAIT makes Parameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Parameters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1}=handles.parameter;
close(gcf)

function trash_dim_Callback(hObject, eventdata, handles)
% hObject    handle to trash_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trash_dim as text
%        str2double(get(hObject,'String')) returns contents of trash_dim as a double


% --- Executes during object creation, after setting all properties.
function trash_dim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trash_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MSVST_flag.
function MSVST_flag_Callback(hObject, eventdata, handles)
% hObject    handle to MSVST_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MSVST_flag



function wavelet_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wavelet_threshold as text
%        str2double(get(hObject,'String')) returns contents of wavelet_threshold as a double


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


% --- Executes on selection change in wavelet_coefficient.
function wavelet_coefficient_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_coefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns wavelet_coefficient contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wavelet_coefficient


% --- Executes during object creation, after setting all properties.
function wavelet_coefficient_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavelet_coefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSVST_mu_Callback(hObject, eventdata, handles)
% hObject    handle to MSVST_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MSVST_mu as text
%        str2double(get(hObject,'String')) returns contents of MSVST_mu as a double


% --- Executes during object creation, after setting all properties.
function MSVST_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MSVST_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSVST_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to MSVST_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MSVST_sigma as text
%        str2double(get(hObject,'String')) returns contents of MSVST_sigma as a double


% --- Executes during object creation, after setting all properties.
function MSVST_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MSVST_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSVST_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to MSVST_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MSVST_alpha as text
%        str2double(get(hObject,'String')) returns contents of MSVST_alpha as a double


% --- Executes during object creation, after setting all properties.
function MSVST_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MSVST_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function neighborhood_Callback(hObject, eventdata, handles)
% hObject    handle to neighborhood (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of neighborhood as text
%        str2double(get(hObject,'String')) returns contents of neighborhood as a double


% --- Executes during object creation, after setting all properties.
function neighborhood_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neighborhood (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gap_Callback(hObject, eventdata, handles)
% hObject    handle to gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gap as text
%        str2double(get(hObject,'String')) returns contents of gap as a double


% --- Executes during object creation, after setting all properties.
function gap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function molNum_Callback(hObject, eventdata, handles)
% hObject    handle to molNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of molNum as text
%        str2double(get(hObject,'String')) returns contents of molNum as a double


% --- Executes during object creation, after setting all properties.
function molNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to molNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gain_Callback(hObject, eventdata, handles)
% hObject    handle to gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gain as text
%        str2double(get(hObject,'String')) returns contents of gain as a double


% --- Executes during object creation, after setting all properties.
function gain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minFWHM_Callback(hObject, eventdata, handles)
% hObject    handle to minFWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minFWHM as text
%        str2double(get(hObject,'String')) returns contents of minFWHM as a double


% --- Executes during object creation, after setting all properties.
function minFWHM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minFWHM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aveFrame_Callback(hObject, eventdata, handles)
% hObject    handle to aveFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aveFrame as text
%        str2double(get(hObject,'String')) returns contents of aveFrame as a double


% --- Executes during object creation, after setting all properties.
function aveFrame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aveFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_Callback(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp as text
%        str2double(get(hObject,'String')) returns contents of amp as a double


% --- Executes during object creation, after setting all properties.
function amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxError_Callback(hObject, eventdata, handles)
% hObject    handle to maxError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxError as text
%        str2double(get(hObject,'String')) returns contents of maxError as a double


% --- Executes during object creation, after setting all properties.
function maxError_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minPhoton_Callback(hObject, eventdata, handles)
% hObject    handle to minPhoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minPhoton as text
%        str2double(get(hObject,'String')) returns contents of minPhoton as a double


% --- Executes during object creation, after setting all properties.
function minPhoton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minPhoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxPhoton_Callback(hObject, eventdata, handles)
% hObject    handle to maxPhoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxPhoton as text
%        str2double(get(hObject,'String')) returns contents of maxPhoton as a double


% --- Executes during object creation, after setting all properties.
function maxPhoton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxPhoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Apply_changes.
function Apply_changes_Callback(hObject, eventdata, handles)
% hObject    handle to Apply_changes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.parameter.detection.wavelet_threshold=str2double(get(handles.wavelet_threshold,'string'));
handles.parameter.detection.wavelet_coefficient=get(handles.wavelet_coefficient,'value');
handles.parameter.detection.MSVST_flag=get(handles.MSVST_flag,'value');
handles.parameter.detection.MSVST_mu=str2double(get(handles.MSVST_mu,'string'));
handles.parameter.detection.MSVST_sigma=str2double(get(handles.MSVST_sigma,'string'));
handles.parameter.detection.MSVST_alpha=str2double(get(handles.MSVST_alpha,'string'));
handles.parameter.detection.trash_dim=str2double(get(handles.trash_dim,'string'));
handles.parameter.detection.boundary_threshold=str2double(get(handles.boundary_threshold,'string'));
if get(handles.Cell_area,'value')
handles.parameter.detection.Cell_area=1;    
%     elseif get(handles.ROI,'value')
%     handles.parameter.detection.Cell_area=[]; 
%     handles.parameter.detection.ROI=1;
elseif get(handles.No_ROI,'value')
    handles.parameter.detection.Cell_area=[];
    handles.parameter.detection.ROI=[];
end
if get(handles.radiobutton3,'value')
    handles.parameter.detection.localmaxima=1;
    handles.parameter.detection.width=str2double(get(handles.edit25,'string'));
else
    handles.parameter.detection.localmaxima=0;
    handles.parameter.detection.width=str2double(get(handles.edit26,'string'));
end
handles.parameter.linking.neighborhood=str2double(get(handles.neighborhood,'string'));
handles.parameter.linking.gap=str2double(get(handles.gap,'string'));
handles.parameter.tracking.gap=str2double(get(handles.gap_track,'string'));
handles.parameter.tracking.minSR=str2double(get(handles.minSR,'string'));
handles.parameter.tracking.maxSR=str2double(get(handles.maxSR,'string'));
handles.parameter.fitting.gain=str2double(get(handles.gain,'string'));
handles.parameter.fitting.factor=str2double(get(handles.factor,'string'));
handles.parameter.fitting.sigma=str2double(get(handles.sigma,'string'));
handles.parameter.fitting.pixelsize=str2double(get(handles.pixelsize,'string'));
handles.parameter.fitting.fitsize=str2double(get(handles.fitsize,'string')); 
handles.parameter.fitting.flag=str2double(get(handles.fit_flag,'string'));
handles.parameter.fitting.photonflag=str2double(get(handles.photonflag,'string'));
handles.parameter.reconstruction.amp=str2double(get(handles.amp,'string'));
handles.parameter.reconstruction.maxError=str2double(get(handles.maxError,'string'));
handles.parameter.reconstruction.minPhoton=str2double(get(handles.minPhoton,'string'));
handles.parameter.reconstruction.maxPhoton=str2double(get(handles.maxPhoton,'string'));
handles.parameter.reconstruction.maxBg=str2double(get(handles.maxBg,'string'));
handles.parameter.reconstruction.meanBg=str2double(get(handles.meanBg,'string'));
handles.parameter.reconstruction.minSigma=str2double(get(handles.minSigma,'string'));
handles.parameter.reconstruction.maxSigma=str2double(get(handles.maxSigma,'string'));
handles.parameter.reconstruction.meanSigma=str2double(get(handles.meanSigma,'string'));
handles.parameter.prompt_flag=get(handles.prompt_flag,'value');
handles.parameter.driftCorrection=get(handles.drift,'value');
handles.parameter.display=get(handles.display,'value');
guidata(hObject, handles);
uiresume;
    
    
function boundary_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to boundary_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boundary_threshold as text
%        str2double(get(hObject,'String')) returns contents of boundary_threshold as a double


% --- Executes during object creation, after setting all properties.
function boundary_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boundary_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save_default.
function Save_default_Callback(hObject, eventdata, handles)
% hObject    handle to Save_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Apply_changes_Callback(hObject, eventdata, handles)
handles=guidata(hObject);
parameter=handles.parameter;
cd main
save('Parameters_default.mat','parameter');
cd ../

% --- Executes on button press in Load_default.
function Load_default_Callback(hObject, eventdata, handles)
% hObject    handle to Load_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parameter=importdata('Parameters_default.mat');
handles.parameter=parameter;
SetParameters(handles);
guidata(hObject, handles);

function SetParameters(handles)
set(handles.wavelet_threshold,'string',num2str(handles.parameter.detection.wavelet_threshold));
set(handles.wavelet_coefficient,'value',handles.parameter.detection.wavelet_coefficient);
set(handles.MSVST_flag,'value',handles.parameter.detection.MSVST_flag);
set(handles.MSVST_mu,'string',num2str(handles.parameter.detection.MSVST_mu));
set(handles.MSVST_sigma,'string',num2str(handles.parameter.detection.MSVST_sigma));
set(handles.MSVST_alpha,'string',num2str(handles.parameter.detection.MSVST_alpha));
set(handles.trash_dim,'string',num2str(handles.parameter.detection.trash_dim));
set(handles.boundary_threshold,'string',num2str(handles.parameter.detection.boundary_threshold))
if ~isempty(handles.parameter.detection.Cell_area)
    set(handles.Cell_area,'value',1);        
elseif ~isempty(handles.parameter.detection.ROI)
    set(handles.ROI,'value',1);
else
    set(handles.No_ROI,'value',1);
end
if handles.parameter.detection.localmaxima==1
    set(handles.radiobutton3,'value',1);
    set(handles.radiobutton4,'value',0);
    set(handles.edit25,'enable','on');
    set(handles.edit26,'enable','off');
    set(handles.edit25,'string',num2str(handles.parameter.detection.width));
else
    set(handles.radiobutton4,'value',1);
    set(handles.radiobutton3,'value',0);
    set(handles.edit26,'enable','on');
    set(handles.edit25,'enable','off');
    set(handles.edit26,'string',num2str(handles.parameter.detection.width));    
end
set(handles.neighborhood,'string',num2str(handles.parameter.linking.neighborhood))
set(handles.gap,'string',num2str(handles.parameter.linking.gap));
set(handles.gap_track,'string',num2str(handles.parameter.tracking.gap))
set(handles.minSR,'string',num2str(handles.parameter.tracking.minSR));
set(handles.maxSR,'string',num2str(handles.parameter.tracking.maxSR));
set(handles.gain,'string',num2str(handles.parameter.fitting.gain));
set(handles.factor,'string',num2str(handles.parameter.fitting.factor));
set(handles.sigma,'string',num2str(handles.parameter.fitting.sigma));
set(handles.pixelsize,'string',num2str(handles.parameter.fitting.pixelsize));
set(handles.fitsize,'string',num2str(handles.parameter.fitting.fitsize));
set(handles.fit_flag,'string',num2str(handles.parameter.fitting.flag));
set(handles.photonflag,'string',num2str(handles.parameter.fitting.photonflag));
set(handles.amp,'string',num2str(handles.parameter.reconstruction.amp));
set(handles.maxError,'string',num2str(handles.parameter.reconstruction.maxError));
set(handles.minPhoton,'string',num2str(handles.parameter.reconstruction.minPhoton));
set(handles.maxPhoton,'string',num2str(handles.parameter.reconstruction.maxPhoton));    
set(handles.maxBg,'string',num2str(handles.parameter.reconstruction.maxBg))
set(handles.meanBg,'string',num2str(handles.parameter.reconstruction.meanBg));
set(handles.minSigma,'string',num2str(handles.parameter.reconstruction.minSigma));    
set(handles.maxSigma,'string',num2str(handles.parameter.reconstruction.maxSigma))
set(handles.meanSigma,'string',num2str(handles.parameter.reconstruction.meanSigma));
set(handles.prompt_flag,'value',handles.parameter.prompt_flag);
set(handles.display,'value',handles.parameter.display);
set(handles.drift,'value',handles.parameter.driftCorrection);

% --- Executes on button press in prompt_flag.
function prompt_flag_Callback(hObject, eventdata, handles)
% hObject    handle to prompt_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prompt_flag


% --- Executes on button press in Undo_change.
function Undo_change_Callback(hObject, eventdata, handles)
% hObject    handle to Undo_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% SetParameters(handles);
uiresume;



function factor_Callback(hObject, eventdata, handles)
% hObject    handle to factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of factor as text
%        str2double(get(hObject,'String')) returns contents of factor as a double


% --- Executes during object creation, after setting all properties.
function factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma as text
%        str2double(get(hObject,'String')) returns contents of sigma as a double


% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pixelsize_Callback(hObject, eventdata, handles)
% hObject    handle to maxphoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxphoton as text
%        str2double(get(hObject,'String')) returns contents of maxphoton as a double


% --- Executes during object creation, after setting all properties.
function pixelsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxphoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fitsize_Callback(hObject, eventdata, handles)
% hObject    handle to fitsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fitsize as text
%        str2double(get(hObject,'String')) returns contents of fitsize as a double


% --- Executes during object creation, after setting all properties.
function fitsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fitsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxBg_Callback(hObject, eventdata, handles)
% hObject    handle to maxBg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxBg as text
%        str2double(get(hObject,'String')) returns contents of maxBg as a double


% --- Executes during object creation, after setting all properties.
function maxBg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxBg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minSigma_Callback(hObject, eventdata, handles)
% hObject    handle to minSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minSigma as text
%        str2double(get(hObject,'String')) returns contents of minSigma as a double


% --- Executes during object creation, after setting all properties.
function minSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxSigma_Callback(hObject, eventdata, handles)
% hObject    handle to maxSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxSigma as text
%        str2double(get(hObject,'String')) returns contents of maxSigma as a double


% --- Executes during object creation, after setting all properties.
function maxSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function meanSigma_Callback(hObject, eventdata, handles)
% hObject    handle to meanSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meanSigma as text
%        str2double(get(hObject,'String')) returns contents of meanSigma as a double


% --- Executes during object creation, after setting all properties.
function meanSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meanSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in display.
function display_Callback(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of display


% --- Executes on button press in drift.
function drift_Callback(hObject, eventdata, handles)
% hObject    handle to drift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drift


% --- Executes on button press in fitting_flag.
function fitting_flag_Callback(hObject, eventdata, handles)
% hObject    handle to fitting_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fitting_flag


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(hObject,'value',1);
set(handles.edit25,'enable','on');
set(handles.edit26,'enable','off');
set(handles.radiobutton4,'value',0)

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(hObject,'value',1);
set(handles.edit25,'enable','off');
set(handles.edit26,'enable','on');
set(handles.radiobutton3,'value',0)


function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fit_flag_Callback(hObject, eventdata, handles)
% hObject    handle to fit_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fit_flag as text
%        str2double(get(hObject,'String')) returns contents of fit_flag as a double


% --- Executes during object creation, after setting all properties.
function fit_flag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fit_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function meanBg_Callback(hObject, eventdata, handles)
% hObject    handle to meanBg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meanBg as text
%        str2double(get(hObject,'String')) returns contents of meanBg as a double


% --- Executes during object creation, after setting all properties.
function meanBg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meanBg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function photonflag_Callback(hObject, eventdata, handles)
% hObject    handle to photonflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of photonflag as text
%        str2double(get(hObject,'String')) returns contents of photonflag as a double


% --- Executes during object creation, after setting all properties.
function photonflag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to photonflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gap_track_Callback(hObject, eventdata, handles)
% hObject    handle to gap_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gap_track as text
%        str2double(get(hObject,'String')) returns contents of gap_track as a double


% --- Executes during object creation, after setting all properties.
function gap_track_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gap_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minSR_Callback(hObject, eventdata, handles)
% hObject    handle to minSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minSR as text
%        str2double(get(hObject,'String')) returns contents of minSR as a double


% --- Executes during object creation, after setting all properties.
function minSR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxSR_Callback(hObject, eventdata, handles)
% hObject    handle to maxSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxSR as text
%        str2double(get(hObject,'String')) returns contents of maxSR as a double


% --- Executes during object creation, after setting all properties.
function maxSR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
