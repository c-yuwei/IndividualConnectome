%% ¡header!
ConverterNeuroimaging2PDFs < ConcreteElement (cn, converter of neuroimaging data to PDFs) converts subject-level NIfTI neuroimaging data into regional probability density functions.

%%% ¡description!
ConverterNeuroimaging2PDFs converts subject-level NIfTI neuroimaging data into regional probability density functions using one or more atlas NIfTI files and atlas mapping files. It can optionally restrict voxel extraction with anatomical reference images, such as GM or WM probability maps, and can optionally normalize voxel values by reference brain regions before PDF calculation. The output is a group of SubjectFUN objects, where each subject contains a matrix whose rows are PDF bins and whose columns are converted brain regions.

%%% ¡seealso!
ConverterNeuroimaging2RegionalValues, Group, SubjectNeuroimaging, SubjectFUN, BrainAtlas, BrainRegion, ImporterGroupSubjectNeuroimaging_NIfTI, ExporterGroupSubjectFUN_XLS, ExporterBrainAtlasXLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the converter of neuroimaging data to PDFs.
%%%% ¡default!
'ConverterNeuroimaging2PDFs'

%%% ¡prop!
NAME (constant, string) is the name of the converter of neuroimaging data to PDFs.
%%%% ¡default!
'Neuroimaging-to-PDFs Converter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the converter of neuroimaging data to PDFs.
%%%% ¡default!
'ConverterNeuroimaging2PDFs converts subject-level NIfTI neuroimaging data into regional probability density functions using one or more atlas NIfTI files and atlas mapping files. It can optionally restrict voxel extraction with anatomical reference images and optionally normalize voxel values by reference brain regions before PDF calculation.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the converter of neuroimaging data to PDFs.
%%%% ¡settings!
'ConverterNeuroimaging2PDFs'

%%% ¡prop!
ID (data, string) is a few-letter code for the converter of neuroimaging data to PDFs.
%%%% ¡default!
'ConverterNeuroimaging2PDFs ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the converter of neuroimaging data to PDFs.
%%%% ¡default!
'ConverterNeuroimaging2PDFs label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the converter of neuroimaging data to PDFs.
%%%% ¡default!
'ConverterNeuroimaging2PDFs notes'

%% ¡props!

%%% ¡prop!
BA_LIST (data, itemlist) is the list of brain atlases used to identify the brain regions.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
BA_NIFTI_FILES (data, stringlist) is the list of atlas NIfTI files aligned with BA_LIST.
%%%% ¡default!
{}

%%% ¡prop!
BA_MAPPING_FILES (data, stringlist) is the list of atlas mapping CSV files aligned with BA_LIST.
%%%% ¡default!
{}

%%% ¡prop!
GR_NEUROIMAGING (data, item) is the group of subject-level neuroimaging data to convert.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectNeuroimaging', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNeuroimaging'))

%%% ¡prop!
GR_LIST_ANAT_REF (data, itemlist) is the list of anatomical reference groups used to restrict voxel extraction.
%%%% ¡settings!
'Group'

%%% ¡prop!
THRESHOLD_ANAT_REF (parameter, scalar) is the threshold applied to anatomical reference images.
%%%% ¡default!
0.5

%%% ¡prop!
ANAT_REF_COMBINE_RULE (parameter, option) is the rule used to combine multiple anatomical reference masks.
%%%% ¡settings!
{'or' 'and'}
%%%% ¡default!
'or'

%%% ¡prop!
REF_BR (data, stringlist) is the list of reference brain-region IDs used for optional normalization before PDF calculation.
%%%% ¡default!
{}

%%% ¡prop!
REF_TOP_PERCENTAGE (parameter, scalar) is the top percentage of reference-region voxel values used to calculate the reference mean.
%%%% ¡default!
1
%%%% ¡check_value!
check = value >= 0.1 && value <= 1;

%%% ¡prop!
CONVERT_BR (data, stringlist) is the list of brain-region IDs to convert into regional PDFs.
%%%% ¡default!
{}

%%% ¡prop!
BIN_EDGES (parameter, rvector) is the bin edges used to calculate regional PDFs.
%%%% ¡default!
linspace(0, 1, 101)

