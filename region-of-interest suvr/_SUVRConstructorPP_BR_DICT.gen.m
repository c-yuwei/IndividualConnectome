%% ¡header!
SUVRConstructorPP_BR_DICT < PanelProp (pr, graph and measure plot) plots the panel to manage the graph and measures of an ensemble analysis.

%%% ¡description!
SUVRConstructorPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.
It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.

%%% ¡seealso!
uitable, AnalyzeEnsemble, Graph, Measure

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'SUVRConstructorPP_BR_DICT'

%%% ¡prop!
NAME (constant, string) is the name of the graph and measure panel.
%%%% ¡default!
'SUVRConstructorPP_BR_DICT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph and measure panel.
%%%% ¡default!
'SUVRConstructorPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph and measure panel.
%%%% ¡settings!
'SUVRConstructorPP_BR_DICT'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph and measure panel.
%%%% ¡default!
'SUVRConstructorPP_BR_DICT'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph and measure panel.
%%%% ¡default!
'SUVRConstructorPP_BR_DICT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph and measure panel.
%%%% ¡default!
'SUVRConstructorPP_BR_DICT'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
SUVRConstructor()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
SUVRConstructor.REF_BR_DICT

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('TABLE')
    pr.memorize('CONTEXTMENU')
    
    % % Create the button
    % uicontrol('Parent', pr.get('H'), ...
    %     'Style', 'pushbutton', ...
    %     'String', 'Load Region-Index Files', ...
    %     'Position', [10, 10, 120, 30], ...
    %     'Callback', @cb_load_mapping_files);
end
% %%%% ¡calculate_callbacks!
% function cb_load_mapping_files(~, ~)
%     roic = pr.get('EL');
%     [files, path] = uigetfile('*.csv', 'Select Region-Index CSV Files', 'MultiSelect', 'on');
%     if ~isequal(files, 0)
%         if ~iscell(files)
%             files = {files};
%         end
%         % Construct IndexedDictionary for MAPPING_PATH_DICT
%         mapping_paths = cellfun(@(f) FILE_PATH('PATH', fullfile(path, f)), files, 'UniformOutput', false);
%         mapping_dict = IndexedDictionary('IT_CLASS', 'FILE_PATH', 'IT_LIST', mapping_paths);
%         roic.set('MAPPING_PATH_DICT', mapping_dict);
%     end
% end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the table.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
	el = pr.get('EL');
    prop = pr.get('PROP');
    set_table()
    pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
    set(pr.get('TABLE'), 'Visible', 'on')
end
%%%% ¡calculate_callbacks!
function set_table()
    % Retrieve core objects and properties
    roic = pr.get('EL');
    prop = pr.get('PROP');
    ba_list = roic.get('BA');
    
    % Determine which atlases to use based on prop
    if prop == 14  % REF_BR_DICT: Use all atlases
        selected_atlases = ba_list;
    elseif prop == 19  % SUVR_REGION_SELECTION: Use one atlas
        atlas_index = roic.get('ATLAS_INDEX');
        if atlas_index < 1 || atlas_index > length(ba_list)
            warning('Invalid ATLAS_INDEX. No atlas selected.');
            return;
        end
        selected_atlases = {ba_list{atlas_index}};
    else
        warning('Invalid property number.');
        return;
    end
    
    % Aggregate brain regions and atlas IDs
    br_it_list = {};
    atlas_ids = {};
    for i = 1:length(selected_atlases)
        ba = selected_atlases{i};
        atlas_id = ba.get('ID');
        br_dict = ba.get('BR_DICT');
        br_it = br_dict.get('IT_LIST');
        br_it_list{i} =  br_it;
        atlas_ids = [atlas_ids; repmat({atlas_id}, length(br_it), 1)];
    end
    br_it_list = [br_it_list{:}];
    % Extract brain region IDs

    if ~isempty(br_it_list)
        br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
    else
        br_list = {};
    end
    % br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
    % Get the effective (selected) brain regions
    if isa(roic.getr(prop), 'NoValue')
        eff_br_list = {};
    else
        eff_br_list = cellfun(@(x) x.get('ID'), roic.get(prop).get('IT_LIST'), 'UniformOutput', false);
    end
    % Prepare table data with 6 columns (same for both properties)
    data = cell(length(br_list), 6);
    for bri = 1:length(br_list)
        data{bri, 1} = any(pr.get('SELECTED') == bri);         % Checkbox
        data{bri, 2} = atlas_ids{bri};                         % Atlas
        data{bri, 3} = br_it_list{bri}.get('ID');              % ID
        data{bri, 4} = br_it_list{bri}.get('LABEL');           % Label
        data{bri, 5} = br_it_list{bri}.get('NOTES');           % Notes
        data{bri, 6} = br_it_list{bri}.get('DESCRIPTION');     % Description
    end
    
    % Configure the table with the same columns and format
    set(pr.get('TABLE'), ...
        'Data', data, ...
        'ColumnName', {'', 'Atlas', 'ID', 'Label', 'Notes', 'Description'}, ...
        'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
        'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto', 'auto'} ...
        )
    
    % Set row names to indicate selected regions
    rowname = cell(length(br_list), 1);
    for bri = 1:length(br_list)
        if any(ismember(eff_br_list, br_list{bri})) && ~isa(roic.get(prop).get('IT', br_list{bri}).getr('X'), 'NoValue')
            rowname{bri} = 'S';  % Selected
        else
            rowname{bri} = '';   % Unselected
        end
    end
    set(pr.get('TABLE'), 'RowName', rowname);
    
    % Style selected rows
    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
    if ~isempty(styles_row)
        removeStyle(pr.get('TABLE'), styles_row)
    end
    if ~isempty(pr.get('SELECTED'))
        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
