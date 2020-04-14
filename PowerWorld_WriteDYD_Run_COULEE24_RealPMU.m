function [data] = PowerWorld_WriteDYD_Run_COULEE24_RealPMU(filenamedyd,gentpj,esst5b,pss2b,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu,XFMR,hygovr,oel1,Line)
%PowerWorld_WriteDYD This function uses a series of other functions to write a
%PSLF dyd file which is later used by a PowerWorld simulation which is ran by
%using the SimAuto Add-on. An aux file is written to 

%% Setup PowerWorld Case  
SetupCase_COULEE24(filename_SetupAux,filename_PlayInCase,Ipmu,Vpmu,SimAuto,XFMR,Line);

%% Open dyd File
fileID=fopen(filenamedyd,'w+');    %Open/create file for reading and writing.
%Discards previous contents.

%% Call Functions to Add Models to dyd File
fprintf(fileID,'models\n');

gentpj_dyd(fileID,'40298','COULEE24','15.00','1','mva=825.6',num2str(gentpj(1),10),num2str(gentpj(2),10),num2str(gentpj(3),10),num2str(gentpj(4),10),num2str(gentpj(5),10),num2str(gentpj(6),10),num2str(gentpj(7),10),num2str(gentpj(8),10),num2str(gentpj(9),10),num2str(gentpj(10),10),num2str(gentpj(11),10),num2str(gentpj(12),10),num2str(gentpj(13),10),num2str(gentpj(14),10),num2str(gentpj(15),10),num2str(gentpj(16),10),num2str(gentpj(17),10),num2str(gentpj(18),10),num2str(gentpj(19),10),num2str(gentpj(20),10));
esst5b_dyd(fileID,'40298','COULEE24','15.00','1',num2str(esst5b(1),10),num2str(esst5b(2),10),num2str(esst5b(3),10),num2str(esst5b(4),10),num2str(esst5b(5),10),num2str(esst5b(6),10),num2str(esst5b(7),10),num2str(esst5b(8),10),num2str(esst5b(9),10),num2str(esst5b(10),10),num2str(esst5b(11),10),num2str(esst5b(12),10),num2str(esst5b(13),10),num2str(esst5b(14),10),num2str(esst5b(15),10),num2str(esst5b(16),10),num2str(esst5b(17),10),num2str(esst5b(18),10));
oel1_dyd(fileID,'40298','COULEE24','15.00','1',num2str(oel1(1),10),num2str(oel1(2),10),num2str(oel1(3),10),num2str(oel1(4),10),num2str(oel1(5),10),num2str(oel1(6),10),num2str(oel1(7),10),num2str(oel1(8),10),num2str(oel1(9),10));
pss2b_dyd(fileID,'40298','COULEE24','15.00','1',num2str(pss2b(1),10),num2str(pss2b(2),10),num2str(pss2b(3),10),num2str(pss2b(4),10),num2str(pss2b(5),10),num2str(pss2b(6),10),num2str(pss2b(7),10),num2str(pss2b(8),10),num2str(pss2b(9),10),num2str(pss2b(10),10),num2str(pss2b(11),10),num2str(pss2b(12),10),num2str(pss2b(13),10),num2str(pss2b(14),10),num2str(pss2b(15),10),num2str(pss2b(16),10),num2str(pss2b(17),10),num2str(pss2b(18),10),num2str(pss2b(19),10),num2str(pss2b(20),10),num2str(pss2b(21),10),num2str(pss2b(22),10),num2str(pss2b(23),10),num2str(pss2b(24),10),num2str(pss2b(25),10),num2str(pss2b(26),10),num2str(pss2b(27),10),num2str(pss2b(28),10),num2str(pss2b(29),10),num2str(pss2b(30),10),num2str(pss2b(31),10),num2str(pss2b(32),10),num2str(pss2b(33),10));
hygovr_dyd(fileID,'40298','COULEE24','15.00','1','mwcap=826.0',num2str(hygovr(1),10),num2str(hygovr(2),10),num2str(hygovr(3),10),num2str(hygovr(4),10),num2str(hygovr(5),10),num2str(hygovr(6),10),num2str(hygovr(7),10),num2str(hygovr(8),10),num2str(hygovr(9),10),num2str(hygovr(10),10),num2str(hygovr(11),10),num2str(hygovr(12),10),num2str(hygovr(13),10),num2str(hygovr(14),10),num2str(hygovr(15),10),num2str(hygovr(16),10),num2str(hygovr(17),10),num2str(hygovr(18),10),num2str(hygovr(19),10),num2str(hygovr(20),10),num2str(hygovr(21),10),num2str(hygovr(22),10),num2str(hygovr(23),10),num2str(hygovr(24),10),num2str(hygovr(25),10),num2str(hygovr(26),10),num2str(hygovr(27),10),num2str(hygovr(28),10),num2str(hygovr(29),10),num2str(hygovr(30),10),num2str(hygovr(31),10),num2str(hygovr(32),10),num2str(hygovr(33),10),num2str(hygovr(34),10),num2str(hygovr(35),10),num2str(hygovr(36),10),num2str(hygovr(37),10),num2str(hygovr(38),10),num2str(hygovr(39),10),num2str(hygovr(40),10));


