%% ¡header!
ImporterGroupSubjNifti < Importer (im, importer of SUVR subject group from .mat) imports a group of subjects with image data from a series of Nifti files.

%%% ¡description!
Importer_Image_Nifti imports the directory to a group of subjects Nifti files 
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
ELCLASS (constant, string) is the class of the subject image group importer for Nifti.
%%%% ¡default!
'ImporterGroupSubjNifti'

%%% ¡prop!
NAME (constant, string) is the name of the subject image group importer for Nifti.
%%%% ¡default!
'Subject Nifti Image Importer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject image importer for Nifti.
%%%% ¡default!
'ImporterGroupSubjNifti imports a group of subjects with image data from a series of Nifti file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject image importer for Nifti.
%%%% ¡settings!
'ImporterGroupSubjNifti'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject image importer for Nifti.
%%%% ¡default!
'ImporterGroupSubjNifti ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of subject image importer for Nifti.
%%%% ¡default!
'ImporterGroupSubjNifti label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about subject image importer for Nifti.
%%%% ¡default!
'ImporterGroupSubjNifti notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the Nifti subject group files from which to load the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
NIFTI_TYPE (data, stringlist) describes the including modality types of each Nifti file for single subject.
%%%% ¡default!
{'GM', 'WM', 'PET'}

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the Nifti files of the subject group.
%%%% ¡settings!
'ImporterGroupSubjNifti'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    im.set('DIRECTORY', directory);
end
value = im;

%%% ¡prop!
GR (result, item) is a group of subjects with Nifti image data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectNifti', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectNifti', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNifti'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectNifti', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNifti') ...
    );

gr.lock('SUB_CLASS');

directory = im.get('DIRECTORY');
Niftitype = im.get('NIFTI_TYPE');
if isfolder(directory)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
    [~, gr_name] = fileparts(directory);
    gr.set( ...
        'ID', gr_name, ...
        'LABEL', gr_name, ...
        'NOTES', ['Group loaded from ' directory] ...
        );

    try
        braph2waitbar(wb, .15, 'Loading subject group ...')
        
        % analyzes file
        files = [dir(fullfile(directory))];
        files = files(~(ismember({files.name},'.') | ismember({files.name},'..')));
        files = files([files.isdir]);
        if ~isempty(files)
            % adds subjects
            sub_dict = gr.memorize('SUB_DICT');
            for i = 1:1:length(files)
                braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading subject directory' num2str(i) ' of ' num2str(length(files)) ' ...'])
                sub_id = files(i).name;
                subject_nifty_folder = [files(i).folder filesep files(i).name];
                subject_nifty_file = dir(fullfile(subject_nifty_folder, '*.nii'));
                subject_nifty_full_path = strcat(subject_nifty_file(1).folder, filesep,{subject_nifty_file.name});
                sub = SubjectNifti( ...
                    'ID', sub_id);
                hasMatch  = false;
                for f = 1:length(subject_nifty_full_path)
                    % Initialize an empty logical array to store matching results
                    isMatch = false(1, length(Niftitype));

                    % Loop through each element of the Niftitype array to check for substring match
                    for i = 1:length(Niftitype)
                        if contains(subject_nifty_full_path{f}, Niftitype{i}) % Check if current path contains any of Niftitype elements
                            isMatch(i) = true;
                        end
                    end

                    % Get the index of the matching element(s)
                    matchingIndex = find(isMatch);

                    if ~isempty(matchingIndex) % If there's at least one match
                        % Use the first match found in Niftitype
                        file_id = convertStringsToChars(Niftitype{matchingIndex(1)});

                        % Add the file path to the subject's nifty dictionary
                        sub.memorize('NIFTI_PATH_DICT').get('ADD', FILE_PATH('ID', file_id, 'PATH', convertStringsToChars(subject_nifty_full_path{f})));

                        % Mark that at least one match was found for this subject
                        hasMatch = true;
                    end
                end

                % After looping through all file paths, check if no matches were found
                if ~hasMatch
                    % Raise a warning if no NIFTI type was found for the subject
                    warning(sprintf([sub_id, ' does not have the required type of data, skip']));
                    return;
                end
                sub_dict.get('ADD', sub);
            end
        end

        % variables of interest
        vois = [];
        if isfile([directory '.vois.xls'])
            [~, ~, vois] = xlsread([directory '.vois.xls']);
        elseif isfile([directory '.vois.xlsx'])
            [~, ~, vois] = xlsread([directory '.vois.xlsx']);
        end
        if ~isempty(vois)
            for i = 3:1:size(vois, 1)
                % Extract the subject ID string from the 'vois' data
                target_id = vois{i, 1};

                % Get the IT_LIST from sub_dict
                IT_LIST = sub_dict.get('IT_LIST');

                % Initialize sub_id as empty
                sub_id = [];

                % Iterate over IT_LIST to find the matching ID
                for j = 1:length(IT_LIST)
                    subject_nifti = IT_LIST{j}; % Get the SubjectNifti object
                    current_id = subject_nifti.get('ID'); % Extract the 'ID' property
                    if strcmp(current_id, target_id)
                        sub_id = j; % Store the index if IDs match
                        break; % Exit the loop as we found the subject
                    end
                end

                % Check if sub_id was found
                if isempty(sub_id)
                    error('BRAPH2:MyElement:SubjectNotFound', 'Subject ID %s not found in sub_dict.', target_id);
                end

                % Retrieve the subject from sub_dict using the matched index
                sub = sub_dict.get('IT', sub_id);

                % Iterate over VOIs for this subject
                for v = 2:1:size(vois, 2)
                    voi_id = vois{1, v};
                    if isnumeric(vois{2, v}) % VOINumeric
                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOINumeric( ...
                            'ID', voi_id, ...
                            'V', vois{i, v} ...
                            ) ...
                            );
                    elseif ischar(vois{2, v}) % VOICategoric
                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOICategoric( ...
                            'ID', voi_id, ...
                            'CATEGORIES', str2cell(vois{2, v}), ...
                            'V', find(strcmp(vois{i, v}, str2cell(vois{2, v}))) ...
                            ) ...
                            );
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
    error([BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectCON_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
% Create example files
% %%%% ¡code!
% create_data_CON_XLS() % only creates files if the example folder doesn't already exist
% 
% %%% ¡test!
% %%%% ¡name!
% GUI
% %%%% ¡probability!
% .01
% %%%% ¡code!
% ba = BrainAtlas();
% 
% im_gr = ImporterGroupSubjNifti( ...
%     'DIRECTORY', [fileparts(which('group_data')) filesep 'Example data CON XLS' filesep 'CON_Group_1_XLS'], ...
%     'WAITBAR', true ...
%     );
% 
% gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')
% 
% gui.get('CLOSE')