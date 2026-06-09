%% ¡header!
ConverterST2CON < ConcreteElement (cn, converter of structural data to individual connectivity data) converts subject-level structural regional values into individual connectivity matrices.

%%% ¡description!
ConverterST2CON converts a group of SubjectST objects into a group of SubjectCON objects using ROI-based individual-connectome construction. It supports perturbation-based and Mahalanobis-distance approaches. The perturbation-based approach follows the individual molecular connectome strategy, constructing a reference partial-correlation network from a reference group, adding one target subject to construct a perturbed partial-correlation network, and calculating a z-score-like normalized deviation matrix. The reference population can be provided as an external group or estimated using leave-one-out from the converted group.

%%% ¡seealso!
Group, SubjectST, SubjectCON, BrainAtlas, BrainRegion, ConverterNeuroimaging2RegionalValues, ExporterGroupSubjectCON_XLS, ExporterBrainAtlasXLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the converter of structural data to individual connectivity data.
%%%% ¡default!
'ConverterST2CON'

%%% ¡prop!
NAME (constant, string) is the name of the converter of structural data to individual connectivity data.
%%%% ¡default!
'Structural-to-Connectivity Converter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the converter of structural data to individual connectivity data.
%%%% ¡default!
'ConverterST2CON converts subject-level structural regional values into individual connectivity matrices using perturbation-based or Mahalanobis-distance approaches.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the converter of structural data to individual connectivity data.
%%%% ¡settings!
'ConverterST2CON'

%%% ¡prop!
ID (data, string) is a few-letter code for the converter of structural data to individual connectivity data.
%%%% ¡default!
'ConverterST2CON ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the converter of structural data to individual connectivity data.
%%%% ¡default!
'ConverterST2CON label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the converter of structural data to individual connectivity data.
%%%% ¡default!
'ConverterST2CON notes'

%% ¡props!

%%% ¡prop!
GR_ST (data, item) is the group of subject-level structural regional values to convert.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))

%%% ¡prop!
GR_REFERENCE (data, item) is the external reference group of subject-level structural regional values.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))

%%% ¡prop!
METHOD (parameter, option) is the method used to construct individual connectivity matrices.
%%%% ¡settings!
{'perturbation' 'mahalanobis'}
%%%% ¡default!
'perturbation'

%%% ¡prop!
REFERENCE_MODE (parameter, option) is the rule used to define the reference population.
%%%% ¡settings!
{'external' 'leave-one-out'}
%%%% ¡default!
'external'

%%% ¡prop!
VOI_SELECTION (data, stringlist) is the list of variables of interest used as covariates for perturbation-based partial correlation; if empty or unavailable, ordinary correlation is used.
%%%% ¡default!
{'Age', 'Sex', 'Education'}

%%% ¡prop!
PERTURBATION_RULE (parameter, option) is the rule used to calculate the perturbation matrix.
%%%% ¡settings!
{'z_score' 'difference' 'absolute_difference'}
%%%% ¡default!
'z_score'

%%% ¡prop!
REGULARIZATION (parameter, scalar) is the covariance regularization used for Mahalanobis-distance calculation.
%%%% ¡default!
1e-6

%%% ¡prop!
OUTPUT_RULE (parameter, option) determines whether the output matrix stores raw distance/deviation values or similarity-like values.
%%%% ¡settings!
{'raw' 'similarity'}
%%%% ¡default!
'raw'

%%% ¡prop!
BA (query, item) is the brain atlas of the converted connectivity data.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡calculate!
gr_st = cn.get('GR_ST');

if gr_st.get('SUB_DICT').get('LENGTH') == 0
    value = BrainAtlas( ...
        'ID', 'StructuralConnectivityAtlas', ...
        'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion') ...
        );
    return
end

sub_st = gr_st.get('SUB_DICT').get('IT', 1);
value = sub_st.get('BA');

%%% ¡prop!
ST_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_ST.
%%%% ¡calculate!
gr_st = cn.get('GR_ST');
sub_dict = gr_st.get('SUB_DICT');
subject_number = sub_dict.get('LENGTH');

