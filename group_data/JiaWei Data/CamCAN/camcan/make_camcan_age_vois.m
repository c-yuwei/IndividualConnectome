%% make_camcan_age_vois.m
% Generate BRAPH-style VOIs Excel files for each CamCAN age-group folder.
%
% Expected folder structure:
%   ROOT_DIR/
%       age-18-30/sub-CCxxxxxx/
%       age-30-40/sub-CCxxxxxx/
%       age-40-50/sub-CCxxxxxx/
%       age-50-60/sub-CCxxxxxx/
%
% The script reads subject IDs from the sub-* folders, matches them to
% data_cell_pre.mat -> data_cell, and writes one VOI spreadsheet per age group.

clear; clc;

%% ===== USER SETTINGS =====
ROOT_DIR = '/home/hang/GitHub/IndividualConnectome-WithYuwei/group_data/JiaWei Data/CamCAN/camcan';
MAT_FILE = fullfile(ROOT_DIR, 'data_cell_pre.mat');  % edit if your .mat file is somewhere else

% Output file naming:
%   "group" -> age-50-60.vois.xlsx  (BRAPH-style name)
%   "plain" -> vois.xlsx            (literal name inside each age folder)
OUTPUT_NAME_MODE = "group";

% VOI columns to write:
%   "minimal"    -> SubjectID, Age, Sex, Education
%   "all_scalar" -> SubjectID plus all scalar variables in data_cell, excluding matrix columns
OUTPUT_MODE = "minimal";

% For minimal mode, display names in the Excel file and source column names in data_cell.
MINIMAL_DISPLAY_HEADERS = ["SubjectID", "Age", "Sex", "Education"];
MINIMAL_SOURCE_HEADERS  = ["ID",        "age", "sex", "edu"];

% Sex coding in data_cell_pre.mat: 1 = Male, 2 = Female.
SEX_CODE_1 = "Male";
SEX_CODE_2 = "Female";

%% ===== LOAD VOI DATA =====
S = load(MAT_FILE, 'data_cell');
data_cell = S.data_cell;
headers = strtrim(string(data_cell(1, :)));

id_col = find(strcmpi(headers, "ID"), 1);
if isempty(id_col)
    error('Could not find ID column in data_cell.');
end

all_ids = strings(size(data_cell, 1) - 1, 1);
for r = 2:size(data_cell, 1)
    all_ids(r - 1) = clean_subject_id(data_cell{r, id_col});
end

%% ===== CHOOSE VOI COLUMNS =====
switch lower(OUTPUT_MODE)
    case "minimal"
        display_headers = MINIMAL_DISPLAY_HEADERS;
        source_headers = MINIMAL_SOURCE_HEADERS;
        source_cols = zeros(1, numel(source_headers));
        for c = 1:numel(source_headers)
            source_cols(c) = find_header(headers, source_headers(c));
        end

    case "all_scalar"
        exclude_headers = ["iscn_bn", "volume_bn", "disn_bn", "jsdn_bn", "corn_bn"];
        scalar_cols = detect_scalar_columns(data_cell);
        scalar_cols = scalar_cols(~ismember(lower(headers(scalar_cols)), lower(exclude_headers)));
        source_cols = unique([id_col scalar_cols], 'stable');
        source_headers = headers(source_cols);
        display_headers = source_headers;
        display_headers(strcmpi(display_headers, "ID")) = "SubjectID";
        display_headers(strcmpi(display_headers, "age")) = "Age";
        display_headers(strcmpi(display_headers, "sex")) = "Sex";
        display_headers(strcmpi(display_headers, "edu")) = "Education";

    otherwise
        error('Unknown OUTPUT_MODE: %s. Use "minimal" or "all_scalar".', OUTPUT_MODE);
end

%% ===== LOOP THROUGH AGE FOLDERS =====
age_dirs = dir(fullfile(ROOT_DIR, 'age-*'));
age_dirs = age_dirs([age_dirs.isdir]);

if isempty(age_dirs)
    error('No age-* folders found under ROOT_DIR: %s', ROOT_DIR);
end

