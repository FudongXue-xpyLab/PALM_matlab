%% photonN, total photons
clear file_name path_name file
[file_name, path_name] = uigetfile( ...
    {'*.mat;', 'total photons MAT-Files'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Mat File','MultiSelect','on');
if ~iscell(file_name)
    file_name = {file_name};
end
Num = length(file_name);
if isequal([file_name,path_name],[0,0])
    return                          %if have no file return
elseif Num == 1
    file_name = file_name{1};
    file = fullfile(path_name,file_name);
    load(file);
    figure;
    hist(photonN,100);title('total photons');
else
    tem = [];
    for i=1:Num
        file = strcat(path_name,'\',file_name{i});
        load(file);
        tem = [tem; photonN];
    end
    photonN = tem;
    figure;
    hist(photonN,100);title('total photons');
end

%% position error
clear file_name path_name file tem
[file_name, path_name] = uigetfile( ...
    {'*.mat;', 'position error MAT-Files'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Mat File','MultiSelect','on');
if ~iscell(file_name)
    file_name = {file_name};
end
Num = length(file_name);
if isequal([file_name,path_name],[0,0])
    return                          %if have no file return
elseif Num == 1
    file_name = file_name{1};
    file = fullfile(path_name,file_name);
    load(file);
    figure;
    hist(deltaR,100);title('position error');
else
    tem = [];
    for i=1:Num
        file = strcat(path_name,'\',file_name{i});
        load(file);
        tem = [tem; deltaR];
    end
    deltaR = tem;
    figure;
    hist(deltaR,100);title('position error');
end

% subplot(2,2,1);hist(photonN,100);title('total photons');
% subplot(2,2,2);hist(deltaR,100);title('position error');
% subplot(2,2,3);hist(sx,20);title('standard deviation');
% subplot(2,2,4);hist(backN,100);title('background photons');