if subject_number == 0
    value = [];
    return
end

first_sub = sub_dict.get('IT', 1);
region_number = numel(first_sub.get('ST'));

st_matrix = nan(subject_number, region_number);

for sub_i = 1:subject_number
    sub = sub_dict.get('IT', sub_i);
    st = sub.get('ST');

    if numel(st) ~= region_number
        error('Subject %s has a different number of structural regional values.', sub.get('ID'))
    end

    st_matrix(sub_i, :) = reshape(st, 1, []);
end

value = st_matrix;

%%% ¡prop!
ST_REF_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_REFERENCE.
%%%% ¡calculate!
gr_reference = cn.get('GR_REFERENCE');
sub_dict = gr_reference.get('SUB_DICT');
subject_number = sub_dict.get('LENGTH');

if subject_number == 0
    value = [];
    return
end

first_sub = sub_dict.get('IT', 1);
region_number = numel(first_sub.get('ST'));

st_ref_matrix = nan(subject_number, region_number);

for sub_i = 1:subject_number
    sub = sub_dict.get('IT', sub_i);
    st = sub.get('ST');

    if numel(st) ~= region_number
        error('Reference subject %s has a different number of structural regional values.', sub.get('ID'))
    end

    st_ref_matrix(sub_i, :) = reshape(st, 1, []);
end

value = st_ref_matrix;

%%% ¡prop!
VOI_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_ST.
%%%% ¡calculate!
gr_st = cn.get('GR_ST');
voi_selection = cn.get('VOI_SELECTION');

value = cn.get('EXTRACT_VOI_MATRIX', gr_st, voi_selection);

%%% ¡prop!
VOI_REF_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_REFERENCE.
%%%% ¡calculate!
gr_reference = cn.get('GR_REFERENCE');
voi_selection = cn.get('VOI_SELECTION');

value = cn.get('EXTRACT_VOI_MATRIX', gr_reference, voi_selection);

%%% ¡prop!
EXTRACT_VOI_MATRIX (query, matrix) extracts selected VOIs from a SubjectST group as a numeric matrix.
%%%% ¡calculate!
gr = varargin{1};
voi_selection = varargin{2};

sub_dict = gr.get('SUB_DICT');
subject_number = sub_dict.get('LENGTH');

if isempty(voi_selection)
    value = [];
    return
end

voi_matrix = nan(subject_number, numel(voi_selection));

for sub_i = 1:subject_number
    sub = sub_dict.get('IT', sub_i);
    voi_dict = sub.get('VOI_DICT');

    for voi_i = 1:numel(voi_selection)
        voi_id = voi_selection{voi_i};
        voi_found = false;

        for dict_i = 1:voi_dict.get('LENGTH')
            voi = voi_dict.get('IT', dict_i);

            if strcmp(voi.get('ID'), voi_id)
                if isa(voi, 'VOINumeric')
                    voi_matrix(sub_i, voi_i) = voi.get('V');
                elseif isa(voi, 'VOICategoric')
                    voi_matrix(sub_i, voi_i) = voi.get('V');
                else
                    error('VOI %s in subject %s is neither VOINumeric nor VOICategoric.', voi_id, sub.get('ID'))
                end

                voi_found = true;
                break
            end
        end

        if ~voi_found
            error('VOI %s was not found in subject %s.', voi_id, sub.get('ID'))
        end
    end
end

value = voi_matrix;

%%% ¡prop!
REFERENCE_MATRIX_FOR_SUBJECT (query, matrix) returns the reference structural matrix for one target subject.
%%%% ¡calculate!
sub_i = varargin{1};

reference_mode = cn.get('REFERENCE_MODE');
st_matrix = cn.get('ST_MATRIX');

if strcmp(reference_mode, 'external')
    ref_matrix = cn.get('ST_REF_MATRIX');

    if isempty(ref_matrix)
        error('GR_REFERENCE must contain subjects when REFERENCE_MODE is external.')
    end

    value = ref_matrix;

