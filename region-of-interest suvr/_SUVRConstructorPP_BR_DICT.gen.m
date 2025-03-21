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
end

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
    roic = pr.get('EL');
    prop = pr.get('PROP');
    
    br_it_list = roic.get('BA').get('BR_DICT').get('IT_LIST');
    br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
    
    if isa(roic.getr(prop), 'NoValue')
        eff_br_list = {};
    else
        eff_br_list = cellfun(@(x) x.get('ID'), roic.get(prop).get('IT_LIST'), 'UniformOutput', false);
    end
    
    rowname = cell(length(br_list), 1);
    data = cell(length(br_list), 5);
    for bri = 1:1:length(br_list)
        if any(ismember(eff_br_list, br_list{bri})) && ~isa(roic.get(prop).get('IT', br_list{bri}).getr('X'), 'NoValue')
            rowname{bri} = 'S';
        else
            rowname{bri} = '';
        end
    
        if any(pr.get('SELECTED') == bri)
            data{bri, 1} = true;
        else
            data{bri, 1} = false;
        end
    
        data{bri, 2} = br_it_list{bri}.get('ID');
        data{bri, 3} = br_it_list{bri}.get('LABEL');
        data{bri, 4} = br_it_list{bri}.get('NOTES');
        data{bri, 5} = br_it_list{bri}.get('DESCRIPTION');
    
        set(pr.get('TABLE'), ...
            'RowName', rowname, ...
            'Data', data ...
            )
    
        % style SELECTED
        styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
        if ~isempty(styles_row)
            removeStyle(pr.get('TABLE'), styles_row)
        end
        if ~isempty(pr.get('SELECTED'))
            addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
        end
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
    br_list = cellfun(@(x) x.get('ID'), roic.get('BA').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
    
    pr.set('SELECTED', [1:1:length(m_list)])
    
    pr.get('UPDATE')
end
function cb_clear_selection(~, ~)
    pr.set('SELECTED', [])
    
    pr.get('UPDATE')
end
function cb_invert_selection(~, ~)
    roic = pr.get('EL');
    br_list = cellfun(@(x) x.get('ID'), roic.get('BA').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
    
    selected_tmp = [1:1:length(m_list)];
    selected_tmp(pr.get('SELECTED')) = [];
    pr.set('SELECTED', selected_tmp);
    
    pr.get('UPDATE')
end
function cb_set(~, ~)
    roic = pr.get('EL');
    prop = pr.get('PROP');
    eff_br_dict = roic.get(prop);
    
    br_it_list = roic.get('BA').get('BR_DICT').get('IT_LIST');
    br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
    selected = pr.get('SELECTED');

    roic.set('EFF_NODES', selected);
    
    added_keys_length = eff_br_dict.get('LENGTH');
    eff_br_dict.get('REMOVE_ALL', 1:1:added_keys_length);
    
    for s = 1:1:length(selected)
        br = br_list{selected(s)};
        eff_br_dict.get('ADD', br_it_list{selected(s)});
    end
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