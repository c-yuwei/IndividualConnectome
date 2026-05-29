classdef ConstructorIndividualConBase < ConcreteElement
	%ConstructorIndividualConBase is the base constructor for individual brain connectome.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% The IndividualConConstructorBase constructs individual brain connectome with SUVR (standard uptake value ratio) data.
	% 
	% Its subclasses need to implement some or all of the following props, including GR GR_REF CONNECTOME_METHOD.
	%
	% The list of ConstructorIndividualConBase properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of Individual Connectome Constructor Base.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Individual Connectome Constructor Base.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Individual Connectome Constructor Base.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Individual Connectome Constructor Base.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Individual Connectome Constructor Base.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Individual Connectome Constructor Base.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Individual Connectome Constructor Base.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
	%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
	%  <strong>12</strong> <strong>CONNECTOME_CONSTRUCT_METHOD</strong> 	CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for individual connectome construction.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
	%
	% ConstructorIndividualConBase methods (constructor):
	%  ConstructorIndividualConBase - constructor
	%
	% ConstructorIndividualConBase methods:
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
	% ConstructorIndividualConBase methods (display):
	%  tostring - string with information about the Individual Base Constructor
	%  disp - displays information about the Individual Base Constructor
	%  tree - displays the tree of the Individual Base Constructor
	%
	% ConstructorIndividualConBase methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Individual Base Constructor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Individual Base Constructor
	%
	% ConstructorIndividualConBase methods (save/load, Static):
	%  save - saves BRAPH2 Individual Base Constructor as b2 file
	%  load - loads a BRAPH2 Individual Base Constructor from a b2 file
	%
	% ConstructorIndividualConBase method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Individual Base Constructor
	%
	% ConstructorIndividualConBase method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Individual Base Constructor
	%
	% ConstructorIndividualConBase methods (inspection, Static):
	%  getClass - returns the class of the Individual Base Constructor
	%  getSubclasses - returns all subclasses of ConstructorIndividualConBase
	%  getProps - returns the property list of the Individual Base Constructor
	%  getPropNumber - returns the property number of the Individual Base Constructor
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
	% ConstructorIndividualConBase methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConstructorIndividualConBase methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConstructorIndividualConBase methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConstructorIndividualConBase methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConstructorIndividualConBase; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConstructorIndividualConBase constants</a>.
	%
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		GR_SUVR = 10; %CET: Computational Efficiency Trick
		GR_SUVR_TAG = 'GR_SUVR';
		GR_SUVR_CATEGORY = 4;
		GR_SUVR_FORMAT = 8;
		
		GR_SUVR_REF = 11; %CET: Computational Efficiency Trick
		GR_SUVR_REF_TAG = 'GR_SUVR_REF';
		GR_SUVR_REF_CATEGORY = 4;
		GR_SUVR_REF_FORMAT = 8;
		
		CONNECTOME_CONSTRUCT_METHOD = 12; %CET: Computational Efficiency Trick
		CONNECTOME_CONSTRUCT_METHOD_TAG = 'CONNECTOME_CONSTRUCT_METHOD';
		CONNECTOME_CONSTRUCT_METHOD_CATEGORY = 6;
		CONNECTOME_CONSTRUCT_METHOD_FORMAT = 16;
		
		GR = 13; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 5;
		GR_FORMAT = 8;
	end
	methods % constructor
		function base = ConstructorIndividualConBase(varargin)
			%ConstructorIndividualConBase() creates a Individual Base Constructor.
			%
			% ConstructorIndividualConBase(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConstructorIndividualConBase(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ConstructorIndividualConBase properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of Individual Connectome Constructor Base.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Individual Connectome Constructor Base.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Individual Connectome Constructor Base.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Individual Connectome Constructor Base.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Individual Connectome Constructor Base.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Individual Connectome Constructor Base.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Individual Connectome Constructor Base.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
			%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
			%  <strong>12</strong> <strong>CONNECTOME_CONSTRUCT_METHOD</strong> 	CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for individual connectome construction.
			%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
			%
			% See also Category, Format.
			
			base = base@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the Individual Base Constructor.
			%
			% BUILD = ConstructorIndividualConBase.GETBUILD() returns the build of 'ConstructorIndividualConBase'.
			%
			% Alternative forms to call this method are:
			%  BUILD = BASE.GETBUILD() returns the build of the Individual Base Constructor BASE.
			%  BUILD = Element.GETBUILD(BASE) returns the build of 'BASE'.
			%  BUILD = Element.GETBUILD('ConstructorIndividualConBase') returns the build of 'ConstructorIndividualConBase'.
			%
			% Note that the Element.GETBUILD(BASE) and Element.GETBUILD('ConstructorIndividualConBase')
			%  are less computationally efficient.
			
			build = 1;
		end
		function base_class = getClass()
			%GETCLASS returns the class of the Individual Base Constructor.
			%
			% CLASS = ConstructorIndividualConBase.GETCLASS() returns the class 'ConstructorIndividualConBase'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BASE.GETCLASS() returns the class of the Individual Base Constructor BASE.
			%  CLASS = Element.GETCLASS(BASE) returns the class of 'BASE'.
			%  CLASS = Element.GETCLASS('ConstructorIndividualConBase') returns 'ConstructorIndividualConBase'.
			%
			% Note that the Element.GETCLASS(BASE) and Element.GETCLASS('ConstructorIndividualConBase')
			%  are less computationally efficient.
			
			base_class = 'ConstructorIndividualConBase';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Individual Base Constructor.
			%
			% LIST = ConstructorIndividualConBase.GETSUBCLASSES() returns all subclasses of 'ConstructorIndividualConBase'.
			%
			% Alternative forms to call this method are:
			%  LIST = BASE.GETSUBCLASSES() returns all subclasses of the Individual Base Constructor BASE.
			%  LIST = Element.GETSUBCLASSES(BASE) returns all subclasses of 'BASE'.
			%  LIST = Element.GETSUBCLASSES('ConstructorIndividualConBase') returns all subclasses of 'ConstructorIndividualConBase'.
			%
			% Note that the Element.GETSUBCLASSES(BASE) and Element.GETSUBCLASSES('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ConstructorIndividualConBase'  'ConstructorIndividualConMahalanobis'  'ConstructorIndividualConPerturbation' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Individual Base Constructor.
			%
			% PROPS = ConstructorIndividualConBase.GETPROPS() returns the property list of Individual Base Constructor
			%  as a row vector.
			%
			% PROPS = ConstructorIndividualConBase.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BASE.GETPROPS([CATEGORY]) returns the property list of the Individual Base Constructor BASE.
			%  PROPS = Element.GETPROPS(BASE[, CATEGORY]) returns the property list of 'BASE'.
			%  PROPS = Element.GETPROPS('ConstructorIndividualConBase'[, CATEGORY]) returns the property list of 'ConstructorIndividualConBase'.
			%
			% Note that the Element.GETPROPS(BASE) and Element.GETPROPS('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 10 11];
				case 5 % Category.RESULT
					prop_list = 13;
				case 6 % Category.QUERY
					prop_list = [8 12];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of Individual Base Constructor.
			%
			% N = ConstructorIndividualConBase.GETPROPNUMBER() returns the property number of Individual Base Constructor.
			%
			% N = ConstructorIndividualConBase.GETPROPNUMBER(CATEGORY) returns the property number of Individual Base Constructor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BASE.GETPROPNUMBER([CATEGORY]) returns the property number of the Individual Base Constructor BASE.
			%  N = Element.GETPROPNUMBER(BASE) returns the property number of 'BASE'.
			%  N = Element.GETPROPNUMBER('ConstructorIndividualConBase') returns the property number of 'ConstructorIndividualConBase'.
			%
			% Note that the Element.GETPROPNUMBER(BASE) and Element.GETPROPNUMBER('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in Individual Base Constructor/error.
			%
			% CHECK = ConstructorIndividualConBase.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BASE.EXISTSPROP(PROP) checks whether PROP exists for BASE.
			%  CHECK = Element.EXISTSPROP(BASE, PROP) checks whether PROP exists for BASE.
			%  CHECK = Element.EXISTSPROP(ConstructorIndividualConBase, PROP) checks whether PROP exists for ConstructorIndividualConBase.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BASE.EXISTSPROP(PROP) throws error if PROP does NOT exist for BASE.
			%   Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%  Element.EXISTSPROP(BASE, PROP) throws error if PROP does NOT exist for BASE.
			%   Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%  Element.EXISTSPROP(ConstructorIndividualConBase, PROP) throws error if PROP does NOT exist for ConstructorIndividualConBase.
			%   Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BASE) and Element.EXISTSPROP('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConstructorIndividualConBase:' 'WrongInput'], ...
					['BRAPH2' ':ConstructorIndividualConBase:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConstructorIndividualConBase.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Individual Base Constructor/error.
			%
			% CHECK = ConstructorIndividualConBase.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BASE.EXISTSTAG(TAG) checks whether TAG exists for BASE.
			%  CHECK = Element.EXISTSTAG(BASE, TAG) checks whether TAG exists for BASE.
			%  CHECK = Element.EXISTSTAG(ConstructorIndividualConBase, TAG) checks whether TAG exists for ConstructorIndividualConBase.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BASE.EXISTSTAG(TAG) throws error if TAG does NOT exist for BASE.
			%   Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%  Element.EXISTSTAG(BASE, TAG) throws error if TAG does NOT exist for BASE.
			%   Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%  Element.EXISTSTAG(ConstructorIndividualConBase, TAG) throws error if TAG does NOT exist for ConstructorIndividualConBase.
			%   Error id: [BRAPH2:ConstructorIndividualConBase:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BASE) and Element.EXISTSTAG('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTRUCT_METHOD'  'GR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConstructorIndividualConBase:' 'WrongInput'], ...
					['BRAPH2' ':ConstructorIndividualConBase:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ConstructorIndividualConBase.'] ...
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
			%  PROPERTY = BASE.GETPROPPROP(POINTER) returns property number of POINTER of BASE.
			%  PROPERTY = Element.GETPROPPROP(ConstructorIndividualConBase, POINTER) returns property number of POINTER of ConstructorIndividualConBase.
			%  PROPERTY = BASE.GETPROPPROP(ConstructorIndividualConBase, POINTER) returns property number of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPPROP(BASE) and Element.GETPROPPROP('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTRUCT_METHOD'  'GR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = BASE.GETPROPTAG(POINTER) returns tag of POINTER of BASE.
			%  TAG = Element.GETPROPTAG(ConstructorIndividualConBase, POINTER) returns tag of POINTER of ConstructorIndividualConBase.
			%  TAG = BASE.GETPROPTAG(ConstructorIndividualConBase, POINTER) returns tag of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPTAG(BASE) and Element.GETPROPTAG('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				constructorindividualconbase_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTRUCT_METHOD'  'GR' };
				tag = constructorindividualconbase_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = BASE.GETPROPCATEGORY(POINTER) returns category of POINTER of BASE.
			%  CATEGORY = Element.GETPROPCATEGORY(ConstructorIndividualConBase, POINTER) returns category of POINTER of ConstructorIndividualConBase.
			%  CATEGORY = BASE.GETPROPCATEGORY(ConstructorIndividualConBase, POINTER) returns category of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPCATEGORY(BASE) and Element.GETPROPCATEGORY('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			constructorindividualconbase_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = constructorindividualconbase_category_list{prop};
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
			%  FORMAT = BASE.GETPROPFORMAT(POINTER) returns format of POINTER of BASE.
			%  FORMAT = Element.GETPROPFORMAT(ConstructorIndividualConBase, POINTER) returns format of POINTER of ConstructorIndividualConBase.
			%  FORMAT = BASE.GETPROPFORMAT(ConstructorIndividualConBase, POINTER) returns format of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPFORMAT(BASE) and Element.GETPROPFORMAT('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			constructorindividualconbase_format_list = { 2  2  2  8  2  2  2  2  4  8  8  16  8 };
			prop_format = constructorindividualconbase_format_list{prop};
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
			%  DESCRIPTION = BASE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BASE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConstructorIndividualConBase, POINTER) returns description of POINTER of ConstructorIndividualConBase.
			%  DESCRIPTION = BASE.GETPROPDESCRIPTION(ConstructorIndividualConBase, POINTER) returns description of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPDESCRIPTION(BASE) and Element.GETPROPDESCRIPTION('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			constructorindividualconbase_description_list = { 'ELCLASS (constant, string) is the class of Individual Connectome Constructor Base.'  'NAME (constant, string) is the name of the Individual Connectome Constructor Base.'  'DESCRIPTION (constant, string) is the description of the Individual Connectome Constructor Base.'  'TEMPLATE (parameter, item) is the template of the Individual Connectome Constructor Base.'  'ID (data, string) is a few-letter code for the Individual Connectome Constructor Base.'  'LABEL (metadata, string) is an extended label of the Individual Connectome Constructor Base.'  'NOTES (metadata, string) are some specific notes about the Individual Connectome Constructor Base.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR_SUVR (data, item) is a group of subjects with mean SUVR data.'  'GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.'  'CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for individual connectome construction.'  'GR (result, item) is a group of subjects with connectivity data.' };
			prop_description = constructorindividualconbase_description_list{prop};
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
			%  SETTINGS = BASE.GETPROPSETTINGS(POINTER) returns settings of POINTER of BASE.
			%  SETTINGS = Element.GETPROPSETTINGS(ConstructorIndividualConBase, POINTER) returns settings of POINTER of ConstructorIndividualConBase.
			%  SETTINGS = BASE.GETPROPSETTINGS(ConstructorIndividualConBase, POINTER) returns settings of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPSETTINGS(BASE) and Element.GETPROPSETTINGS('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConstructorIndividualConBase.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % ConstructorIndividualConBase.GR_SUVR
					prop_settings = Format.getFormatSettings(8);
				case 11 % ConstructorIndividualConBase.GR_SUVR_REF
					prop_settings = Format.getFormatSettings(8);
				case 12 % ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					prop_settings = Format.getFormatSettings(16);
				case 13 % ConstructorIndividualConBase.GR
					prop_settings = 'Group';
				case 4 % ConstructorIndividualConBase.TEMPLATE
					prop_settings = 'IndividualConConstructorBase';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConstructorIndividualConBase.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConstructorIndividualConBase.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BASE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BASE.
			%  DEFAULT = Element.GETPROPDEFAULT(ConstructorIndividualConBase, POINTER) returns the default value of POINTER of ConstructorIndividualConBase.
			%  DEFAULT = BASE.GETPROPDEFAULT(ConstructorIndividualConBase, POINTER) returns the default value of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPDEFAULT(BASE) and Element.GETPROPDEFAULT('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConstructorIndividualConBase.WAITBAR
					prop_default = true;
				case 10 % ConstructorIndividualConBase.GR_SUVR
					prop_default = Group('SUB_CLASS', 'SubjectST');
				case 11 % ConstructorIndividualConBase.GR_SUVR_REF
					prop_default = Group('SUB_CLASS', 'SubjectST');
				case 12 % ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					prop_default = {};
				case 13 % ConstructorIndividualConBase.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case 1 % ConstructorIndividualConBase.ELCLASS
					prop_default = 'ConstructorIndividualConBase';
				case 2 % ConstructorIndividualConBase.NAME
					prop_default = 'Individual Connectome Constructor Base';
				case 3 % ConstructorIndividualConBase.DESCRIPTION
					prop_default = 'A Individual Connectome Constructor Base (IndividualConConstructorBase) comprises brain connectome constructor with a specific dataset. Its subclasses need to implement the props GR, GR_REF and CONNECTOME_METHOD.';
				case 4 % ConstructorIndividualConBase.TEMPLATE
					prop_default = Format.getFormatDefault(8, ConstructorIndividualConBase.getPropSettings(prop));
				case 5 % ConstructorIndividualConBase.ID
					prop_default = 'IndividualConConstructorBase ID';
				case 6 % ConstructorIndividualConBase.LABEL
					prop_default = 'Individual Connectome Constructor Base label';
				case 7 % ConstructorIndividualConBase.NOTES
					prop_default = 'Individual Connectome Constructor Base notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConstructorIndividualConBase.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConstructorIndividualConBase.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BASE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BASE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConstructorIndividualConBase, POINTER) returns the conditioned default value of POINTER of ConstructorIndividualConBase.
			%  DEFAULT = BASE.GETPROPDEFAULTCONDITIONED(ConstructorIndividualConBase, POINTER) returns the conditioned default value of POINTER of ConstructorIndividualConBase.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BASE) and Element.GETPROPDEFAULTCONDITIONED('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			prop_default = ConstructorIndividualConBase.conditioning(prop, ConstructorIndividualConBase.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BASE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BASE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BASE.
			%  CHECK = Element.CHECKPROP(ConstructorIndividualConBase, PROP, VALUE) checks VALUE format for PROP of ConstructorIndividualConBase.
			%  CHECK = BASE.CHECKPROP(ConstructorIndividualConBase, PROP, VALUE) checks VALUE format for PROP of ConstructorIndividualConBase.
			% 
			% BASE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ConstructorIndividualConBase:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BASE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BASE.
			%   Error id: BRAPH2:ConstructorIndividualConBase:WrongInput
			%  Element.CHECKPROP(ConstructorIndividualConBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConBase.
			%   Error id: BRAPH2:ConstructorIndividualConBase:WrongInput
			%  BASE.CHECKPROP(ConstructorIndividualConBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConBase.
			%   Error id: BRAPH2:ConstructorIndividualConBase:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BASE) and Element.CHECKPROP('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			switch prop
				case 9 % ConstructorIndividualConBase.WAITBAR
					check = Format.checkFormat(4, value, ConstructorIndividualConBase.getPropSettings(prop));
				case 10 % ConstructorIndividualConBase.GR_SUVR
					check = Format.checkFormat(8, value, ConstructorIndividualConBase.getPropSettings(prop));
				case 11 % ConstructorIndividualConBase.GR_SUVR_REF
					check = Format.checkFormat(8, value, ConstructorIndividualConBase.getPropSettings(prop));
				case 12 % ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					check = Format.checkFormat(16, value, ConstructorIndividualConBase.getPropSettings(prop));
				case 13 % ConstructorIndividualConBase.GR
					check = Format.checkFormat(8, value, ConstructorIndividualConBase.getPropSettings(prop));
				case 4 % ConstructorIndividualConBase.TEMPLATE
					check = Format.checkFormat(8, value, ConstructorIndividualConBase.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConstructorIndividualConBase:' 'WrongInput'], ...
					['BRAPH2' ':ConstructorIndividualConBase:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConstructorIndividualConBase.getPropTag(prop) ' (' ConstructorIndividualConBase.getFormatTag(ConstructorIndividualConBase.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(base, prop, varargin)
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
				case 13 % ConstructorIndividualConBase.GR
					rng_settings_ = rng(); rng(base.getPropSeed(13), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectCON', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					gr_suvr = base.get('GR_SUVR');
					sub_dict = gr.memorize('SUB_DICT');
					connectivityMatrix = base.get('CONNECTOME_CONSTRUCT_METHOD');
					wb = braph2waitbar(base.get('WAITBAR'), 0, ['Build up individual connectivity matrix for subjects ...']);
					for i = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
					    ba = gr_suvr.get('SUB_DICT').get('IT',i).get('BA');
					    braph2waitbar(wb, .15 + .85 * i / gr_suvr.get('SUB_DICT').get('LENGTH'), ['Calculating individual connectivity for subject ' num2str(i) ' of ' num2str(gr_suvr.get('SUB_DICT').get('LENGTH')) ' ...'])
					    sub_id = gr_suvr.get('SUB_DICT').get('IT',i).get('ID');
					    sub = SubjectCON( ...
					        'ID', sub_id, ...
					        'BA', ba, ...
					        'CON', connectivityMatrix{i} ...
					        );
					    sub_dict.get('ADD', sub);
					end
					braph2waitbar(wb, 'close')
					value = gr;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(base, prop, varargin{:});
					else
						value = calculateValue@Element(base, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(base, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(base) ' ' base.getPropTag(prop) '.'];
			
			switch prop
				case 13 % ConstructorIndividualConBase.GR
					check = any(strcmp(value.get('SUB_CLASS'), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(8, value, 'Group') already checked
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(base, prop, value);
					end
			end
		end
	end
end