elseif strcmp(reference_mode, 'leave-one-out')
    if size(st_matrix, 1) < 3
        error('Leave-one-out reference mode requires at least three subjects in GR_ST.')
    end

    ref_idx = setdiff(1:size(st_matrix, 1), sub_i);
    value = st_matrix(ref_idx, :);

else
    error('Unsupported REFERENCE_MODE: %s', reference_mode)
end

%%% ¡prop!
REFERENCE_VOI_MATRIX_FOR_SUBJECT (query, matrix) returns the reference VOI matrix for one target subject.
%%%% ¡calculate!
sub_i = varargin{1};

reference_mode = cn.get('REFERENCE_MODE');
voi_selection = cn.get('VOI_SELECTION');

if isempty(voi_selection)
    value = [];
    return
end

if strcmp(reference_mode, 'external')
    voi_ref_matrix = cn.get('VOI_REF_MATRIX');

    if isempty(voi_ref_matrix)
        error('GR_REFERENCE must contain VOIs when VOI_SELECTION is not empty and REFERENCE_MODE is external.')
    end

    value = voi_ref_matrix;

elseif strcmp(reference_mode, 'leave-one-out')
    voi_matrix = cn.get('VOI_MATRIX');

    if size(voi_matrix, 1) < 3
        error('Leave-one-out reference mode requires at least three subjects in GR_ST.')
    end

    ref_idx = setdiff(1:size(voi_matrix, 1), sub_i);
    value = voi_matrix(ref_idx, :);

else
    error('Unsupported REFERENCE_MODE: %s', reference_mode)
end

%%% ¡prop!
MAHALANOBIS_CONNECTOMES (query, cell) calculates Mahalanobis-distance individual connectivity matrices.
%%%% ¡calculate!
st_matrix = cn.get('ST_MATRIX');
regularization = cn.get('REGULARIZATION');
output_rule = cn.get('OUTPUT_RULE');

subject_number = size(st_matrix, 1);
region_number = size(st_matrix, 2);

connectomes = cell(1, subject_number);

wb = braph2waitbar(cn.get('WAITBAR'), 0, 'Calculating Mahalanobis-distance individual connectivity matrices ...');

