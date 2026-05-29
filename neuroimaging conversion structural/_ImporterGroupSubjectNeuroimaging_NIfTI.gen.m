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
% creates empty Group
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
            braph2waitbar(wb, .05 + .55 * s / max(numel(sub_folders), 1), ['Loading subject folder ' num2str(s) ' of ' num2str(numel(sub_folders)) ' ...'])

            sub_id = sub_folders(s).name;
            sub_root = fullfile(sub_folders(s).folder, sub_folders(s).name);

            % Resolve session folder
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
                    % allow no-session layout
                    ses_dir = sub_root;
                else
                    % default: first session found
                    ses_dir = fullfile(ses_candidates(1).folder, ses_candidates(1).name);
                end
            end

            % Resolve modality folder
            modality_dir = fullfile(ses_dir, modality);
            if ~isfolder(modality_dir)
                warning('%s does not contain modality folder %s. Skipping.', sub_id, modality);
                continue;
            end

            % Find NIfTI files
            nii_files = [ ...
                dir(fullfile(modality_dir, '*.nii')); ...
                dir(fullfile(modality_dir, '*.nii.gz')) ...
                ];

            if isempty(nii_files)
                warning('%s does not contain any NIfTI files in %s. Skipping.', sub_id, modality_dir);
                continue;
            end

            % PET-specific target selection
            chosen_file = [];
            if strcmpi(modality, 'pet') && ~isempty(target)
                match_idx = find(contains(upper({nii_files.name}), upper(target)), 1, 'first');
                if ~isempty(match_idx)
                    chosen_file = nii_files(match_idx);
                else
                    warning('%s: no PET file matched tracer %s in %s. Using first NIfTI found.', ...
                        sub_id, target, modality_dir);
                end
            end

            % Fallback: first NIfTI found
            if isempty(chosen_file)
                chosen_file = nii_files(1);
            end

            chosen_path = fullfile(chosen_file.folder, chosen_file.name);

            % Build subject
            sub = SubjectNeuroimaging();

            % Save chosen file into NIfTI_PATH_DICT
            % Use modality or modality+tracer as file ID
            if strcmpi(modality, 'pet') && ~isempty(target)
                file_id = [upper(modality) '_' upper(target)];
            else
                file_id = upper(modality);
            end

            % % % % sub.memorize('NIfTI_PATH_DICT').get('ADD', ...
            % % % %     FILE_PATH( ...
            % % % %         'ID', file_id, ...
            % % % %         'PATH', chosen_path ...
            % % % %         ) ...
            % % % %     );

            % Optional notes on subject
            sub.set('LABEL', sub_id);
            sub.set('NOTES', ['Loaded from ' modality_dir]);

            sub_dict.get('ADD', sub);
        end

        % Load variables of interest
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
                braph2waitbar(wb, .6 + .35 * (i-1) / max(size(vois, 1)-1, 1), ['Loading VOIs of subject ' num2str(i-1) ' of ' num2str(size(vois, 1)-1) ' ...'])

                target_id = vois{i, 1};

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

                    if isnumeric(vois{i, v})
                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOINumeric( ...
                                'ID', voi_id, ...
                                'V', vois{i, v} ...
                                ) ...
                            );
                    elseif ischar(vois{i, v}) || isstring(vois{i, v})
                        categories = {};
                        if ischar(vois{2, v}) || isstring(vois{2, v})
                            categories = str2cell(char(vois{2, v}));
                        end

                        if ~isempty(categories)
                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOICategoric( ...
                                    'ID', voi_id, ...
                                    'CATEGORIES', categories, ...
                                    'V', find(strcmp(char(vois{i, v}), categories), 1, 'first') ...
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
    error([BRAPH2.STR ':ImporterGroupSubjectNIfTI:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectNIfTI:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_example_NIfTI() % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('SUVRConstructor')), 'Example data NIfTI');
im_gr1 = ImporterGroupSubjectNeuroimaging_NIfTI('DIRECTORY',[example_data_dir filesep 'Group1'], ...
    'NIfTI_TYPE', {'T1'},...
    'WAITBAR', true);
gr = im_gr1.get('GR');
gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')