%%% ¡prop!
BIN_CENTERS (query, rvector) is the bin centers corresponding to BIN_EDGES.
%%%% ¡calculate!
bin_edges = cn.get('BIN_EDGES');

if numel(bin_edges) < 2
    error('BIN_EDGES must contain at least two values.')
end

value = (bin_edges(1:end-1) + bin_edges(2:end)) / 2;

%%% ¡prop!
BR_LABEL_IN_MAPS (query, cell) finds the atlas index and numeric atlas label for a brain-region ID.
%%%% ¡calculate!
br_id = varargin{1};
region_label_map_list = varargin{2};

atlas_idx = [];
region_label = [];

for i = 1:numel(region_label_map_list)
    region_label_map = region_label_map_list{i};

    if isKey(region_label_map, br_id)
        atlas_idx = i;
        region_label = region_label_map(br_id);
        value = {atlas_idx, region_label};
        return
    end
end

value = {atlas_idx, region_label};

%%% ¡prop!
BA (result, item) is the brain atlas containing the converted brain regions.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡calculate!
ba_list = cn.get('BA_LIST');
convert_br = cn.get('CONVERT_BR');

if isempty(ba_list)
    value = BrainAtlas( ...
        'ID', 'RegionalPDFAtlas', ...
        'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion') ...
        );
    return
end

if isempty(convert_br)
    ba = ba_list{1};
    value = ba;
    return
end

selected_br_list = {};

for br_i = 1:numel(convert_br)
    br_id = convert_br{br_i};
    br_found = false;

    for ba_i = 1:numel(ba_list)
        ba = ba_list{ba_i};
        br_dict = ba.get('BR_DICT');

        for j = 1:br_dict.get('LENGTH')
            br = br_dict.get('IT', j);

            if strcmp(br.get('ID'), br_id)
                selected_br_list{end + 1} = br; %#ok<AGROW>
                br_found = true;
                break
            end
        end

        if br_found
            break
        end
    end

    if ~br_found
        warning('Brain region "%s" was not found in BA_LIST and will be skipped.', br_id)
    end
end

value = BrainAtlas( ...
    'ID', 'RegionalPDFAtlas', ...
    'LABEL', 'Regional PDF atlas', ...
    'NOTES', 'Brain atlas containing the regions converted from subject-level NIfTI data into PDFs.', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', selected_br_list) ...
    );

%%% ¡prop!
GR_FUN (result, item) is the group of subjects with regional PDFs.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
ba_list = cn.get('BA_LIST');
ba_nifti_files = cn.get('BA_NIFTI_FILES');
ba_mapping_files = cn.get('BA_MAPPING_FILES');
gr_neuroimaging = cn.get('GR_NEUROIMAGING');
gr_list_anat_ref = cn.get('GR_LIST_ANAT_REF');
threshold_anat_ref = cn.get('THRESHOLD_ANAT_REF');
anat_ref_combine_rule = cn.get('ANAT_REF_COMBINE_RULE');
ref_br = cn.get('REF_BR');
ref_top_percentage = cn.get('REF_TOP_PERCENTAGE');
convert_br = cn.get('CONVERT_BR');
bin_edges = cn.get('BIN_EDGES');

if gr_neuroimaging.get('SUB_DICT').get('LENGTH') == 0
    value = Group( ...
        'SUB_CLASS', 'SubjectFUN', ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
        );
    return
end

if isempty(ba_list)
    error('BA_LIST must not be empty.')
end

if isempty(ba_nifti_files)
    error('BA_NIFTI_FILES must not be empty.')
end

if isempty(ba_mapping_files)
    error('BA_MAPPING_FILES must not be empty.')
end

if numel(ba_nifti_files) ~= numel(ba_mapping_files)
    error('BA_NIFTI_FILES and BA_MAPPING_FILES must have the same length.')
end

if numel(ba_list) ~= numel(ba_nifti_files)
    error('BA_LIST and BA_NIFTI_FILES must have the same length.')
end

if isempty(convert_br)
    error('CONVERT_BR must not be empty.')
end

if numel(bin_edges) < 2
    error('BIN_EDGES must contain at least two values.')
end

