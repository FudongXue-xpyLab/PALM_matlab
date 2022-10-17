function Batch_process_files(handles)
N=length(handles.filestr);
for f=1:N
    handles.parameter.PALM.fitting_flag=0;
    handles.parameter.batch=1;
    handles.filename=handles.filestr{f};
    t=strfind(handles.filename,'.tif');
    if ~isempty(t)
        handles.filebase=handles.filename(1:t-1);
    end
    str=['Processing ',handles.filename];
    set(handles.text2,'string',str)
    if get(handles.checkbox1,'value')
        str=strcat(handles.pathname,handles.filename);
        [handles.A,handles.ImageNumber]=tiffread(str);
        handles.V=[];
        [row, column]=size(handles.A(:,:,1));
        handles.row=row;
        handles.column=column;
        handles.data_w=[];
        handles.data_wavelet=uint16(zeros(row,column,1));        
        %******************************************************************
        if handles.parameter.detection.MSVST_flag
            A=single(handles.A(:,:,1));
            [out,M]=Gauss2D(A,1);
            ImgMax=locmax2d(out,[5 5]);
            [y x]=find(ImgMax>0);
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
        end
        %******************************************************************
        if handles.parameter.detection.Cell_area==1
            [W2 W3 A3]=waveletTransform(handles.A(:,:,1),1,3);
            threshold=handles.parameter.detection.boundary_threshold*mean2(A3);
            level=threshold/65535;   
        %     BW_area=im2bw(uint16(A3),level); 
        %     BW_area=bwareaopen(BW_area,1000);
            BW_area=AreaDetect(uint16(A3),level);   
            B=bwboundaries(BW_area,'noholes');
            handles.boundary=B{1};
            handles.parameter.detection.Cell_area=BW_area;
        else
            handles.boundary=[];
            BW_area=ones(row,column);
            handles.parameter.detection.Cell_area=BW_area;
        end
        set(handles.text10,'string','Detection ...')
        mywaitbar(0,handles.axes2,'');
        for i=1:handles.ImageNumber  
            data_w=Detection(handles.A(:,:,i),handles.parameter);
            handles.data_wavelet(:,:,1)=uint16(data_w);    
            handles.V{i}=FindPots(handles,data_w);
            if handles.parameter.detection.trash_dim>0
                IX=handles.V{i}(:,3)>handles.parameter.detection.trash_dim;
                handles.V{i}=handles.V{i}(IX,:);
            end
            mywaitbar(i/handles.ImageNumber,handles.axes2,[num2str(floor(i/handles.ImageNumber*100)),'%']);
        end
        set(handles.text10,'string','Detection finished!')
        if ~get(handles.checkbox2,'value')
            P.V=handles.V;
            P.ImageNumber=handles.ImageNumber;
            P.A=handles.A;
            P.row=handles.row;
            P.column=handles.column;
            P.parameter.detection.Cell_area=handles.parameter.detection.Cell_area;
            P.boundary=handles.boundary;
            fstr=strcat(handles.pathname,handles.filebase,'_Detection.mat');
            save(fstr,'P');
        end
    end
    %**************************************************************************
    if get(handles.checkbox2,'value')
        if ~get(handles.checkbox1,'value')
            fstr=strcat(handles.pathname,handles.filebase,'_Detection.mat');
            if ~exist(fstr,'file')
                set(handles.text10,'string','Process finished!');
                continue
            end
            P=importdata(fstr);
            handles.V=P.V;
            handles.ImageNumber=P.ImageNumber;
            handles.A=P.A;
            handles.parameter.detection.Cell_area=P.parameter.detection.Cell_area;
            handles.boundary=P.boundary;
            handles.row=P.row;
            handles.column=P.column;
        end
        set(handles.text10,'string','Linking ...')
        handles.data_wavelet=[];
        
        handles.parameter.prompt_flag=0;
        handles=PALM_linking_new(handles);
        
        P.V=handles.V;
        P.ImageNumber=handles.ImageNumber;
        P.A=handles.A;
        P.DV=handles.DV;
        P.row=handles.row;
        P.column=handles.column;
        P.parameter.detection.Cell_area=handles.parameter.detection.Cell_area;
        set(handles.text10,'string','Linking Finished!')
        fstr=strcat(handles.pathname,handles.filebase,'_Tracking.mat');
        save(fstr,'P');
    end
    %**************************************************************************
    if get(handles.checkbox3,'value')
        if ~get(handles.checkbox2,'value')
            set(handles.text10,'string','Loading linking result ...')
            fstr=strcat(handles.pathname,handles.filebase,'_Tracking.mat');
            if ~exist(fstr,'file')
                set(handles.text10,'string','Process finished!');
                continue
            end
            P=importdata(fstr);
            handles.V=P.V;
            handles.ImageNumber=P.ImageNumber;
            handles.A=P.A;
            handles.DV=P.DV;                
            handles.row=P.row;
            handles.column=P.column;
            handles.parameter.detection.Cell_area=P.parameter.detection.Cell_area;
        else        
            handles.row=row;
            handles.column=column;
        end
        set(handles.text10,'string','Fitting ...')
        if handles.parameter.fitting.flag==1
            handles=PALM_fitting_GPU(handles);
        elseif handles.parameter.fitting.flag==2
            handles=PALM_fitting_CPU(handles);
        else   
            handles=PALM_fitting_ANN(handles);
        end
        handles.parameter.PALM.fitting_flag=1;
        set(handles.text10,'string','Fitting finished!')
        if handles.parameter.fitting.flag==3
            fstr=strcat(handles.pathname,handles.filebase,'_Fitting_ANN.mat');
        else
            fstr=strcat(handles.pathname,handles.filebase,'_Fitting.mat');
        end
        P.parameter = handles.parameter;
        P.pathname=handles.pathname;
        P.filestr=handles.filestr;
        P.filename=handles.filename;
        P.filebase=handles.filebase;
        P.ImageNumber=handles.ImageNumber;
        P.row=handles.row;
        P.column=handles.column;
        P.fitInfo_old=handles.fitInfo_old;
        P.ROI=handles.ROI;
        P.trackInfo=handles.trackInfo;
        P.fitInfo=handles.fitInfo;
        save(fstr,'P','-v7.3');
        %******************************************************************
    end
    %**************************************************************************
    if get(handles.checkbox4,'value')
        set(handles.text10,'string','Reconstruction ...')
        if ~get(handles.checkbox3,'value')
            set(handles.text10,'string','Loading fitting result ...')
            if handles.parameter.fitting.flag==3
                fstr=strcat(handles.pathname,handles.filebase,'_Fitting_ANN.mat');
            else
                fstr=strcat(handles.pathname,handles.filebase,'_Fitting.mat');
            end
            if ~exist(fstr,'file')
                set(handles.text10,'string','Process finished!');
                continue
            end
            P=importdata(fstr);
            handles.parameter = P.parameter;
            handles.pathname=P.pathname;
            handles.filestr=P.filestr;
            handles.filename=P.filename;
            handles.filebase=P.filebase;
            handles.ImageNumber=P.ImageNumber;
            handles.row=P.row;
            handles.column=P.column;
            handles.fitInfo_old=P.fitInfo_old;
            handles.ROI=P.ROI;
            handles.trackInfo=P.trackInfo;
            handles.fitInfo=P.fitInfo;
        end        
        PALM_reconstruction(handles);
        set(handles.text10,'string','Reconstruction finished!')
    end
end
