close all; delete(findall(0, 'type', 'figure')); clear all
directory = '.';
braph2genesis_directory = [directory filesep() 'braph2genesis'];
%% Copy pipeline folders into braph2genesis/pipelines
pipeline_folders = {
    'structural region-of-interest'
    };

for i = 1:1:numel(pipeline_folders)
    pipeline_folder = pipeline_folders{i};
    target_folder = fullfile(braph2genesis_directory, 'pipelines', pipeline_folder);

    fprintf(['Copying pipeline "' pipeline_folder '" to "' target_folder '"\n']);
    copyfile([directory filesep() pipeline_folder], target_folder);
end

disp(' ')

%%
el_path = [filesep 'pipelines' filesep 'structural region-of-interest']
el_class_list = {'SubjectNIfTI'}
regenerate(el_path, el_class_list)