% Load atlas NIfTI files and mapping tables.
atlas_data_list = cell(1, numel(ba_nifti_files));
region_label_map_list = cell(1, numel(ba_mapping_files));

for atlas_i = 1:numel(ba_nifti_files)
    atlas_file = ba_nifti_files{atlas_i};
    mapping_file = ba_mapping_files{atlas_i};

    if ~isfile(atlas_file)
        error('Atlas NIfTI file not found: %s', atlas_file)
    end

    if ~isfile(mapping_file)
        error('Atlas mapping file not found: %s', mapping_file)
    end

    atlas_data_list{atlas_i} = niftiread(atlas_file);

    mapping_table = readtable(mapping_file, 'TextType', 'string');

    if width(mapping_table) < 4
        error('Atlas mapping file must have at least 4 columns: %s', mapping_file)
    end

    atlas_labels = mapping_table{:, 3};
    atlas_br_ids = string(mapping_table{:, 4});

    region_label_map = containers.Map();

    for row_i = 1:numel(atlas_br_ids)
        br_id = char(atlas_br_ids(row_i));

        if isempty(br_id) || ismissing(string(br_id))
            continue
        end

        region_label_map(br_id) = double(atlas_labels(row_i));
    end

    region_label_map_list{atlas_i} = region_label_map;
end

% Build output brain atlas from CONVERT_BR.
ba_fun = cn.get('BA');

% Create output group.
gr_fun = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
    );

sub_dict = gr_fun.memorize('SUB_DICT');
sub_dict_neuroimaging = gr_neuroimaging.get('SUB_DICT');
subject_number = sub_dict_neuroimaging.get('LENGTH');

n_bins = numel(bin_edges) - 1;

wb = braph2waitbar(cn.get('WAITBAR'), 0, 'Converting neuroimaging data to regional PDFs ...');

