classdef IndividualConConstructorBase < ConcreteElement
	%IndividualConConstructorBase is the base constructor for individual brain connectome.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% The IndividualConConstructorBase constructs individual brain connectome with SUVR (standard uptake value ratio) data.
	% 
	% Its subclasses need to implement some or all of the following props, including GR GR_REF CONNECTOME_METHOD.
	%
	% The list of IndividualConConstructorBase properties is:
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
	%  <strong>12</strong> <strong>CONNECTOME_CONSTUCT_METHOD</strong> 	CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for individual connectome construction.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
	%
	% IndividualConConstructorBase methods (constructor):
	%  IndividualConConstructorBase - constructor
	%
	% IndividualConConstructorBase methods:
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
	% IndividualConConstructorBase methods (display):
	%  tostring - string with information about the Individual Base Constructor
	%  disp - displays information about the Individual Base Constructor
	%  tree - displays the tree of the Individual Base Constructor
	%
	% IndividualConConstructorBase methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Individual Base Constructor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Individual Base Constructor
	%
	% IndividualConConstructorBase methods (save/load, Static):
	%  save - saves BRAPH2 Individual Base Constructor as b2 file
	%  load - loads a BRAPH2 Individual Base Constructor from a b2 file
	%
	% IndividualConConstructorBase method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Individual Base Constructor
	%
	% IndividualConConstructorBase method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Individual Base Constructor
	%
	% IndividualConConstructorBase methods (inspection, Static):
	%  getClass - returns the class of the Individual Base Constructor
	%  getSubclasses - returns all subclasses of IndividualConConstructorBase
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
	% IndividualConConstructorBase methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% IndividualConConstructorBase methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% IndividualConConstructorBase methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% IndividualConConstructorBase methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?IndividualConConstructorBase; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">IndividualConConstructorBase constants</a>.
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
		
		CONNECTOME_CONSTUCT_METHOD = 12; %CET: Computational Efficiency Trick
		CONNECTOME_CONSTUCT_METHOD_TAG = 'CONNECTOME_CONSTUCT_METHOD';
		CONNECTOME_CONSTUCT_METHOD_CATEGORY = 6;
		CONNECTOME_CONSTUCT_METHOD_FORMAT = 16;
		
		GR = 13; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 5;
		GR_FORMAT = 8;
	end
	methods % constructor
		function base = IndividualConConstructorBase(varargin)
			%IndividualConConstructorBase() creates a Individual Base Constructor.
			%
			% IndividualConConstructorBase(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% IndividualConConstructorBase(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of IndividualConConstructorBase properties is:
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
			%  <strong>12</strong> <strong>CONNECTOME_CONSTUCT_METHOD</strong> 	CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for individual connectome construction.
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
			% BUILD = IndividualConConstructorBase.GETBUILD() returns the build of 'IndividualConConstructorBase'.
			%
			% Alternative forms to call this method are:
			%  BUILD = BASE.GETBUILD() returns the build of the Individual Base Constructor BASE.
			%  BUILD = Element.GETBUILD(BASE) returns the build of 'BASE'.
			%  BUILD = Element.GETBUILD('IndividualConConstructorBase') returns the build of 'IndividualConConstructorBase'.
			%
			% Note that the Element.GETBUILD(BASE) and Element.GETBUILD('IndividualConConstructorBase')
			%  are less computationally efficient.
			
			build = 1;
		end
		function base_class = getClass()
			%GETCLASS returns the class of the Individual Base Constructor.
			%
			% CLASS = IndividualConConstructorBase.GETCLASS() returns the class 'IndividualConConstructorBase'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BASE.GETCLASS() returns the class of the Individual Base Constructor BASE.
			%  CLASS = Element.GETCLASS(BASE) returns the class of 'BASE'.
			%  CLASS = Element.GETCLASS('IndividualConConstructorBase') returns 'IndividualConConstructorBase'.
			%
			% Note that the Element.GETCLASS(BASE) and Element.GETCLASS('IndividualConConstructorBase')
			%  are less computationally efficient.
			
			base_class = 'IndividualConConstructorBase';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Individual Base Constructor.
			%
			% LIST = IndividualConConstructorBase.GETSUBCLASSES() returns all subclasses of 'IndividualConConstructorBase'.
			%
			% Alternative forms to call this method are:
			%  LIST = BASE.GETSUBCLASSES() returns all subclasses of the Individual Base Constructor BASE.
			%  LIST = Element.GETSUBCLASSES(BASE) returns all subclasses of 'BASE'.
			%  LIST = Element.GETSUBCLASSES('IndividualConConstructorBase') returns all subclasses of 'IndividualConConstructorBase'.
			%
			% Note that the Element.GETSUBCLASSES(BASE) and Element.GETSUBCLASSES('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'IndividualConConstructorBase'  'IndividualDeviationConConstructor'  'IndividualDistanceConConstructor' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Individual Base Constructor.
			%
			% PROPS = IndividualConConstructorBase.GETPROPS() returns the property list of Individual Base Constructor
			%  as a row vector.
			%
			% PROPS = IndividualConConstructorBase.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BASE.GETPROPS([CATEGORY]) returns the property list of the Individual Base Constructor BASE.
			%  PROPS = Element.GETPROPS(BASE[, CATEGORY]) returns the property list of 'BASE'.
			%  PROPS = Element.GETPROPS('IndividualConConstructorBase'[, CATEGORY]) returns the property list of 'IndividualConConstructorBase'.
			%
			% Note that the Element.GETPROPS(BASE) and Element.GETPROPS('IndividualConConstructorBase')
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
			% N = IndividualConConstructorBase.GETPROPNUMBER() returns the property number of Individual Base Constructor.
			%
			% N = IndividualConConstructorBase.GETPROPNUMBER(CATEGORY) returns the property number of Individual Base Constructor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BASE.GETPROPNUMBER([CATEGORY]) returns the property number of the Individual Base Constructor BASE.
			%  N = Element.GETPROPNUMBER(BASE) returns the property number of 'BASE'.
			%  N = Element.GETPROPNUMBER('IndividualConConstructorBase') returns the property number of 'IndividualConConstructorBase'.
			%
			% Note that the Element.GETPROPNUMBER(BASE) and Element.GETPROPNUMBER('IndividualConConstructorBase')
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
			% CHECK = IndividualConConstructorBase.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BASE.EXISTSPROP(PROP) checks whether PROP exists for BASE.
			%  CHECK = Element.EXISTSPROP(BASE, PROP) checks whether PROP exists for BASE.
			%  CHECK = Element.EXISTSPROP(IndividualConConstructorBase, PROP) checks whether PROP exists for IndividualConConstructorBase.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BASE.EXISTSPROP(PROP) throws error if PROP does NOT exist for BASE.
			%   Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%  Element.EXISTSPROP(BASE, PROP) throws error if PROP does NOT exist for BASE.
			%   Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%  Element.EXISTSPROP(IndividualConConstructorBase, PROP) throws error if PROP does NOT exist for IndividualConConstructorBase.
			%   Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BASE) and Element.EXISTSPROP('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualConConstructorBase:' 'WrongInput'], ...
					['BRAPH2' ':IndividualConConstructorBase:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for IndividualConConstructorBase.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Individual Base Constructor/error.
			%
			% CHECK = IndividualConConstructorBase.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BASE.EXISTSTAG(TAG) checks whether TAG exists for BASE.
			%  CHECK = Element.EXISTSTAG(BASE, TAG) checks whether TAG exists for BASE.
			%  CHECK = Element.EXISTSTAG(IndividualConConstructorBase, TAG) checks whether TAG exists for IndividualConConstructorBase.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BASE.EXISTSTAG(TAG) throws error if TAG does NOT exist for BASE.
			%   Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%  Element.EXISTSTAG(BASE, TAG) throws error if TAG does NOT exist for BASE.
			%   Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%  Element.EXISTSTAG(IndividualConConstructorBase, TAG) throws error if TAG does NOT exist for IndividualConConstructorBase.
			%   Error id: [BRAPH2:IndividualConConstructorBase:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BASE) and Element.EXISTSTAG('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualConConstructorBase:' 'WrongInput'], ...
					['BRAPH2' ':IndividualConConstructorBase:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for IndividualConConstructorBase.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(IndividualConConstructorBase, POINTER) returns property number of POINTER of IndividualConConstructorBase.
			%  PROPERTY = BASE.GETPROPPROP(IndividualConConstructorBase, POINTER) returns property number of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPPROP(BASE) and Element.GETPROPPROP('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(IndividualConConstructorBase, POINTER) returns tag of POINTER of IndividualConConstructorBase.
			%  TAG = BASE.GETPROPTAG(IndividualConConstructorBase, POINTER) returns tag of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPTAG(BASE) and Element.GETPROPTAG('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				individualconconstructorbase_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' };
				tag = individualconconstructorbase_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(IndividualConConstructorBase, POINTER) returns category of POINTER of IndividualConConstructorBase.
			%  CATEGORY = BASE.GETPROPCATEGORY(IndividualConConstructorBase, POINTER) returns category of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPCATEGORY(BASE) and Element.GETPROPCATEGORY('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualConConstructorBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualconconstructorbase_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = individualconconstructorbase_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(IndividualConConstructorBase, POINTER) returns format of POINTER of IndividualConConstructorBase.
			%  FORMAT = BASE.GETPROPFORMAT(IndividualConConstructorBase, POINTER) returns format of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPFORMAT(BASE) and Element.GETPROPFORMAT('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualConConstructorBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualconconstructorbase_format_list = { 2  2  2  8  2  2  2  2  4  8  8  16  8 };
			prop_format = individualconconstructorbase_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(IndividualConConstructorBase, POINTER) returns description of POINTER of IndividualConConstructorBase.
			%  DESCRIPTION = BASE.GETPROPDESCRIPTION(IndividualConConstructorBase, POINTER) returns description of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPDESCRIPTION(BASE) and Element.GETPROPDESCRIPTION('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualConConstructorBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualconconstructorbase_description_list = { 'ELCLASS (constant, string) is the class of Individual Connectome Constructor Base.'  'NAME (constant, string) is the name of the Individual Connectome Constructor Base.'  'DESCRIPTION (constant, string) is the description of the Individual Connectome Constructor Base.'  'TEMPLATE (parameter, item) is the template of the Individual Connectome Constructor Base.'  'ID (data, string) is a few-letter code for the Individual Connectome Constructor Base.'  'LABEL (metadata, string) is an extended label of the Individual Connectome Constructor Base.'  'NOTES (metadata, string) are some specific notes about the Individual Connectome Constructor Base.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR_SUVR (data, item) is a group of subjects with mean SUVR data.'  'GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.'  'CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for individual connectome construction.'  'GR (result, item) is a group of subjects with connectivity data.' };
			prop_description = individualconconstructorbase_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(IndividualConConstructorBase, POINTER) returns settings of POINTER of IndividualConConstructorBase.
			%  SETTINGS = BASE.GETPROPSETTINGS(IndividualConConstructorBase, POINTER) returns settings of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPSETTINGS(BASE) and Element.GETPROPSETTINGS('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualConConstructorBase.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % IndividualConConstructorBase.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % IndividualConConstructorBase.GR_SUVR
					prop_settings = Format.getFormatSettings(8);
				case 11 % IndividualConConstructorBase.GR_SUVR_REF
					prop_settings = Format.getFormatSettings(8);
				case 12 % IndividualConConstructorBase.CONNECTOME_CONSTUCT_METHOD
					prop_settings = Format.getFormatSettings(16);
				case 13 % IndividualConConstructorBase.GR
					prop_settings = 'Group';
				case 4 % IndividualConConstructorBase.TEMPLATE
					prop_settings = 'IndividualConConstructorBase';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = IndividualConConstructorBase.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualConConstructorBase.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BASE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BASE.
			%  DEFAULT = Element.GETPROPDEFAULT(IndividualConConstructorBase, POINTER) returns the default value of POINTER of IndividualConConstructorBase.
			%  DEFAULT = BASE.GETPROPDEFAULT(IndividualConConstructorBase, POINTER) returns the default value of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPDEFAULT(BASE) and Element.GETPROPDEFAULT('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndividualConConstructorBase.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % IndividualConConstructorBase.WAITBAR
					prop_default = true;
				case 10 % IndividualConConstructorBase.GR_SUVR
					prop_default = Group('SUB_CLASS', 'SubjectST');
				case 11 % IndividualConConstructorBase.GR_SUVR_REF
					prop_default = Group('SUB_CLASS', 'SubjectST');
				case 12 % IndividualConConstructorBase.CONNECTOME_CONSTUCT_METHOD
					prop_default = {};
				case 13 % IndividualConConstructorBase.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case 1 % IndividualConConstructorBase.ELCLASS
					prop_default = 'IndividualConConstructorBase';
				case 2 % IndividualConConstructorBase.NAME
					prop_default = 'Individual Connectome Constructor Base';
				case 3 % IndividualConConstructorBase.DESCRIPTION
					prop_default = 'A Individual Connectome Constructor Base (IndividualConConstructorBase) comprises brain connectome constructor with a specific dataset. Its subclasses need to implement the props GR, GR_REF and CONNECTOME_METHOD.';
				case 4 % IndividualConConstructorBase.TEMPLATE
					prop_default = Format.getFormatDefault(8, IndividualConConstructorBase.getPropSettings(prop));
				case 5 % IndividualConConstructorBase.ID
					prop_default = 'IndividualConConstructorBase ID';
				case 6 % IndividualConConstructorBase.LABEL
					prop_default = 'Individual Connectome Constructor Base label';
				case 7 % IndividualConConstructorBase.NOTES
					prop_default = 'Individual Connectome Constructor Base notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = IndividualConConstructorBase.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualConConstructorBase.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BASE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BASE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(IndividualConConstructorBase, POINTER) returns the conditioned default value of POINTER of IndividualConConstructorBase.
			%  DEFAULT = BASE.GETPROPDEFAULTCONDITIONED(IndividualConConstructorBase, POINTER) returns the conditioned default value of POINTER of IndividualConConstructorBase.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BASE) and Element.GETPROPDEFAULTCONDITIONED('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = IndividualConConstructorBase.getPropProp(pointer);
			
			prop_default = IndividualConConstructorBase.conditioning(prop, IndividualConConstructorBase.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(IndividualConConstructorBase, PROP, VALUE) checks VALUE format for PROP of IndividualConConstructorBase.
			%  CHECK = BASE.CHECKPROP(IndividualConConstructorBase, PROP, VALUE) checks VALUE format for PROP of IndividualConConstructorBase.
			% 
			% BASE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:IndividualConConstructorBase:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BASE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BASE.
			%   Error id: BRAPH2:IndividualConConstructorBase:WrongInput
			%  Element.CHECKPROP(IndividualConConstructorBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualConConstructorBase.
			%   Error id: BRAPH2:IndividualConConstructorBase:WrongInput
			%  BASE.CHECKPROP(IndividualConConstructorBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualConConstructorBase.
			%   Error id: BRAPH2:IndividualConConstructorBase:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BASE) and Element.CHECKPROP('IndividualConConstructorBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = IndividualConConstructorBase.getPropProp(pointer);
			
			switch prop
				case 9 % IndividualConConstructorBase.WAITBAR
					check = Format.checkFormat(4, value, IndividualConConstructorBase.getPropSettings(prop));
				case 10 % IndividualConConstructorBase.GR_SUVR
					check = Format.checkFormat(8, value, IndividualConConstructorBase.getPropSettings(prop));
				case 11 % IndividualConConstructorBase.GR_SUVR_REF
					check = Format.checkFormat(8, value, IndividualConConstructorBase.getPropSettings(prop));
				case 12 % IndividualConConstructorBase.CONNECTOME_CONSTUCT_METHOD
					check = Format.checkFormat(16, value, IndividualConConstructorBase.getPropSettings(prop));
				case 13 % IndividualConConstructorBase.GR
					check = Format.checkFormat(8, value, IndividualConConstructorBase.getPropSettings(prop));
				case 4 % IndividualConConstructorBase.TEMPLATE
					check = Format.checkFormat(8, value, IndividualConConstructorBase.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualConConstructorBase:' 'WrongInput'], ...
					['BRAPH2' ':IndividualConConstructorBase:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' IndividualConConstructorBase.getPropTag(prop) ' (' IndividualConConstructorBase.getFormatTag(IndividualConConstructorBase.getPropFormat(prop)) ').'] ...
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
				case 13 % IndividualConConstructorBase.GR
					rng_settings_ = rng(); rng(base.getPropSeed(13), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectCON', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					gr_suvr = base.get('GR_SUVR');
					sub_dict = gr.memorize('SUB_DICT');
					connectivityMatrix = base.get('CONNECTOME_CONSTUCT_METHOD');
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
				case 13 % IndividualConConstructorBase.GR
					check = any(strcmp(value.get('SUB_CLASS'), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(8, value, 'Group') already checked
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(base, prop, value);
					end
			end
		end
	end
end
