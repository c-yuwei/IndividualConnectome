%% ¡header!
ConverterPDFs2CON < ConcreteElement (c, converter of PDFs to connectivity data) converts SubjectFUN regional PDF data into SubjectCON connectivity data.

%%% ¡description!
ConverterPDFs2CON converts a group of SubjectFUN objects containing regional probability density functions into a group of SubjectCON objects containing individual connectivity matrices. The connectivity matrices can be constructed using correlation or Jensen-Shannon similarity.

%%% ¡seealso!
Group, SubjectFUN, SubjectCON, AnalyzeEnsemble_FUN_WU, AnalyzeEnsemble_FUN_JensenShannon_WU, GraphWU, ExporterGroupSubjectCON_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the converter of PDFs to connectivity data.
%%%% ¡default!
'ConverterPDFs2CON'

%%% ¡prop!
NAME (constant, string) is the name of the converter of PDFs to connectivity data.
%%%% ¡default!
'PDFs-to-Connectivity Converter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the converter of PDFs to connectivity data.
%%%% ¡default!
'ConverterPDFs2CON converts SubjectFUN regional PDF data into SubjectCON connectivity data using correlation or Jensen-Shannon similarity.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the converter of PDFs to connectivity data.
%%%% ¡settings!
'ConverterPDFs2CON'

%%% ¡prop!
ID (data, string) is a few-letter code for the converter of PDFs to connectivity data.
%%%% ¡default!
'ConverterPDFs2CON ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the converter of PDFs to connectivity data.
%%%% ¡default!
'ConverterPDFs2CON label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the converter of PDFs to connectivity data.
%%%% ¡default!
'ConverterPDFs2CON notes'

%% ¡props!

%%% ¡prop!
GR_PDFS (data, item) is the group of SubjectFUN objects containing regional PDFs.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))

%%% ¡prop!
METHOD (parameter, option) is the method used to construct individual connectivity matrices from regional PDFs.
%%%% ¡settings!
{'correlation' 'jensen-shannon'}
%%%% ¡default!
'correlation'

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
ANALYSIS (query, item) is the graph analysis used to construct the individual connectivity matrices.
%%%% ¡calculate!
gr_pdfs = c.get('GR_PDFS');
method = c.get('METHOD');

switch lower(method)
    case 'correlation'
        analysis = AnalyzeEnsemble_FUN_WU( ...
            'GR', gr_pdfs, ...
            'WAITBAR', c.get('WAITBAR') ...
            );

    case 'jensen-shannon'
        analysis = AnalyzeEnsemble_FUN_JensenShannon_WU( ...
            'GR', gr_pdfs, ...
            'WAITBAR', c.get('WAITBAR') ...
            );

    otherwise
        error('Unknown METHOD "%s". Valid methods are "correlation" and "jensen-shannon".', method)
end

if ~isa(c.get('GRAPH_TEMPLATE'), 'NoValue')
    analysis.set('GRAPH_TEMPLATE', c.get('GRAPH_TEMPLATE'));
end

value = analysis;

%%% ¡prop!
G_DICT (query, idict) is the graph dictionary obtained from the selected PDF-to-connectivity analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡calculate!
analysis = c.get('ANALYSIS');
value = analysis.get('G_DICT');

%%% ¡prop!
GR_CON (result, item) is the group of SubjectCON objects containing individual connectivity matrices.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
gr_pdfs = c.get('GR_PDFS');
g_dict = c.get('G_DICT');

gr_con = Group( ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
    );

sub_dict_con = gr_con.memorize('SUB_DICT');

sub_dict_pdfs = gr_pdfs.get('SUB_DICT');
subject_number = sub_dict_pdfs.get('LENGTH');

if subject_number ~= g_dict.get('LENGTH')
    error('GR_PDFS and G_DICT have different numbers of subjects/graphs.')
end

wb = braph2waitbar(c.get('WAITBAR'), 0, 'Converting graph outputs to SubjectCON group ...');

for sub_i = 1:subject_number
    sub_pdfs = sub_dict_pdfs.get('IT', sub_i);
    g = g_dict.get('IT', sub_i);

    A = g.get('A');

    if iscell(A)
        A = A{1};
    end

    sub_con = SubjectCON( ...
        'ID', sub_pdfs.get('ID'), ...
        'LABEL', sub_pdfs.get('LABEL'), ...
        'NOTES', sub_pdfs.get('NOTES'), ...
        'BA', sub_pdfs.get('BA'), ...
        'CON', A, ...
        'VOI_DICT', sub_pdfs.get('VOI_DICT') ...
        );

    sub_dict_con.get('ADD', sub_con);

    braph2waitbar( ...
        wb, ...
        sub_i / subject_number, ...
        ['Converting subject ' num2str(sub_i) ' of ' num2str(subject_number) ' ...'] ...
        )