for sub_i = 1:subject_number
    sub_neuroimaging = sub_dict_neuroimaging.get('IT', sub_i);
    subject_id = sub_neuroimaging.get('ID');

    neuroimaging_file = sub_neuroimaging.get('ABSOLUTE_NIFTI_PATH');

    if ~isfile(neuroimaging_file)
        error('Subject neuroimaging file not found: %s', neuroimaging_file)
    end

    neuroimaging_data = double(niftiread(neuroimaging_file));

    % Build anatomical reference mask.
    anat_mask = true(size(neuroimaging_data));

    if ~isempty(gr_list_anat_ref)
        if strcmpi(anat_ref_combine_rule, 'and')
            anat_mask = true(size(neuroimaging_data));
        else
            anat_mask = false(size(neuroimaging_data));
        end

        for anat_i = 1:numel(gr_list_anat_ref)
            gr_anat = gr_list_anat_ref{anat_i};
            sub_anat = gr_anat.get('SUB_DICT').get('IT', sub_i);

            if ~strcmp(sub_anat.get('ID'), subject_id)
                error('Subject ID mismatch between GR_NEUROIMAGING and GR_LIST_ANAT_REF{%d}: %s versus %s.', ...
                    anat_i, subject_id, sub_anat.get('ID'))
            end

            anat_file = sub_anat.get('ABSOLUTE_NIFTI_PATH');

            if ~isfile(anat_file)
                error('Anatomical reference file not found: %s', anat_file)
            end

            anat_data = double(niftiread(anat_file));
            anat_mask_i = anat_data >= threshold_anat_ref;

            if strcmpi(anat_ref_combine_rule, 'and')
                anat_mask = anat_mask & anat_mask_i;
            else
                anat_mask = anat_mask | anat_mask_i;
            end
        end
    end

    % Build reference mask if needed.
    use_reference_normalization = ~isempty(ref_br);
    reference_mask = false(size(neuroimaging_data));

    if use_reference_normalization
        for ref_i = 1:numel(ref_br)
            br_id = ref_br{ref_i};
            br_label_info = cn.get('BR_LABEL_IN_MAPS', br_id, region_label_map_list);
            atlas_idx = br_label_info{1};
            region_label = br_label_info{2};

            if isempty(atlas_idx)
                error('Reference brain region "%s" was not found in BA_MAPPING_FILES.', br_id)
            end

            reference_mask = reference_mask | (atlas_data_list{atlas_idx} == region_label);
        end

        reference_mask = reference_mask & anat_mask;
        reference_values = neuroimaging_data(reference_mask);
        reference_values = reference_values(~isnan(reference_values));

        if isempty(reference_values)
            error('Reference mask is empty for subject %s.', subject_id)
        end

        reference_values = sort(reference_values(:), 'descend');

        top_count = ceil(numel(reference_values) * ref_top_percentage);
        top_count = max(top_count, 1);

        reference_values = reference_values(1:top_count);
        reference_mean = mean(reference_values);

        if reference_mean == 0 || isnan(reference_mean)
            error('Invalid reference mean for subject %s.', subject_id)
        end
    else
        reference_mean = 1;
    end

    % Convert each target brain region into a PDF.
    pdf_matrix = nan(n_bins, numel(convert_br));

    for br_i = 1:numel(convert_br)
        br_id = convert_br{br_i};
        br_label_info = cn.get('BR_LABEL_IN_MAPS', br_id, region_label_map_list);
        atlas_idx = br_label_info{1};
        region_label = br_label_info{2};

        if isempty(atlas_idx)
            warning('Converted brain region "%s" was not found in BA_MAPPING_FILES. Setting PDF to NaN.', br_id)
            pdf_matrix(:, br_i) = NaN;
            continue
        end

        roi_mask = (atlas_data_list{atlas_idx} == region_label);
        final_mask = roi_mask & anat_mask;

        roi_values = neuroimaging_data(final_mask);
        roi_values = roi_values(~isnan(roi_values));

        if isempty(roi_values)
            pdf_matrix(:, br_i) = NaN;
        else
            roi_values = roi_values / reference_mean;
            pdf_values = histcounts(roi_values, bin_edges, 'Normalization', 'pdf');
            pdf_matrix(:, br_i) = pdf_values(:);
        end
    end

    sub_fun = SubjectFUN( ...
        'ID', subject_id, ...
        'LABEL', sub_neuroimaging.get('LABEL'), ...
        'NOTES', sub_neuroimaging.get('NOTES'), ...
        'BA', ba_fun, ...
        'FUN', pdf_matrix, ...
        'VOI_DICT', sub_neuroimaging.get('VOI_DICT') ...
        );

    sub_dict.get('ADD', sub_fun);

    braph2waitbar(wb, sub_i / subject_number, ...
        ['Converting neuroimaging data to PDFs for subject ' num2str(sub_i) ' of ' num2str(subject_number) ' ...'])
end

braph2waitbar(wb, 'close')

value = gr_fun;

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar.
%%%% ¡default!
true

%% ¡tests!

%%% ¡excluded_props!
[ConverterNeuroimaging2PDFs.BR_LABEL_IN_MAPS ConverterNeuroimaging2PDFs.BIN_CENTERS]

%%% ¡test!
%%%% ¡name!
Sanity check - convert GM probability NIfTI data to regional PDFs
%%%% ¡probability!
.01
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('ConverterNeuroimaging2PDFs')), 'Example data NIfTI');
example_atlas_dir = fullfile(fileparts(which('ConverterNeuroimaging2PDFs')), 'example atlases NIfTI');

if isempty(dir(fullfile(example_data_dir, 'sub-*', 'ses-*', 'anat', '*_GMprob.nii')))
    create_data_NIfTI_GMProb();
end

im_ba = ImporterBrainAtlasXLS( ...
    'FILE', fullfile(example_atlas_dir, 'aal120_atlas.xlsx'), ...
    'WAITBAR', false ...
    );

ba_aal120 = im_ba.get('BA');

im_gr = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', example_data_dir, ...
    'MODALITY', 'anat', ...
    'TARGET', 'GMprob', ...
    'BA', ba_aal120, ...
    'WAITBAR', false ...
    );

gr_gmprob = im_gr.get('GR');

brain_regions_to_convert = {};
for i = 1:5
    brain_regions_to_convert{i} = ba_aal120.get('BR_DICT').get('IT', i).get('ID'); %#ok<AGROW>
end

bin_edges = linspace(0, 1, 101);

