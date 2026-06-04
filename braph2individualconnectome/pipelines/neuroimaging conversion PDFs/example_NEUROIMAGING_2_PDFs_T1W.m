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
