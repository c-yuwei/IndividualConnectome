close all; delete(findall(0, 'type', 'figure')); clear all
directory = '.';
braph2genesis_directory = [directory filesep() 'braph2genesis'];

%% Copy pipeline folders into braph2genesis/pipelines
pipeline_folders = {
    'neuroimaging conversion structural'
    'neuroimaging conversion PDFs'
    };

for i = 1:1:numel(pipeline_folders)
    pipeline_folder = pipeline_folders{i};
    target_folder = fullfile(braph2genesis_directory, 'pipelines', pipeline_folder);

    fprintf(['Copying pipeline "' pipeline_folder '" to "' target_folder '"\n']);
    copyfile([directory filesep() pipeline_folder], target_folder);
end

disp(' ')

%% compile elements from the standard distribution (no unit test needed)
% el_path = [filesep 'pipelines' filesep 'structural']
% el_class_list = {'ImporterGroupSubjectST_XLS' 'ExporterGroupSubjectST_XLS'}
el_path = [filesep 'neuralnetworks']
el_class_list = {'NNClassifierMLP_EvaluatorPF_ROC'}
add_elclasses_to_concreteelement(el_class_list)
update_parent_subclasses_from_elclass_list(el_class_list, el_path)
regenerate(el_path, el_class_list, 'UnitTest', false)
update_parent_subclasses_from_elclass_list(el_class_list, el_path)
clear subclasses % clear the persisten cache so to update the subclasses list

%%
el_path = [filesep 'pipelines' filesep pipeline_folders{1}]
el_class_list = {'ConverterNeuroimaging2RegionalValues'}
add_elclasses_to_concreteelement(el_class_list)
update_parent_subclasses_from_elclass_list(el_class_list, el_path)

regenerate(el_path, el_class_list, 'UnitTest', true)

%%
el_path = [filesep 'pipelines' filesep pipeline_folders{2}]
el_class_list = {'ConverterNeuroimaging2PDFs'}
add_elclasses_to_concreteelement(el_class_list)
update_parent_subclasses_from_elclass_list(el_class_list, el_path)

regenerate(el_path, el_class_list, 'UnitTest', true)

