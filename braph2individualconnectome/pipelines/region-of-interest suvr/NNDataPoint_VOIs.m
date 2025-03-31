classdef NNDataPoint_VOIs < NNDataPoint
	%NNDataPoint_VOIs data point) is a data point for classification with a graph.
	% It is a subclass of <a href="matlab:help NNDataPoint">NNDataPoint</a>.
	%
	% A data point for classification with variable of interests (VOIs) (NNDataPoint_VOIs) 
	%  contains both input and target for neural network analysis.
	% The input is the value of variable of interests extracted from vois.file of subject.
	% The target is obtained from the variables of interest of the subject.
	%
	% The list of NNDataPoint_VOIs properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data point for variable of interest.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data point for variable of interest.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data point for variable of interest.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data point for variable of interest.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data point for variable of interest.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the data point for variable of interest.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data point for variable of interest.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input value for this data point, a vector of VOI values.
	%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target values for this data point.
	%  <strong>11</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) is a dictionary with variable of interests.
	%  <strong>12</strong> <strong>TARGET_CLASS</strong> 	TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
	%
	% NNDataPoint_VOIs methods (constructor):
	%  NNDataPoint_VOIs - constructor
	%
	% NNDataPoint_VOIs methods:
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
	% NNDataPoint_VOIs methods (display):
	%  tostring - string with information about the variable of interests (VOIs
	%  disp - displays information about the variable of interests (VOIs
	%  tree - displays the tree of the variable of interests (VOIs
	%
	% NNDataPoint_VOIs methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two variable of interests (VOIs are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the variable of interests (VOIs
	%
	% NNDataPoint_VOIs methods (save/load, Static):
	%  save - saves BRAPH2 variable of interests (VOIs as b2 file
	%  load - loads a BRAPH2 variable of interests (VOIs from a b2 file
	%
	% NNDataPoint_VOIs method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the variable of interests (VOIs
	%
	% NNDataPoint_VOIs method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the variable of interests (VOIs
	%
	% NNDataPoint_VOIs methods (inspection, Static):
	%  getClass - returns the class of the variable of interests (VOIs
	%  getSubclasses - returns all subclasses of NNDataPoint_VOIs
	%  getProps - returns the property list of the variable of interests (VOIs
	%  getPropNumber - returns the property number of the variable of interests (VOIs
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
	% NNDataPoint_VOIs methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataPoint_VOIs methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataPoint_VOIs methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataPoint_VOIs methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataPoint_VOIs; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataPoint_VOIs constants</a>.
	%
	
	properties (Constant) % properties
		VOI_DICT = 11; %CET: Computational Efficiency Trick
		VOI_DICT_TAG = 'VOI_DICT';
		VOI_DICT_CATEGORY = 4;
		VOI_DICT_FORMAT = 10;
		
		TARGET_CLASS = 12; %CET: Computational Efficiency Trick
		TARGET_CLASS_TAG = 'TARGET_CLASS';
		TARGET_CLASS_CATEGORY = 3;
		TARGET_CLASS_FORMAT = 3;
	end
	methods % constructor
		function dp = NNDataPoint_VOIs(varargin)
			%NNDataPoint_VOIs() creates a variable of interests (VOIs.
			%
			% NNDataPoint_VOIs(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataPoint_VOIs(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDataPoint_VOIs properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data point for variable of interest.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data point for variable of interest.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data point for variable of interest.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data point for variable of interest.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data point for variable of interest.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the data point for variable of interest.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data point for variable of interest.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input value for this data point, a vector of VOI values.
			%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target values for this data point.
			%  <strong>11</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) is a dictionary with variable of interests.
			%  <strong>12</strong> <strong>TARGET_CLASS</strong> 	TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
			%
			% See also Category, Format.
			
			dp = dp@NNDataPoint(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the variable of interests (VOIs.
			%
			% BUILD = NNDataPoint_VOIs.GETBUILD() returns the build of 'NNDataPoint_VOIs'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DP.GETBUILD() returns the build of the variable of interests (VOIs DP.
			%  BUILD = Element.GETBUILD(DP) returns the build of 'DP'.
			%  BUILD = Element.GETBUILD('NNDataPoint_VOIs') returns the build of 'NNDataPoint_VOIs'.
			%
			% Note that the Element.GETBUILD(DP) and Element.GETBUILD('NNDataPoint_VOIs')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dp_class = getClass()
			%GETCLASS returns the class of the variable of interests (VOIs.
			%
			% CLASS = NNDataPoint_VOIs.GETCLASS() returns the class 'NNDataPoint_VOIs'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DP.GETCLASS() returns the class of the variable of interests (VOIs DP.
			%  CLASS = Element.GETCLASS(DP) returns the class of 'DP'.
			%  CLASS = Element.GETCLASS('NNDataPoint_VOIs') returns 'NNDataPoint_VOIs'.
			%
			% Note that the Element.GETCLASS(DP) and Element.GETCLASS('NNDataPoint_VOIs')
			%  are less computationally efficient.
			
			dp_class = 'NNDataPoint_VOIs';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the variable of interests (VOIs.
			%
			% LIST = NNDataPoint_VOIs.GETSUBCLASSES() returns all subclasses of 'NNDataPoint_VOIs'.
			%
			% Alternative forms to call this method are:
			%  LIST = DP.GETSUBCLASSES() returns all subclasses of the variable of interests (VOIs DP.
			%  LIST = Element.GETSUBCLASSES(DP) returns all subclasses of 'DP'.
			%  LIST = Element.GETSUBCLASSES('NNDataPoint_VOIs') returns all subclasses of 'NNDataPoint_VOIs'.
			%
			% Note that the Element.GETSUBCLASSES(DP) and Element.GETSUBCLASSES('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDataPoint_VOIs' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of variable of interests (VOIs.
			%
			% PROPS = NNDataPoint_VOIs.GETPROPS() returns the property list of variable of interests (VOIs
			%  as a row vector.
			%
			% PROPS = NNDataPoint_VOIs.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DP.GETPROPS([CATEGORY]) returns the property list of the variable of interests (VOIs DP.
			%  PROPS = Element.GETPROPS(DP[, CATEGORY]) returns the property list of 'DP'.
			%  PROPS = Element.GETPROPS('NNDataPoint_VOIs'[, CATEGORY]) returns the property list of 'NNDataPoint_VOIs'.
			%
			% Note that the Element.GETPROPS(DP) and Element.GETPROPS('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 12];
				case 4 % Category.DATA
					prop_list = [5 11];
				case 5 % Category.RESULT
					prop_list = [9 10];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of variable of interests (VOIs.
			%
			% N = NNDataPoint_VOIs.GETPROPNUMBER() returns the property number of variable of interests (VOIs.
			%
			% N = NNDataPoint_VOIs.GETPROPNUMBER(CATEGORY) returns the property number of variable of interests (VOIs
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DP.GETPROPNUMBER([CATEGORY]) returns the property number of the variable of interests (VOIs DP.
			%  N = Element.GETPROPNUMBER(DP) returns the property number of 'DP'.
			%  N = Element.GETPROPNUMBER('NNDataPoint_VOIs') returns the property number of 'NNDataPoint_VOIs'.
			%
			% Note that the Element.GETPROPNUMBER(DP) and Element.GETPROPNUMBER('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 12;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in variable of interests (VOIs/error.
			%
			% CHECK = NNDataPoint_VOIs.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSPROP(PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(DP, PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(NNDataPoint_VOIs, PROP) checks whether PROP exists for NNDataPoint_VOIs.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%  Element.EXISTSPROP(DP, PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%  Element.EXISTSPROP(NNDataPoint_VOIs, PROP) throws error if PROP does NOT exist for NNDataPoint_VOIs.
			%   Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DP) and Element.EXISTSPROP('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_VOIs:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataPoint_VOIs.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in variable of interests (VOIs/error.
			%
			% CHECK = NNDataPoint_VOIs.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSTAG(TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(DP, TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(NNDataPoint_VOIs, TAG) checks whether TAG exists for NNDataPoint_VOIs.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%  Element.EXISTSTAG(DP, TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%  Element.EXISTSTAG(NNDataPoint_VOIs, TAG) throws error if TAG does NOT exist for NNDataPoint_VOIs.
			%   Error id: [BRAPH2:NNDataPoint_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DP) and Element.EXISTSTAG('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'VOI_DICT'  'TARGET_CLASS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_VOIs:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDataPoint_VOIs.'] ...
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
			%  PROPERTY = DP.GETPROPPROP(POINTER) returns property number of POINTER of DP.
			%  PROPERTY = Element.GETPROPPROP(NNDataPoint_VOIs, POINTER) returns property number of POINTER of NNDataPoint_VOIs.
			%  PROPERTY = DP.GETPROPPROP(NNDataPoint_VOIs, POINTER) returns property number of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPPROP(DP) and Element.GETPROPPROP('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'VOI_DICT'  'TARGET_CLASS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = DP.GETPROPTAG(POINTER) returns tag of POINTER of DP.
			%  TAG = Element.GETPROPTAG(NNDataPoint_VOIs, POINTER) returns tag of POINTER of NNDataPoint_VOIs.
			%  TAG = DP.GETPROPTAG(NNDataPoint_VOIs, POINTER) returns tag of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPTAG(DP) and Element.GETPROPTAG('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatapoint_vois_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'VOI_DICT'  'TARGET_CLASS' };
				tag = nndatapoint_vois_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = DP.GETPROPCATEGORY(POINTER) returns category of POINTER of DP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataPoint_VOIs, POINTER) returns category of POINTER of NNDataPoint_VOIs.
			%  CATEGORY = DP.GETPROPCATEGORY(NNDataPoint_VOIs, POINTER) returns category of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPCATEGORY(DP) and Element.GETPROPCATEGORY('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_VOIs.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_vois_category_list = { 1  1  1  3  4  2  2  6  5  5  4  3 };
			prop_category = nndatapoint_vois_category_list{prop};
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
			%  FORMAT = DP.GETPROPFORMAT(POINTER) returns format of POINTER of DP.
			%  FORMAT = Element.GETPROPFORMAT(NNDataPoint_VOIs, POINTER) returns format of POINTER of NNDataPoint_VOIs.
			%  FORMAT = DP.GETPROPFORMAT(NNDataPoint_VOIs, POINTER) returns format of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPFORMAT(DP) and Element.GETPROPFORMAT('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_VOIs.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_vois_format_list = { 2  2  2  8  2  2  2  2  16  16  10  3 };
			prop_format = nndatapoint_vois_format_list{prop};
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
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataPoint_VOIs, POINTER) returns description of POINTER of NNDataPoint_VOIs.
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(NNDataPoint_VOIs, POINTER) returns description of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPDESCRIPTION(DP) and Element.GETPROPDESCRIPTION('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_VOIs.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_vois_description_list = { 'ELCLASS (constant, string) is the class of the data point for variable of interest.'  'NAME (constant, string) is the name of the data point for variable of interest.'  'DESCRIPTION (constant, string) is the description of the data point for variable of interest.'  'TEMPLATE (parameter, item) is the template of the data point for variable of interest.'  'ID (data, string) is a few-letter code for the data point for variable of interest.'  'LABEL (metadata, string) is an extended label of the data point for variable of interest.'  'NOTES (metadata, string) are some specific notes about the data point for variable of interest.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'INPUT (result, cell) is the input value for this data point, a vector of VOI values.'  'TARGET (result, cell) is the target values for this data point.'  'VOI_DICT (data, idict) is a dictionary with variable of interests.'  'TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.' };
			prop_description = nndatapoint_vois_description_list{prop};
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
			%  SETTINGS = DP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataPoint_VOIs, POINTER) returns settings of POINTER of NNDataPoint_VOIs.
			%  SETTINGS = DP.GETPROPSETTINGS(NNDataPoint_VOIs, POINTER) returns settings of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPSETTINGS(DP) and Element.GETPROPSETTINGS('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_VOIs.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPoint_VOIs.VOI_DICT
					prop_settings = 'Subject';
				case 12 % NNDataPoint_VOIs.TARGET_CLASS
					prop_settings = Format.getFormatSettings(3);
				case 4 % NNDataPoint_VOIs.TEMPLATE
					prop_settings = 'NNDataPoint_VOIs';
				otherwise
					prop_settings = getPropSettings@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataPoint_VOIs.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_VOIs.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataPoint_VOIs, POINTER) returns the default value of POINTER of NNDataPoint_VOIs.
			%  DEFAULT = DP.GETPROPDEFAULT(NNDataPoint_VOIs, POINTER) returns the default value of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPDEFAULT(DP) and Element.GETPROPDEFAULT('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataPoint_VOIs.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPoint_VOIs.VOI_DICT
					prop_default = Format.getFormatDefault(10, NNDataPoint_VOIs.getPropSettings(prop));
				case 12 % NNDataPoint_VOIs.TARGET_CLASS
					prop_default = Format.getFormatDefault(3, NNDataPoint_VOIs.getPropSettings(prop));
				case 1 % NNDataPoint_VOIs.ELCLASS
					prop_default = 'NNDataPoint_VOIs';
				case 2 % NNDataPoint_VOIs.NAME
					prop_default = 'Neural Network Data Point for variable of interests';
				case 3 % NNDataPoint_VOIs.DESCRIPTION
					prop_default = 'A data point for variable of interests (NNDataPoint_VOIs) contains both input and target for neural network analysis. The input is the value of variable of interests extracted from vois.file of subject.. The target is obtained from the variables of interest of the subject.';
				case 4 % NNDataPoint_VOIs.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDataPoint_VOIs.getPropSettings(prop));
				case 5 % NNDataPoint_VOIs.ID
					prop_default = 'NNDataPoint_VOIs ID';
				case 6 % NNDataPoint_VOIs.LABEL
					prop_default = 'NNDataPoint_VOIs label';
				case 7 % NNDataPoint_VOIs.NOTES
					prop_default = 'NNDataPoint_VOIs notes';
				otherwise
					prop_default = getPropDefault@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataPoint_VOIs.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_VOIs.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataPoint_VOIs, POINTER) returns the conditioned default value of POINTER of NNDataPoint_VOIs.
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(NNDataPoint_VOIs, POINTER) returns the conditioned default value of POINTER of NNDataPoint_VOIs.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DP) and Element.GETPROPDEFAULTCONDITIONED('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataPoint_VOIs.getPropProp(pointer);
			
			prop_default = NNDataPoint_VOIs.conditioning(prop, NNDataPoint_VOIs.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DP.
			%  CHECK = Element.CHECKPROP(NNDataPoint_VOIs, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_VOIs.
			%  CHECK = DP.CHECKPROP(NNDataPoint_VOIs, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_VOIs.
			% 
			% DP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDataPoint_VOIs:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DP.
			%   Error id: BRAPH2:NNDataPoint_VOIs:WrongInput
			%  Element.CHECKPROP(NNDataPoint_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_VOIs.
			%   Error id: BRAPH2:NNDataPoint_VOIs:WrongInput
			%  DP.CHECKPROP(NNDataPoint_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_VOIs.
			%   Error id: BRAPH2:NNDataPoint_VOIs:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DP) and Element.CHECKPROP('NNDataPoint_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataPoint_VOIs.getPropProp(pointer);
			
			switch prop
				case 11 % NNDataPoint_VOIs.VOI_DICT
					check = Format.checkFormat(10, value, NNDataPoint_VOIs.getPropSettings(prop));
				case 12 % NNDataPoint_VOIs.TARGET_CLASS
					check = Format.checkFormat(3, value, NNDataPoint_VOIs.getPropSettings(prop));
				case 4 % NNDataPoint_VOIs.TEMPLATE
					check = Format.checkFormat(8, value, NNDataPoint_VOIs.getPropSettings(prop));
				otherwise
					if prop <= 10
						check = checkProp@NNDataPoint(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_VOIs:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataPoint_VOIs.getPropTag(prop) ' (' NNDataPoint_VOIs.getFormatTag(NNDataPoint_VOIs.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dp, prop, varargin)
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
				case 9 % NNDataPoint_VOIs.INPUT
					rng_settings_ = rng(); rng(dp.getPropSeed(9), 'twister')
					
					voi_dict = dp.get('VOI_DICT');
					if voi_dict.get('LENGTH') == 0
					    value = {};
					else
					    % Extract all VOI values into a vector
					    voi_list = voi_dict.get('IT_LIST');
					    values = cellfun(@(voi) voi.get('V'), voi_list, 'UniformOutput', false);
					    % Convert to numeric vector (assumes VOIs are numeric or categorical indices)
					    value = {cell2mat(values)};
					end
					
					rng(rng_settings_)
					
				case 10 % NNDataPoint_VOIs.TARGET
					rng_settings_ = rng(); rng(dp.getPropSeed(10), 'twister')
					
					value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 10
						value = calculateValue@NNDataPoint(dp, prop, varargin{:});
					else
						value = calculateValue@Element(dp, prop, varargin{:});
					end
			end
			
		end
	end
end
