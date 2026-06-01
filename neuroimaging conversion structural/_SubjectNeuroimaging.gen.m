%% ¡header!
SubjectNeuroimaging < Subject (sub, subject with neuroimaging file) is a subject with neuroimaging file (NIfTI).

%%% ¡description!
Subject with a NIfTI files containing brain imaging data.

%%% ¡seealso!
ImporterGroupSubjectCON_TXT, ExporterGroupSubjectCON_TXT, ImporterGroupSubjectCON_XLS, ExporterGroupSubjectCON_XLS, ImporterGroupSubjNIfTI

%%% ¡build!
1

%% ¡gui!

%%% ¡menu_import!
if isa(el, 'Group')
    uimenu(menu_import, ...
        'Tag', 'MENU.Import.TXT', ...
        'Label', 'Import TXT ...', ...
        'Callback', {@cb_importer_TXT});
end
function cb_importer_TXT(~, ~)
    try
        im = ImporterGroupSubjectCON_TXT( ...
            'ID', 'Import Group of SubjectCons from TXT', ...
            'WAITBAR', true ...
            ).get('GET_DIR');
        if ~isa(im.getr('DIRECTORY'), 'NoValue')
            gr = im.get('GR');
            gui = GUIElement('PE', gr);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input Group of SubjectCONs in TXT format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

if isa(el, 'Group')
    uimenu(menu_import, ...
        'Tag', 'MENU.Import.XLS', ...
        'Label', 'Import XLS ...', ...
        'Callback', {@cb_importer_XLS});
end
function cb_importer_XLS(~, ~)
    try
        im = ImporterGroupSubjectCON_XLS( ...
            'ID', 'Import Group of SubjectCons from XLS', ...
            'WAITBAR', true ...
            ).get('GET_DIR');
        if ~isa(im.getr('DIRECTORY'), 'NoValue')
            gr = im.get('GR');
            gui = GUIElement('PE', gr);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input Group of SubjectCONs in XLS format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

%%% ¡menu_export!
if isa(el, 'Group')
    uimenu(menu_export, ...
        'Tag', 'MENU.Export.TXT', ...
        'Label', 'Export TXT ...', ...
        'Callback', {@cb_exporter_TXT});
end
function cb_exporter_TXT(~, ~)
    ex = ExporterGroupSubjectCON_TXT( ...
        'ID', 'Export Brain Group of SubjectCons to TXT', ...
        'GR', el, ...
        'WAITBAR', true ...
        ).get('PUT_DIR');
    if ~isa(ex.get('DIRECTORY'), 'NoValue')
        ex.get('SAVE');
    end
end

if isa(el, 'Group')
    uimenu(menu_export, ...
        'Tag', 'MENU.Export.XLS', ...
        'Label', 'Export XLS ...', ...
        'Callback', {@cb_exporter_XLS});
end
function cb_exporter_XLS(~, ~)
    ex = ExporterGroupSubjectCON_XLS( ...
        'ID', 'Export Brain Group of SubjectCons to XLS', ...
        'GR', el, ...
        'WAITBAR', true ...
        ).get('PUT_DIR');
    if ~isa(ex.get('DIRECTORY'), 'NoValue')
        ex.get('SAVE');
    end
end

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SubjectNeuroimaging.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectNeuroimaging.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectNeuroimaging.RELATIVE_NIFTI_PATH
%%%% ¡title!
Subject NIfTI PATH

%%% ¡prop!
%%%% ¡id!
SubjectNeuroimaging.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectNeuroimaging.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'SubjectNeuroimaging'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Subject Neuroimaging'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with a NIfTI files containing brain imaging data.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectNeuroimaging'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectNeuroimaging ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectNeuroimaging label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectNeuroimaging notes'

%% ¡props!

%%% ¡prop!
RELATIVE_NIFTI_PATH (data, string) is the relative path to the subject NIfTI file.

%%% ¡prop!
BASE_DIR (data, string) is the base directory used to resolve the relative NIfTI file path.
%%%% ¡default!
fileparts(which('SubjectNeuroimaging'))

%%% ¡prop!
ABSOLUTE_NIFTI_PATH (query, string) is the absolute path to the subject NIfTI file, resolved from BASE_DIR and RELATIVE_NIFTI_PATH. This keeps the file location portable across different computers.
%%%% ¡calculate!
base_dir = sub.get('BASE_DIR');
relative_path = sub.get('RELATIVE_NIFTI_PATH');

if isempty(relative_path)
    value = '';
elseif isfolder(fileparts(relative_path)) || isfile(relative_path)
    value = relative_path;
elseif isempty(base_dir)
    value = relative_path;
else
    value = fullfile(base_dir, relative_path);
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
% Step 1: Load Brain Atlas
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

% Step 2: Create Group with SubjectNeuroimaging instances
gr = Group('SUB_CLASS', 'SubjectNeuroimaging', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNeuroimaging'));
for i = 1:1:50
    sub = SubjectNeuroimaging( ...
        'ID', ['SUB NIfTI ' int2str(i)]);
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()));
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)));
    gr.get('SUB_DICT').get('ADD', sub);
end

% Step 3: Test GUI
gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW');
gui.get('SHOW');

gui.get('CLOSE');
