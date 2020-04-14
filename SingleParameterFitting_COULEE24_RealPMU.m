% Jacob Eisenbarth, July 2019
% This script will be used to run multiple different PowerWorld cases within
% Matlab. First, the script writes a  .dyd file from Matlab using a
% series of functions. NEED to finish Description.....

%% Initialize Matlab
clc,clear all, format longG,format compact
% close all
tic

%% Establish a connection with PowerWorld / SimAuto
disp('>> Connecting to PowerWorld Simulator / SimAuto...')
SimAuto = actxserver('pwrworld.SimulatorAuto');
disp('Connection established')

%% Data to be Entered into dyd File
%Model gentpj
gentpj(1)=7.6; %Tpdo
gentpj(2)=0.08; %Tppdo
gentpj(3)=0; %Tpqo
gentpj(4)=0.04; %Tppqo
% gentpj(5)=4.9722; %H
gentpj(5)=4.78185274744723; %H average 4 param fit combined CJBP



gentpj(6)=0; %D
gentpj(7)=1.02; %Ld
gentpj(8)=0.7; %Lq           %Avoid fitting because when Tpqo=0 Lq must = Lpq
gentpj(9)=0.32; %Lpd
gentpj(10)=0.7; %Lpq           %Avoid fitting because when Tpqo=0 Lq must = Lpq
gentpj(11)=0.25; %Lppd
gentpj(12)=0.25; %Lppq
gentpj(13)=0.15; %Ll
gentpj(14)=0.08; %S1
gentpj(15)=0.24; %S12
gentpj(16)=0.0028; %Ra
gentpj(17)=0; %Rcomp
gentpj(18)=0.08; %Xcomp
gentpj(19)=0; %accel
gentpj(20)=0.08; %Kis


index_gentpj=[1,2,4,5,7,9,11:16,18,20];     %Index for numerical parameters to edit

%Model esst5b
esst5b(1)=0; %Tr
esst5b(2)=200; %Kr
esst5b(3)=0.004; %T1
esst5b(4)=0.004; %Kc
esst5b(5)=9.5; %Vrmax
esst5b(6)=-8.6; %Vrmin
esst5b(7)=1.2; %Tc1
esst5b(8)=2.667; %Tb1
esst5b(9)=0.01; %Tc2
esst5b(10)=0.017; %Tb2
esst5b(11)=1.52; %Toc1
esst5b(12)=3.378; %Tob1
esst5b(13)=0.1; %Toc2
esst5b(14)=0.15; %Tob2
esst5b(15)=1.5; %Tuc1
esst5b(16)=3.33; %Tub1
esst5b(17)=0.1; %Tuc2
esst5b(18)=0.15; %Tub2


index_esst5b=[2:18];     %Index for numerical parameters to edit

%Model oel1
oel1(1)=1.89; %Ifdset
oel1(2)=2.87; %Ifdmax
oel1(3)=10; %Tpickup
oel1(4)=0; %Runback
oel1(5)=999; %Tmax
oel1(6)=999; %Tset
oel1(7)=1.8; %Ifcont
oel1(8)=0; %Vfdflag
oel1(9)=0; %Alarm

index_oel1=[1:3,5:7];       %Index for numerical parameters to edit

%Model pss2b
pss2b(1)=1; %J1
pss2b(2)=0; %K1
pss2b(3)=3; %J2
pss2b(4)=0; %K2
pss2b(5)=999; %Vsi1max
pss2b(6)=-999; %Vsi1min
pss2b(7)=10; %Tw1
pss2b(8)=10; %Tw2
pss2b(9)=999; %Vsi2max
pss2b(10)=-999; %Vsi2min
pss2b(11)=10; %Tw3
pss2b(12)=0; %Tw4
pss2b(13)=0.017; %T6
pss2b(14)=10; %T7
pss2b(15)=1.006; %Ks2
pss2b(16)=1; %Ks3
pss2b(17)=0.3; %T8
pss2b(18)=0.15; %T9
pss2b(19)=4; %N
pss2b(20)=2; %m
% pss2b(21)=10; %Ks1
pss2b(21)=8.90630828903003; %Ks1 average 4 param fit combined CJBP

% pss2b(22)=0.5; %T1
pss2b(22)=0.413995000588163; %T1 average 4 param fit combined CJBP

pss2b(23)=0.05; %T2
pss2b(24)=0.04; %T3
pss2b(25)=0.017; %T4
pss2b(26)=0.06; %T10
pss2b(27)=0.017; %T11
pss2b(28)=0.1; %Vstmax
pss2b(29)=-0.1; %Vstmin
% pss2b(28)=0; %Vstmax
% pss2b(29)=0; %Vstmin

pss2b(30)=1; %a
pss2b(31)=0; %Ta
pss2b(32)=0; %Tb
pss2b(33)=1; %Ks4


index_pss2b=[5:11,13:30,33];     %Index for numerical parameters to edit

%Model hygovr
hygovr(1)=1; %Pmax
hygovr(2)=0; %Pmin
hygovr(3)=0.05; %R
hygovr(4)=0.05; %Td
hygovr(5)=0.017; %T1
hygovr(6)=0.1; %T2
hygovr(7)=0.1; %T3
hygovr(8)=0.1; %T4
hygovr(9)=0.1; %T5
hygovr(10)=0.1; %T6
hygovr(11)=0.1; %T7
hygovr(12)=0.1; %T8
hygovr(13)=0.1; %Tp
hygovr(14)=0.0714; %Velop
hygovr(15)=-0.0552; %Velcl
hygovr(16)=0.5; %Ki
hygovr(17)=4; %Kg
hygovr(18)=1.05; %gmax
hygovr(19)=-0.05; %gmin
hygovr(20)=0; %Tt
hygovr(21)=0; %db1
hygovr(22)=0; %eps
hygovr(23)=0; %db2
hygovr(24)=2; %Tw
hygovr(25)=1; %At
hygovr(26)=1; %Dturb
hygovr(27)=0; %qnl
hygovr(28)=1; %H0
hygovr(29)=0.16; %Gv1
hygovr(30)=0; %Pgv1
hygovr(31)=0.61; %Gv2
hygovr(32)=0.64; %Pgv2
hygovr(33)=0.7; %Gv3
hygovr(34)=0.75; %Pgv3
hygovr(35)=0.85; %Gv4
hygovr(36)=0.91; %Pgv4
hygovr(37)=0.98; %Gv5
hygovr(38)=0.99; %Pgv5
hygovr(39)=1; %Gv6
hygovr(40)=1; %Pgv6

