classdef FILE_PATH < ConcreteElement
	%FILE_PATH is the base element for the variables of interest.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A FILE_PATH is the base element for storing path of subject data files.
	%  Instances of this class should not be created. 
	%  Use one of its subclasses instead.
	%
	% The list of FILE_PATH properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the variable of interest.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the variable of interest.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of element for savfile path for subjects.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the variable of interest.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the variable of interest.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the variable of interest.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the variable of interest.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PATH</strong> 	PATH (data, string) is the path of target files.
	%
	% FILE_PATH methods (constructor):
	%  FILE_PATH - constructor
	%
	% FILE_PATH methods:
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
	% FILE_PATH methods (display):
	%  tostring - string with information about the path of interest
	%  disp - displays information about the path of interest
	%  tree - displays the tree of the path of interest
	%
	% FILE_PATH methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two path of interest are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the path of interest
	%
	% FILE_PATH methods (save/load, Static):
	%  save - saves BRAPH2 path of interest as b2 file
	%  load - loads a BRAPH2 path of interest from a b2 file
	%
	% FILE_PATH method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the path of interest
	%
	% FILE_PATH method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the path of interest
	%
	% FILE_PATH methods (inspection, Static):
	%  getClass - returns the class of the path of interest
	%  getSubclasses - returns all subclasses of FILE_PATH
	%  getProps - returns the property list of the path of interest
	%  getPropNumber - returns the property number of the path of interest
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
	% FILE_PATH methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% FILE_PATH methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% FILE_PATH methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% FILE_PATH methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?FILE_PATH; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">FILE_PATH constants</a>.
	%
	%
	% See also VOINumeric, VOICategoric.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		PATH = 9; %CET: Computational Efficiency Trick
		PATH_TAG = 'PATH';
		PATH_CATEGORY = 4;
		PATH_FORMAT = 2;
	end
	methods % constructor
		function FP = FILE_PATH(varargin)
			%FILE_PATH() creates a path of interest.
			%
			% FILE_PATH(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% FILE_PATH(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of FILE_PATH properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the variable of interest.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the variable of interest.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of element for savfile path for subjects.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the variable of interest.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the variable of interest.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the variable of interest.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the variable of interest.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PATH</strong> 	PATH (data, string) is the path of target files.
			%
			% See also Category, Format.
			
			FP = FP@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the path of interest.
			%
			% BUILD = FILE_PATH.GETBUILD() returns the build of 'FILE_PATH'.
			%
			% Alternative forms to call this method are:
			%  BUILD = FP.GETBUILD() returns the build of the path of interest FP.
			%  BUILD = Element.GETBUILD(FP) returns the build of 'FP'.
			%  BUILD = Element.GETBUILD('FILE_PATH') returns the build of 'FILE_PATH'.
			%
			% Note that the Element.GETBUILD(FP) and Element.GETBUILD('FILE_PATH')
			%  are less computationally efficient.
			
			build = 1;
		end
		function FP_class = getClass()
			%GETCLASS returns the class of the path of interest.
			%
			% CLASS = FILE_PATH.GETCLASS() returns the class 'FILE_PATH'.
			%
			% Alternative forms to call this method are:
			%  CLASS = FP.GETCLASS() returns the class of the path of interest FP.
			%  CLASS = Element.GETCLASS(FP) returns the class of 'FP'.
			%  CLASS = Element.GETCLASS('FILE_PATH') returns 'FILE_PATH'.
			%
			% Note that the Element.GETCLASS(FP) and Element.GETCLASS('FILE_PATH')
			%  are less computationally efficient.
			
			FP_class = 'FILE_PATH';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the path of interest.
			%
			% LIST = FILE_PATH.GETSUBCLASSES() returns all subclasses of 'FILE_PATH'.
			%
			% Alternative forms to call this method are:
			%  LIST = FP.GETSUBCLASSES() returns all subclasses of the path of interest FP.
			%  LIST = Element.GETSUBCLASSES(FP) returns all subclasses of 'FP'.
			%  LIST = Element.GETSUBCLASSES('FILE_PATH') returns all subclasses of 'FILE_PATH'.
			%
			% Note that the Element.GETSUBCLASSES(FP) and Element.GETSUBCLASSES('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'FILE_PATH' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of path of interest.
			%
			% PROPS = FILE_PATH.GETPROPS() returns the property list of path of interest
			%  as a row vector.
			%
			% PROPS = FILE_PATH.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = FP.GETPROPS([CATEGORY]) returns the property list of the path of interest FP.
			%  PROPS = Element.GETPROPS(FP[, CATEGORY]) returns the property list of 'FP'.
			%  PROPS = Element.GETPROPS('FILE_PATH'[, CATEGORY]) returns the property list of 'FILE_PATH'.
			%
			% Note that the Element.GETPROPS(FP) and Element.GETPROPS('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9];
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
					prop_list = [5 9];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of path of interest.
			%
			% N = FILE_PATH.GETPROPNUMBER() returns the property number of path of interest.
			%
			% N = FILE_PATH.GETPROPNUMBER(CATEGORY) returns the property number of path of interest
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = FP.GETPROPNUMBER([CATEGORY]) returns the property number of the path of interest FP.
			%  N = Element.GETPROPNUMBER(FP) returns the property number of 'FP'.
			%  N = Element.GETPROPNUMBER('FILE_PATH') returns the property number of 'FILE_PATH'.
			%
			% Note that the Element.GETPROPNUMBER(FP) and Element.GETPROPNUMBER('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 9;
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
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in path of interest/error.
			%
			% CHECK = FILE_PATH.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = FP.EXISTSPROP(PROP) checks whether PROP exists for FP.
			%  CHECK = Element.EXISTSPROP(FP, PROP) checks whether PROP exists for FP.
			%  CHECK = Element.EXISTSPROP(FILE_PATH, PROP) checks whether PROP exists for FILE_PATH.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:FILE_PATH:WrongInput]
			%
			% Alternative forms to call this method are:
			%  FP.EXISTSPROP(PROP) throws error if PROP does NOT exist for FP.
			%   Error id: [BRAPH2:FILE_PATH:WrongInput]
			%  Element.EXISTSPROP(FP, PROP) throws error if PROP does NOT exist for FP.
			%   Error id: [BRAPH2:FILE_PATH:WrongInput]
			%  Element.EXISTSPROP(FILE_PATH, PROP) throws error if PROP does NOT exist for FILE_PATH.
			%   Error id: [BRAPH2:FILE_PATH:WrongInput]
			%
			% Note that the Element.EXISTSPROP(FP) and Element.EXISTSPROP('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 9 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':FILE_PATH:' 'WrongInput'], ...
					['BRAPH2' ':FILE_PATH:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for FILE_PATH.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in path of interest/error.
			%
			% CHECK = FILE_PATH.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = FP.EXISTSTAG(TAG) checks whether TAG exists for FP.
			%  CHECK = Element.EXISTSTAG(FP, TAG) checks whether TAG exists for FP.
			%  CHECK = Element.EXISTSTAG(FILE_PATH, TAG) checks whether TAG exists for FILE_PATH.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:FILE_PATH:WrongInput]
			%
			% Alternative forms to call this method are:
			%  FP.EXISTSTAG(TAG) throws error if TAG does NOT exist for FP.
			%   Error id: [BRAPH2:FILE_PATH:WrongInput]
			%  Element.EXISTSTAG(FP, TAG) throws error if TAG does NOT exist for FP.
			%   Error id: [BRAPH2:FILE_PATH:WrongInput]
			%  Element.EXISTSTAG(FILE_PATH, TAG) throws error if TAG does NOT exist for FILE_PATH.
			%   Error id: [BRAPH2:FILE_PATH:WrongInput]
			%
			% Note that the Element.EXISTSTAG(FP) and Element.EXISTSTAG('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PATH' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':FILE_PATH:' 'WrongInput'], ...
					['BRAPH2' ':FILE_PATH:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for FILE_PATH.'] ...
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
			%  PROPERTY = FP.GETPROPPROP(POINTER) returns property number of POINTER of FP.
			%  PROPERTY = Element.GETPROPPROP(FILE_PATH, POINTER) returns property number of POINTER of FILE_PATH.
			%  PROPERTY = FP.GETPROPPROP(FILE_PATH, POINTER) returns property number of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPPROP(FP) and Element.GETPROPPROP('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PATH' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = FP.GETPROPTAG(POINTER) returns tag of POINTER of FP.
			%  TAG = Element.GETPROPTAG(FILE_PATH, POINTER) returns tag of POINTER of FILE_PATH.
			%  TAG = FP.GETPROPTAG(FILE_PATH, POINTER) returns tag of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPTAG(FP) and Element.GETPROPTAG('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				file_path_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PATH' };
				tag = file_path_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = FP.GETPROPCATEGORY(POINTER) returns category of POINTER of FP.
			%  CATEGORY = Element.GETPROPCATEGORY(FILE_PATH, POINTER) returns category of POINTER of FILE_PATH.
			%  CATEGORY = FP.GETPROPCATEGORY(FILE_PATH, POINTER) returns category of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPCATEGORY(FP) and Element.GETPROPCATEGORY('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = FILE_PATH.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			file_path_category_list = { 1  1  1  3  4  2  2  6  4 };
			prop_category = file_path_category_list{prop};
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
			%  FORMAT = FP.GETPROPFORMAT(POINTER) returns format of POINTER of FP.
			%  FORMAT = Element.GETPROPFORMAT(FILE_PATH, POINTER) returns format of POINTER of FILE_PATH.
			%  FORMAT = FP.GETPROPFORMAT(FILE_PATH, POINTER) returns format of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPFORMAT(FP) and Element.GETPROPFORMAT('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = FILE_PATH.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			file_path_format_list = { 2  2  2  8  2  2  2  2  2 };
			prop_format = file_path_format_list{prop};
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
			%  DESCRIPTION = FP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of FP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(FILE_PATH, POINTER) returns description of POINTER of FILE_PATH.
			%  DESCRIPTION = FP.GETPROPDESCRIPTION(FILE_PATH, POINTER) returns description of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPDESCRIPTION(FP) and Element.GETPROPDESCRIPTION('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = FILE_PATH.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			file_path_description_list = { 'ELCLASS (constant, string) is the class of the variable of interest.'  'NAME (constant, string) is the name of the variable of interest.'  'DESCRIPTION (constant, string) is the description of element for savfile path for subjects.'  'TEMPLATE (parameter, item) is the template of the variable of interest.'  'ID (data, string) is a few-letter code for the variable of interest.'  'LABEL (metadata, string) is an extended label of the variable of interest.'  'NOTES (metadata, string) are some specific notes about the variable of interest.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PATH (data, string) is the path of target files.' };
			prop_description = file_path_description_list{prop};
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
			%  SETTINGS = FP.GETPROPSETTINGS(POINTER) returns settings of POINTER of FP.
			%  SETTINGS = Element.GETPROPSETTINGS(FILE_PATH, POINTER) returns settings of POINTER of FILE_PATH.
			%  SETTINGS = FP.GETPROPSETTINGS(FILE_PATH, POINTER) returns settings of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPSETTINGS(FP) and Element.GETPROPSETTINGS('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = FILE_PATH.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % FILE_PATH.PATH
					prop_settings = Format.getFormatSettings(2);
				case 4 % FILE_PATH.TEMPLATE
					prop_settings = 'FILE_PATH';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = FILE_PATH.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = FILE_PATH.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = FP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of FP.
			%  DEFAULT = Element.GETPROPDEFAULT(FILE_PATH, POINTER) returns the default value of POINTER of FILE_PATH.
			%  DEFAULT = FP.GETPROPDEFAULT(FILE_PATH, POINTER) returns the default value of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPDEFAULT(FP) and Element.GETPROPDEFAULT('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = FILE_PATH.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % FILE_PATH.PATH
					prop_default = Format.getFormatDefault(2, FILE_PATH.getPropSettings(prop));
				case 1 % FILE_PATH.ELCLASS
					prop_default = 'FILE_PATH';
				case 2 % FILE_PATH.NAME
					prop_default = 'FILE PATH';
				case 3 % FILE_PATH.DESCRIPTION
					prop_default = 'A path Of Interest  is the base element for a variable of interest. Instances of this class should not be created. Use one of its subclasses instead.';
				case 4 % FILE_PATH.TEMPLATE
					prop_default = Format.getFormatDefault(8, FILE_PATH.getPropSettings(prop));
				case 5 % FILE_PATH.ID
					prop_default = 'FILE PATH ID';
				case 6 % FILE_PATH.LABEL
					prop_default = 'FILE PATH label';
				case 7 % FILE_PATH.NOTES
					prop_default = 'FILE PATH notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = FILE_PATH.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = FILE_PATH.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = FP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of FP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(FILE_PATH, POINTER) returns the conditioned default value of POINTER of FILE_PATH.
			%  DEFAULT = FP.GETPROPDEFAULTCONDITIONED(FILE_PATH, POINTER) returns the conditioned default value of POINTER of FILE_PATH.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(FP) and Element.GETPROPDEFAULTCONDITIONED('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = FILE_PATH.getPropProp(pointer);
			
			prop_default = FILE_PATH.conditioning(prop, FILE_PATH.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = FP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = FP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of FP.
			%  CHECK = Element.CHECKPROP(FILE_PATH, PROP, VALUE) checks VALUE format for PROP of FILE_PATH.
			%  CHECK = FP.CHECKPROP(FILE_PATH, PROP, VALUE) checks VALUE format for PROP of FILE_PATH.
			% 
			% FP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:FILE_PATH:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of FP.
			%   Error id: BRAPH2:FILE_PATH:WrongInput
			%  Element.CHECKPROP(FILE_PATH, PROP, VALUE) throws error if VALUE has not a valid format for PROP of FILE_PATH.
			%   Error id: BRAPH2:FILE_PATH:WrongInput
			%  FP.CHECKPROP(FILE_PATH, PROP, VALUE) throws error if VALUE has not a valid format for PROP of FILE_PATH.
			%   Error id: BRAPH2:FILE_PATH:WrongInput]
			% 
			% Note that the Element.CHECKPROP(FP) and Element.CHECKPROP('FILE_PATH')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = FILE_PATH.getPropProp(pointer);
			
			switch prop
				case 9 % FILE_PATH.PATH
					check = Format.checkFormat(2, value, FILE_PATH.getPropSettings(prop));
				case 4 % FILE_PATH.TEMPLATE
					check = Format.checkFormat(8, value, FILE_PATH.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':FILE_PATH:' 'WrongInput'], ...
					['BRAPH2' ':FILE_PATH:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' FILE_PATH.getPropTag(prop) ' (' FILE_PATH.getFormatTag(FILE_PATH.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