%% helper function
function add_elclasses_to_concreteelement(el_class_list, concrete_element_file)
%ADD_ELCLASSES_TO_CONCRETEELEMENT Adds element classes to ConcreteElement.getSubclasses().
%
% add_elclasses_to_concreteelement(el_class_list)
% add_elclasses_to_concreteelement(el_class_list, concrete_element_file)
%
% Example:
%   el_class_list = {'NNDataPoint_Tabular'};
%   add_elclasses_to_concreteelement(el_class_list)
%
%   el_class_list = {'NNDataPoint_Tabular', 'NNDatasetProcess_Tabular'};
%   add_elclasses_to_concreteelement(el_class_list)

    if nargin < 2 || isempty(concrete_element_file)
        concrete_element_file = fullfile('braph2individualconnectome', 'src', 'ds', 'ConcreteElement.m');
    end

    if ischar(el_class_list) || isstring(el_class_list)
        el_class_list = cellstr(el_class_list);
    end

    if ~iscellstr(el_class_list)
        error('el_class_list must be a char, string, or cell array of character vectors.')
    end

    if ~isfile(concrete_element_file)
        error('File not found: %s', concrete_element_file)
    end

    txt = fileread(concrete_element_file);

    % Match the subclass_list assignment.
    pattern = 'subclass_list\s*=\s*\{(?<classes>.*?)\};\s*%CET: Computational Efficiency Trick';
    match = regexp(txt, pattern, 'names', 'once');

    if isempty(match)
        error('Could not find the subclass_list assignment in %s.', concrete_element_file)
    end

    % Extract current subclasses.
    class_tokens = regexp(match.classes, '''([^'']+)''', 'tokens');
    subclass_list = cellfun(@(c) c{1}, class_tokens, 'UniformOutput', false);

    % Add new element classes if missing.
    added_list = {};
    for i = 1:numel(el_class_list)
        el_class = strtrim(el_class_list{i});

        if isempty(el_class)
            continue
        end

        if any(strcmp(subclass_list, el_class))
            fprintf('%s is already listed in ConcreteElement.getSubclasses().\n', el_class);
            continue
        end

        subclass_list = insert_elclass(subclass_list, el_class);
        added_list{end + 1} = el_class; %#ok<AGROW>
    end

    if isempty(added_list)
        fprintf('No changes made to %s.\n', concrete_element_file);
        return
    end

    % Rebuild the subclass_list line in BRAPH 2 compact style.
    new_class_block = strjoin( ...
        cellfun(@(c) ['''' c ''''], subclass_list, 'UniformOutput', false), ...
        '  ' ...
        );

    new_subclass_assignment = ...
        ['subclass_list = { ' new_class_block ' }; %CET: Computational Efficiency Trick'];

    % Replace old subclass_list assignment.
    old_assignment_pattern = ...
        'subclass_list\s*=\s*\{.*?\};\s*%CET: Computational Efficiency Trick';

    txt_new = regexprep(txt, old_assignment_pattern, new_subclass_assignment, 'once');

    % Write updated file.
    fid = fopen(concrete_element_file, 'w');

    if fid == -1
        error('Could not open %s for writing.', concrete_element_file)
    end

    cleanup = onCleanup(@() fclose(fid));
    fprintf(fid, '%s', txt_new);

    fprintf('Updated %s.\n', concrete_element_file);
    fprintf('Added: %s\n', strjoin(added_list, ', '));
end

function subclass_list = insert_elclass(subclass_list, el_class)
%INSERT_ELCLASS Inserts new element class in a sensible location.

    % Preferred anchors for common BRAPH 2 class families.
    if startsWith(el_class, 'NNDataPoint_')
        anchor = 'NNDataPoint_Image';
    elseif startsWith(el_class, 'NNDataset')
        anchor = 'NNDatasetProcess_MNIST';
    elseif startsWith(el_class, 'NNVariationalAutoencoder')
        anchor = 'NNVariationalAutoencoder';
    else
        anchor = 'ConcreteElement';
    end

    idx = find(strcmp(subclass_list, anchor), 1, 'last');

    if isempty(idx)
        idx = 1;
    end

    subclass_list = [subclass_list(1:idx), {el_class}, subclass_list(idx+1:end)];
end

function update_parent_subclasses_from_elclass_list(el_class_list, el_path)
%UPDATE_PARENT_SUBCLASSES_FROM_ELCLASS_LIST Updates parent getSubclasses() for Genesis elements.
%
% This function:
%   1. Finds the Genesis description file for each element class.
%   2. Optionally restricts the search to a path fragment, e.g.
%      [filesep 'pipelines' filesep pipeline_folders{1}]
%   3. Reads the header to identify the parent class.
%   4. Locates the compiled parent .m file automatically using WHICH.
%   5. Updates the parent's getSubclasses() if the new class is missing.
%
% Examples:
%   el_class_list = {'NNDataPoint_Tabular' 'NNDatasetProcess_Tabular'};
%   update_parent_subclasses_from_elclass_list(el_class_list)
%
%   el_path = [filesep 'pipelines' filesep pipeline_folders{1}];
%   update_parent_subclasses_from_elclass_list(el_class_list, el_path)

    if nargin < 2
        el_path = '';
    end

    if ischar(el_class_list) || isstring(el_class_list)
        el_class_list = cellstr(el_class_list);
    end

    if ~iscellstr(el_class_list)
        error('el_class_list must be a char, string, or cell array of character vectors.')
    end

    for i = 1:numel(el_class_list)
        el_class = strtrim(el_class_list{i});

        if isempty(el_class)
            continue
        end

        fprintf('\nUpdating subclass registration for %s...\n', el_class);

        gen_file = find_genesis_file_from_path_or_pwd(el_class, el_path);

        if isempty(gen_file)
            warning('Could not find Genesis description file for %s. Skipping.', el_class)
            continue
        end

        gen_txt = fileread(gen_file);
        [parsed_el_class, parent_class] = parse_genesis_header(gen_txt);

        if ~strcmp(parsed_el_class, el_class)
            warning( ...
                'Requested class %s, but Genesis header defines %s. Using header value.', ...
                el_class, parsed_el_class ...
                )
            el_class = parsed_el_class;
        end

        parent_file = which([parent_class '.m']);

        if isempty(parent_file)
            warning( ...
                'Could not locate compiled parent class file %s.m using MATLAB path. Skipping %s.', ...
                parent_class, el_class ...
                )
            continue
        end

        fprintf('Genesis file: %s\n', gen_file);
        fprintf('Parent class: %s\n', parent_class);
        fprintf('Parent file:  %s\n', parent_file);

        update_getsubclasses_in_file(parent_file, parent_class, el_class);
    end
end

function gen_file = find_genesis_file_from_path_or_pwd(el_class, el_path)
%FIND_GENESIS_FILE_FROM_PATH_OR_PWD Finds the Genesis file for el_class.
%
% Search order:
%   1. MATLAB path using WHICH.
%   2. Current working directory recursively.
%
% If el_path is provided, only files whose full path contains el_path are used.
%
% Example el_path:
%   [filesep 'pipelines' filesep pipeline_folders{1}]

    if nargin < 2
        el_path = '';
    end

    candidates = {
        ['_' el_class '.gen.m']
        [el_class '.gen.m']
        };

    gen_file = '';

    matching_files = {};

    % 1. Try MATLAB path.
    for i = 1:numel(candidates)
        f = which(candidates{i});

        if ~isempty(f) && path_matches_el_path(f, el_path)
            matching_files{end + 1} = f; %#ok<AGROW>
        end
    end

    % 2. Try recursive search from current folder.
    for i = 1:numel(candidates)
        files = dir(fullfile(pwd, '**', candidates{i}));

        for j = 1:numel(files)
            f = fullfile(files(j).folder, files(j).name);

            if path_matches_el_path(f, el_path)
                matching_files{end + 1} = f; %#ok<AGROW>
            end
        end
    end

    % Remove duplicates while preserving order.
    matching_files = unique(matching_files, 'stable');

    if isempty(matching_files)
        return
    end

    if numel(matching_files) > 1
        warning('Multiple Genesis files found for %s after filtering. Using first:', el_class)

        for i = 1:numel(matching_files)
            fprintf('  %s\n', matching_files{i});
        end
    end

    gen_file = matching_files{1};
end

function tf = path_matches_el_path(file_path, el_path)
%PATH_MATCHES_EL_PATH Checks whether file_path matches the optional path filter.

if isempty(el_path)
    tf = true;
    return
end

% Normalise separators for safer matching.
file_path_norm = strrep(file_path, filesep, '/');
el_path_norm = strrep(el_path, filesep, '/');

tf = contains(file_path_norm, el_path_norm);
end

function [el_class, parent_class] = parse_genesis_header(gen_txt)
%PARSE_GENESIS_HEADER Extracts child and parent class from Genesis header.
%
% Expected:
%   %% ¡header!
%   NNDataPoint_Tabular < NNDataPoint (...) is ...

    pattern = ...
        '%%\s*¡header!\s*(?<el_class>[A-Za-z]\w*)\s*<\s*(?<parent_class>[A-Za-z]\w*)';

    match = regexp(gen_txt, pattern, 'names', 'once');

    if isempty(match)
        error(['Could not parse Genesis header. Expected format:' newline ...
               '%% ¡header!' newline ...
               'ChildClass < ParentClass (...) is ...'])
    end

    el_class = match.el_class;
    parent_class = match.parent_class;
end

function update_getsubclasses_in_file(parent_file, parent_class, child_class)
%UPDATE_GETSUBCLASSES_IN_FILE Adds child_class to parent_class.getSubclasses().

    txt = fileread(parent_file);

    pattern = ...
        'subclass_list\s*=\s*\{(?<classes>.*?)\};\s*%CET:\s*Computational Efficiency Trick';

    match = regexp(txt, pattern, 'names', 'once');

    if isempty(match)
        warning('Could not find subclass_list assignment in %s. Skipping.', parent_file)
        return
    end

    class_tokens = regexp(match.classes, '''([^'']+)''', 'tokens');
    subclass_list = cellfun(@(c) c{1}, class_tokens, 'UniformOutput', false);

    if any(strcmp(subclass_list, child_class))
        fprintf('%s is already listed in %s.getSubclasses(). No change made.\n', ...
            child_class, parent_class);
        return
    end

    insert_idx = choose_insert_position(subclass_list, parent_class, child_class);

    subclass_list = [ ...
        subclass_list(1:insert_idx), ...
        {child_class}, ...
        subclass_list(insert_idx + 1:end) ...
        ];

    class_block = strjoin( ...
        cellfun(@(c) ['''' c ''''], subclass_list, 'UniformOutput', false), ...
        '  ' ...
        );

    new_assignment = ...
        ['subclass_list = { ' class_block ' }; %CET: Computational Efficiency Trick'];

    txt_new = regexprep( ...
        txt, ...
        'subclass_list\s*=\s*\{.*?\};\s*%CET:\s*Computational Efficiency Trick', ...
        new_assignment, ...
        'once' ...
        );

    fid = fopen(parent_file, 'w');

    if fid == -1
        error('Could not open file for writing: %s', parent_file)
    end

    cleanup = onCleanup(@() fclose(fid));
    fprintf(fid, '%s', txt_new);

    fprintf('Added %s to %s.getSubclasses().\n', child_class, parent_class);
end

function insert_idx = choose_insert_position(subclass_list, parent_class, child_class)
%CHOOSE_INSERT_POSITION Chooses insertion location in subclass_list.

    underscore_idx = strfind(child_class, '_');

    if ~isempty(underscore_idx)
        family_prefix = child_class(1:underscore_idx(1));

        family_matches = startsWith(subclass_list, family_prefix);
        idx = find(family_matches, 1, 'last');

        if ~isempty(idx)
            insert_idx = idx;
            return
        end
    end

    idx = find(strcmp(subclass_list, parent_class), 1, 'last');

    if ~isempty(idx)
        insert_idx = idx;
    else
        insert_idx = numel(subclass_list);
    end
end
