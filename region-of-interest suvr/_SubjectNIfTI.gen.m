%% ¡header!
SubjectNIfTI < Subject (sub, subject with Nifti files) is a subject with Nifti data (e.g. PET, MRI).

%%% ¡description!
Subject with nifti files containing brain imaging data (e.g. obtained from PET).

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
SubjectNIfTI.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectNIfTI.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectNIfTI.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectNIfTI.NIFTI_PATH_DICT
%%%% ¡title!
Nifti data directory

%%% ¡prop!
%%%% ¡id!
SubjectNIfTI.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'SubjectNIfTI'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Subject NIfTI'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with nifti files containing brain imaging data (e.g. obtained from PET).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectNIfTI'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectNIfTI ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectNIfTI label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectNIfTI notes'

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
% Step 1: Load Brain Atlas
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

% Step 2: Create Group with SubjectNIfTI instances
gr = Group('SUB_CLASS', 'SubjectNIfTI', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNIfTI'));
for i = 1:1:50
    sub = SubjectNIfTI( ...
        'ID', ['SUB Nifti ' int2str(i)]);
    % Add the file path to the subject's nifty dictionary
    sub.memorize('NIFTI_PATH_DICT').get('ADD', FILE_PATH('ID', convertStringsToChars(string(i)), 'PATH', convertStringsToChars('*/*')));
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()));
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)));
    gr.get('SUB_DICT').get('ADD', sub);
end

% Step 3: Test GUI
gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW');
gui.get('SHOW');

% Pause for visual confirmation
disp('GUI is open. Closing in 3 seconds...');
pause(3);

gui.get('CLOSE');
