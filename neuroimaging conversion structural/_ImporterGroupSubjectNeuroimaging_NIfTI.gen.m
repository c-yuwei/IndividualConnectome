%% ¡header!
ImporterGroupSubjectNeuroimaging_NIfTI < Importer (im, importer of neuroimaging subject group from NIfTI) imports a group of subjects with image data from a series of NIfTI files.

%%% ¡description!
ImporterGroupSubjectNeuroimaging_NIfTI imports the directory to a group of subjects NIfTI files 
 in a folder. All these files must be in the same folder; also, no other files 
 should be in the folder. Each file contains a 3D brain volume matrix.
The variables of interest are from another XLS/XLSX file named "SUVR_GROUP_MAT.vois.xlsx" 
 (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectCON, ExporterGroupSubjectCON_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject image group importer for NIfTI.
%%%% ¡default!
'ImporterGroupSubjectNeuroimaging_NIfTI'

%%% ¡prop!
NAME (constant, string) is the name of the subject image group importer for NIfTI.
%%%% ¡default!
'Subject Neuroimaging Importer for NIfTI file'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject image importer for NIfTI.
%%%% ¡default!
'ImporterGroupSubjectNeuroimaging_NIfTI imports a group of subjects with image data from a series of NIfTI file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject image importer for NIfTI.
%%%% ¡settings!
'ImporterGroupSubjectNeuroimaging_NIfTI'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject image importer for NIfTI.
%%%% ¡default!
'ImporterGroupSubjectNeuroimaging_NIfTI ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of subject image importer for NIfTI.
%%%% ¡default!
'ImporterGroupSubjectNeuroimaging_NIfTI label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about subject image importer for NIfTI.
%%%% ¡default!
'ImporterGroupSubjectNeuroimaging_NIfTI notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the NIfTI subject group files from which to load the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
SESSION (data, string) is the session contained in the BIDS folder.
%%%% ¡default!
'ses-01'

%%% ¡prop!
MODALITY (data, string) is the modality contained in the BIDS folder.
%%%% ¡default!
'anat'

%%% ¡prop!
TARGET (data, string) is the target contained in the BIDS folder.
%%%% ¡default!
'FDG'

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the NIfTI files of the subject group.
%%%% ¡settings!
'ImporterGroupSubjectNeuroimaging_NIfTI'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    im.set('DIRECTORY', directory);
end
value = im;

%%% ¡prop!
GR (result, item) is a group of subjects with NIfTI image data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectNeuroimaging', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectNeuroimaging', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNeuroimaging'))
%%%% ¡calculate!

% Creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectNeuroimaging', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNeuroimaging') ...
    );

gr.lock('SUB_CLASS');

directory = im.get('DIRECTORY');
session = im.get('SESSION');      % e.g. 'ses-01', can be empty
modality = im.get('MODALITY');    % e.g. 'pet' or 'anat'
target = im.get('TARGET');        % e.g. 'FDG', mainly for pet