index_hygovr=[1,3:19,24:26,28,29,31:40];  %Index for numerical parameters to edit

%Model XFMR
XFMR(1)= 0.000000; %XFMR R
XFMR(2)= 0.020890; %XFMR X
XFMR(2)= 0.0297318251450101; %XFMR average 4 param fit combined CJBP




index_XFMR=[2];     %Index for numerical parameters to edit

%Model Line
Line(1)= 0.000010; %Line R
Line(2)= 0.00023; %Line X
Line(3)= 0.02096; %Line B

index_Line=[1:3];     %Index for numerical parameters to edit


gentpj_original=gentpj;
esst5b_original=esst5b;
oel1_original=oel1;
pss2b_original=pss2b;
hygovr_original=hygovr;
XFMR_original=XFMR;
Line_original=Line;


index=struct('gentpj',index_gentpj,'esst5b',index_esst5b,'oel1',index_oel1,'pss2b',index_pss2b,'hygovr',index_hygovr,'XFMR',index_XFMR,'Line',index_Line);

clear index_gentpj index_esst5b index_oel1 index_pss2b index_hygovr index_XFMR index_Line

%% Parameter List to be Ran in Single Parameter Fitting
list2016=[...
    "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_9235_95to9265_95.mat";...
    "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_9711_4to9741_4.mat";...
    "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19795_45to19825_45.mat";...
    "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_20397_2to20427_2.mat";...
    
    %ZM Best Fit
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_9231_9to9261_9.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_9711_85to9741_85.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19798_5to19828_5.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_20398_75to20428_75.mat"
    ];

list2017=[...
    "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_5092_35to5122_35.mat";...
    "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_5708_1to5738_1.mat";...
    "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_8698_6to8728_6.mat";...
    "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_9299to9329.mat";...
    
    %ZM Best Fit
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_5093_1to5123_1.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_5708_9to5738_9.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_8691_95to8721_95.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2017Event_9299_3to9329_3.mat"
    ];
list2018=[...
    "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_5097_15to5127_15.mat"
    "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_5511_4to5541_4.mat"
    "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_8701_05to8731_05.mat"
    "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_8878_2to8908_2.mat"
    
    %ZM Best Fit
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_5098_8to5128_8.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_5511_7to5541_7.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_8702_6to8732_6.mat"
    %     "COULEE24 Real Data Combined Revisit\COULEE24_2018Event_8875_6to8905_6.mat"
    ];

% numbers=[...
% %     [9241-10:.05:9241]',[9271-10:.05:9271]';...
% %         [9721-10:.05:9721]',[9751-10:.05:9751]';...
%         [19800-10:.05:19800]',[19830-10:.05:19830]';...
% %         [20400-10:.05:20400]',[20430-10:.05:20430]';...
% ];
%
%
% for y=1:size(numbers,1)
%     t1name=num2str(round(min(numbers(y,:)),3));
%     t2name=num2str(round(max(numbers(y,:)),3));
%
%     t1name(find(t1name=='.'))='_';
%     t2name(find(t2name=='.'))='_';
%     list2016(y,:)=['COULEE24 Real Data Combined Revisit\COULEE24_2016Event_',t1name,'to',t2name,'.mat'];
% end

% list2016=[...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19791_95to19821_95.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19799_55to19829_55.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19793_4to19823_4.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19795_45to19825_45.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19798_05to19828_05.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19791_9to19821_9.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19795_25to19825_25.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19791_75to19821_75.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19799_8to19829_8.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19796_5to19826_5.mat";...
%     "COULEE24 Real Data Combined Revisit\COULEE24_2016Event_19796to19826.mat";...
%     ];
% numbers=[[5101-10:.05:5101]',[5131-10:.05:5131]';...
%         [5710-10:.05:5710]',[5740-10:.05:5740]';...
%         [8701-10:.05:8701]',[8731-10:.05:8731]';...
%         [9306-10:.05:9306]',[9336-10:.05:9336]';]
% for y=1:size(numbers,1)
%     t1name=num2str(round(min(numbers(y,:)),3));
%     t2name=num2str(round(max(numbers(y,:)),3));
%
%     t1name(find(t1name=='.'))='_';
%     t2name(find(t2name=='.'))='_';
%     list2017(y,:)=['COULEE24 Real Data Combined Revisit\COULEE24_2017Event_',t1name,'to',t2name,'.mat'];
% end
%
% numbers=[[5101-10:.05:5101]',[5131-10:.05:5131]';...
%     [5521-10:.05:5521]',[5551-10:.05:5551]';...
%     [8704-10:.05:8704]',[8734-10:.05:8734]';...
%     [8885-10:.05:8885]',[8915-10:.05:8915]';]
% for y=1:size(numbers,1)
%     t1name=num2str(round(min(numbers(y,:)),3));
%     t2name=num2str(round(max(numbers(y,:)),3));
%
%     t1name(find(t1name=='.'))='_';
%     t2name(find(t2name=='.'))='_';
%     list2018(y,:)=['COULEE24 Real Data Combined Revisit\COULEE24_2018Event_',t1name,'to',t2name,'.mat'];
% end

