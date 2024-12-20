%% ¡header!
SubjectNifti < Subject (sub, subject with Nifti files) is a subject with Nifti data (e.g. PET, MRI).

%%% ¡description!
Subject with nifti files containing brain imaging data (e.g. obtained from PET).

%%% ¡seealso!
ImporterGroupSubjectCON_TXT, ExporterGroupSubjectCON_TXT, ImporterGroupSubjectCON_XLS, ExporterGroupSubjectCON_XLS, ImporterGroupSubjNifti

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
SubjectNifti.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectNifti.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectNifti.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectNifti.NIFTI_PATH_DICT
%%%% ¡title!
Nifti data directory

%%% ¡prop!
%%%% ¡id!
SubjectNifti.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'SubjectNifti'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Subject Nifti'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with nifti files containing brain imaging data (e.g. obtained from PET).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectNifti'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectNifti ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectNifti label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectNifti notes'

%% ¡props!

%%% ¡prop!
NIFTI_PATH_DICT (data, idict) is direcotry to subject nifti data.
%%%% ¡settings!
'FILE_PATH'


%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectSUVR', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectSUVR'));
for i = 1:1:50
    sub = SubjectNifti( ...
        'ID', ['SUB Nifti ' int2str(i)], ...
        'LABEL', ['Subejct Nifti ' int2str(i)], ...
        'NOTES', ['Notes on subject Nifti ' int2str(i)], ...
        'BA', ba, ...
        'NFITI_PATH_DICT', rand(ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')