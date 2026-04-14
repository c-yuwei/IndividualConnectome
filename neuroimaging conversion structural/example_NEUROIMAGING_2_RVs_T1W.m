%EXAMPLE_NEUROIMGING_2_ROI_T1W
% Script example pipeline neuroimaing (T1w) conversion to
% regional values (VOLUME)
clear variables %#ok<*NASGU>

%% Load BrainAtlases
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases neuroimaging NIfTI' filesep 'aal120_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba_aal120 = im_ba.get('BA');

%% Load Groups of SubjectNeuroimaging
im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example data NIfTI'], ...
    'MODALITY', 'anat', ...
    'TARGET', 'gmprob'
    'BA', ba_aal120, ...
    'WAITBAR', true ...
    );

gr_anat_gmprob = im_gr_gm.get('GR');

%% Convert neuroimaging data to region-of-interest data
ba_nifti_files = {
    [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases neuroimaging NIfTI' filesep 'aal120_atlas.nii']
    [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases neuroimaging NIfTI' filesep 'td_atlas.nii']
    };

ba_mapping_files = {
    [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases neuroimaging NIfTI' filesep 'aal120_atlas_mapping.csv']
    [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases neuroimaging NIfTI' filesep 'td_atlas_mapping.csv']
    };

brain_regions_to_convert = {};
convert_brain_regions_idx = 1:94; % cerebral all regions in aal120
for i = 1:length(convert_brain_regions_idx)
    brain_regions_to_convert{i} = ba_aal120.get('BR_DICT').get('IT', convert_brain_regions_idx(i)).get('ID');
end 

cn = ConverterNeuroimaging2RegionalValues( ...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIfTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR_LIST', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', gr_anat_gmprob);

gr_st = cn.get('GR_ST')
ba_st = cn.get('BA')

%% Export data
directory = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Converted data T1w'];
mkdir(directory);
file = [directory filesep 'group_subjects_SUVR.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr_st ...
    );
ex.get('SAVE');

file = [directory filesep 'brain_atlas.xlsx'];
ex = ExporterBrainAtlasXLS( ...
    'FILE', file, ...
    'BA', ba_st ...
    );
ex.get('SAVE');