end

%%% ¡prop!
SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning

%%% ¡prop!
HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('TABLE', Element.getNoValue())
    pr.set('CONTEXTMENU', Element.getNoValue())
end

%%% ¡prop!
CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning

%% ¡props!

%%% ¡prop!
TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
%%%% ¡default!
s(30)

%%% ¡prop!
SELECTED (gui, cvector) is the list of selected items.
%%%% ¡conditioning!
if isrow(value)
    value = value';
end

%%% ¡prop!
TABLE (evanescent, handle) is the table.
%%%% ¡calculate!
table = uitable( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'table', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'ColumnSortable', true, ...
    'ColumnName', {'', 'Brain Region', 'ID', 'Label', 'Notes', 'Description'}, ...
    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char', 'char'}, ...
    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto', 'auto'}, ...
    'ColumnEditable', [true false false false false false], ...
    'CellEditCallback', {@cb_table} ...
    );
value = table;
%%%% ¡calculate_callbacks!
function cb_table(~, event) % (src, event)
    % only needs to update the selector

        i = event.Indices(1);
        
        selected = pr.get('SELECTED');
        if event.NewData == 1
            pr.set('SELECTED', sort(unique([selected; i])));
        else
            pr.set('SELECTED', selected(selected ~= i));
        end
        
        pr.get('UPDATE')    
end

%%% ¡prop!
CONTEXTMENU (evanescent, handle) is the context menu.
%%%% ¡calculate!
contextmenu = uicontextmenu( ...
    'Parent', ancestor(pr.get('H'), 'figure'), ...
    'Tag', 'CONTEXTMENU' ...
    );
menu_select_all = uimenu( ...
	'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_SELECT_ALL', ...
    'Text', 'Select All Measures', ...
    'MenuSelectedFcn', {@cb_select_all} ...
    );
menu_clear_selection = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_CLEAR_SELECTION', ...
    'Text', 'Clear Selection', ...
    'MenuSelectedFcn', {@cb_clear_selection} ...
    );
menu_invert_selection = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_INVERT_SELECTION', ...
    'Text', 'Invert Selection', ...
    'MenuSelectedFcn', {@cb_invert_selection} ...
    );
menu_set = uimenu( ...
	'Separator', 'on', ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_CALCULATE', ...
    'Text', 'Set Selected Brain Regions', ...
	'MenuSelectedFcn', {@cb_set} ...
    );

set(pr.get('TABLE'), 'ContextMenu', contextmenu)

value = contextmenu;
%%%% ¡calculate_callbacks!
function cb_select_all(~, ~)
    roic = pr.get('EL');
    
    % Get the list of brain atlases
    ba_list = roic.get('BA');
    br_it_list = {};
    for i = 1:length(ba_list)
        ba = ba_list{i};
        br_dict = ba.get('BR_DICT');
        br_it = br_dict.get('IT_LIST');
        br_it_list{i} = br_it;
    end
    br_it_list = [br_it_list{:}];
    % Select all brain regions
    pr.set('SELECTED', [1:1:length(br_it_list)]);
    
    % Update the panel
    pr.get('UPDATE');
end
function cb_clear_selection(~, ~)
    pr.set('SELECTED', [])
    
    pr.get('UPDATE')
end
function cb_invert_selection(~, ~)
    roic = pr.get('EL');
    
    % Get the list of brain atlases
    ba_list = roic.get('BA');
    br_it_list = {};
    for i = 1:length(ba_list)
        ba = ba_list{i};
        br_dict = ba.get('BR_DICT');
        br_it = br_dict.get('IT_LIST');
        br_it_list{i} = br_it;
    end
    br_it_list = [br_it_list{:}];
    % Invert the current selection
    selected = pr.get('SELECTED');
    all_indices = [1:1:length(br_it_list)];
    selected_tmp = setdiff(all_indices, selected);
    pr.set('SELECTED', selected_tmp);
    
    % Update the panel
    pr.get('UPDATE');
end
function cb_set(~, ~)
    roic = pr.get('EL');
    prop = pr.get('PROP');
    eff_br_dict = roic.get(prop);
    
    % Get the list of brain atlases and aggregate brain regions
    ba_list = roic.get('BA');
    br_it_list = {};
    for i = 1:length(ba_list)
        ba = ba_list{i};
        br_dict = ba.get('BR_DICT');
        br_it = br_dict.get('IT_LIST');
        br_it_list{i} = br_it;
    end
    br_it_list = [br_it_list{:}];
    % Get selected indices
    selected = pr.get('SELECTED');
    
    % Clear existing REF_BR_DICT
    eff_br_dict.get('REMOVE_ALL', 1:eff_br_dict.get('LENGTH'));
    
    % Add selected brain regions
    for s = 1:length(selected)
        br = br_it_list{selected(s)};
        eff_br_dict.get('ADD', br);
    end
    
    % Update the element and refresh the panel
    roic.set(prop, eff_br_dict);
    pr.get('UPDATE');
end
%% ¡tests!

%%% ¡excluded_props!
[SUVRConstructorPP_BR_DICT.PARENT SUVRConstructorPP_BR_DICT.H SUVRConstructorPP_BR_DICT.EL SUVRConstructorPP_BR_DICT.LISTENER_CB SUVRConstructorPP_BR_DICT.HEIGHT SUVRConstructorPP_BR_DICT.TABLE SUVRConstructorPP_BR_DICT.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SUVRConstructorPP_BR_DICT'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SUVRConstructorPP_BR_DICT'])