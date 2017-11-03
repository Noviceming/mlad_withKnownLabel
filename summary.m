clear; clc; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rootFolder = 'D:/results/results_mlad_withKnownLabel/';
caseNum = 0 : 7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

caseNumBin = fliplr(de2bi(caseNum));
caseNumBinChar = num2str(caseNumBin);
caseNumBinChar = caseNumBinChar(~isspace(caseNumBinChar));
caseNumBinChar = reshape(caseNumBinChar, [size(caseNumBin ,1), length(caseNumBinChar)/size(caseNumBin ,1)]);

folderBasic = '2012-01-01--2012-12-31_sensor_1-38_fusion';
fileBasic = '2012-01-01--2012-12-31_sensor_1-38_fusion_autoenc1epoch_300_globalEpoch_500.mat';

for nMlad = 1 : 2 %length(caseNum)
    for nTrainRatio = 1 : 3 %pct
        for nSeed = 1 : 10
            fprintf('\nLoading...    mlad%s  trainRatio: %d  seed: %d    ', caseNumBinChar(nMlad, :), nTrainRatio, nSeed)
            fileFull = sprintf('%s/mlad%s/%s_trainRatio_%dpct_seed_%d/%s', rootFolder, caseNumBinChar(nMlad, :), folderBasic, nTrainRatio, nSeed, fileBasic);
            fileOrigin = load(fileFull);
            if  isfield(fileOrigin, 'confTrainAccuracy')
                out.train{nMlad}{nTrainRatio}(nSeed) = fileOrigin.confTrainAccuracy;
                out.vali{nMlad}{nTrainRatio}(nSeed) = fileOrigin.confValiAccuracy;
                out.test{nMlad}{nTrainRatio}(nSeed) = fileOrigin.confTestAccuracy;
                fprintf('collected    ')
            else
                fprintf('no accuracy!    ')
                out.train{nMlad}{nTrainRatio}(nSeed) = NaN;
                out.vali{nMlad}{nTrainRatio}(nSeed) = NaN;
                out.test{nMlad}{nTrainRatio}(nSeed) = NaN;
            end            
            clear fileOrigin
        end
        out.trainMean{nMlad}(nTrainRatio) = mean(out.train{nMlad}{nTrainRatio});
        out.trainStd{nMlad}(nTrainRatio) = std(out.train{nMlad}{nTrainRatio});
        out.valiMean{nMlad}(nTrainRatio) = mean(out.vali{nMlad}{nTrainRatio});
        out.valiStd{nMlad}(nTrainRatio) = std(out.vali{nMlad}{nTrainRatio});
        out.testMean{nMlad}(nTrainRatio) = mean(out.test{nMlad}{nTrainRatio});
        out.testStd{nMlad}(nTrainRatio) = std(out.test{nMlad}{nTrainRatio});
    end
end

sumFolder = 'summary/';
if ~exist(sumFolder, 'dir')
    mkdir(sumFolder)
end

save([sumFolder 'summary_' datestr(now,'yyyy-mm-dd_HH-MM-SS') '.mat'], 'out', '-v7.3')
fprintf('saved.\n')








