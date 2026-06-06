classdef ConverterPDFs2CON < ConcreteElement
	%ConverterPDFs2CON converts SubjectFUN regional PDF data into SubjectCON connectivity data.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% ConverterPDFs2CON converts a group of SubjectFUN objects containing regional probability density functions into a group of SubjectCON objects containing individual connectivity matrices. The connectivity matrices can be constructed using correlation or Jensen-Shannon similarity.
	%
	% The list of ConverterPDFs2CON properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the converter of PDFs to connectivity data.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the converter of PDFs to connectivity data.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the converter of PDFs to connectivity data.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the converter of PDFs to connectivity data.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the converter of PDFs to connectivity data.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the converter of PDFs to connectivity data.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the converter of PDFs to connectivity data.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>GR_PDFS</strong> 	GR_PDFS (data, item) is the group of SubjectFUN objects containing regional PDFs.
	%  <strong>10</strong> <strong>METHOD</strong> 	METHOD (parameter, option) is the method used to construct individual connectivity matrices from regional PDFs.
	%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
	%  <strong>12</strong> <strong>ANALYSIS</strong> 	ANALYSIS (query, item) is the graph analysis used to construct the individual connectivity matrices.
	%  <strong>13</strong> <strong>G_DICT</strong> 	G_DICT (query, idict) is the graph dictionary obtained from the selected PDF-to-connectivity analysis.
	%  <strong>14</strong> <strong>GR_CON</strong> 	GR_CON (result, item) is the group of SubjectCON objects containing individual connectivity matrices.
	%  <strong>15</strong> <strong>BA</strong> 	BA (result, item) is the brain atlas used by the converted SubjectCON group.
	%  <strong>16</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%
	% ConverterPDFs2CON methods (constructor):
	%  ConverterPDFs2CON - constructor
	%
	% ConverterPDFs2CON methods:
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
	% ConverterPDFs2CON methods (display):
	%  tostring - string with information about the converter of PDFs to connectivity data
	%  disp - displays information about the converter of PDFs to connectivity data
	%  tree - displays the tree of the converter of PDFs to connectivity data
	%
	% ConverterPDFs2CON methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two converter of PDFs to connectivity data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the converter of PDFs to connectivity data
	%
	% ConverterPDFs2CON methods (save/load, Static):
	%  save - saves BRAPH2 converter of PDFs to connectivity data as b2 file
	%  load - loads a BRAPH2 converter of PDFs to connectivity data from a b2 file
	%
	% ConverterPDFs2CON method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the converter of PDFs to connectivity data
	%
	% ConverterPDFs2CON method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the converter of PDFs to connectivity data
	%
	% ConverterPDFs2CON methods (inspection, Static):
	%  getClass - returns the class of the converter of PDFs to connectivity data
	%  getSubclasses - returns all subclasses of ConverterPDFs2CON
	%  getProps - returns the property list of the converter of PDFs to connectivity data
	%  getPropNumber - returns the property number of the converter of PDFs to connectivity data
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
	% ConverterPDFs2CON methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConverterPDFs2CON methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConverterPDFs2CON methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConverterPDFs2CON methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConverterPDFs2CON; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConverterPDFs2CON constants</a>.
	%
	%
	% See also Group, SubjectFUN, SubjectCON, AnalyzeEnsemble_FUN_WU, AnalyzeEnsemble_FUN_JensenShannon_WU, GraphWU, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		GR_PDFS = 9; %CET: Computational Efficiency Trick
		GR_PDFS_TAG = 'GR_PDFS';
		GR_PDFS_CATEGORY = 4;
		GR_PDFS_FORMAT = 8;
		
		METHOD = 10; %CET: Computational Efficiency Trick
		METHOD_TAG = 'METHOD';
		METHOD_CATEGORY = 3;
		METHOD_FORMAT = 5;
		
		GRAPH_TEMPLATE = 11; %CET: Computational Efficiency Trick
		GRAPH_TEMPLATE_TAG = 'GRAPH_TEMPLATE';
		GRAPH_TEMPLATE_CATEGORY = 3;
		GRAPH_TEMPLATE_FORMAT = 8;
		
		ANALYSIS = 12; %CET: Computational Efficiency Trick
		ANALYSIS_TAG = 'ANALYSIS';
		ANALYSIS_CATEGORY = 6;
		ANALYSIS_FORMAT = 8;
		
		G_DICT = 13; %CET: Computational Efficiency Trick
		G_DICT_TAG = 'G_DICT';
		G_DICT_CATEGORY = 6;
		G_DICT_FORMAT = 10;
		
		GR_CON = 14; %CET: Computational Efficiency Trick
		GR_CON_TAG = 'GR_CON';
		GR_CON_CATEGORY = 5;
		GR_CON_FORMAT = 8;
		
		BA = 15; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 5;
		BA_FORMAT = 8;
		
		WAITBAR = 16; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
	end
	methods % constructor
		function c = ConverterPDFs2CON(varargin)
			%ConverterPDFs2CON() creates a converter of PDFs to connectivity data.
			%
			% ConverterPDFs2CON(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConverterPDFs2CON(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ConverterPDFs2CON properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the converter of PDFs to connectivity data.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the converter of PDFs to connectivity data.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the converter of PDFs to connectivity data.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the converter of PDFs to connectivity data.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the converter of PDFs to connectivity data.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the converter of PDFs to connectivity data.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the converter of PDFs to connectivity data.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>GR_PDFS</strong> 	GR_PDFS (data, item) is the group of SubjectFUN objects containing regional PDFs.
			%  <strong>10</strong> <strong>METHOD</strong> 	METHOD (parameter, option) is the method used to construct individual connectivity matrices from regional PDFs.
			%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
			%  <strong>12</strong> <strong>ANALYSIS</strong> 	ANALYSIS (query, item) is the graph analysis used to construct the individual connectivity matrices.
			%  <strong>13</strong> <strong>G_DICT</strong> 	G_DICT (query, idict) is the graph dictionary obtained from the selected PDF-to-connectivity analysis.
			%  <strong>14</strong> <strong>GR_CON</strong> 	GR_CON (result, item) is the group of SubjectCON objects containing individual connectivity matrices.
			%  <strong>15</strong> <strong>BA</strong> 	BA (result, item) is the brain atlas used by the converted SubjectCON group.
			%  <strong>16</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%
			% See also Category, Format.
			
			c = c@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the converter of PDFs to connectivity data.
			%
			% BUILD = ConverterPDFs2CON.GETBUILD() returns the build of 'ConverterPDFs2CON'.
			%
			% Alternative forms to call this method are:
			%  BUILD = C.GETBUILD() returns the build of the converter of PDFs to connectivity data C.
			%  BUILD = Element.GETBUILD(C) returns the build of 'C'.
			%  BUILD = Element.GETBUILD('ConverterPDFs2CON') returns the build of 'ConverterPDFs2CON'.
			%
			% Note that the Element.GETBUILD(C) and Element.GETBUILD('ConverterPDFs2CON')
			%  are less computationally efficient.
			
			build = 1;
		end
		function c_class = getClass()
			%GETCLASS returns the class of the converter of PDFs to connectivity data.
			%
			% CLASS = ConverterPDFs2CON.GETCLASS() returns the class 'ConverterPDFs2CON'.
			%
			% Alternative forms to call this method are:
			%  CLASS = C.GETCLASS() returns the class of the converter of PDFs to connectivity data C.
			%  CLASS = Element.GETCLASS(C) returns the class of 'C'.
			%  CLASS = Element.GETCLASS('ConverterPDFs2CON') returns 'ConverterPDFs2CON'.
			%
			% Note that the Element.GETCLASS(C) and Element.GETCLASS('ConverterPDFs2CON')
			%  are less computationally efficient.
			
			c_class = 'ConverterPDFs2CON';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the converter of PDFs to connectivity data.
			%
			% LIST = ConverterPDFs2CON.GETSUBCLASSES() returns all subclasses of 'ConverterPDFs2CON'.
			%
			% Alternative forms to call this method are:
			%  LIST = C.GETSUBCLASSES() returns all subclasses of the converter of PDFs to connectivity data C.
			%  LIST = Element.GETSUBCLASSES(C) returns all subclasses of 'C'.
			%  LIST = Element.GETSUBCLASSES('ConverterPDFs2CON') returns all subclasses of 'ConverterPDFs2CON'.
			%
			% Note that the Element.GETSUBCLASSES(C) and Element.GETSUBCLASSES('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ConverterPDFs2CON' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of converter of PDFs to connectivity data.
			%
			% PROPS = ConverterPDFs2CON.GETPROPS() returns the property list of converter of PDFs to connectivity data
			%  as a row vector.
			%
			% PROPS = ConverterPDFs2CON.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = C.GETPROPS([CATEGORY]) returns the property list of the converter of PDFs to connectivity data C.
			%  PROPS = Element.GETPROPS(C[, CATEGORY]) returns the property list of 'C'.
			%  PROPS = Element.GETPROPS('ConverterPDFs2CON'[, CATEGORY]) returns the property list of 'ConverterPDFs2CON'.
			%
			% Note that the Element.GETPROPS(C) and Element.GETPROPS('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 10 11];
				case 4 % Category.DATA
					prop_list = [5 9];
				case 5 % Category.RESULT
					prop_list = [14 15];
				case 6 % Category.QUERY
					prop_list = [8 12 13];
				case 9 % Category.GUI
					prop_list = 16;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of converter of PDFs to connectivity data.
			%
			% N = ConverterPDFs2CON.GETPROPNUMBER() returns the property number of converter of PDFs to connectivity data.
			%
			% N = ConverterPDFs2CON.GETPROPNUMBER(CATEGORY) returns the property number of converter of PDFs to connectivity data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = C.GETPROPNUMBER([CATEGORY]) returns the property number of the converter of PDFs to connectivity data C.
			%  N = Element.GETPROPNUMBER(C) returns the property number of 'C'.
			%  N = Element.GETPROPNUMBER('ConverterPDFs2CON') returns the property number of 'ConverterPDFs2CON'.
			%
			% Note that the Element.GETPROPNUMBER(C) and Element.GETPROPNUMBER('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 16;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 3;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 3;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in converter of PDFs to connectivity data/error.
			%
			% CHECK = ConverterPDFs2CON.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSPROP(PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(C, PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(ConverterPDFs2CON, PROP) checks whether PROP exists for ConverterPDFs2CON.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSPROP(PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%  Element.EXISTSPROP(C, PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%  Element.EXISTSPROP(ConverterPDFs2CON, PROP) throws error if PROP does NOT exist for ConverterPDFs2CON.
			%   Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%
			% Note that the Element.EXISTSPROP(C) and Element.EXISTSPROP('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterPDFs2CON:' 'WrongInput'], ...
					['BRAPH2' ':ConverterPDFs2CON:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConverterPDFs2CON.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in converter of PDFs to connectivity data/error.
			%
			% CHECK = ConverterPDFs2CON.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSTAG(TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(C, TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(ConverterPDFs2CON, TAG) checks whether TAG exists for ConverterPDFs2CON.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSTAG(TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%  Element.EXISTSTAG(C, TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%  Element.EXISTSTAG(ConverterPDFs2CON, TAG) throws error if TAG does NOT exist for ConverterPDFs2CON.
			%   Error id: [BRAPH2:ConverterPDFs2CON:WrongInput]
			%
			% Note that the Element.EXISTSTAG(C) and Element.EXISTSTAG('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GR_PDFS'  'METHOD'  'GRAPH_TEMPLATE'  'ANALYSIS'  'G_DICT'  'GR_CON'  'BA'  'WAITBAR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterPDFs2CON:' 'WrongInput'], ...
					['BRAPH2' ':ConverterPDFs2CON:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ConverterPDFs2CON.'] ...
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
			%  PROPERTY = C.GETPROPPROP(POINTER) returns property number of POINTER of C.
			%  PROPERTY = Element.GETPROPPROP(ConverterPDFs2CON, POINTER) returns property number of POINTER of ConverterPDFs2CON.
			%  PROPERTY = C.GETPROPPROP(ConverterPDFs2CON, POINTER) returns property number of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPPROP(C) and Element.GETPROPPROP('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GR_PDFS'  'METHOD'  'GRAPH_TEMPLATE'  'ANALYSIS'  'G_DICT'  'GR_CON'  'BA'  'WAITBAR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = C.GETPROPTAG(POINTER) returns tag of POINTER of C.
			%  TAG = Element.GETPROPTAG(ConverterPDFs2CON, POINTER) returns tag of POINTER of ConverterPDFs2CON.
			%  TAG = C.GETPROPTAG(ConverterPDFs2CON, POINTER) returns tag of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPTAG(C) and Element.GETPROPTAG('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				converterpdfs2con_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GR_PDFS'  'METHOD'  'GRAPH_TEMPLATE'  'ANALYSIS'  'G_DICT'  'GR_CON'  'BA'  'WAITBAR' };
				tag = converterpdfs2con_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = C.GETPROPCATEGORY(POINTER) returns category of POINTER of C.
			%  CATEGORY = Element.GETPROPCATEGORY(ConverterPDFs2CON, POINTER) returns category of POINTER of ConverterPDFs2CON.
			%  CATEGORY = C.GETPROPCATEGORY(ConverterPDFs2CON, POINTER) returns category of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPCATEGORY(C) and Element.GETPROPCATEGORY('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterPDFs2CON.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterpdfs2con_category_list = { 1  1  1  3  4  2  2  6  4  3  3  6  6  5  5  9 };
			prop_category = converterpdfs2con_category_list{prop};
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
			%  FORMAT = C.GETPROPFORMAT(POINTER) returns format of POINTER of C.
			%  FORMAT = Element.GETPROPFORMAT(ConverterPDFs2CON, POINTER) returns format of POINTER of ConverterPDFs2CON.
			%  FORMAT = C.GETPROPFORMAT(ConverterPDFs2CON, POINTER) returns format of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPFORMAT(C) and Element.GETPROPFORMAT('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterPDFs2CON.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterpdfs2con_format_list = { 2  2  2  8  2  2  2  2  8  5  8  8  10  8  8  4 };
			prop_format = converterpdfs2con_format_list{prop};
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
			%  DESCRIPTION = C.GETPROPDESCRIPTION(POINTER) returns description of POINTER of C.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConverterPDFs2CON, POINTER) returns description of POINTER of ConverterPDFs2CON.
			%  DESCRIPTION = C.GETPROPDESCRIPTION(ConverterPDFs2CON, POINTER) returns description of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPDESCRIPTION(C) and Element.GETPROPDESCRIPTION('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterPDFs2CON.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterpdfs2con_description_list = { 'ELCLASS (constant, string) is the class of the converter of PDFs to connectivity data.'  'NAME (constant, string) is the name of the converter of PDFs to connectivity data.'  'DESCRIPTION (constant, string) is the description of the converter of PDFs to connectivity data.'  'TEMPLATE (parameter, item) is the template of the converter of PDFs to connectivity data.'  'ID (data, string) is a few-letter code for the converter of PDFs to connectivity data.'  'LABEL (metadata, string) is an extended label of the converter of PDFs to connectivity data.'  'NOTES (metadata, string) are some specific notes about the converter of PDFs to connectivity data.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'GR_PDFS (data, item) is the group of SubjectFUN objects containing regional PDFs.'  'METHOD (parameter, option) is the method used to construct individual connectivity matrices from regional PDFs.'  'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.'  'ANALYSIS (query, item) is the graph analysis used to construct the individual connectivity matrices.'  'G_DICT (query, idict) is the graph dictionary obtained from the selected PDF-to-connectivity analysis.'  'GR_CON (result, item) is the group of SubjectCON objects containing individual connectivity matrices.'  'BA (result, item) is the brain atlas used by the converted SubjectCON group.'  'WAITBAR (gui, logical) determines whether to show the waitbar.' };
			prop_description = converterpdfs2con_description_list{prop};
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
			%  SETTINGS = C.GETPROPSETTINGS(POINTER) returns settings of POINTER of C.
			%  SETTINGS = Element.GETPROPSETTINGS(ConverterPDFs2CON, POINTER) returns settings of POINTER of ConverterPDFs2CON.
			%  SETTINGS = C.GETPROPSETTINGS(ConverterPDFs2CON, POINTER) returns settings of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPSETTINGS(C) and Element.GETPROPSETTINGS('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterPDFs2CON.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConverterPDFs2CON.GR_PDFS
					prop_settings = 'Group';
				case 10 % ConverterPDFs2CON.METHOD
					prop_settings = {'correlation' 'jensen-shannon'};
				case 11 % ConverterPDFs2CON.GRAPH_TEMPLATE
					prop_settings = 'GraphWU';
				case 12 % ConverterPDFs2CON.ANALYSIS
					prop_settings = Format.getFormatSettings(8);
				case 13 % ConverterPDFs2CON.G_DICT
					prop_settings = 'GraphWU';
				case 14 % ConverterPDFs2CON.GR_CON
					prop_settings = 'Group';
				case 15 % ConverterPDFs2CON.BA
					prop_settings = 'BrainAtlas';
				case 16 % ConverterPDFs2CON.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 4 % ConverterPDFs2CON.TEMPLATE
					prop_settings = 'ConverterPDFs2CON';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConverterPDFs2CON.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterPDFs2CON.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULT(POINTER) returns the default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULT(ConverterPDFs2CON, POINTER) returns the default value of POINTER of ConverterPDFs2CON.
			%  DEFAULT = C.GETPROPDEFAULT(ConverterPDFs2CON, POINTER) returns the default value of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPDEFAULT(C) and Element.GETPROPDEFAULT('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConverterPDFs2CON.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConverterPDFs2CON.GR_PDFS
					prop_default = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
				case 10 % ConverterPDFs2CON.METHOD
					prop_default = 'correlation';
				case 11 % ConverterPDFs2CON.GRAPH_TEMPLATE
					prop_default = Format.getFormatDefault(8, ConverterPDFs2CON.getPropSettings(prop));
				case 12 % ConverterPDFs2CON.ANALYSIS
					prop_default = Format.getFormatDefault(8, ConverterPDFs2CON.getPropSettings(prop));
				case 13 % ConverterPDFs2CON.G_DICT
					prop_default = Format.getFormatDefault(10, ConverterPDFs2CON.getPropSettings(prop));
				case 14 % ConverterPDFs2CON.GR_CON
					prop_default = Format.getFormatDefault(8, ConverterPDFs2CON.getPropSettings(prop));
				case 15 % ConverterPDFs2CON.BA
					prop_default = Format.getFormatDefault(8, ConverterPDFs2CON.getPropSettings(prop));
				case 16 % ConverterPDFs2CON.WAITBAR
					prop_default = true;
				case 1 % ConverterPDFs2CON.ELCLASS
					prop_default = 'ConverterPDFs2CON';
				case 2 % ConverterPDFs2CON.NAME
					prop_default = 'PDFs-to-Connectivity Converter';
				case 3 % ConverterPDFs2CON.DESCRIPTION
					prop_default = 'ConverterPDFs2CON converts SubjectFUN regional PDF data into SubjectCON connectivity data using correlation or Jensen-Shannon similarity.';
				case 4 % ConverterPDFs2CON.TEMPLATE
					prop_default = Format.getFormatDefault(8, ConverterPDFs2CON.getPropSettings(prop));
				case 5 % ConverterPDFs2CON.ID
					prop_default = 'ConverterPDFs2CON ID';
				case 6 % ConverterPDFs2CON.LABEL
					prop_default = 'ConverterPDFs2CON label';
				case 7 % ConverterPDFs2CON.NOTES
					prop_default = 'ConverterPDFs2CON notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConverterPDFs2CON.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterPDFs2CON.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConverterPDFs2CON, POINTER) returns the conditioned default value of POINTER of ConverterPDFs2CON.
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(ConverterPDFs2CON, POINTER) returns the conditioned default value of POINTER of ConverterPDFs2CON.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(C) and Element.GETPROPDEFAULTCONDITIONED('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConverterPDFs2CON.getPropProp(pointer);
			
			prop_default = ConverterPDFs2CON.conditioning(prop, ConverterPDFs2CON.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = C.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = C.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of C.
			%  CHECK = Element.CHECKPROP(ConverterPDFs2CON, PROP, VALUE) checks VALUE format for PROP of ConverterPDFs2CON.
			%  CHECK = C.CHECKPROP(ConverterPDFs2CON, PROP, VALUE) checks VALUE format for PROP of ConverterPDFs2CON.
			% 
			% C.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ConverterPDFs2CON:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  C.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of C.
			%   Error id: BRAPH2:ConverterPDFs2CON:WrongInput
			%  Element.CHECKPROP(ConverterPDFs2CON, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterPDFs2CON.
			%   Error id: BRAPH2:ConverterPDFs2CON:WrongInput
			%  C.CHECKPROP(ConverterPDFs2CON, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterPDFs2CON.
			%   Error id: BRAPH2:ConverterPDFs2CON:WrongInput]
			% 
			% Note that the Element.CHECKPROP(C) and Element.CHECKPROP('ConverterPDFs2CON')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConverterPDFs2CON.getPropProp(pointer);
			
			switch prop
				case 9 % ConverterPDFs2CON.GR_PDFS
					check = Format.checkFormat(8, value, ConverterPDFs2CON.getPropSettings(prop));
				case 10 % ConverterPDFs2CON.METHOD
					check = Format.checkFormat(5, value, ConverterPDFs2CON.getPropSettings(prop));
				case 11 % ConverterPDFs2CON.GRAPH_TEMPLATE
					check = Format.checkFormat(8, value, ConverterPDFs2CON.getPropSettings(prop));
				case 12 % ConverterPDFs2CON.ANALYSIS
					check = Format.checkFormat(8, value, ConverterPDFs2CON.getPropSettings(prop));
				case 13 % ConverterPDFs2CON.G_DICT
					check = Format.checkFormat(10, value, ConverterPDFs2CON.getPropSettings(prop));
				case 14 % ConverterPDFs2CON.GR_CON
					check = Format.checkFormat(8, value, ConverterPDFs2CON.getPropSettings(prop));
				case 15 % ConverterPDFs2CON.BA
					check = Format.checkFormat(8, value, ConverterPDFs2CON.getPropSettings(prop));
				case 16 % ConverterPDFs2CON.WAITBAR
					check = Format.checkFormat(4, value, ConverterPDFs2CON.getPropSettings(prop));
				case 4 % ConverterPDFs2CON.TEMPLATE
					check = Format.checkFormat(8, value, ConverterPDFs2CON.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterPDFs2CON:' 'WrongInput'], ...
					['BRAPH2' ':ConverterPDFs2CON:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConverterPDFs2CON.getPropTag(prop) ' (' ConverterPDFs2CON.getFormatTag(ConverterPDFs2CON.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(c, prop, varargin)
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
				case 12 % ConverterPDFs2CON.ANALYSIS
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
					
				case 13 % ConverterPDFs2CON.G_DICT
					analysis = c.get('ANALYSIS');
					value = analysis.get('G_DICT');
					
				case 14 % ConverterPDFs2CON.GR_CON
					rng_settings_ = rng(); rng(c.getPropSeed(14), 'twister')
					
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
					
					rng(rng_settings_)
					
				case 15 % ConverterPDFs2CON.BA
					rng_settings_ = rng(); rng(c.getPropSeed(15), 'twister')
					
					gr_pdfs = c.get('GR_PDFS');
					
					if gr_pdfs.get('SUB_DICT').get('LENGTH') == 0
					    value = BrainAtlas();
					else
					    value = gr_pdfs.get('SUB_DICT').get('IT', 1).get('BA');
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(c, prop, varargin{:});
					else
						value = calculateValue@Element(c, prop, varargin{:});
					end
			end
			
		end
	end
end