end

braph2waitbar(wb, 'close')

value = gr_con;

%%% ¡prop!
BA (result, item) is the brain atlas used by the converted SubjectCON group.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡calculate!
gr_pdfs = c.get('GR_PDFS');

if gr_pdfs.get('SUB_DICT').get('LENGTH') == 0
    value = BrainAtlas();
else
    value = gr_pdfs.get('SUB_DICT').get('IT', 1).get('BA');
end

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar.
%%%% ¡default!
true

%% ¡tests!

%%% ¡excluded_props!
[ConverterPDFs2CON.TEMPLATE ConverterPDFs2CON.GRAPH_TEMPLATE ConverterPDFs2CON.ANALYSIS ConverterPDFs2CON.G_DICT]

%%% ¡test!
%%%% ¡name!
Convert SubjectFUN PDFs to SubjectCON using correlation
%%%% ¡probability!
.01
%%%% ¡code!
ba = BrainAtlas( ...
    'BR_DICT', IndexedDictionary( ...
        'IT_CLASS', 'BrainRegion', ...
        'IT_LIST', { ...
            BrainRegion('ID', 'BR1'), ...
            BrainRegion('ID', 'BR2'), ...
            BrainRegion('ID', 'BR3') ...
            } ...
        ) ...
    );

gr_pdfs = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
    );

for i = 1:3
    sub = SubjectFUN( ...
        'ID', ['sub-' int2str(i)], ...
        'BA', ba, ...
        'FUN', rand(100, 3) ...
        );

    gr_pdfs.get('SUB_DICT').get('ADD', sub)
end

c = ConverterPDFs2CON( ...
    'GR_PDFS', gr_pdfs, ...
    'METHOD', 'correlation', ...
    'WAITBAR', false ...
    );

gr_con = c.get('GR_CON');

assert(isequal(gr_con.get('SUB_DICT').get('LENGTH'), 3), ...
    'The converted SubjectCON group should contain 3 subjects.')

sub_con = gr_con.get('SUB_DICT').get('IT', 1);

assert(isequal(size(sub_con.get('CON')), [3 3]), ...
    'The converted connectivity matrix should be 3-by-3.')

%%% ¡test!
%%%% ¡name!
Convert SubjectFUN PDFs to SubjectCON using Jensen-Shannon similarity
%%%% ¡probability!
.01
%%%% ¡code!
ba = BrainAtlas( ...
    'BR_DICT', IndexedDictionary( ...
        'IT_CLASS', 'BrainRegion', ...
        'IT_LIST', { ...
            BrainRegion('ID', 'BR1'), ...
            BrainRegion('ID', 'BR2'), ...
            BrainRegion('ID', 'BR3') ...
            } ...
        ) ...
    );

gr_pdfs = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
    );

for i = 1:3
    pdf_data = rand(100, 3);
    pdf_data = pdf_data ./ sum(pdf_data, 1);

    sub = SubjectFUN( ...
        'ID', ['sub-' int2str(i)], ...
        'BA', ba, ...
        'FUN', pdf_data ...
        );

    gr_pdfs.get('SUB_DICT').get('ADD', sub)
end

c = ConverterPDFs2CON( ...
    'GR_PDFS', gr_pdfs, ...
    'METHOD', 'jensen-shannon', ...
    'WAITBAR', false ...
    );

gr_con = c.get('GR_CON');

assert(isequal(gr_con.get('SUB_DICT').get('LENGTH'), 3), ...
    'The converted SubjectCON group should contain 3 subjects.')

sub_con = gr_con.get('SUB_DICT').get('IT', 1);
A = sub_con.get('CON');

assert(isequal(size(A), [3 3]), ...
    'The converted connectivity matrix should be 3-by-3.')

assert(max(abs(A - A'), [], 'all') < 1e-12, ...
    'The Jensen-Shannon connectivity matrix should be symmetric.')

assert(all(A(:) >= 0) && all(A(:) <= 1), ...
    'The Jensen-Shannon connectivity values should be in the range [0, 1].')