if isfolder(directory)

    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');

    [~, gr_name] = fileparts(directory);
    gr.set( ...
        'ID', gr_name, ...
        'LABEL', gr_name, ...
        'NOTES', ['Group loaded from ' directory] ...
        );

    try

        braph2waitbar(wb, 0.05, 'Scanning subject folders ...')

        % Find subject folders: sub-*
        sub_folders = dir(fullfile(directory, 'sub-*'));
        sub_folders = sub_folders([sub_folders.isdir]);

        if isempty(sub_folders)
            warning('No sub-* folders found in %s.', directory);
        end

        sub_dict = gr.memorize('SUB_DICT');

        for s = 1:numel(sub_folders)

            braph2waitbar( ...
                wb, ...
                .05 + .55 * s / max(numel(sub_folders), 1), ...
                ['Loading subject folder ' num2str(s) ' of ' num2str(numel(sub_folders)) ' ...'] ...
                )

            sub_id = sub_folders(s).name;
            sub_root = fullfile(sub_folders(s).folder, sub_folders(s).name);

            %% Resolve session folder

            if ~isempty(session)

                ses_dir = fullfile(sub_root, session);

                if ~isfolder(ses_dir)
                    warning('%s does not contain session folder %s. Skipping.', sub_id, session);
                    continue;
                end

            else

                ses_candidates = dir(fullfile(sub_root, 'ses-*'));
                ses_candidates = ses_candidates([ses_candidates.isdir]);

                if isempty(ses_candidates)
                    % Allow no-session layout
                    ses_dir = sub_root;
                else
                    % Default: first session found
                    ses_dir = fullfile(ses_candidates(1).folder, ses_candidates(1).name);
                end
            end

            %% Resolve modality folder

            modality_dir = fullfile(ses_dir, modality);

            if ~isfolder(modality_dir)
                warning('%s does not contain modality folder %s. Skipping.', sub_id, modality);
                continue;
            end

            %% Find NIfTI files

            nii_files = [ ...
                dir(fullfile(modality_dir, '*.nii')); ...
                dir(fullfile(modality_dir, '*.nii.gz')) ...
                ];

            if isempty(nii_files)
                warning('%s does not contain any NIfTI files in %s. Skipping.', sub_id, modality_dir);
                continue;
            end

            %% Target-specific file selection

            chosen_file = [];

            if ~isempty(target)

                nii_names = {nii_files.name};
                match_idx = find(contains(upper(nii_names), upper(target)), 1, 'first');

                if ~isempty(match_idx)
                    chosen_file = nii_files(match_idx);
                else
                    warning( ...
                        '%s: no NIfTI file matched target %s in %s. Using first NIfTI found.', ...
                        sub_id, ...
                        target, ...
                        modality_dir ...
                        );
                end
            end

            % Fallback: first NIfTI found
            if isempty(chosen_file)
                chosen_file = nii_files(1);
            end

            chosen_path = fullfile(chosen_file.folder, chosen_file.name);

            %% Convert absolute path to BASE_DIR + RELATIVE_NIFTI_PATH

            % The base directory is the root directory being imported.
            % This should normally be the BIDS-like dataset/group folder,
            % i.e. the level above sub-* folders.
            base_dir = directory;

            % Store the selected NIfTI file as a path relative to base_dir.
            relative_nifti_path = chosen_path;

            if startsWith(chosen_path, [base_dir filesep])
                relative_nifti_path = extractAfter(chosen_path, length(base_dir) + 1);
            elseif strcmp(chosen_path, base_dir)
                relative_nifti_path = '';
            else
                warning( ...
                    '%s: chosen NIfTI path is not inside BASE_DIR. Storing absolute path as RELATIVE_NIFTI_PATH.', ...
                    sub_id ...
                    );
            end

            relative_nifti_path = char(relative_nifti_path);

            %% Build subject

            sub = SubjectNeuroimaging();

            sub.set('ID', sub_id);
            sub.set('LABEL', sub_id);
            sub.set('NOTES', ['NIfTI file loaded from ' modality_dir]);
            sub.set('BASE_DIR', base_dir);
            sub.set('RELATIVE_NIFTI_PATH', relative_nifti_path);

            sub_dict.get('ADD', sub);
        end

        %% Load variables of interest

        vois = [];

        if isfile(fullfile(directory, 'reference_data', ['group_' modality '.vois.xls']))
            [~, ~, vois] = xlsread(fullfile(directory, 'reference_data', ['group_' modality '.vois.xls']));

        elseif isfile(fullfile(directory, 'reference_data', ['group_' modality '.vois.xlsx']))
            [~, ~, vois] = xlsread(fullfile(directory, 'reference_data', ['group_' modality '.vois.xlsx']));

        elseif isfile([directory '.vois.xls'])
            [~, ~, vois] = xlsread([directory '.vois.xls']);

        elseif isfile([directory '.vois.xlsx'])
            [~, ~, vois] = xlsread([directory '.vois.xlsx']);
        end

        if ~isempty(vois)

            for i = 2:size(vois, 1)

                braph2waitbar( ...
                    wb, ...
                    .6 + .35 * (i - 1) / max(size(vois, 1) - 1, 1), ...
                    ['Loading VOIs of subject ' num2str(i - 1) ' of ' num2str(size(vois, 1) - 1) ' ...'] ...
                    )

                target_id = vois{i, 1};

                if isempty(target_id)
                    warning('Empty subject ID found in VOI row %d. Skipping.', i);
                    continue;
                end

                if isstring(target_id)
                    target_id = char(target_id);
                end

                if isnumeric(target_id)
                    target_id = num2str(target_id);
                end

                IT_LIST = sub_dict.get('IT_LIST');
                sub_idx = [];

                for j = 1:length(IT_LIST)

                    current_id = IT_LIST{j}.get('ID');

                    if strcmp(current_id, target_id)
                        sub_idx = j;
                        break;
                    end
                end

                if isempty(sub_idx)
                    warning('Subject ID %s from VOIs not found in loaded subjects. Skipping VOIs for this row.', target_id);
                    continue;
                end

                sub = sub_dict.get('IT', sub_idx);

                for v = 2:size(vois, 2)

                    voi_id = vois{1, v};

                    if isempty(voi_id)
                        continue;
                    end

                    if isstring(voi_id)
                        voi_id = char(voi_id);
                    end

                    if isnumeric(voi_id)
                        voi_id = num2str(voi_id);
                    end

                    voi_value = vois{i, v};

                    if isempty(voi_value)
                        continue;
                    end

                    %% Numeric VOI

                    if isnumeric(voi_value) && isscalar(voi_value) && ~isnan(voi_value)

                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOINumeric( ...
                            'ID', voi_id, ...
                            'V', voi_value ...
                            ) ...
                            );

                    %% Categoric VOI

                    elseif ischar(voi_value) || isstring(voi_value)

                        voi_value = char(voi_value);

                        categories = {};

                        if size(vois, 1) >= 2 && (ischar(vois{2, v}) || isstring(vois{2, v}))
                            categories = str2cell(char(vois{2, v}));
                        end

                        if ~isempty(categories)

                            category_index = find(strcmp(voi_value, categories), 1, 'first');

                            if isempty(category_index)
                                warning( ...
                                    'Value %s for VOI %s in subject %s is not listed in categories. Skipping.', ...
                                    voi_value, ...
                                    voi_id, ...
                                    target_id ...
                                    );
                                continue;
                            end

                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOICategoric( ...
                                'ID', voi_id, ...
                                'CATEGORIES', categories, ...
                                'V', category_index ...
                                ) ...
                                );
                        end
                    end
                end
            end
        end

    catch e

        braph2waitbar(wb, 'close')
        rethrow(e)
    end

    braph2waitbar(wb, 'close')