% H_XFMRX_startvalue=[4.55332052708436	8.10130409943049	0.440900485520102	0.0262387288700234
%     4.92550881375282	7.22944762342336	0.472209594154978	0.0217957029089176
%     5.05057160001831	8.23177195769595	0.390682057014872	0.0195046665728217
%     4.36788474409428	9.17235892186780	0.455632190853258	0.0350241347020978
%     4.65935920370102	9.28735142362998	0.421866196471711	0.0358755106632624
%     5.10304436585218	8.37767098081577	0.409307922505960	0.0237232658617034
%     5.11301028388366	8.74943046866152	0.392006402327963	0.0222044722240136
%     4.59551739690986	9.43022796902482	0.432495037016950	0.0412187657254302
%     4.87221123075772	9.31241619567552	0.380769766160648	0.0288816116192252
%     4.61585112749633	9.87173414741554	0.381447554406342	0.0376220342799667
%     4.77791998497628	10.1640464870212	0.368375592023308	0.0325875374333200
%     4.74803369083996	8.94793919369841	0.422247208601860	0.0321054708793394];

% list_noisemult=[.0043] %2017 data
% list_noisemult=[.0014] %2018 data
list_noisemult=[0] %2018 data

% list_noisemult=[.0121]
% list_noisemult=[.0089]
% list_noisemult=[.0042]

for m=1:1
    %     if m==1
    %         list=list2016;
    %     elseif m==2
    %         list=list2017;
    %     elseif m==3
    %         list=list2018;
    %     end
    
    list=[list2016;list2017;list2018;];
    %     list=list(3,:);
    % list=list2016;
    
%         for k=1:length(list_noisemult)
    %     clear final_theta output resnorm
%         for k=1:length(list)
    
    %         gentpj(5)=H_XFMRX_startvalue(k,1);
    %         pss2b(21)=H_XFMRX_startvalue(k,2);
    %         pss2b(22)=H_XFMRX_startvalue(k,3);
    %         XFMR(2)=H_XFMRX_startvalue(k,4);
    
%     gentpj(5)=H_XFMRX_startvalue(7,1);
%     pss2b(21)=H_XFMRX_startvalue(7,2);
%     pss2b(22)=H_XFMRX_startvalue(7,3);
%     XFMR(2)=H_XFMRX_startvalue(7,4);
%     
%     gentpj_original=gentpj;
%     %         esst5b_original=esst5b;
%     %         oel1_original=oel1;
%     pss2b_original=pss2b;
%     %         hygovr_original=hygovr;
%     XFMR_original=XFMR;
%     %         Line_original=Line;
%     
    
%     for k=1:size(list,1)
%             paramlist=[1:100];
%     paramlist=[4,53,54,79,89,97];
%     paramlist=[4,46,54,47,62,53,48,63,7,97,6,21,1,15,20,58,90,50,89,92,55,49,56,2,40,41,14,9,3,13,85];
paramlist=[4,46,54,47,62,53,48,63,7,97,6 ];
%paramlist(1:20)=[];
%         paramlist=[4];
    
    for k=1:length(paramlist)
        %         paramlist=[4,53,54,97];
        %         paramlist=[4,97];
        %         paramlist=[1:100];
        %         noisemultstr=num2str(list_noisemult(k));
        
        %         noisemultstr=noisemultstr(find(noisemultstr=='.')+1:end);
        %     if m==1
        %         paramlist=[54,56];
        %         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real PMU Data from 2018\2018 Fittings\Test of Single and Multiparameter Fits\COULEE24_2018_TwoParameterT1_T3_Event12_VNoiseMult_',noisemultstr,'PQoffset_01_NoiseAfter10sec.mat'];
        %     end
        
        
        %         paramlist=[4,53,54,97];
        %     paramlist=[4,103,105];
        %     paramlist=[4,97];
        %         paramlist=[4,48,53,54,63,92,97];
        
        %                 paramlist=[4,5,53,54,82,97];
        %     paramlist=[3,7,10,11,33]+39;
        %                 paramlist=[1:100];
        
        
        %         for k=1:length(paramlist)
        % for k=1:length(noisemultiplierlist)
        %File Names to Be Used In Script
        filename_SetupAux=[pwd,'\SetupAux.aux'];
        filename_PlayInCase='COULEE24_PlayIn_RealPMU.PWB';
        filename_DataAux=[pwd,'\PlayInData.aux'];
        filenamedyd=[pwd,'\COULEE24_PlayIn.dyd'];
        filename_RunAux = [pwd,'\LoadDYD_RunPlayIn_RealPMU.aux'];
        
        %     filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real PMU Data from 2017\COULEE24_2017_Multiparameter_H_Ld_XfmrX_2.mat'];
        %                     noisemultstr=num2str(list_noisemult(k));
        noisemultstr=num2str(list_noisemult(1));
        
        noisemultstr=noisemultstr(find(noisemultstr=='.')+1:end);
        
        %         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real PMU Data from 2017\2017 Fittings\COULEE24_2017_SingleParameterH_Ld_XfmrX_Event1_VNoiseMult_',noisemultstr,'PQoffset_01_NoiseAfter10sec.mat'];
        %     filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real PMU Data from 2017\2017 Fittings\COULEE24_2017_MultiParameter_H_Pss2bKs1_Pss2bT1_XfmrX_StartHXfmrAvg'];
        %         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real PMU Data from 2017\2017 Fittings\COULEE24_2017_HSingleParameter_NoNoise_2018avgH_Ks1_T1_XfmrX'];
        
        %         if m==1
        %             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_2016_PlayInBestInitialization_ZM.mat'];
        %         elseif m==2
        %             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_2017_PlayInBestInitialization_ZM.mat'];
        %         elseif m==3
        %             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_2018_PlayInBestInitialization_ZM.mat'];
        %         end
        %         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_Combined_H_XfmrX_SingleParameter_NoNoise_H_Ks1_T1_XfmrXstart.mat'];