for sub_i = 1:subject_number
    braph2waitbar(wb, sub_i / max(subject_number, 1), ...
        ['Calculating Mahalanobis connectome for subject ' num2str(sub_i) ' of ' num2str(subject_number) ' ...'])

    x = st_matrix(sub_i, :);
    ref_matrix = cn.get('REFERENCE_MATRIX_FOR_SUBJECT', sub_i);

    if size(ref_matrix, 2) ~= region_number
        error('Target and reference structural matrices have different numbers of regions.')
    end

    A = zeros(region_number, region_number);

    for i = 1:region_number
        for j = i:region_number
            ref_pair = ref_matrix(:, [i j]);
            x_pair = x([i j]);

            mu = mean(ref_pair, 1, 'omitnan');
            sigma = cov(ref_pair, 'omitrows');

            if any(isnan(mu)) || any(isnan(sigma(:)))
                d = NaN;
            else
                sigma = sigma + regularization * eye(2);
                delta = x_pair - mu;
                d = sqrt(delta / sigma * delta');
            end

            A(i, j) = d;
            A(j, i) = d;
        end
    end

    A(1:region_number + 1:end) = 0;

    if strcmp(output_rule, 'similarity')
        A = 1 ./ (1 + A);
        A(1:region_number + 1:end) = 0;
    end

    connectomes{sub_i} = A;
end

braph2waitbar(wb, 'close')

value = connectomes;

%%% ¡prop!
PERTURBATION_CONNECTOMES (query, cell) calculates perturbation-based individual connectivity matrices.
%%%% ¡calculate!
st_matrix = cn.get('ST_MATRIX');
voi_selection = cn.get('VOI_SELECTION');
perturbation_rule = cn.get('PERTURBATION_RULE');
output_rule = cn.get('OUTPUT_RULE');

subject_number = size(st_matrix, 1);
region_number = size(st_matrix, 2);

connectomes = cell(1, subject_number);

wb = braph2waitbar(cn.get('WAITBAR'), 0, 'Calculating perturbation-based individual connectivity matrices ...');

for sub_i = 1:subject_number
    braph2waitbar(wb, sub_i / max(subject_number, 1), ...
        ['Calculating perturbation connectome for subject ' num2str(sub_i) ' of ' num2str(subject_number) ' ...'])

    x = st_matrix(sub_i, :);
    ref_matrix = cn.get('REFERENCE_MATRIX_FOR_SUBJECT', sub_i);
    n_ref = size(ref_matrix, 1);

    if size(ref_matrix, 2) ~= region_number
        error('Target and reference structural matrices have different numbers of regions.')
    end

    if n_ref < 3
        error('Perturbation-based individual connectome construction requires at least three reference subjects.')
    end

    use_partialcorr = ~isempty(voi_selection);

    if use_partialcorr
        try
            voi_matrix = cn.get('VOI_MATRIX');
            ref_voi_matrix = cn.get('REFERENCE_VOI_MATRIX_FOR_SUBJECT', sub_i);
            x_voi = voi_matrix(sub_i, :);

            if size(ref_voi_matrix, 1) ~= n_ref
                warning('Reference structural matrix and reference VOI matrix have different numbers of subjects. Using ordinary correlation for subject %s.', ...
                    num2str(sub_i))
                use_partialcorr = false;
            end

            if use_partialcorr && size(ref_voi_matrix, 2) ~= numel(voi_selection)
                warning('Reference VOI matrix has a different number of covariates than VOI_SELECTION. Using ordinary correlation for subject %s.', ...
                    num2str(sub_i))
                use_partialcorr = false;
            end

            if use_partialcorr && (any(isnan(ref_voi_matrix(:))) || any(isnan(x_voi(:))))
                warning('Missing VOI values found for subject %s. Using ordinary correlation instead of partial correlation.', ...
                    num2str(sub_i))
                use_partialcorr = false;
            end

        catch
            warning('Selected VOIs are not fully available for subject %s. Using ordinary correlation instead of partial correlation.', ...
                num2str(sub_i))
            use_partialcorr = false;
        end
    end

    if use_partialcorr
        ref_corr = partialcorr(ref_matrix, ref_voi_matrix, 'Rows', 'pairwise');
        pert_corr = partialcorr([ref_matrix; x], [ref_voi_matrix; x_voi], 'Rows', 'pairwise');
    else
        ref_corr = corr(ref_matrix, 'Rows', 'pairwise');
        pert_corr = corr([ref_matrix; x], 'Rows', 'pairwise');
    end

    switch perturbation_rule
        case 'z_score'
            % Xu et al. paper-style perturbation:
            %
            %   A(i, j) = (PPCN+1(i, j) - PPCN(i, j)) ...
            %             / ((1 - PPCN(i, j)^2) / (N - 1))
            %
            % If VOI_SELECTION is empty or unavailable, ref_corr and pert_corr
            % are ordinary correlation networks. If VOI_SELECTION is complete,
            % they are partial-correlation networks adjusted for selected VOIs.
            denominator = (1 - ref_corr.^2) ./ (n_ref - 1);
            denominator(abs(denominator) < eps) = eps;

            A = (pert_corr - ref_corr) ./ denominator;

        case 'difference'
            A = pert_corr - ref_corr;

        case 'absolute_difference'
            A = abs(pert_corr - ref_corr);

        otherwise
            error('Unsupported PERTURBATION_RULE: %s', perturbation_rule)
    end

    A(isnan(A)) = 0;
    A(isinf(A)) = 0;
    A(1:region_number + 1:end) = 0;

    if strcmp(output_rule, 'similarity')
        A = abs(A);
        A(1:region_number + 1:end) = 0;
    end

    connectomes{sub_i} = A;
end

braph2waitbar(wb, 'close')

value = connectomes;

%%% ¡prop!
CONNECTOMES (query, cell) returns the individual connectivity matrices calculated by the selected method.
%%%% ¡calculate!
method = cn.get('METHOD');

switch method
    case 'perturbation'
        value = cn.get('PERTURBATION_CONNECTOMES');

    case 'mahalanobis'
        value = cn.get('MAHALANOBIS_CONNECTOMES');

    otherwise
        error('Unsupported METHOD: %s', method)
end

%%% ¡prop!
GR_CON (result, item) is the group of subjects with individual connectivity matrices.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
gr_st = cn.get('GR_ST');
ba = cn.get('BA');
connectomes = cn.get('CONNECTOMES');

gr_con = Group( ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
    );

sub_dict_con = gr_con.memorize('SUB_DICT');
sub_dict_st = gr_st.get('SUB_DICT');

for sub_i = 1:sub_dict_st.get('LENGTH')
    sub_st = sub_dict_st.get('IT', sub_i);

    sub_con = SubjectCON( ...
        'ID', sub_st.get('ID'), ...
        'LABEL', sub_st.get('LABEL'), ...
        'NOTES', sub_st.get('NOTES'), ...
        'BA', ba, ...
        'CON', connectomes{sub_i}, ...
        'VOI_DICT', sub_st.get('VOI_DICT') ...
        );

    sub_dict_con.get('ADD', sub_con);
end

value = gr_con;

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar.
%%%% ¡default!
true

%% ¡tests!

%%% ¡excluded_props!
[ConverterST2CON.ST_MATRIX ConverterST2CON.ST_REF_MATRIX ConverterST2CON.VOI_MATRIX ConverterST2CON.VOI_REF_MATRIX ConverterST2CON.EXTRACT_VOI_MATRIX ConverterST2CON.REFERENCE_MATRIX_FOR_SUBJECT ConverterST2CON.REFERENCE_VOI_MATRIX_FOR_SUBJECT ConverterST2CON.MAHALANOBIS_CONNECTOMES ConverterST2CON.PERTURBATION_CONNECTOMES ConverterST2CON.CONNECTOMES]

%%% ¡test!
%%%% ¡name!
Sanity check - Mahalanobis external reference
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx', 'WAITBAR', false);
ba = im_ba.get('BA');

region_number = 10;
subject_number = 8;
reference_number = 20;

br_list = {};
for i = 1:region_number
    br_list{end + 1} = ba.get('BR_DICT').get('IT', i); %#ok<AGROW>
end

ba_test = BrainAtlas( ...
    'ID', 'TestAtlas', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', br_list) ...
    );

gr_st = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));