fclose(fileID);     %Closes file.


%% Run Simulation

%% Process Aux File to Load and Run Simulation
%Setup Aux File to Run Simulation
fileID = fopen(filename_RunAux,'w');
fprintf(fileID,['SCRIPT LoadDYD_RunPlayIn\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['//Clear Log\n']);
fprintf(fileID,['LogClear;\n'],filename_PlayInCase);

fprintf(fileID,['//Load Case\n']);
fprintf(fileID,['OpenCase("%s",PWB);\n'],filename_PlayInCase);

fprintf(fileID,['//Load SetupAux Aux File\n']);
fprintf(fileID,['LoadAux("SetupAux.aux");\n']);

fprintf(fileID,['//Load Aux File with PlayInData\n']);
fprintf(fileID,['LoadAux("PlayInData.aux");\n']);

fprintf(fileID,['//Enter Edit Mode\n']);
fprintf(fileID,['EnterMode(EDIT);\n']);

fprintf(fileID,['//Load Dyd File\n']);
fprintf(fileID,['TSLoadGE("COULEE24_PlayIn.dyd", NO, YES);\n']);


fprintf(fileID,['//Enter Run Mode\n']);
fprintf(fileID,['EnterMode(RUN);\n']);

% fprintf(fileID,['//AutoCorrect\n']);
% fprintf(fileID,['TSAutoCorrect;\n']);
% 'Auto Correct On'

fprintf(fileID,['//Solve Dynamic Simulation\n']);
fprintf(fileID,['TSSolveAll;\n']);

fprintf(fileID,['//Save to Log\n']);
fprintf(fileID,['LogSave("Log_PowerWorld.txt");\n']);

fprintf(fileID,['}\n\n']);
fclose(fileID);

 
% Make the processAuxFile call
simOutput = SimAuto.ProcessAuxFile(filename_RunAux);

%% Load Results into Matlab via TSGetContingencyResults
% Here we get the results for all of the angles directly into Matlab via SimAuto
%%
newCtgName = 'My Transient Contingency';
objFieldList = {'"Plot ''PlayInData''"' };
simOutput = SimAuto.TSGetContingencyResults(newCtgName, objFieldList , '0.0', '30.0');
if ~(strcmp(simOutput{1},''))
disp(simOutput{1})
else
% disp('GetTSResultsInSimAuto successful')
 
%Get the results
data.Data = simOutput{3};
 
%Get the header variables to use for plot labels
data.Header = simOutput{2};

% Convert a matrix of strings into a matrix of numbers and plot them
data.Data = str2double(data.Data);
end



end

