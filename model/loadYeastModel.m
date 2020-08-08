%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model = loadYeastModel
% Loads model and adds the rxnGeneMatrix to the structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function model = loadYeastModel

scriptFolder = fileparts(which(mfilename));
currentDir = cd(scriptFolder);
model = readCbModel('yeast_8.4.1_cobra.mat');
model = buildRxnGeneMat(model);
cd(currentDir)

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