for i = 1:subject_number
    sub = SubjectST( ...
        'ID', ['sub-' int2str(i)], ...
        'BA', ba_test, ...
        'ST', rand(region_number, 1) ...
        );

    gr_st.get('SUB_DICT').get('ADD', sub)
end

gr_reference = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));

for i = 1:reference_number
    sub = SubjectST( ...
        'ID', ['ref-' int2str(i)], ...
        'BA', ba_test, ...
        'ST', rand(region_number, 1) ...
        );

    gr_reference.get('SUB_DICT').get('ADD', sub)
end

cn = ConverterST2CON( ...
    'GR_ST', gr_st, ...
    'GR_REFERENCE', gr_reference, ...
    'METHOD', 'mahalanobis', ...
    'REFERENCE_MODE', 'external', ...
    'WAITBAR', false ...
    );

gr_con = cn.get('GR_CON');

assert(isequal(gr_con.get('SUB_DICT').get('LENGTH'), subject_number), ...
    'The converted group should contain the same number of subjects as GR_ST.')

sub_con = gr_con.get('SUB_DICT').get('IT', 1);
con = sub_con.get('CON');

assert(isequal(size(con), [region_number region_number]), ...
    'The converted connectivity matrix should have region_number-by-region_number size.')

assert(isequal(con, con'), ...
    'The Mahalanobis connectivity matrix should be symmetric.')

assert(all(diag(con) == 0), ...
    'The Mahalanobis connectivity matrix should have zero diagonal.')

%%% ¡test!
%%%% ¡name!
Sanity check - Paper-style perturbation external reference
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx', 'WAITBAR', false);
ba = im_ba.get('BA');

region_number = 10;
subject_number = 8;
reference_number = 20;

br_list = {};
for i = 1:region_number
    br_list{end + 1} = ba.get('BR_DICT').get('IT', i); %#ok<AGROW>
end

ba_test = BrainAtlas( ...
    'ID', 'TestAtlas', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', br_list) ...
    );

gr_st = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));

