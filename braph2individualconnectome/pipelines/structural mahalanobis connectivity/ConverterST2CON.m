classdef ConverterST2CON < ConcreteElement
	%ConverterST2CON converts subject-level structural regional values into individual connectivity matrices.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% ConverterST2CON converts a group of SubjectST objects into a group of SubjectCON objects using ROI-based individual-connectome construction. It supports perturbation-based and Mahalanobis-distance approaches. The perturbation-based approach follows the individual molecular connectome strategy, constructing a reference partial-correlation network from a reference group, adding one target subject to construct a perturbed partial-correlation network, and calculating a z-score-like normalized deviation matrix. The reference population can be provided as an external group or estimated using leave-one-out from the converted group.
	%
	% The list of ConverterST2CON properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the converter of structural data to individual connectivity data.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the converter of structural data to individual connectivity data.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the converter of structural data to individual connectivity data.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the converter of structural data to individual connectivity data.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the converter of structural data to individual connectivity data.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the converter of structural data to individual connectivity data.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the converter of structural data to individual connectivity data.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>GR_ST</strong> 	GR_ST (data, item) is the group of subject-level structural regional values to convert.
	%  <strong>10</strong> <strong>GR_REFERENCE</strong> 	GR_REFERENCE (data, item) is the external reference group of subject-level structural regional values.
	%  <strong>11</strong> <strong>METHOD</strong> 	METHOD (parameter, option) is the method used to construct individual connectivity matrices.
	%  <strong>12</strong> <strong>REFERENCE_MODE</strong> 	REFERENCE_MODE (parameter, option) is the rule used to define the reference population.
	%  <strong>13</strong> <strong>VOI_SELECTION</strong> 	VOI_SELECTION (data, stringlist) is the list of variables of interest used as covariates for perturbation-based partial correlation; if empty or unavailable, ordinary correlation is used.
	%  <strong>14</strong> <strong>PERTURBATION_RULE</strong> 	PERTURBATION_RULE (parameter, option) is the rule used to calculate the perturbation matrix.
	%  <strong>15</strong> <strong>REGULARIZATION</strong> 	REGULARIZATION (parameter, scalar) is the covariance regularization used for Mahalanobis-distance calculation.
	%  <strong>16</strong> <strong>OUTPUT_RULE</strong> 	OUTPUT_RULE (parameter, option) determines whether the output matrix stores raw distance/deviation values or similarity-like values.
	%  <strong>17</strong> <strong>BA</strong> 	BA (query, item) is the brain atlas of the converted connectivity data.
	%  <strong>18</strong> <strong>ST_MATRIX</strong> 	ST_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_ST.
	%  <strong>19</strong> <strong>ST_REF_MATRIX</strong> 	ST_REF_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_REFERENCE.
	%  <strong>20</strong> <strong>VOI_MATRIX</strong> 	VOI_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_ST.
	%  <strong>21</strong> <strong>VOI_REF_MATRIX</strong> 	VOI_REF_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_REFERENCE.
	%  <strong>22</strong> <strong>EXTRACT_VOI_MATRIX</strong> 	EXTRACT_VOI_MATRIX (query, matrix) extracts selected VOIs from a SubjectST group as a numeric matrix.
	%  <strong>23</strong> <strong>REFERENCE_MATRIX_FOR_SUBJECT</strong> 	REFERENCE_MATRIX_FOR_SUBJECT (query, matrix) returns the reference structural matrix for one target subject.
	%  <strong>24</strong> <strong>REFERENCE_VOI_MATRIX_FOR_SUBJECT</strong> 	REFERENCE_VOI_MATRIX_FOR_SUBJECT (query, matrix) returns the reference VOI matrix for one target subject.
	%  <strong>25</strong> <strong>MAHALANOBIS_CONNECTOMES</strong> 	MAHALANOBIS_CONNECTOMES (query, cell) calculates Mahalanobis-distance individual connectivity matrices.
	%  <strong>26</strong> <strong>PERTURBATION_CONNECTOMES</strong> 	PERTURBATION_CONNECTOMES (query, cell) calculates perturbation-based individual connectivity matrices.
	%  <strong>27</strong> <strong>CONNECTOMES</strong> 	CONNECTOMES (query, cell) returns the individual connectivity matrices calculated by the selected method.
	%  <strong>28</strong> <strong>GR_CON</strong> 	GR_CON (result, item) is the group of subjects with individual connectivity matrices.
	%  <strong>29</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%
	% ConverterST2CON methods (constructor):
	%  ConverterST2CON - constructor
	%
	% ConverterST2CON methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% ConverterST2CON methods (display):
	%  tostring - string with information about the converter of structural data to individual connectivity data
	%  disp - displays information about the converter of structural data to individual connectivity data
	%  tree - displays the tree of the converter of structural data to individual connectivity data
	%
	% ConverterST2CON methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two converter of structural data to individual connectivity data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the converter of structural data to individual connectivity data
	%
	% ConverterST2CON methods (save/load, Static):
	%  save - saves BRAPH2 converter of structural data to individual connectivity data as b2 file
	%  load - loads a BRAPH2 converter of structural data to individual connectivity data from a b2 file
	%
	% ConverterST2CON method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the converter of structural data to individual connectivity data
	%
	% ConverterST2CON method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the converter of structural data to individual connectivity data
	%
	% ConverterST2CON methods (inspection, Static):
	%  getClass - returns the class of the converter of structural data to individual connectivity data
	%  getSubclasses - returns all subclasses of ConverterST2CON
	%  getProps - returns the property list of the converter of structural data to individual connectivity data
	%  getPropNumber - returns the property number of the converter of structural data to individual connectivity data
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% ConverterST2CON methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConverterST2CON methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConverterST2CON methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConverterST2CON methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConverterST2CON; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConverterST2CON constants</a>.
	%
	%
	% See also Group, SubjectST, SubjectCON, BrainAtlas, BrainRegion, ConverterNeuroimaging2RegionalValues, ExporterGroupSubjectCON_XLS, ExporterBrainAtlasXLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		GR_ST = 9; %CET: Computational Efficiency Trick
		GR_ST_TAG = 'GR_ST';
		GR_ST_CATEGORY = 4;
		GR_ST_FORMAT = 8;
		
		GR_REFERENCE = 10; %CET: Computational Efficiency Trick
		GR_REFERENCE_TAG = 'GR_REFERENCE';
		GR_REFERENCE_CATEGORY = 4;
		GR_REFERENCE_FORMAT = 8;
		
		METHOD = 11; %CET: Computational Efficiency Trick
		METHOD_TAG = 'METHOD';
		METHOD_CATEGORY = 3;
		METHOD_FORMAT = 5;
		
		REFERENCE_MODE = 12; %CET: Computational Efficiency Trick
		REFERENCE_MODE_TAG = 'REFERENCE_MODE';
		REFERENCE_MODE_CATEGORY = 3;
		REFERENCE_MODE_FORMAT = 5;
		
		VOI_SELECTION = 13; %CET: Computational Efficiency Trick
		VOI_SELECTION_TAG = 'VOI_SELECTION';
		VOI_SELECTION_CATEGORY = 4;
		VOI_SELECTION_FORMAT = 3;
		
		PERTURBATION_RULE = 14; %CET: Computational Efficiency Trick
		PERTURBATION_RULE_TAG = 'PERTURBATION_RULE';
		PERTURBATION_RULE_CATEGORY = 3;
		PERTURBATION_RULE_FORMAT = 5;
		
		REGULARIZATION = 15; %CET: Computational Efficiency Trick
		REGULARIZATION_TAG = 'REGULARIZATION';
		REGULARIZATION_CATEGORY = 3;
		REGULARIZATION_FORMAT = 11;
		
		OUTPUT_RULE = 16; %CET: Computational Efficiency Trick
		OUTPUT_RULE_TAG = 'OUTPUT_RULE';
		OUTPUT_RULE_CATEGORY = 3;
		OUTPUT_RULE_FORMAT = 5;
		
		BA = 17; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 6;
		BA_FORMAT = 8;
		
		ST_MATRIX = 18; %CET: Computational Efficiency Trick
		ST_MATRIX_TAG = 'ST_MATRIX';
		ST_MATRIX_CATEGORY = 6;
		ST_MATRIX_FORMAT = 14;
		
		ST_REF_MATRIX = 19; %CET: Computational Efficiency Trick
		ST_REF_MATRIX_TAG = 'ST_REF_MATRIX';
		ST_REF_MATRIX_CATEGORY = 6;
		ST_REF_MATRIX_FORMAT = 14;
		
		VOI_MATRIX = 20; %CET: Computational Efficiency Trick
		VOI_MATRIX_TAG = 'VOI_MATRIX';
		VOI_MATRIX_CATEGORY = 6;
		VOI_MATRIX_FORMAT = 14;
		
		VOI_REF_MATRIX = 21; %CET: Computational Efficiency Trick
		VOI_REF_MATRIX_TAG = 'VOI_REF_MATRIX';
		VOI_REF_MATRIX_CATEGORY = 6;
		VOI_REF_MATRIX_FORMAT = 14;
		
		EXTRACT_VOI_MATRIX = 22; %CET: Computational Efficiency Trick
		EXTRACT_VOI_MATRIX_TAG = 'EXTRACT_VOI_MATRIX';
		EXTRACT_VOI_MATRIX_CATEGORY = 6;
		EXTRACT_VOI_MATRIX_FORMAT = 14;
		
		REFERENCE_MATRIX_FOR_SUBJECT = 23; %CET: Computational Efficiency Trick
		REFERENCE_MATRIX_FOR_SUBJECT_TAG = 'REFERENCE_MATRIX_FOR_SUBJECT';
		REFERENCE_MATRIX_FOR_SUBJECT_CATEGORY = 6;
		REFERENCE_MATRIX_FOR_SUBJECT_FORMAT = 14;
		
		REFERENCE_VOI_MATRIX_FOR_SUBJECT = 24; %CET: Computational Efficiency Trick
		REFERENCE_VOI_MATRIX_FOR_SUBJECT_TAG = 'REFERENCE_VOI_MATRIX_FOR_SUBJECT';
		REFERENCE_VOI_MATRIX_FOR_SUBJECT_CATEGORY = 6;
		REFERENCE_VOI_MATRIX_FOR_SUBJECT_FORMAT = 14;
		
		MAHALANOBIS_CONNECTOMES = 25; %CET: Computational Efficiency Trick
		MAHALANOBIS_CONNECTOMES_TAG = 'MAHALANOBIS_CONNECTOMES';
		MAHALANOBIS_CONNECTOMES_CATEGORY = 6;
		MAHALANOBIS_CONNECTOMES_FORMAT = 16;
		
		PERTURBATION_CONNECTOMES = 26; %CET: Computational Efficiency Trick
		PERTURBATION_CONNECTOMES_TAG = 'PERTURBATION_CONNECTOMES';
		PERTURBATION_CONNECTOMES_CATEGORY = 6;
		PERTURBATION_CONNECTOMES_FORMAT = 16;
		
		CONNECTOMES = 27; %CET: Computational Efficiency Trick
		CONNECTOMES_TAG = 'CONNECTOMES';
		CONNECTOMES_CATEGORY = 6;
		CONNECTOMES_FORMAT = 16;
		
		GR_CON = 28; %CET: Computational Efficiency Trick
		GR_CON_TAG = 'GR_CON';
		GR_CON_CATEGORY = 5;
		GR_CON_FORMAT = 8;
		
		WAITBAR = 29; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
	end
	methods % constructor
		function cn = ConverterST2CON(varargin)
			%ConverterST2CON() creates a converter of structural data to individual connectivity data.
			%
			% ConverterST2CON(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConverterST2CON(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ConverterST2CON properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the converter of structural data to individual connectivity data.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the converter of structural data to individual connectivity data.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the converter of structural data to individual connectivity data.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the converter of structural data to individual connectivity data.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the converter of structural data to individual connectivity data.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the converter of structural data to individual connectivity data.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the converter of structural data to individual connectivity data.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>GR_ST</strong> 	GR_ST (data, item) is the group of subject-level structural regional values to convert.
			%  <strong>10</strong> <strong>GR_REFERENCE</strong> 	GR_REFERENCE (data, item) is the external reference group of subject-level structural regional values.
			%  <strong>11</strong> <strong>METHOD</strong> 	METHOD (parameter, option) is the method used to construct individual connectivity matrices.
			%  <strong>12</strong> <strong>REFERENCE_MODE</strong> 	REFERENCE_MODE (parameter, option) is the rule used to define the reference population.
			%  <strong>13</strong> <strong>VOI_SELECTION</strong> 	VOI_SELECTION (data, stringlist) is the list of variables of interest used as covariates for perturbation-based partial correlation; if empty or unavailable, ordinary correlation is used.
			%  <strong>14</strong> <strong>PERTURBATION_RULE</strong> 	PERTURBATION_RULE (parameter, option) is the rule used to calculate the perturbation matrix.
			%  <strong>15</strong> <strong>REGULARIZATION</strong> 	REGULARIZATION (parameter, scalar) is the covariance regularization used for Mahalanobis-distance calculation.
			%  <strong>16</strong> <strong>OUTPUT_RULE</strong> 	OUTPUT_RULE (parameter, option) determines whether the output matrix stores raw distance/deviation values or similarity-like values.
			%  <strong>17</strong> <strong>BA</strong> 	BA (query, item) is the brain atlas of the converted connectivity data.
			%  <strong>18</strong> <strong>ST_MATRIX</strong> 	ST_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_ST.
			%  <strong>19</strong> <strong>ST_REF_MATRIX</strong> 	ST_REF_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_REFERENCE.
			%  <strong>20</strong> <strong>VOI_MATRIX</strong> 	VOI_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_ST.
			%  <strong>21</strong> <strong>VOI_REF_MATRIX</strong> 	VOI_REF_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_REFERENCE.
			%  <strong>22</strong> <strong>EXTRACT_VOI_MATRIX</strong> 	EXTRACT_VOI_MATRIX (query, matrix) extracts selected VOIs from a SubjectST group as a numeric matrix.
			%  <strong>23</strong> <strong>REFERENCE_MATRIX_FOR_SUBJECT</strong> 	REFERENCE_MATRIX_FOR_SUBJECT (query, matrix) returns the reference structural matrix for one target subject.
			%  <strong>24</strong> <strong>REFERENCE_VOI_MATRIX_FOR_SUBJECT</strong> 	REFERENCE_VOI_MATRIX_FOR_SUBJECT (query, matrix) returns the reference VOI matrix for one target subject.
			%  <strong>25</strong> <strong>MAHALANOBIS_CONNECTOMES</strong> 	MAHALANOBIS_CONNECTOMES (query, cell) calculates Mahalanobis-distance individual connectivity matrices.
			%  <strong>26</strong> <strong>PERTURBATION_CONNECTOMES</strong> 	PERTURBATION_CONNECTOMES (query, cell) calculates perturbation-based individual connectivity matrices.
			%  <strong>27</strong> <strong>CONNECTOMES</strong> 	CONNECTOMES (query, cell) returns the individual connectivity matrices calculated by the selected method.
			%  <strong>28</strong> <strong>GR_CON</strong> 	GR_CON (result, item) is the group of subjects with individual connectivity matrices.
			%  <strong>29</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%
			% See also Category, Format.
			
			cn = cn@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the converter of structural data to individual connectivity data.
			%
			% BUILD = ConverterST2CON.GETBUILD() returns the build of 'ConverterST2CON'.
			%
			% Alternative forms to call this method are:
			%  BUILD = CN.GETBUILD() returns the build of the converter of structural data to individual connectivity data CN.
			%  BUILD = Element.GETBUILD(CN) returns the build of 'CN'.
			%  BUILD = Element.GETBUILD('ConverterST2CON') returns the build of 'ConverterST2CON'.
			%
			% Note that the Element.GETBUILD(CN) and Element.GETBUILD('ConverterST2CON')
			%  are less computationally efficient.
			
			build = 1;
		end
		function cn_class = getClass()
			%GETCLASS returns the class of the converter of structural data to individual connectivity data.
			%
			% CLASS = ConverterST2CON.GETCLASS() returns the class 'ConverterST2CON'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CN.GETCLASS() returns the class of the converter of structural data to individual connectivity data CN.
			%  CLASS = Element.GETCLASS(CN) returns the class of 'CN'.
			%  CLASS = Element.GETCLASS('ConverterST2CON') returns 'ConverterST2CON'.
			%
			% Note that the Element.GETCLASS(CN) and Element.GETCLASS('ConverterST2CON')
			%  are less computationally efficient.
			
			cn_class = 'ConverterST2CON';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the converter of structural data to individual connectivity data.
			%
			% LIST = ConverterST2CON.GETSUBCLASSES() returns all subclasses of 'ConverterST2CON'.
			%
			% Alternative forms to call this method are:
			%  LIST = CN.GETSUBCLASSES() returns all subclasses of the converter of structural data to individual connectivity data CN.
			%  LIST = Element.GETSUBCLASSES(CN) returns all subclasses of 'CN'.
			%  LIST = Element.GETSUBCLASSES('ConverterST2CON') returns all subclasses of 'ConverterST2CON'.
			%
			% Note that the Element.GETSUBCLASSES(CN) and Element.GETSUBCLASSES('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ConverterST2CON' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of converter of structural data to individual connectivity data.
			%
			% PROPS = ConverterST2CON.GETPROPS() returns the property list of converter of structural data to individual connectivity data
			%  as a row vector.
			%
			% PROPS = ConverterST2CON.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CN.GETPROPS([CATEGORY]) returns the property list of the converter of structural data to individual connectivity data CN.
			%  PROPS = Element.GETPROPS(CN[, CATEGORY]) returns the property list of 'CN'.
			%  PROPS = Element.GETPROPS('ConverterST2CON'[, CATEGORY]) returns the property list of 'ConverterST2CON'.
			%
			% Note that the Element.GETPROPS(CN) and Element.GETPROPS('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 11 12 14 15 16];
				case 4 % Category.DATA
					prop_list = [5 9 10 13];
				case 5 % Category.RESULT
					prop_list = 28;
				case 6 % Category.QUERY
					prop_list = [8 17 18 19 20 21 22 23 24 25 26 27];
				case 9 % Category.GUI
					prop_list = 29;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of converter of structural data to individual connectivity data.
			%
			% N = ConverterST2CON.GETPROPNUMBER() returns the property number of converter of structural data to individual connectivity data.
			%
			% N = ConverterST2CON.GETPROPNUMBER(CATEGORY) returns the property number of converter of structural data to individual connectivity data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CN.GETPROPNUMBER([CATEGORY]) returns the property number of the converter of structural data to individual connectivity data CN.
			%  N = Element.GETPROPNUMBER(CN) returns the property number of 'CN'.
			%  N = Element.GETPROPNUMBER('ConverterST2CON') returns the property number of 'ConverterST2CON'.
			%
			% Note that the Element.GETPROPNUMBER(CN) and Element.GETPROPNUMBER('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 29;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 6;
				case 4 % Category.DATA
					prop_number = 4;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 12;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in converter of structural data to individual connectivity data/error.
			%
			% CHECK = ConverterST2CON.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CN.EXISTSPROP(PROP) checks whether PROP exists for CN.
			%  CHECK = Element.EXISTSPROP(CN, PROP) checks whether PROP exists for CN.
			%  CHECK = Element.EXISTSPROP(ConverterST2CON, PROP) checks whether PROP exists for ConverterST2CON.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CN.EXISTSPROP(PROP) throws error if PROP does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%  Element.EXISTSPROP(CN, PROP) throws error if PROP does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%  Element.EXISTSPROP(ConverterST2CON, PROP) throws error if PROP does NOT exist for ConverterST2CON.
			%   Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CN) and Element.EXISTSPROP('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 29 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterST2CON:' 'WrongInput'], ...
					['BRAPH2' ':ConverterST2CON:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConverterST2CON.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in converter of structural data to individual connectivity data/error.
			%
			% CHECK = ConverterST2CON.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CN.EXISTSTAG(TAG) checks whether TAG exists for CN.
			%  CHECK = Element.EXISTSTAG(CN, TAG) checks whether TAG exists for CN.
			%  CHECK = Element.EXISTSTAG(ConverterST2CON, TAG) checks whether TAG exists for ConverterST2CON.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CN.EXISTSTAG(TAG) throws error if TAG does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%  Element.EXISTSTAG(CN, TAG) throws error if TAG does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%  Element.EXISTSTAG(ConverterST2CON, TAG) throws error if TAG does NOT exist for ConverterST2CON.
			%   Error id: [BRAPH2:ConverterST2CON:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CN) and Element.EXISTSTAG('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GR_ST'  'GR_REFERENCE'  'METHOD'  'REFERENCE_MODE'  'VOI_SELECTION'  'PERTURBATION_RULE'  'REGULARIZATION'  'OUTPUT_RULE'  'BA'  'ST_MATRIX'  'ST_REF_MATRIX'  'VOI_MATRIX'  'VOI_REF_MATRIX'  'EXTRACT_VOI_MATRIX'  'REFERENCE_MATRIX_FOR_SUBJECT'  'REFERENCE_VOI_MATRIX_FOR_SUBJECT'  'MAHALANOBIS_CONNECTOMES'  'PERTURBATION_CONNECTOMES'  'CONNECTOMES'  'GR_CON'  'WAITBAR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterST2CON:' 'WrongInput'], ...
					['BRAPH2' ':ConverterST2CON:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ConverterST2CON.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = CN.GETPROPPROP(POINTER) returns property number of POINTER of CN.
			%  PROPERTY = Element.GETPROPPROP(ConverterST2CON, POINTER) returns property number of POINTER of ConverterST2CON.
			%  PROPERTY = CN.GETPROPPROP(ConverterST2CON, POINTER) returns property number of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPPROP(CN) and Element.GETPROPPROP('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GR_ST'  'GR_REFERENCE'  'METHOD'  'REFERENCE_MODE'  'VOI_SELECTION'  'PERTURBATION_RULE'  'REGULARIZATION'  'OUTPUT_RULE'  'BA'  'ST_MATRIX'  'ST_REF_MATRIX'  'VOI_MATRIX'  'VOI_REF_MATRIX'  'EXTRACT_VOI_MATRIX'  'REFERENCE_MATRIX_FOR_SUBJECT'  'REFERENCE_VOI_MATRIX_FOR_SUBJECT'  'MAHALANOBIS_CONNECTOMES'  'PERTURBATION_CONNECTOMES'  'CONNECTOMES'  'GR_CON'  'WAITBAR' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = CN.GETPROPTAG(POINTER) returns tag of POINTER of CN.
			%  TAG = Element.GETPROPTAG(ConverterST2CON, POINTER) returns tag of POINTER of ConverterST2CON.
			%  TAG = CN.GETPROPTAG(ConverterST2CON, POINTER) returns tag of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPTAG(CN) and Element.GETPROPTAG('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				converterst2con_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GR_ST'  'GR_REFERENCE'  'METHOD'  'REFERENCE_MODE'  'VOI_SELECTION'  'PERTURBATION_RULE'  'REGULARIZATION'  'OUTPUT_RULE'  'BA'  'ST_MATRIX'  'ST_REF_MATRIX'  'VOI_MATRIX'  'VOI_REF_MATRIX'  'EXTRACT_VOI_MATRIX'  'REFERENCE_MATRIX_FOR_SUBJECT'  'REFERENCE_VOI_MATRIX_FOR_SUBJECT'  'MAHALANOBIS_CONNECTOMES'  'PERTURBATION_CONNECTOMES'  'CONNECTOMES'  'GR_CON'  'WAITBAR' };
				tag = converterst2con_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = CN.GETPROPCATEGORY(POINTER) returns category of POINTER of CN.
			%  CATEGORY = Element.GETPROPCATEGORY(ConverterST2CON, POINTER) returns category of POINTER of ConverterST2CON.
			%  CATEGORY = CN.GETPROPCATEGORY(ConverterST2CON, POINTER) returns category of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPCATEGORY(CN) and Element.GETPROPCATEGORY('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterST2CON.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterst2con_category_list = { 1  1  1  3  4  2  2  6  4  4  3  3  4  3  3  3  6  6  6  6  6  6  6  6  6  6  6  5  9 };
			prop_category = converterst2con_category_list{prop};
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = CN.GETPROPFORMAT(POINTER) returns format of POINTER of CN.
			%  FORMAT = Element.GETPROPFORMAT(ConverterST2CON, POINTER) returns format of POINTER of ConverterST2CON.
			%  FORMAT = CN.GETPROPFORMAT(ConverterST2CON, POINTER) returns format of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPFORMAT(CN) and Element.GETPROPFORMAT('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterST2CON.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterst2con_format_list = { 2  2  2  8  2  2  2  2  8  8  5  5  3  5  11  5  8  14  14  14  14  14  14  14  16  16  16  8  4 };
			prop_format = converterst2con_format_list{prop};
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = CN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConverterST2CON, POINTER) returns description of POINTER of ConverterST2CON.
			%  DESCRIPTION = CN.GETPROPDESCRIPTION(ConverterST2CON, POINTER) returns description of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPDESCRIPTION(CN) and Element.GETPROPDESCRIPTION('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterST2CON.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterst2con_description_list = { 'ELCLASS (constant, string) is the class of the converter of structural data to individual connectivity data.'  'NAME (constant, string) is the name of the converter of structural data to individual connectivity data.'  'DESCRIPTION (constant, string) is the description of the converter of structural data to individual connectivity data.'  'TEMPLATE (parameter, item) is the template of the converter of structural data to individual connectivity data.'  'ID (data, string) is a few-letter code for the converter of structural data to individual connectivity data.'  'LABEL (metadata, string) is an extended label of the converter of structural data to individual connectivity data.'  'NOTES (metadata, string) are some specific notes about the converter of structural data to individual connectivity data.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'GR_ST (data, item) is the group of subject-level structural regional values to convert.'  'GR_REFERENCE (data, item) is the external reference group of subject-level structural regional values.'  'METHOD (parameter, option) is the method used to construct individual connectivity matrices.'  'REFERENCE_MODE (parameter, option) is the rule used to define the reference population.'  'VOI_SELECTION (data, stringlist) is the list of variables of interest used as covariates for perturbation-based partial correlation; if empty or unavailable, ordinary correlation is used.'  'PERTURBATION_RULE (parameter, option) is the rule used to calculate the perturbation matrix.'  'REGULARIZATION (parameter, scalar) is the covariance regularization used for Mahalanobis-distance calculation.'  'OUTPUT_RULE (parameter, option) determines whether the output matrix stores raw distance/deviation values or similarity-like values.'  'BA (query, item) is the brain atlas of the converted connectivity data.'  'ST_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_ST.'  'ST_REF_MATRIX (query, matrix) is the subject-by-region structural matrix of GR_REFERENCE.'  'VOI_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_ST.'  'VOI_REF_MATRIX (query, matrix) is the subject-by-covariate VOI matrix of GR_REFERENCE.'  'EXTRACT_VOI_MATRIX (query, matrix) extracts selected VOIs from a SubjectST group as a numeric matrix.'  'REFERENCE_MATRIX_FOR_SUBJECT (query, matrix) returns the reference structural matrix for one target subject.'  'REFERENCE_VOI_MATRIX_FOR_SUBJECT (query, matrix) returns the reference VOI matrix for one target subject.'  'MAHALANOBIS_CONNECTOMES (query, cell) calculates Mahalanobis-distance individual connectivity matrices.'  'PERTURBATION_CONNECTOMES (query, cell) calculates perturbation-based individual connectivity matrices.'  'CONNECTOMES (query, cell) returns the individual connectivity matrices calculated by the selected method.'  'GR_CON (result, item) is the group of subjects with individual connectivity matrices.'  'WAITBAR (gui, logical) determines whether to show the waitbar.' };
			prop_description = converterst2con_description_list{prop};
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = CN.GETPROPSETTINGS(POINTER) returns settings of POINTER of CN.
			%  SETTINGS = Element.GETPROPSETTINGS(ConverterST2CON, POINTER) returns settings of POINTER of ConverterST2CON.
			%  SETTINGS = CN.GETPROPSETTINGS(ConverterST2CON, POINTER) returns settings of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPSETTINGS(CN) and Element.GETPROPSETTINGS('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterST2CON.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConverterST2CON.GR_ST
					prop_settings = 'Group';
				case 10 % ConverterST2CON.GR_REFERENCE
					prop_settings = 'Group';
				case 11 % ConverterST2CON.METHOD
					prop_settings = {'perturbation' 'mahalanobis'};
				case 12 % ConverterST2CON.REFERENCE_MODE
					prop_settings = {'external' 'leave-one-out'};
				case 13 % ConverterST2CON.VOI_SELECTION
					prop_settings = Format.getFormatSettings(3);
				case 14 % ConverterST2CON.PERTURBATION_RULE
					prop_settings = {'z_score' 'difference' 'absolute_difference'};
				case 15 % ConverterST2CON.REGULARIZATION
					prop_settings = Format.getFormatSettings(11);
				case 16 % ConverterST2CON.OUTPUT_RULE
					prop_settings = {'raw' 'similarity'};
				case 17 % ConverterST2CON.BA
					prop_settings = 'BrainAtlas';
				case 18 % ConverterST2CON.ST_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 19 % ConverterST2CON.ST_REF_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 20 % ConverterST2CON.VOI_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 21 % ConverterST2CON.VOI_REF_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 22 % ConverterST2CON.EXTRACT_VOI_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 23 % ConverterST2CON.REFERENCE_MATRIX_FOR_SUBJECT
					prop_settings = Format.getFormatSettings(14);
				case 24 % ConverterST2CON.REFERENCE_VOI_MATRIX_FOR_SUBJECT
					prop_settings = Format.getFormatSettings(14);
				case 25 % ConverterST2CON.MAHALANOBIS_CONNECTOMES
					prop_settings = Format.getFormatSettings(16);
				case 26 % ConverterST2CON.PERTURBATION_CONNECTOMES
					prop_settings = Format.getFormatSettings(16);
				case 27 % ConverterST2CON.CONNECTOMES
					prop_settings = Format.getFormatSettings(16);
				case 28 % ConverterST2CON.GR_CON
					prop_settings = 'Group';
				case 29 % ConverterST2CON.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 4 % ConverterST2CON.TEMPLATE
					prop_settings = 'ConverterST2CON';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConverterST2CON.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterST2CON.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CN.
			%  DEFAULT = Element.GETPROPDEFAULT(ConverterST2CON, POINTER) returns the default value of POINTER of ConverterST2CON.
			%  DEFAULT = CN.GETPROPDEFAULT(ConverterST2CON, POINTER) returns the default value of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPDEFAULT(CN) and Element.GETPROPDEFAULT('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConverterST2CON.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConverterST2CON.GR_ST
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case 10 % ConverterST2CON.GR_REFERENCE
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case 11 % ConverterST2CON.METHOD
					prop_default = 'perturbation';
				case 12 % ConverterST2CON.REFERENCE_MODE
					prop_default = 'external';
				case 13 % ConverterST2CON.VOI_SELECTION
					prop_default = {'Age', 'Sex', 'Education'};
				case 14 % ConverterST2CON.PERTURBATION_RULE
					prop_default = 'z_score';
				case 15 % ConverterST2CON.REGULARIZATION
					prop_default = 1e-6;
				case 16 % ConverterST2CON.OUTPUT_RULE
					prop_default = 'raw';
				case 17 % ConverterST2CON.BA
					prop_default = Format.getFormatDefault(8, ConverterST2CON.getPropSettings(prop));
				case 18 % ConverterST2CON.ST_MATRIX
					prop_default = Format.getFormatDefault(14, ConverterST2CON.getPropSettings(prop));
				case 19 % ConverterST2CON.ST_REF_MATRIX
					prop_default = Format.getFormatDefault(14, ConverterST2CON.getPropSettings(prop));
				case 20 % ConverterST2CON.VOI_MATRIX
					prop_default = Format.getFormatDefault(14, ConverterST2CON.getPropSettings(prop));
				case 21 % ConverterST2CON.VOI_REF_MATRIX
					prop_default = Format.getFormatDefault(14, ConverterST2CON.getPropSettings(prop));
				case 22 % ConverterST2CON.EXTRACT_VOI_MATRIX
					prop_default = Format.getFormatDefault(14, ConverterST2CON.getPropSettings(prop));
				case 23 % ConverterST2CON.REFERENCE_MATRIX_FOR_SUBJECT
					prop_default = Format.getFormatDefault(14, ConverterST2CON.getPropSettings(prop));
				case 24 % ConverterST2CON.REFERENCE_VOI_MATRIX_FOR_SUBJECT
					prop_default = Format.getFormatDefault(14, ConverterST2CON.getPropSettings(prop));
				case 25 % ConverterST2CON.MAHALANOBIS_CONNECTOMES
					prop_default = Format.getFormatDefault(16, ConverterST2CON.getPropSettings(prop));
				case 26 % ConverterST2CON.PERTURBATION_CONNECTOMES
					prop_default = Format.getFormatDefault(16, ConverterST2CON.getPropSettings(prop));
				case 27 % ConverterST2CON.CONNECTOMES
					prop_default = Format.getFormatDefault(16, ConverterST2CON.getPropSettings(prop));
				case 28 % ConverterST2CON.GR_CON
					prop_default = Format.getFormatDefault(8, ConverterST2CON.getPropSettings(prop));
				case 29 % ConverterST2CON.WAITBAR
					prop_default = true;
				case 1 % ConverterST2CON.ELCLASS
					prop_default = 'ConverterST2CON';
				case 2 % ConverterST2CON.NAME
					prop_default = 'Structural-to-Connectivity Converter';
				case 3 % ConverterST2CON.DESCRIPTION
					prop_default = 'ConverterST2CON converts subject-level structural regional values into individual connectivity matrices using perturbation-based or Mahalanobis-distance approaches.';
				case 4 % ConverterST2CON.TEMPLATE
					prop_default = Format.getFormatDefault(8, ConverterST2CON.getPropSettings(prop));
				case 5 % ConverterST2CON.ID
					prop_default = 'ConverterST2CON ID';
				case 6 % ConverterST2CON.LABEL
					prop_default = 'ConverterST2CON label';
				case 7 % ConverterST2CON.NOTES
					prop_default = 'ConverterST2CON notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConverterST2CON.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterST2CON.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConverterST2CON, POINTER) returns the conditioned default value of POINTER of ConverterST2CON.
			%  DEFAULT = CN.GETPROPDEFAULTCONDITIONED(ConverterST2CON, POINTER) returns the conditioned default value of POINTER of ConverterST2CON.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CN) and Element.GETPROPDEFAULTCONDITIONED('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConverterST2CON.getPropProp(pointer);
			
			prop_default = ConverterST2CON.conditioning(prop, ConverterST2CON.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CN.
			%  CHECK = Element.CHECKPROP(ConverterST2CON, PROP, VALUE) checks VALUE format for PROP of ConverterST2CON.
			%  CHECK = CN.CHECKPROP(ConverterST2CON, PROP, VALUE) checks VALUE format for PROP of ConverterST2CON.
			% 
			% CN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ConverterST2CON:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CN.
			%   Error id: BRAPH2:ConverterST2CON:WrongInput
			%  Element.CHECKPROP(ConverterST2CON, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterST2CON.
			%   Error id: BRAPH2:ConverterST2CON:WrongInput
			%  CN.CHECKPROP(ConverterST2CON, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterST2CON.
			%   Error id: BRAPH2:ConverterST2CON:WrongInput]
			% 
			% Note that the Element.CHECKPROP(CN) and Element.CHECKPROP('ConverterST2CON')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConverterST2CON.getPropProp(pointer);
			
			switch prop
				case 9 % ConverterST2CON.GR_ST
					check = Format.checkFormat(8, value, ConverterST2CON.getPropSettings(prop));
				case 10 % ConverterST2CON.GR_REFERENCE
					check = Format.checkFormat(8, value, ConverterST2CON.getPropSettings(prop));
				case 11 % ConverterST2CON.METHOD
					check = Format.checkFormat(5, value, ConverterST2CON.getPropSettings(prop));
				case 12 % ConverterST2CON.REFERENCE_MODE
					check = Format.checkFormat(5, value, ConverterST2CON.getPropSettings(prop));
				case 13 % ConverterST2CON.VOI_SELECTION
					check = Format.checkFormat(3, value, ConverterST2CON.getPropSettings(prop));
				case 14 % ConverterST2CON.PERTURBATION_RULE
					check = Format.checkFormat(5, value, ConverterST2CON.getPropSettings(prop));
				case 15 % ConverterST2CON.REGULARIZATION
					check = Format.checkFormat(11, value, ConverterST2CON.getPropSettings(prop));
				case 16 % ConverterST2CON.OUTPUT_RULE
					check = Format.checkFormat(5, value, ConverterST2CON.getPropSettings(prop));
				case 17 % ConverterST2CON.BA
					check = Format.checkFormat(8, value, ConverterST2CON.getPropSettings(prop));
				case 18 % ConverterST2CON.ST_MATRIX
					check = Format.checkFormat(14, value, ConverterST2CON.getPropSettings(prop));
				case 19 % ConverterST2CON.ST_REF_MATRIX
					check = Format.checkFormat(14, value, ConverterST2CON.getPropSettings(prop));
				case 20 % ConverterST2CON.VOI_MATRIX
					check = Format.checkFormat(14, value, ConverterST2CON.getPropSettings(prop));
				case 21 % ConverterST2CON.VOI_REF_MATRIX
					check = Format.checkFormat(14, value, ConverterST2CON.getPropSettings(prop));
				case 22 % ConverterST2CON.EXTRACT_VOI_MATRIX
					check = Format.checkFormat(14, value, ConverterST2CON.getPropSettings(prop));
				case 23 % ConverterST2CON.REFERENCE_MATRIX_FOR_SUBJECT
					check = Format.checkFormat(14, value, ConverterST2CON.getPropSettings(prop));
				case 24 % ConverterST2CON.REFERENCE_VOI_MATRIX_FOR_SUBJECT
					check = Format.checkFormat(14, value, ConverterST2CON.getPropSettings(prop));
				case 25 % ConverterST2CON.MAHALANOBIS_CONNECTOMES
					check = Format.checkFormat(16, value, ConverterST2CON.getPropSettings(prop));
				case 26 % ConverterST2CON.PERTURBATION_CONNECTOMES
					check = Format.checkFormat(16, value, ConverterST2CON.getPropSettings(prop));
				case 27 % ConverterST2CON.CONNECTOMES
					check = Format.checkFormat(16, value, ConverterST2CON.getPropSettings(prop));
				case 28 % ConverterST2CON.GR_CON
					check = Format.checkFormat(8, value, ConverterST2CON.getPropSettings(prop));
				case 29 % ConverterST2CON.WAITBAR
					check = Format.checkFormat(4, value, ConverterST2CON.getPropSettings(prop));
				case 4 % ConverterST2CON.TEMPLATE
					check = Format.checkFormat(8, value, ConverterST2CON.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterST2CON:' 'WrongInput'], ...
					['BRAPH2' ':ConverterST2CON:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConverterST2CON.getPropTag(prop) ' (' ConverterST2CON.getFormatTag(ConverterST2CON.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(cn, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 17 % ConverterST2CON.BA
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
					
				case 18 % ConverterST2CON.ST_MATRIX
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
					
				case 19 % ConverterST2CON.ST_REF_MATRIX
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
					
				case 20 % ConverterST2CON.VOI_MATRIX
					gr_st = cn.get('GR_ST');
					voi_selection = cn.get('VOI_SELECTION');
					
					value = cn.get('EXTRACT_VOI_MATRIX', gr_st, voi_selection);
					
				case 21 % ConverterST2CON.VOI_REF_MATRIX
					gr_reference = cn.get('GR_REFERENCE');
					voi_selection = cn.get('VOI_SELECTION');
					
					value = cn.get('EXTRACT_VOI_MATRIX', gr_reference, voi_selection);
					
				case 22 % ConverterST2CON.EXTRACT_VOI_MATRIX
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
					
				case 23 % ConverterST2CON.REFERENCE_MATRIX_FOR_SUBJECT
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
					
				case 24 % ConverterST2CON.REFERENCE_VOI_MATRIX_FOR_SUBJECT
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
					
				case 25 % ConverterST2CON.MAHALANOBIS_CONNECTOMES
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
					
				case 26 % ConverterST2CON.PERTURBATION_CONNECTOMES
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
					
				case 27 % ConverterST2CON.CONNECTOMES
					method = cn.get('METHOD');
					
					switch method
					    case 'perturbation'
					        value = cn.get('PERTURBATION_CONNECTOMES');
					
					    case 'mahalanobis'
					        value = cn.get('MAHALANOBIS_CONNECTOMES');
					
					    otherwise
					        error('Unsupported METHOD: %s', method)
					end
					
				case 28 % ConverterST2CON.GR_CON
					rng_settings_ = rng(); rng(cn.getPropSeed(28), 'twister')
					
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
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(cn, prop, varargin{:});
					else
						value = calculateValue@Element(cn, prop, varargin{:});
					end
			end
			
		end
	end
end