else
    error( ...
        ['BRAPH2' ':ImporterGroupSubjectNIfTI:' 'ErrorIO'], ...
        ['BRAPH2' ':ImporterGroupSubjectNIfTI:' 'ErrorIO' '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_NIfTI_GMProb(); % only creates files if the example folder doesn't already exist
create_data_NIfTI_WMProb(); % only creates files if the example folder doesn't already exist
create_data_NIfTI_PET(); % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('ImporterGroupSubjectNeuroimaging_NIfTI')), 'Example data NIfTI');
im_gr = ImporterGroupSubjectNeuroimaging_NIfTI('DIRECTORY', example_data_dir, ...
	    'MODALITY', 'anat', ...
        'TARGET', 'GMprob', ...
	    'WAITBAR', true);
gr = im_gr.get('GR');
gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
Sanity check - file number for anatomical gray matter probability data
%%%% ¡probability!
.01
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('ImporterGroupSubjectNeuroimaging_NIfTI')), 'Example data NIfTI');

im_gr = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', example_data_dir, ...
    'MODALITY', 'anat', ...
    'TARGET', 'GMprob', ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');
sub_num = gr.get('SUB_DICT').get('LENGTH');

assert(isequal(sub_num, 10), ...
    'The imported group should contain 10 subjects, which is the default number in the simulated data.')

sub_nifti_file = gr.get('SUB_DICT').get('IT', 1).get('ABSOLUTE_NIFTI_PATH');

assert(contains(sub_nifti_file, 'GMprob'), ...
    'The imported anatomical file should contain "GMprob" in the file path.')

assert(isfile(sub_nifti_file), ...
    'The imported GM probability NIfTI file does not exist.')


%%% ¡test!
%%%% ¡name!
Sanity check - file number for anatomical white matter probability data
%%%% ¡probability!
.01
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('ImporterGroupSubjectNeuroimaging_NIfTI')), 'Example data NIfTI');

im_gr = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', example_data_dir, ...
    'MODALITY', 'anat', ...
    'TARGET', 'WMprob', ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');
sub_num = gr.get('SUB_DICT').get('LENGTH');

assert(isequal(sub_num, 10), ...
    'The imported group should contain 10 subjects, which is the default number in the simulated data.')

sub_nifti_file = gr.get('SUB_DICT').get('IT', 1).get('ABSOLUTE_NIFTI_PATH');

assert(contains(sub_nifti_file, 'WMprob'), ...
    'The imported anatomical file should contain "WMprob" in the file path.')

assert(isfile(sub_nifti_file), ...
    'The imported WM probability NIfTI file does not exist.')


%%% ¡test!
%%%% ¡name!
Sanity check - file number for PET data
%%%% ¡probability!
.01
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('ImporterGroupSubjectNeuroimaging_NIfTI')), 'Example data NIfTI');

im_gr = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', example_data_dir, ...
    'MODALITY', 'pet', ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');
sub_num = gr.get('SUB_DICT').get('LENGTH');

assert(isequal(sub_num, 10), ...
    'The imported group should contain 10 subjects, which is the default number in the simulated data.')

sub_nifti_file = gr.get('SUB_DICT').get('IT', 1).get('ABSOLUTE_NIFTI_PATH');

assert(contains(sub_nifti_file, '_pet.nii'), ...
    'The imported PET file should contain "_pet.nii" in the file path.')

assert(isfile(sub_nifti_file), ...
    'The imported PET NIfTI file does not exist.')