for i = 1:subject_number
    sub = SubjectST( ...
        'ID', ['sub-' int2str(i)], ...
        'BA', ba_test, ...
        'ST', rand(region_number, 1) ...
        );

    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 60 + i))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', 1 + mod(i, 2)))
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Education', 'V', 12 + mod(i, 8)))

    gr_st.get('SUB_DICT').get('ADD', sub)
end

gr_reference = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));

for i = 1:reference_number
    sub = SubjectST( ...
        'ID', ['ref-' int2str(i)], ...
        'BA', ba_test, ...
        'ST', rand(region_number, 1) ...
        );

    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 60 + i))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', 1 + mod(i, 2)))
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Education', 'V', 12 + mod(i, 8)))

    gr_reference.get('SUB_DICT').get('ADD', sub)
end

cn = ConverterST2CON( ...
    'GR_ST', gr_st, ...
    'GR_REFERENCE', gr_reference, ...
    'WAITBAR', false ...
    );

gr_con = cn.get('GR_CON');

assert(isequal(gr_con.get('SUB_DICT').get('LENGTH'), subject_number), ...
    'The converted group should contain the same number of subjects as GR_ST.')

sub_con = gr_con.get('SUB_DICT').get('IT', 1);
con = sub_con.get('CON');

assert(isequal(size(con), [region_number region_number]), ...
    'The converted connectivity matrix should have region_number-by-region_number size.')

assert(isequal(con, con'), ...
    'The perturbation connectivity matrix should be symmetric.')

assert(all(diag(con) == 0), ...
    'The perturbation connectivity matrix should have zero diagonal.')

%%% ¡test!
%%%% ¡name!
Sanity check - Perturbation leave-one-out
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx', 'WAITBAR', false);
ba = im_ba.get('BA');

region_number = 10;
subject_number = 20;

br_list = {};
for i = 1:region_number
    br_list{end + 1} = ba.get('BR_DICT').get('IT', i); %#ok<AGROW>
end

ba_test = BrainAtlas( ...
    'ID', 'TestAtlas', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', br_list) ...
    );

gr_st = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));

for i = 1:subject_number
    sub = SubjectST( ...
        'ID', ['sub-' int2str(i)], ...
        'BA', ba_test, ...
        'ST', rand(region_number, 1) ...
        );

    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 20 + i))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', 1 + mod(i, 2)))

    gr_st.get('SUB_DICT').get('ADD', sub)
end

cn = ConverterST2CON( ...
    'GR_ST', gr_st, ...
    'METHOD', 'perturbation', ...
    'REFERENCE_MODE', 'leave-one-out', ...
    'VOI_SELECTION', {'Age', 'Sex'}, ...
    'PERTURBATION_RULE', 'absolute_difference', ...
    'WAITBAR', false ...
    );

gr_con = cn.get('GR_CON');

assert(isequal(gr_con.get('SUB_DICT').get('LENGTH'), subject_number), ...
    'The converted group should contain the same number of subjects as GR_ST.')

sub_con = gr_con.get('SUB_DICT').get('IT', 1);
con = sub_con.get('CON');

assert(isequal(size(con), [region_number region_number]), ...
    'The converted connectivity matrix should have region_number-by-region_number size.')

assert(isequal(con, con'), ...
    'The perturbation connectivity matrix should be symmetric.')

assert(all(diag(con) == 0), ...
    'The perturbation connectivity matrix should have zero diagonal.')