%                     filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_Combined_Many_SingleParameter_NoNoise_H_Ks1_T1_XfmrX_AVGStart_VarianceTest.mat'];
%                 filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_Combined_H_SingleParameter_Event7_VNoiseMult_',noisemultstr,'_PQoffset_00_H_Ks1_T1_XfmrX_AVGStart.mat'];
%                 filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_Combined_AllSingleParameter_NoNoise_H_Ks1_T1_XfmrX_AVGStart2.mat'];
        filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\COULEE24 Real Data Combined Revisit\Fittings\COULEE24_Combined_Many_SingleParameter_Event7_VNoiseMult_',noisemultstr,'_PQoffset_00_H_Ks1_T1_XfmrX_AVGStart_VarianceTest.mat'];
        
        
        numericalsims=1;
        %     clear final_theta resnorm output
        %         clear data data_orig;
        for x=1:numericalsims
            %     for x=1:length(paramlist)
            
            %% Setup PlayIn PowerWorld Case for PMU Data
            %Load datacsv
%                         load(['D:\Users\JEisenbarth\Desktop\PowerWorld Files\',char(list(k))]);
            load(['D:\Users\JEisenbarth\Desktop\PowerWorld Files\',char(list(7))]);
            
            %% Write Data Aux File for Coulee Event PlayIn
            datacsv.t1=datacsv.t1-datacsv.t1(1);
            t1=datacsv.t1;
            Vt=datacsv.Vt;
            I=datacsv.I;
            f1=datacsv.f1;
            
            %% ADD Filtered Measurement Noise to V and F
            %Noise Multipliers
            %                 Vtnoisemultiplier=.0006;
            Vtnoisemultiplier=list_noisemult(1);
%             Vtnoisemultiplier=list_noisemult(k);
            
            %         Vtnoisemultiplier=0;
            
            
            %Voltage and current Noise
            Iavg=690.65241321168;       %A
            Vtavg=313583.691665234;      %Volts
            [b,a]=butter(3,5/30); %LP filter with cutoff of 5Hz
            
            
            
            %Find Start Time Event
            indexstartevent=find(round(t1,8)==datacsv.tevent);
            
            rng(x)            
            Vtnoisemag=Vtnoisemultiplier*Vtavg*randn(length(Vt(indexstartevent:end)),1);
            Vtnoiseang=Vtnoisemultiplier*pi*randn(length(Vt(indexstartevent:end)),1);
            Inoisemag=Vtnoisemultiplier*Iavg*randn(length(I(indexstartevent:end)),1);
            Inoiseang=Vtnoisemultiplier*pi*randn(length(I(indexstartevent:end)),1);
            
            Vtnoisemag=filter(b,a,Vtnoisemag);
            Vtnoiseang=filter(b,a,Vtnoiseang);
            Inoisemag=filter(b,a,Inoisemag);
            Inoiseang=filter(b,a,Inoiseang);
            
            Vtnoisemag(1)=0;
            Vtnoiseang(1)=0;
            Inoisemag(1)=0;
            Inoiseang(1)=0;
            
            Vtnoise=[Vt(1:indexstartevent-1);(abs(Vt(indexstartevent:end))+Vtnoisemag).*exp(1i*(angle(Vt(indexstartevent:end))+Vtnoiseang))];
            Inoise=[I(1:indexstartevent-1);(abs(I(indexstartevent:end))+Inoisemag).*exp(1i*(angle(I(indexstartevent:end))+Inoiseang))];
            
            %Calculate P and Q
            P=real(3*Vtnoise.*conj(Inoise)/1e6);
            Q=imag(3*Vtnoise.*conj(Inoise)/1e6);
            
            %Frequency
            anglenoise=[zeros(indexstartevent-1,1);Vtnoiseang;];
            
            
            fmeasnoise = (30/pi)*angle(exp(1i*anglenoise(2:end))./exp(1i*anglenoise(1:end-1))); %freq error mHz
            fmeasnoise = [fmeasnoise(1);fmeasnoise]/sqrt(6);
            
            fmeasnoise=filter(b,a,fmeasnoise);
            f1(2:end)=f1(2:end)+fmeasnoise(2:end);
            
            %         f1=[f1(1:index10sec);f1(index10sec+1:end)+fmeasnoise];
            
            %Add P and Q Offset Noise
            Pavg=mean(datacsv.P);
            Qavg=mean(datacsv.Q);
            %         PQ_offsetMult=.01;
            PQ_offsetMult=0;
            
            
            
            %         P(2:end)=P(2:end)+Pavg*PQ_offsetMult*(rand(1)-.5);
            %         Q(2:end)=Q(2:end)+Qavg*PQ_offsetMult*(rand(1)-.5);
            
            P(1)=P(1)+Pavg*PQ_offsetMult/10*(rand(1)-.5);
            Q(1)=Q(1)+Qavg*PQ_offsetMult/10*(rand(1)-.5);
            
%             %Filter Plot Check
%             figure
%             subplot(3,1,1)
%             plot(t1,real(Vtnoise*sqrt(3)/500e3),t1,real(Vt*sqrt(3)/500e3),'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             title(['COULEE24 Event: Voltage PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%             ylabel('Real Voltage ')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
%             
%             subplot(3,1,2)
%             plot(t1,imag(Vtnoise*sqrt(3)/500e3),t1,imag(Vt*sqrt(3)/500e3),'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             ylabel('Imag Voltage ')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
%             
%             subplot(3,1,3)
%             plot(t1,abs(Vtnoise*sqrt(3)/500e3),t1,abs(Vt*sqrt(3)/500e3),'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             ylabel('Voltage Magnitude(pu)')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
%             
%             figure
%             subplot(3,1,1)
%             plot(t1,real(Inoise),t1,real(I),'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             title(['COULEE24 Event: Current PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%             ylabel('Real Current(A)')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
%             
%             subplot(3,1,2)
%             plot(t1,imag(Inoise),t1,imag(I),'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             ylabel('Imag Current (A)')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
%             
%             subplot(3,1,3)
%             plot(t1,abs(Inoise),t1,abs(I),'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             ylabel('Current Magnitude(A)')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
%             
%             figure
%             plot(t1,(f1),t1,(f1-fmeasnoise),'LineWidth',1)
%             
%             legend('Added Measurement Noise','Original')
%             title(['COULEE24 Event: Frequency PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%             xlabel('Time(s)')
%             ylabel('Frequency (Hz)')
%             grid
%             xlim([0,30])
%             
%             figure
%             subplot(2,1,1)
%             plot(t1,P,t1,datacsv.P,'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             title(['COULEE24 Event: Real Power PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%             ylabel('Real Power (MW)')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
%             
%             subplot(2,1,2)
%             plot(t1,Q,t1,datacsv.Q,'LineWidth',1)
%             legend('Added Measurement Noise','Original')
%             title(['COULEE24 Event: Reactive Power PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%             ylabel('Reactive Power (MVAR)')
%             xlabel('Time(s)')
%             grid
%             xlim([0,30])
            
            datacsv.Pnonoise=datacsv.P;
            datacsv.Qnonoise=datacsv.Q;
            datacsv.P=P;
            datacsv.Q=Q;
            
            datacsv.Vtnoise=Vtnoise;
            datacsv.Inoise=Inoise;
            datacsv.f1noise=f1;
            
            
            %           WritePlayInAux(filename_DataAux,t1,ones(size(t1))*abs(Vtnoise(1)*sqrt(3)/500e3),ones(size(t1))*f1(1)/60)
            
            WritePlayInAux(filename_DataAux,t1,abs(Vtnoise*sqrt(3)/500e3),f1/60)
            
            
            %% Setup PowerWorld Case Based on Starting Point for Real PMU Data
            Vpmu=datacsv.Vtnoise(1);
            Ipmu=datacsv.Inoise(1);
            SetupCase_COULEE24(filename_SetupAux,filename_PlayInCase,Ipmu,Vpmu,SimAuto,XFMR,Line)
            
            
            %% Setup to Run to Minimize Cost Function
            %Setup Column Vector of Parameter to Adjust
            theta_indicies=[ones(length(index.gentpj),1),[1:length(index.gentpj)]';...
                2*ones(length(index.esst5b),1),[1:length(index.esst5b)]';...
                3*ones(length(index.oel1),1),[1:length(index.oel1)]';...
                4*ones(length(index.pss2b),1),[1:length(index.pss2b)]';...
                5*ones(length(index.hygovr),1),[1:length(index.hygovr)]';...
                6*ones(length(index.XFMR),1),[1:length(index.XFMR)]';...
                7*ones(length(index.Line),1),[1:length(index.Line)]';];
            
            %Setup Lower Bound Vector for Timeconstants >4*Timestep
            lb_list=-Inf*ones(size(theta_indicies,1),1);
            lb_list([1])=4*1/300;
            lb_list([2])=4*1/300;
            lb_list([3])=4*1/300;
            lb_list([5])=.32;
            lb_list([6])=.25;
            lb_list([8])=.32;
            lb_list([15])=0;
            lb_list([16,21,22,23,24,25,26,27,28,29,30,31])=4*1/300;
            lb_list([40,41,44])=0;
            lb_list([42,45])=4*1/300;
            lb_list([46,50,55,57,59])=4*1/300;
            lb_list([66,68,70,72,74,75])=4*1/300;
            lb_list([82,83])=4*1/300;
            lb_list([85])=0;
            lb_list([91])=.16;
            
            lb_list([54])=0;
            
            ub_list=Inf*ones(size(theta_indicies,1),1);
            ub_list([7])=.32;
            ub_list([8])=.7;
            
            %                 theta_indicies=list(k,:);
            %         lb=[lb_list(5);lb_list(6);lb_list(54);lb_list(27);];
            %         ub=[ub_list(5);ub_list(6);ub_list(54);ub_list(27);];
            %         theta_indicies=theta_indicies([5,6,54,27],:);
            %         lb=[lb_list(k);];
            %         ub=[ub_list(k);];
            %         theta_indicies=theta_indicies([k],:);
            lb=[lb_list(paramlist(k));];
            ub=[ub_list(paramlist(k));];
            theta_indicies=theta_indicies([paramlist(k)],:);
            %
            
%                             lb=[lb_list(paramlist(1));];
%                             ub=[ub_list(paramlist(1));];
%                             theta_indicies=theta_indicies([paramlist(1)],:);
            %
%                                 lb=[lb_list(paramlist(x));];
%                                 ub=[ub_list(paramlist(x));];
%                                 theta_indicies=theta_indicies([paramlist(x)],:);
            
            
%                         theta_indicies=theta_indicies([paramlist],:);
%                         lb=[lb_list(paramlist);];
%                         ub=[ub_list(paramlist);];
            
            %             theta_indicies=[1,4;1,5];    %1st column is model,2nd column is numerical parameter,3rd column is what residual vector to use 1=P 2=Q 3=P&Q
            %Ex. [1,5]->model=gentpj, parameter=H, P for
            % residual calculations.
            %Ex. [2,2]->model=esst5b, parameter=Kr, Q for
            % residual calculations.
            
            %Setup theta Vectors
            theta=zeros(size(theta_indicies,1),1);
            for b=1:length(theta)
                if theta_indicies(b,1)==1
                    theta(b)= gentpj_original(index.gentpj(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==2
                    theta(b)= esst5b_original(index.esst5b(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==3
                    theta(b)= oel1_original(index.oel1(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==4
                    theta(b)= pss2b_original(index.pss2b(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==5
                    theta(b)= hygovr_original(index.hygovr(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==6
                    theta(b)= XFMR_original(index.XFMR(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==7
                    theta(b)= Line_original(index.Line(theta_indicies(b,2)));
                end
            end
            
            percentnominal=abs(.01*theta);
            
            %% Run Simulation w Original theta in model
            % Run Original Simulation w/ Nominal dyd file.
                        [data_orig(k,x)] = PowerWorld_WriteDYD_Run_COULEE24_RealPMU(filenamedyd,gentpj_original,esst5b_original,pss2b_original,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu,XFMR_original,hygovr_original,oel1_original,Line_original);
            
            
            %% Run Minimizing Cost Function
            PQ_Flag=2; %When PQ_Flag is 2 then that means to use P and Q for residual calculations.
            k
%             opts=optimoptions(@lsqnonlin,'TolFun',1e-12,'Display','iter','Diagnostics','off','Tolx',1e-3,'MaxFunEvals',50,'SpecifyObjectiveGradient',true);
                        opts=optimoptions(@lsqnonlin,'TolFun',1e-12,'Display','iter','Diagnostics','off','Tolx',1e-12,'MaxFunEvals',0,'MaxIterations',0,'SpecifyObjectiveGradient',true);
            
            residual = @(theta) residual_Jacobian_PowerWorld_RealPMU_COULEE24(theta,theta_indicies,index,datacsv,filenamedyd,gentpj,esst5b,pss2b,PQ_Flag,SimAuto,percentnominal,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu,XFMR,hygovr,oel1,Line)

            [final_theta(k,x),resnorm,residualout,exitflag,output,lambda,Jacobian] = lsqnonlin(residual,theta,lb,ub,opts);
%             [final_theta(k,x),resnorm(k,x),residualout,exitflag,output(k,x),lambda,Jacobian] = lsqnonlin(residual,theta,lb,ub,opts);
            %             [final_theta(k,:),resnorm(k,:),residualout,exitflag,output(k,:),lambda,Jacobian] = lsqnonlin(residual,theta,lb,ub,opts);
            %             residual_save(k,:)=residualout;
            %                                     rtest(m,k)=mean(abs(residualout));
            
            Variance_save(k,x)=inv(transpose(full(Jacobian))*full(Jacobian));
            
            
            x
            
            %% Run Simulation with newly found theta
            
            %             %Put thetas into model
            %             for m=1:size(theta_indicies,1)
            %                 if theta_indicies(m,1)==1
            %                     gentpj(index.gentpj(theta_indicies(m,2)))=final_theta(k,m);
            %                 elseif theta_indicies(m,1)==2
            %                     esst5b(index.esst5b(theta_indicies(m,2)))=final_theta(k,m);
            %                 elseif theta_indicies(m,1)==3
            %                     oel1(index.oel1(theta_indicies(m,2)))=final_theta(k,m);
            %                 elseif theta_indicies(m,1)==4
            %                     pss2b(index.pss2b(theta_indicies(m,2)))=final_theta(k,m);
            %                 elseif theta_indicies(m,1)==5
            %                     hygovr(index.hygovr(theta_indicies(m,2)))=final_theta(k,m);
            %                 elseif theta_indicies(m,1)==6
            %                     XFMR(index.XFMR(theta_indicies(m,2)))=final_theta(k,m);
            %                 elseif theta_indicies(m,1)==7
            %                     Line(index.Line(theta_indicies(m,2)))=final_theta(k,m);
            %                 end
            %             end
            %             %Run Simulation w final theta in model
            %             [data(k,x)] = PowerWorld_WriteDYD_Run_COULEE24_RealPMU(filenamedyd,gentpj,esst5b,pss2b,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu,XFMR,hygovr,oel1,Line);
            %
            %             %Set Models to Original
            %             gentpj=gentpj_original;
            %             esst5b=esst5b_original;
            %             oel1=oel1_original;
            %             pss2b=pss2b_original;
            %             hygovr=hygovr_original;
            %             XFMR=XFMR_original;
            %             Line=Line_original;
            
            toc
            %         %% Save Fitting Data
            %         %         %         %         %save(filename_SaveLocation,'final_theta','resnorm','output','list')
            %         %         %         %         %save(filename_SaveLocation,'final_theta','resnorm','output','list','data')
            %         %         %         %
            %             datacsv_save(k,x)=datacsv;
            %
            %
            %             save(filename_SaveLocation,'final_theta','resnorm','output','list','data','data_orig','datacsv','datacsv_save')
            %                             save(filename_SaveLocation,'list','data_orig','datacsv','datacsv_save')
            %
%                         save(filename_SaveLocation,'final_theta','resnorm','output','list','paramlist','Variance_save')
%                         save(filename_SaveLocation,'final_theta','list','paramlist')
            
            %                      save(filename_SaveLocation,'rtest','list')
            %         %
        end
        
        %% Plot Check
        list_title2017=[...
            "2017 125 MW Square-wave Pulse";...
            "2017 CJ Brake Pulse";...
            "2017 CJ Brake Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 CJ Brake Pulse";...
            "2017 CJ Brake Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            ];
        
        list_title2018=[...
            "2018 125 MW Square-wave Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            ];
        
        
        
                figure
                ndxP=PWFind(data_orig(k),'Branch ',' 40287 41744 1 ','MW From');
                ndxQ=PWFind(data_orig(k),'Branch ',' 40287 41744 1 ','Mvar From');
                subplot(2,1,1)
                hold on
                plot(datacsv.t1,datacsv.P,'LineWidth',1.5,'DisplayName','Event')
                plot(data_orig(k,1).Data(:,1),data_orig(k,1).Data(:,ndxP),'LineWidth',1.5,'DisplayName','PlayIn Orig')
%                 plot(data(k,1).Data(:,1),data(k,1).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Fitted')
                hold off
                if size(list2017,1)==size(list,1)
                    title(['k=',num2str(k),' ',char(list_title2017(k,:)),' P Plot'])
                elseif size(list2018,1)==size(list,1)
                    title(['k=',num2str(k),' ',char(list_title2018(k,:)),' P Plot'])
                end
                %     title(list(k,:))
                legend('Location','Best')
                grid
                xlabel('Seconds')
                ylabel('Real Power [MW]')
                    xlim([0,20])
        
                subplot(2,1,2)
                hold on
                plot(datacsv.t1,datacsv.Q,'LineWidth',1.5,'DisplayName','Event')
                plot(data_orig(k,1).Data(:,1),data_orig(k,1).Data(:,ndxQ),'LineWidth',1.5,'DisplayName','PlayIn Orig')
%                 plot(data(k,1).Data(:,1),data(k,1).Data(:,ndxQ),'LineWidth',1,'DisplayName','PlayIn Fitted')
                hold off
                if size(list2017,1)==size(list,1)
                    title(['k=',num2str(k),' ',char(list_title2017(k,:)),' Q Plot'])
                elseif size(list2018,1)==size(list,1)
                    title(['k=',num2str(k),' ',char(list_title2018(k,:)),' Q Plot'])
                end
                % title(list(k,:))
                legend('Location','Best')
                grid
                xlabel('Seconds')
                ylabel('Reactive Power [MVAR]')
                        xlim([0,20])
                %         savefig(['F:\Grad School Research\State Plots\PQ Plots\PQPlot_Event',num2str(k),'.fig'])
        %
        %         % subplot(3,1,3)
        %         %     hold on
        %         %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,11),'LineWidth',1,'DisplayName','PlayIn Orig')
        %         %     hold off
        %         %     if size(list2017,1)==size(list,1)
        %         %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' Vref State Plot'])
        %         %     elseif size(list2018,1)==size(list,1)
        %         %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' Vref Plot'])
        %         %     end
        %         %     legend();
        %         %     ylim([1,1.01])
        %         %     yticks([1:.001:1.01])
        %         %     grid
        %         %     xlabel('Seconds')
        %         %     ylabel('Pu')
        %
        %         % subplot(3,1,3)
        %         %     hold on
        %         %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,21),'LineWidth',1,'DisplayName','PlayIn Orig')
        %         %     hold off
        %         %     if size(list2017,1)==size(list,1)
        %         %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' ',data_orig(k).Header{21-1,6}])
        %         %     elseif size(list2018,1)==size(list,1)
        %         %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' ',data_orig(k).Header{21-1,6}])
        %         %     end
        %         %     legend();
        %         %     grid
        %         %     xlabel('Seconds')
        %         %     ylabel('Pu')
        %         %
        %         %
        %         %         subplot(3,1,3)
        %         %         hold on
        %         %         % plot(residual,'DisplayName',['Parameter=',num2str(theta)])
        %         %         plot(residual,'DisplayName',['Parameter='])
        %         %         hold off
        %         %         title('Residual')
        %         %         legend();
        %         %             %
        %         subplot(3,1,3)
        %         hold on
        %         plot(abs([data_orig(k,1).Data([1:5:9002],ndxP)-datacsv.P;data_orig(k,1).Data([1:5:9002],ndxQ)-datacsv.Q]),'DisplayName','PlayIn Orig')
        %         plot(abs([data(k,1).Data([1:5:9002],ndxP)-datacsv.P;data(k,1).Data([1:5:9002],ndxQ)-datacsv.Q]),'DisplayName','PlayIn Fitted')
        %         hold off
        %         title('Residual')
        %         %     xlim([10,30])
        %         legend('Location','NorthWest')
        %         grid
        
        %     rtest(k,:)=abs([data_orig(k,1).Data([1:5:9002],ndxP)-datacsv.P;data_orig(k,1).Data([1:5:9002],ndxQ)-datacsv.Q]);
        
        %
        %
        %
        %
        %
        %
        %     ndxV=PWFind(data_orig(k),'Bus ',' 40287 ','V pu');
        %     figure
        %     subplot(2,1,1)
        %     hold on
        %     plot(datacsv.t1,datacsv.v1,'LineWidth',1,'DisplayName','Event')
        %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,ndxV),'LineWidth',1,'DisplayName','PlayIn Orig')
        %     plot(data.Data(:,1),data.Data(:,ndxV),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %     hold off
        %     if size(list2017,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' V Plot'])
        %     elseif size(list2018,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' V Plot'])
        %     end
        %     legend();
        %     grid
        %
        %
        %     ndxF=PWFind(data_orig(k),'Bus ',' 40287 ','Frequency in PU');
        %     subplot(2,1,2)
        %     hold on
        %     plot(datacsv.t1,datacsv.f1/60,'LineWidth',1,'DisplayName','Event')
        %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,ndxF),'LineWidth',1,'DisplayName','PlayIn Orig')
        %     plot(data.Data(:,1),data.Data(:,ndxF),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %     hold off
        %     if size(list2017,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' F Plot'])
        %     elseif size(list2018,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' F Plot'])
        %     end
        %     legend();
        %     grid
        %     savefig(['F:\Grad School Research\State Plots\VF Plots\VFPlot_Event',num2str(k),'.fig'])
        %
        %     ndxVang=PWFind(data_orig(k),'Bus ',' 41744 ','V angle No shift');
        %     subplot(3,1,3)
        %     hold on
        %     plot(datacsv.t1,datacsv.Vang1-datacsv.Vang1(1),'LineWidth',1,'DisplayName','Event')
        %     plot(data_orig(k).Data(:,1),unwrap((data_orig(k).Data(:,ndxVang)-data_orig(k).Data(1,ndxVang))*pi/180)*180/pi,'LineWidth',1,'DisplayName','PlayIn Orig')
        %
        % %         plot(data.Data(:,1),unwrap((data.Data(:,ndxVang)-data.Data(1,ndxVang))*pi/180)*180/pi,'LineWidth',1,'DisplayName','PlayIn Fitted')
        %         hold off
        %         title('Vang Plot')
        %         legend();
        %         grid
        
        % %Plot Exciter
        %     x=1;
        %     b=1;
        %     for z=9:20
        %         if(x>3)
        %             x=1;
        %             savefig(['F:\Grad School Research\State Plots\Exciter State Plots\ExciterStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %             b=b+1;
        %         end
        %         if(x==1)
        %             figure
        %         end
        %         subplot(3,1,x)
        %         hold on
        %         plot(data_orig(k).Data(:,1),data_orig(k).Data(:,z),'LineWidth',1,'DisplayName','PlayIn Orig')
        %         %     plot(data(k).Data(:,1),data(k).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %         hold off
        %         if size(list2017,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2017(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         elseif size(list2018,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2018(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         end
        %         legend();
        %         grid
        %         xlabel('Seconds')
        %
        %         x=x+1;
        %     end
        %     savefig(['F:\Grad School Research\State Plots\Exciter State Plots\ExciterStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %
        % %Plot Stabilizer
        %     x=1;
        %     b=1;
        %     for z=21:31
        %         if(x>3)
        %             x=1;
        %             savefig(['F:\Grad School Research\State Plots\Stabilizer State Plots\StabilizerStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %             b=b+1;
        %         end
        %         if(x==1)
        %             figure
        %         end
        %         subplot(3,1,x)
        %         hold on
        %         plot(data_orig(k).Data(:,1),data_orig(k).Data(:,z),'LineWidth',1,'DisplayName','PlayIn Orig')
        %         %     plot(data(k).Data(:,1),data(k).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %         hold off
        %         if size(list2017,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2017(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         elseif size(list2018,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2018(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         end
        %         legend();
        %         grid
        %         xlabel('Seconds')
        %
        %         x=x+1;
        %     end
        %     savefig(['F:\Grad School Research\State Plots\Stabilizer State Plots\StabilizerStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %
        % %Plot Governor
        %     x=1;
        %     b=1;
        %     for z=32:43
        %         if(x>3)
        %             x=1;
        %             savefig(['F:\Grad School Research\State Plots\Governor State Plots\GovernorStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %             b=b+1;
        %         end
        %         if(x==1)
        %             figure
        %         end
        %         subplot(3,1,x)
        %         hold on
        %         plot(data_orig(k).Data(:,1),data_orig(k).Data(:,z),'LineWidth',1,'DisplayName','PlayIn Orig')
        %         %     plot(data(k).Data(:,1),data(k).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %         hold off
        %         if size(list2017,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2017(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         elseif size(list2018,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2018(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         end
        %         legend();
        %         grid
        %         xlabel('Seconds')
        %
        %         x=x+1;
        %     end
        %     savefig(['F:\Grad School Research\State Plots\Governor State Plots\GovernorStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %
        % %Plot Machine
        %     x=1;
        %     b=1;
        %     for z=44:51
        %         if(x>3)
        %             x=1;
        %             savefig(['F:\Grad School Research\State Plots\Machine State Plots\MachineStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %             b=b+1;
        %         end
        %         if(x==1)
        %             figure
        %         end
        %         subplot(3,1,x)
        %         hold on
        %         plot(data_orig(k).Data(:,1),data_orig(k).Data(:,z),'LineWidth',1,'DisplayName','PlayIn Orig')
        %         %     plot(data(k).Data(:,1),data(k).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %         hold off
        %         if size(list2017,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2017(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         elseif size(list2018,1)==size(list,1)
        %             title(['k=',num2str(k),' ',char(list_title2018(k,:)),' ',data_orig(k).Header{z-1,6}])
        %         end
        %         legend();
        %         grid
        %         xlabel('Seconds')
        %
        %         x=x+1;
        %     end
        %     savefig(['F:\Grad School Research\State Plots\Machine State Plots\MachineStates_Event',num2str(k),'_Plot',num2str(b),'PSS2BOFF.fig'])
        %
        %
        %
        %     %         figure
        %     %     subplot(2,1,1)
        %     %     hold on
        %     %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,11),'LineWidth',1,'DisplayName','PlayIn Orig')
        %     %     %     plot(data(k).Data(:,1),data(k).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %     %     hold off
        %     %     if size(list2017,1)==size(list,1)
        %     %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' VOEL'])
        %     %     elseif size(list2018,1)==size(list,1)
        %     %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' VOEL'])
        %     %     end
        %     %     legend();
        %     %     grid
        %     %     xlabel('Seconds')
        %     %
        %     %
        %     %     subplot(2,1,2)
        %     %     hold on
        %     %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,12),'LineWidth',1,'DisplayName','PlayIn Orig')
        %     %     %     plot(data(k).Data(:,1),data(k).Data(:,ndxQ),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %     %     hold off
        %     %     if size(list2017,1)==size(list,1)
        %     %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),'VUEL'])
        %     %     elseif size(list2018,1)==size(list,1)
        %     %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),'VUEL'])
        %     %     end
        %     %     legend();
        %     %     grid
        %     %     xlabel('Seconds')
        %
        
    end
end
