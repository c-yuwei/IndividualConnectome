%% ¡header!
IndividualConConstructorBase < ConcreteElement (base, Individual Base Constructor) is the base constructor for individual brain connectome.

%%% ¡description!
The IndividualConConstructorBase constructs individual brain connectome with SUVR (standard uptake value ratio) data.

Its subclasses need to implement some or all of the following props, including GR GR_REF CONNECTOME_METHOD.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of Individual Connectome Constructor Base.
%%%% ¡default!
'IndividualConConstructorBase'

%%% ¡prop!
NAME (constant, string) is the name of the Individual Connectome Constructor Base.
%%%% ¡default!
'Individual Connectome Constructor Base'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Individual Connectome Constructor Base.
%%%% ¡default!
'A Individual Connectome Constructor Base (IndividualConConstructorBase) comprises brain connectome constructor with a specific dataset. Its subclasses need to implement the props GR, GR_REF and CONNECTOME_METHOD.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Individual Connectome Constructor Base.
%%%% ¡settings!
'IndividualConConstructorBase'

%%% ¡prop!
ID (data, string) is a few-letter code for the Individual Connectome Constructor Base.
%%%% ¡default!
'IndividualConConstructorBase ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Individual Connectome Constructor Base.
%%%% ¡default!
'Individual Connectome Constructor Base label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Individual Connectome Constructor Base.
%%%% ¡default!
'Individual Connectome Constructor Base notes'

%% ¡props!

%%% ¡prop!
GR_SUVR (data, item) is a group of subjects with mean SUVR data.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for individual connectome construction.
%%%% ¡default!
{};

%%% ¡prop!
GR (result, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
    );

gr.lock('SUB_CLASS');

gr_suvr = base.get('GR_SUVR');
sub_dict = gr.memorize('SUB_DICT');
connectivityMatrix = base.get('CONNECTOME_CONSTUCT_METHOD');
for i = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
    ba = gr_suvr.get('SUB_DICT').get('IT',i).get('BA');
    % braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])
    sub_id = gr_suvr.get('SUB_DICT').get('IT',i).get('ID');
    sub = SubjectCON( ...
        'ID', sub_id, ...
        'BA', ba, ...
        'CON', connectivityMatrix{i} ...
        );
    sub_dict.get('ADD', sub);
end

value = gr;