for a = 1:numel(age_dirs)
    age_name = string(age_dirs(a).name);
    age_dir = fullfile(ROOT_DIR, age_dirs(a).name);

    sub_dirs = dir(fullfile(age_dir, 'sub-*'));
    sub_dirs = sub_dirs([sub_dirs.isdir]);
    subject_ids = string({sub_dirs.name})';
    subject_ids = sort(subject_ids);

    fprintf('\n%s: found %d subject folders\n', age_name, numel(subject_ids));

    % Row 1 = VOI names. Row 2 = categorical levels for Sex, matching BRAPH examples.
    out = cell(numel(subject_ids) + 2, numel(display_headers));
    out(1, :) = cellstr(display_headers);
    out(2, :) = {[]};
    sex_display_col = find(strcmpi(display_headers, "Sex"), 1);
    if ~isempty(sex_display_col)
        out{2, sex_display_col} = sprintf('Female\nMale');
    end

    missing_subjects = strings(0, 1);

    for i = 1:numel(subject_ids)
        sid = subject_ids(i);
        match_idx = find(strcmp(all_ids, sid), 1);

        if isempty(match_idx)
            missing_subjects(end + 1, 1) = sid; %#ok<SAGROW>
            out{i + 2, 1} = char(sid);
            continue
        end

        data_row = match_idx + 1;  % +1 because row 1 in data_cell is headers

        for c = 1:numel(source_cols)
            source_header = source_headers(c);
            raw_value = data_cell{data_row, source_cols(c)};

            if strcmpi(source_header, "ID")
                out{i + 2, c} = char(sid);
            elseif strcmpi(source_header, "sex")
                out{i + 2, c} = convert_sex(raw_value, SEX_CODE_1, SEX_CODE_2);
            else
                out{i + 2, c} = to_excel_value(raw_value);
            end
        end
    end

    % Choose output name.
    switch lower(OUTPUT_NAME_MODE)
        case "group"
            out_file = fullfile(age_dir, char(age_name + ".vois.xlsx"));
        case "plain"
            out_file = fullfile(age_dir, 'vois.xlsx');
        otherwise
            error('Unknown OUTPUT_NAME_MODE: %s. Use "group" or "plain".', OUTPUT_NAME_MODE);
    end

    if isfile(out_file)
        delete(out_file);  % avoids stale cells if the new table is smaller than an old one
    end
    writecell(out, out_file, 'Sheet', 1);
    fprintf('  wrote: %s\n', out_file);

    % Save missing IDs, if any.
    missing_file = fullfile(age_dir, 'missing_subjects_for_vois.txt');
    if ~isempty(missing_subjects)
        writelines(missing_subjects, missing_file);
        warning('%s: %d subject(s) were not found in data_cell_pre.mat. See %s', ...
            age_name, numel(missing_subjects), missing_file);
    elseif isfile(missing_file)
        delete(missing_file);
    end
end

fprintf('\nDone.\n');

%% ===== HELPER FUNCTIONS =====
function idx = find_header(headers, target)
    idx = find(strcmpi(strtrim(headers), strtrim(string(target))), 1);
    if isempty(idx)
        error('Could not find required column "%s" in data_cell headers.', target);
    end
end

function sid = clean_subject_id(value)
    if iscell(value)
        value = value{1};
    end
    sid = strtrim(string(value));
end

function value = to_excel_value(raw_value)
    if iscell(raw_value)
        if isempty(raw_value)
            value = [];
            return
        end
        raw_value = raw_value{1};
    end

    if isempty(raw_value)
        value = [];
    elseif isnumeric(raw_value) || islogical(raw_value)
        if isscalar(raw_value)
            if isnan(double(raw_value))
                value = [];
            else
                value = raw_value;
            end
        else
            value = [];  % matrices are not VOI scalar values
        end
    elseif isstring(raw_value) || ischar(raw_value)
        s = strtrim(string(raw_value));
        if ismissing(s) || strlength(s) == 0
            value = [];
        else
            value = char(s);
        end
    else
        value = [];
    end
end

function sex_value = convert_sex(raw_value, code1_label, code2_label)
    value = to_excel_value(raw_value);
    if isempty(value)
        sex_value = [];
        return
    end

    if isnumeric(value) || islogical(value)
        if value == 1
            sex_value = char(code1_label);
        elseif value == 2
            sex_value = char(code2_label);
        else
            sex_value = value;
        end
    else
        s = string(value);
        if any(strcmpi(s, ["1", "male", "m"]))
            sex_value = char(code1_label);
        elseif any(strcmpi(s, ["2", "female", "f"]))
            sex_value = char(code2_label);
        else
            sex_value = char(s);
        end
    end
end

function scalar_cols = detect_scalar_columns(data_cell)
    n_cols = size(data_cell, 2);
    scalar_cols = [];
    for c = 2:n_cols  % skip ID here; it is added separately
        ok = true;
        has_any_value = false;
        for r = 2:size(data_cell, 1)
            v = data_cell{r, c};
            if iscell(v)
                if isempty(v)
                    continue
                end
                v = v{1};
            end
            if isempty(v)
                continue
            end
            if (isnumeric(v) || islogical(v)) && isscalar(v)
                if ~isnan(double(v))
                    has_any_value = true;
                end
            elseif (isstring(v) || ischar(v)) && isscalar(string(v))
                if strlength(strtrim(string(v))) > 0
                    has_any_value = true;
                end
            else
                ok = false;
                break
            end
        end
        if ok && has_any_value
            scalar_cols(end + 1) = c; %#ok<AGROW>
        end
    end
end
