%EXAMPLE_NEUROIMGING_2_ROI_T1W
% Script example pipeline neuroimaing (T1w) conversion to
% probability density functions (PDFs)
clear variables %#ok<*NASGU>

%% Create dataset
atlas_path = [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii'];
example_data_dir = [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Example data NIfTI PDF shape covariation'];
create_data_NIfTI_GMProb_PDFShape(atlas_path, example_data_dir)

%% Load BrainAtlases
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba_aal120 = im_ba.get('BA');

%% Load Groups of SubjectNeuroimaging
im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Example data NIfTI PDF shape covariation'], ...
    'MODALITY', 'anat', ...
    'TARGET', 'gmprob', ...
    'WAITBAR', true ...
    );

gr_anat_gmprob = im_gr_gm.get('GR');

%% Convert neuroimaging data to probability density functions
ba_nifti_files = {
    [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii']
    };

ba_mapping_files = {
    [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas_mapping.csv']
    };

brain_regions_to_convert = {};
convert_brain_regions_idx = 1:94; % cerebral all regions in aal120
for i = 1:length(convert_brain_regions_idx)
    brain_regions_to_convert{i} = ba_aal120.get('BR_DICT').get('IT', convert_brain_regions_idx(i)).get('ID');
end 

cn = ConverterNeuroimaging2PDFs( ...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'PDF_METHOD', 'kde', ...
    'KDE_NUM_POINTS', 500, ...
    'GR_NEUROIMAGING', gr_anat_gmprob);

gr_pdfs = cn.get('GR_FUN');
ba_pdfs = cn.get('BA');

%% Export data
directory_base = [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Converted data T1w'];
mkdir(directory_base);
ex = ExporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', directory_base, ...
    'GR', gr_pdfs ...
    );
ex.get('SAVE');

file = [directory_base filesep 'brain_atlas.xlsx'];
ex = ExporterBrainAtlasXLS( ...
    'FILE', file, ...
    'BA', ba_pdfs ...
    );
ex.get('SAVE');

%% Verification
% Verify that KDE-based PDFs preserve the designed covarying ROI pattern.

gt_file = [example_data_dir filesep 'reference_data' filesep 'groundtruth_covarying_rois_gmprob.xlsx'];
gt = readtable(gt_file, 'VariableNamingRule', 'preserve');

num_regions = numel(brain_regions_to_convert);
num_subjects = gr_pdfs.get('SUB_DICT').get('LENGTH');

is_covarying = logical(gt.IsCovarying(1:num_regions));

% Extract one compact PDF-shape feature per subject and ROI.
% Here we use the variance of each PDF along the KDE point axis.
pdf_shape = nan(num_subjects, num_regions);

for sub_i = 1:num_subjects
    fun = gr_pdfs.get('SUB_DICT').get('IT', sub_i).get('FUN'); % KDE points x ROIs

    assert(isequal(size(fun, 2), num_regions), ...
        'Verification failed: unexpected number of converted regions.')

    x = (1:size(fun, 1))';

    for br_i = 1:num_regions
        p = fun(:, br_i);
        p = p / sum(p); % normalize PDF scale

        mu = sum(x .* p);
        pdf_shape(sub_i, br_i) = sum(((x - mu) .^ 2) .* p);
    end
end

% Correlate ROI PDF-shape features across subjects.
roi_corr = corr(pdf_shape, 'Rows', 'pairwise');

cov_idx = find(is_covarying);
noncov_idx = find(~is_covarying);

within_cov = roi_corr(cov_idx, cov_idx);
between_cov_noncov = roi_corr(cov_idx, noncov_idx);

within_cov_mean = mean(within_cov(triu(true(size(within_cov)), 1)), 'omitnan');
between_mean = mean(between_cov_noncov(:), 'omitnan');

assert(within_cov_mean > between_mean, ...
    'Verification failed: covarying ROIs do not show stronger PDF-shape similarity.')

fprintf('Verification passed: KDE PDFs preserve the designed covarying ROI pattern.\n')
fprintf('Mean within-covarying similarity: %.4f\n', within_cov_mean)
fprintf('Mean between covarying/non-covarying similarity: %.4f\n', between_mean)
