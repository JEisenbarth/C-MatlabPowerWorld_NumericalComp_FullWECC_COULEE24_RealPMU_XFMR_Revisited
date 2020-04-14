function [] = SetupCase_COULEE24(filename_SetupAux,filename_PlayInCase,Ipmu,Vpmu,SimAuto,XFMR,Line)
%SetupCase_COULEE24 This funciton will be used to write and run an Aux file
% to setup a case file from PMU Data. It takes the PMU voltage at the
% PlayIn bus then performs a calcuation to find the voltage and power at
% the generator bus so that the P,Q, and V measurements for the PMU match
% match the setup case.

%% Calculate Vm and Pm for Bus with COULEE24 Generator
% Sbase=100e6;
% Vbase=500e3;
% Ibase=Sbase/(sqrt(3)*Vbase);
% 
% Vt=Vpmu/Vbase;
% 
% %Known Quantities
% Sbase=100e6;
% Z=(XFMR(1)+1i*XFMR(2));   %PU
% S=Ppmu*1e6+1i*Qpmu*1e6;               %MVA
% S=S/Sbase;              %PU
% XfmrTap=1.07620;           %Ratio
% 
% %Calculate Vm and Pm
% I=conj(S/Vpmu);                   %PU
% Vm=-I*Z*XfmrTap+Vpmu/XfmrTap; %Solve Vm then plug in for I.
% Pm=-real(Vm*conj(I))*XfmrTap*Sbase/1e6;
% Known Quantities
Sbase=100e6;
Vbase=500e3/sqrt(3);
Ibase=Sbase/(Vbase);
XfmrTap=1.07620;

Vt=Vpmu/Vbase;
It=-Ipmu*3/Ibase;

% abs(Vt)
% real(Vt*conj(It))*Sbase/1e6
% imag(Vt*conj(It))*Sbase/1e6

%% Voltage over Line
ZLine=Line(1)+j*Line(2);

I1=Vt*j*Line(3)/2;
I2=It+I1;
Vc=Vt+I2*(ZLine);
I3=Vc*j*Line(3)/2;
Ic=I2+I3;

% abs(Vc)
% real(Vc*conj(Ic))*Sbase/1e6
% imag(Vc*conj(Ic))*Sbase/1e6


%% Voltage over XFMR
ZXfmr=XFMR(1)+j*XFMR(2);
Vm=Ic*ZXfmr*XfmrTap+Vc/XfmrTap; %Solve Vm then plug in for I.
Pm=real(Vm*conj(Ic))*XfmrTap*Sbase/1e6;
% Qm=imag(Vm*conj(Ic))*XfmrTap*Sbase/1e6
% abs(Vm)


fileID = fopen(filename_SetupAux,'w');
fprintf(fileID,['SCRIPT\n']);
fprintf(fileID,['{\n']);
% fprintf(fileID,['//Load Case\n']);

fprintf(fileID,['OpenCase("%s",PWB);\n'],filename_PlayInCase);
% fprintf(fileID,['//Enter Edit Mode\n']);
fprintf(fileID,['EnterMode(EDIT);\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Line Parameters for PlayIn\n']);
fprintf(fileID,['DATA (Branch, [BusNum,BusName,BusNum:1,BusName:1,LineCircuit,LineR,LineX,LineC])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['40287 "COULEE" 41744 "COULEE24" 1 ',num2str(Line(1),12),' ',num2str(Line(2),12),' ',num2str(Line(3),12),'\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Transformer Parameters for PlayIn\n']);
fprintf(fileID,['DATA (Branch, [BusNum,BusName,BusNum:1,BusName:1,LineCircuit,LineR,LineX])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['41744 "COULEE24" 40298 "COULEE24" 1 ',num2str(XFMR(1),12),' ',num2str(XFMR(2),12),'\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Generator Voltage for PlayIn Gen\n']);
fprintf(fileID,['DATA (GEN, [BusNum,BusName,GenID,VoltSet])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['40287 "COULEE" 1 ',num2str(abs(Vt),12),'\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Bus Voltage and Angle for PlayIn Bus\n']);
fprintf(fileID,['DATA (Bus, [BusNum,BusName,BusPUVolt,BusAngle])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['40287 "COULEE" ',num2str(abs(Vt),12),' 0\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Generator Real Power and Voltage for Gen\n']);
fprintf(fileID,['DATA (GEN, [BusNum,BusName,GenID,VoltSet,GenMW])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['40298 "COULEE24" 1 ',num2str(abs(Vm),12),' ',num2str(Pm,12),'\n']);
fprintf(fileID,['}\n\n']);

fprintf(fileID,['SCRIPT\n']);
fprintf(fileID,['{\n']);
% fprintf(fileID,['//Enter Run Mode\n']);
fprintf(fileID,['EnterMode(RUN);\n']);
% fprintf(fileID,['//Solve Power Flow\n']);
fprintf(fileID,['SolvePowerFlow (RECTNEWT,"","");\n']);
% fprintf(fileID,['SaveCase("%s");\n'],filename_PlayInCase);
fprintf(fileID,['}\n\n']);
fclose(fileID);

%% Process Aux File to Load and Run Simulation
% Make the processAuxFile call
% simOutput = SimAuto.ProcessAuxFile(filename_SetupAux);

end

