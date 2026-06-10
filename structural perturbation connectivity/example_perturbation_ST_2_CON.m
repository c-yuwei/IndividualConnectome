%EXAMPLE_PERTURBATION_ST_2_CON
% Script example pipeline structural regional values conversion to
% individual connectivity data using the perturbation approach.
clear variables %#ok<*NASGU>

%% Setup paths for simulated data 
base_dir = fileparts(which('example_mahalanobis_ST_2_CON'));

reference_st_dir = [base_dir filesep 'Converted data structural T1w reference group'];
target_st_dir = [base_dir filesep 'Converted data structural T1w target group'];

if ~isfolder(reference_st_dir) || ~isfolder(target_st_dir)
    create_data_two_simulated_groups
end

reference_group_file = [reference_st_dir filesep 'group_subjects_VOLUME.xlsx'];
target_group_file = [target_st_dir filesep 'group_subjects_VOLUME.xlsx'];
atlas_file = [reference_st_dir filesep 'brain_atlas.xlsx'];
base_dir = fileparts(which('example_perturbation_ST_2_CON'));

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', atlas_file, ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load reference SubjectST group
im_gr_reference = ImporterGroupSubjectST_XLS( ...
    'FILE', reference_group_file, ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_reference = im_gr_reference.get('GR');

%% Load target SubjectST group
im_gr_target = ImporterGroupSubjectST_XLS( ...
    'FILE', target_group_file, ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_target = im_gr_target.get('GR');

%% Convert target regional values to individual connectomes
cn = ConverterST2CON( ...
    'GR_ST', gr_target, ...
    'GR_REFERENCE', gr_reference, ...
    'METHOD', 'perturbation', ...
    'REFERENCE_MODE', 'external', ...
    'WAITBAR', true ...
    );

gr_con = cn.get('GR_CON');

%% Export data
directory_base = [base_dir filesep 'Converted CON data Perturbation'];

if ~isfolder(directory_base)
    mkdir(directory_base);
end

ex = ExporterGroupSubjectCON_XLS( ...
    'DIRECTORY', directory_base, ...
    'GR', gr_con ...
    );

ex.get('SAVE');

file_ba = [directory_base filesep 'brain_atlas.xlsx'];

ex = ExporterBrainAtlasXLS( ...
    'FILE', file_ba, ...
    'BA', ba ...
    );

ex.get('SAVE');

%% Verification
sub_dict_con = gr_con.get('SUB_DICT');
target_number = gr_target.get('SUB_DICT').get('LENGTH');

assert(isequal(sub_dict_con.get('LENGTH'), target_number), ...
    'Verification failed: converted CON group and target ST group have different numbers of subjects.')

sub_con = sub_dict_con.get('IT', 1);
con = sub_con.get('CON');

br_number = ba.get('BR_DICT').get('LENGTH');

assert(isequal(size(con), [br_number br_number]), ...
    'Verification failed: individual connectome size does not match the brain atlas size.')

assert(all(~isnan(con(:))), ...
    'Verification failed: Mahalanobis individual connectome contains NaN values.')

assert(isequal(con, con'), ...
    'Verification failed: Mahalanobis individual connectome is not symmetric.')

assert(all(diag(con) == 0), ...
    'Verification failed: Mahalanobis individual connectome diagonal is not zero.')

fprintf('Verification passed: Mahalanobis ST-to-CON conversion generated %d individual connectomes.\n', ...
    sub_dict_con.get('LENGTH'));

fprintf('Reference group subjects: %d\n', gr_reference.get('SUB_DICT').get('LENGTH'));
fprintf('Target group subjects: %d\n', gr_target.get('SUB_DICT').get('LENGTH'));
