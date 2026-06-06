%EXAMPLE_divergence_PDFS_2_CON
% Script example pipeline PDFs conversion to connectivity data using
% Jensen Shannon divergence.
clear variables %#ok<*NASGU>

%% Create dataset
example_data_dir = [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Converted data T1w'];

if ~isfolder(example_data_dir)
    example_NEUROIMAGING_2_PDFs_T1W
    example_data_dir = [fileparts(which('ConverterNeuroimaging2PDFs')) filesep 'Converted data T1w'];
end

%% Load BrainAtlas
atlas_file = [example_data_dir filesep 'brain_atlas.xlsx'];

im_ba = ImporterBrainAtlasXLS( ...
    'FILE', atlas_file, ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Group of SubjectFUN with regional PDFs
group_directory = [example_data_dir filesep 'Group ID'];

im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', group_directory, ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_pdfs = im_gr.get('GR');

%% Convert PDFs to connectivity using Jensen-Shannon similarity
c = ConverterPDFs2CON( ...
    'GR_PDFS', gr_pdfs, ...
    'METHOD', 'jensen-shannon' ...
    );

gr_con = c.get('GR_CON');

%% Export data
directory_base = [fileparts(which('example_divergence_PDFs_2_CON')) filesep 'Converted CON data'];

if ~isfolder(directory_base)
    mkdir(directory_base);
end

ex = ExporterGroupSubjectCON_XLS( ...
    'DIRECTORY', directory_base, ...
    'GR', gr_con ...
    );

ex.get('SAVE');

file = [directory_base filesep 'brain_atlas.xlsx'];

ex = ExporterBrainAtlasXLS( ...
    'FILE', file, ...
    'BA', ba ...
    );

ex.get('SAVE');