cn = ConverterNeuroimaging2PDFs( ...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIFTI_FILES', {fullfile(example_atlas_dir, 'aal120_atlas.nii')}, ...
    'BA_MAPPING_FILES', {fullfile(example_atlas_dir, 'aal120_atlas_mapping.csv')}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', gr_gmprob, ...
    'BIN_EDGES', bin_edges, ...
    'WAITBAR', false ...
    );

gr_fun = cn.get('GR_FUN');

assert(isequal(gr_fun.get('SUB_DICT').get('LENGTH'), 10), ...
    'The converted group should contain 10 subjects.')

sub_fun = gr_fun.get('SUB_DICT').get('IT', 1);
fun = sub_fun.get('FUN');

assert(isequal(size(fun), [100 5]), ...
    'The converted subject should contain a 100-by-5 PDF matrix.')

assert(all(~isnan(fun(:))), ...
    'The converted regional PDFs should not contain NaN values.')

%%% ¡test!
%%%% ¡name!
Sanity check - convert PET SUVR NIfTI data to regional PDFs
%%%% ¡probability!
.01
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('ConverterNeuroimaging2PDFs')), 'Example data NIfTI');
example_atlas_dir = fullfile(fileparts(which('ConverterNeuroimaging2PDFs')), 'example atlases NIfTI');

if isempty(dir(fullfile(example_data_dir, 'sub-*', 'ses-*', 'pet', '*_pet.nii')))
    create_data_NIfTI_PET();
end

if isempty(dir(fullfile(example_data_dir, 'sub-*', 'ses-*', 'anat', '*_GMprob.nii')))
    create_data_NIfTI_GMProb();
end

if isempty(dir(fullfile(example_data_dir, 'sub-*', 'ses-*', 'anat', '*_WMprob.nii')))
    create_data_NIfTI_WMProb();
end

im_ba = ImporterBrainAtlasXLS( ...
    'FILE', fullfile(example_atlas_dir, 'aal120_atlas.xlsx'), ...
    'WAITBAR', false ...
    );

ba_aal120 = im_ba.get('BA');

im_gr_pet = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', example_data_dir, ...
    'MODALITY', 'pet', ...
    'BA', ba_aal120, ...
    'WAITBAR', false ...
    );

gr_pet = im_gr_pet.get('GR');

im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', example_data_dir, ...
    'MODALITY', 'anat', ...
    'TARGET', 'GMprob', ...
    'BA', ba_aal120, ...
    'WAITBAR', false ...
    );

gr_gmprob = im_gr_gm.get('GR');

im_gr_wm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', example_data_dir, ...
    'MODALITY', 'anat', ...
    'TARGET', 'WMprob', ...
    'BA', ba_aal120, ...
    'WAITBAR', false ...
    );

gr_wmprob = im_gr_wm.get('GR');

brain_regions_to_convert = {};
for i = 1:5
    brain_regions_to_convert{end + 1} = ba_aal120.get('BR_DICT').get('IT', i).get('ID'); %#ok<AGROW>
end

bin_edges = linspace(0, 3, 101);

cn = ConverterNeuroimaging2PDFs( ...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIFTI_FILES', {fullfile(example_atlas_dir, 'aal120_atlas.nii')}, ...
    'BA_MAPPING_FILES', {fullfile(example_atlas_dir, 'aal120_atlas_mapping.csv')}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', gr_pet, ...
    'GR_LIST_ANAT_REF', {gr_gmprob, gr_wmprob}, ...
    'THRESHOLD_ANAT_REF', 0.5, ...
    'ANAT_REF_COMBINE_RULE', 'or', ...
    'REF_BR', {}, ...
    'BIN_EDGES', bin_edges, ...
    'WAITBAR', false ...
    );

gr_fun = cn.get('GR_FUN');

assert(isequal(gr_fun.get('SUB_DICT').get('LENGTH'), 10), ...
    'The converted PET group should contain 10 subjects.')

sub_fun = gr_fun.get('SUB_DICT').get('IT', 1);
fun = sub_fun.get('FUN');

assert(isequal(size(fun), [100 5]), ...
    'The converted PET subject should contain a 100-by-5 PDF matrix.')

assert(all(~isnan(fun(:))), ...
    'The converted PET regional PDFs should not contain NaN values.')
