classdef SubjectNeuroimaging < Subject
	%SubjectNeuroimaging is a subject with neuroimaging file (NIfTI).
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with a NIfTI files containing brain imaging data.
	%
	% The list of SubjectNeuroimaging properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) contains the variables of interest of the subject.
	%  <strong>10</strong> <strong>NIFTI_FILE</strong> 	NIFTI_FILE (data, string) is direcotry to subject nifti data.
	%
	% SubjectNeuroimaging methods (constructor):
	%  SubjectNeuroimaging - constructor
	%
	% SubjectNeuroimaging methods:
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
	% SubjectNeuroimaging methods (display):
	%  tostring - string with information about the subject with neuroimaging file
	%  disp - displays information about the subject with neuroimaging file
	%  tree - displays the tree of the subject with neuroimaging file
	%
	% SubjectNeuroimaging methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with neuroimaging file are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with neuroimaging file
	%
	% SubjectNeuroimaging methods (save/load, Static):
	%  save - saves BRAPH2 subject with neuroimaging file as b2 file
	%  load - loads a BRAPH2 subject with neuroimaging file from a b2 file
	%
	% SubjectNeuroimaging method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with neuroimaging file
	%
	% SubjectNeuroimaging method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with neuroimaging file
	%
	% SubjectNeuroimaging methods (inspection, Static):
	%  getClass - returns the class of the subject with neuroimaging file
	%  getSubclasses - returns all subclasses of SubjectNeuroimaging
	%  getProps - returns the property list of the subject with neuroimaging file
	%  getPropNumber - returns the property number of the subject with neuroimaging file
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
	% SubjectNeuroimaging methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectNeuroimaging methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectNeuroimaging methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectNeuroimaging methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectNeuroimaging; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectNeuroimaging constants</a>.
	%
	%
	% See also ImporterGroupSubjectCON_TXT, ExporterGroupSubjectCON_TXT, ImporterGroupSubjectCON_XLS, ExporterGroupSubjectCON_XLS, ImporterGroupSubjNIfTI.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		NIFTI_FILE = 10; %CET: Computational Efficiency Trick
		NIFTI_FILE_TAG = 'NIFTI_FILE';
		NIFTI_FILE_CATEGORY = 4;
		NIFTI_FILE_FORMAT = 2;
	end
	methods % constructor
		function sub = SubjectNeuroimaging(varargin)
			%SubjectNeuroimaging() creates a subject with neuroimaging file.
			%
			% SubjectNeuroimaging(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectNeuroimaging(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SubjectNeuroimaging properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) contains the variables of interest of the subject.
			%  <strong>10</strong> <strong>NIFTI_FILE</strong> 	NIFTI_FILE (data, string) is direcotry to subject nifti data.
			%
			% See also Category, Format.
			
			sub = sub@Subject(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the subject with neuroimaging file.
			%
			% BUILD = SubjectNeuroimaging.GETBUILD() returns the build of 'SubjectNeuroimaging'.
			%
			% Alternative forms to call this method are:
			%  BUILD = SUB.GETBUILD() returns the build of the subject with neuroimaging file SUB.
			%  BUILD = Element.GETBUILD(SUB) returns the build of 'SUB'.
			%  BUILD = Element.GETBUILD('SubjectNeuroimaging') returns the build of 'SubjectNeuroimaging'.
			%
			% Note that the Element.GETBUILD(SUB) and Element.GETBUILD('SubjectNeuroimaging')
			%  are less computationally efficient.
			
			build = 1;
		end
		function sub_class = getClass()
			%GETCLASS returns the class of the subject with neuroimaging file.
			%
			% CLASS = SubjectNeuroimaging.GETCLASS() returns the class 'SubjectNeuroimaging'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with neuroimaging file SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectNeuroimaging') returns 'SubjectNeuroimaging'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectNeuroimaging')
			%  are less computationally efficient.
			
			sub_class = 'SubjectNeuroimaging';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with neuroimaging file.
			%
			% LIST = SubjectNeuroimaging.GETSUBCLASSES() returns all subclasses of 'SubjectNeuroimaging'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with neuroimaging file SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectNeuroimaging') returns all subclasses of 'SubjectNeuroimaging'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SubjectNeuroimaging' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with neuroimaging file.
			%
			% PROPS = SubjectNeuroimaging.GETPROPS() returns the property list of subject with neuroimaging file
			%  as a row vector.
			%
			% PROPS = SubjectNeuroimaging.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with neuroimaging file SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectNeuroimaging'[, CATEGORY]) returns the property list of 'SubjectNeuroimaging'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10];
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
					prop_list = [5 9 10];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of subject with neuroimaging file.
			%
			% N = SubjectNeuroimaging.GETPROPNUMBER() returns the property number of subject with neuroimaging file.
			%
			% N = SubjectNeuroimaging.GETPROPNUMBER(CATEGORY) returns the property number of subject with neuroimaging file
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with neuroimaging file SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectNeuroimaging') returns the property number of 'SubjectNeuroimaging'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 10;
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
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with neuroimaging file/error.
			%
			% CHECK = SubjectNeuroimaging.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectNeuroimaging, PROP) checks whether PROP exists for SubjectNeuroimaging.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%  Element.EXISTSPROP(SubjectNeuroimaging, PROP) throws error if PROP does NOT exist for SubjectNeuroimaging.
			%   Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 10 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectNeuroimaging:' 'WrongInput'], ...
					['BRAPH2' ':SubjectNeuroimaging:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectNeuroimaging.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with neuroimaging file/error.
			%
			% CHECK = SubjectNeuroimaging.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectNeuroimaging, TAG) checks whether TAG exists for SubjectNeuroimaging.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%  Element.EXISTSTAG(SubjectNeuroimaging, TAG) throws error if TAG does NOT exist for SubjectNeuroimaging.
			%   Error id: [BRAPH2:SubjectNeuroimaging:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'NIFTI_FILE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectNeuroimaging:' 'WrongInput'], ...
					['BRAPH2' ':SubjectNeuroimaging:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SubjectNeuroimaging.'] ...
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
			%  PROPERTY = SUB.GETPROPPROP(POINTER) returns property number of POINTER of SUB.
			%  PROPERTY = Element.GETPROPPROP(SubjectNeuroimaging, POINTER) returns property number of POINTER of SubjectNeuroimaging.
			%  PROPERTY = SUB.GETPROPPROP(SubjectNeuroimaging, POINTER) returns property number of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'NIFTI_FILE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = SUB.GETPROPTAG(POINTER) returns tag of POINTER of SUB.
			%  TAG = Element.GETPROPTAG(SubjectNeuroimaging, POINTER) returns tag of POINTER of SubjectNeuroimaging.
			%  TAG = SUB.GETPROPTAG(SubjectNeuroimaging, POINTER) returns tag of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				subjectneuroimaging_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'NIFTI_FILE' };
				tag = subjectneuroimaging_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = SUB.GETPROPCATEGORY(POINTER) returns category of POINTER of SUB.
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectNeuroimaging, POINTER) returns category of POINTER of SubjectNeuroimaging.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectNeuroimaging, POINTER) returns category of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectNeuroimaging.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectneuroimaging_category_list = { 1  1  1  3  4  2  2  6  4  4 };
			prop_category = subjectneuroimaging_category_list{prop};
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
			%  FORMAT = SUB.GETPROPFORMAT(POINTER) returns format of POINTER of SUB.
			%  FORMAT = Element.GETPROPFORMAT(SubjectNeuroimaging, POINTER) returns format of POINTER of SubjectNeuroimaging.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectNeuroimaging, POINTER) returns format of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectNeuroimaging.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectneuroimaging_format_list = { 2  2  2  8  2  2  2  2  10  2 };
			prop_format = subjectneuroimaging_format_list{prop};
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
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SUB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectNeuroimaging, POINTER) returns description of POINTER of SubjectNeuroimaging.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectNeuroimaging, POINTER) returns description of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectNeuroimaging.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectneuroimaging_description_list = { 'ELCLASS (constant, string) is the class of the subject.'  'NAME (constant, string) is the name of the subject.'  'DESCRIPTION (constant, string) is the description of the subject.'  'TEMPLATE (parameter, item) is the template of the subject.'  'ID (data, string) is a few-letter code for the subject.'  'LABEL (metadata, string) is an extended label of the subject.'  'NOTES (metadata, string) are some specific notes about the subject.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'VOI_DICT (data, idict) contains the variables of interest of the subject.'  'NIFTI_FILE (data, string) is direcotry to subject nifti data.' };
			prop_description = subjectneuroimaging_description_list{prop};
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
			%  SETTINGS = SUB.GETPROPSETTINGS(POINTER) returns settings of POINTER of SUB.
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectNeuroimaging, POINTER) returns settings of POINTER of SubjectNeuroimaging.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectNeuroimaging, POINTER) returns settings of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectNeuroimaging.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % SubjectNeuroimaging.NIFTI_FILE
					prop_settings = Format.getFormatSettings(2);
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectNeuroimaging.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectNeuroimaging.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectNeuroimaging, POINTER) returns the default value of POINTER of SubjectNeuroimaging.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectNeuroimaging, POINTER) returns the default value of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectNeuroimaging.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % SubjectNeuroimaging.NIFTI_FILE
					prop_default = Format.getFormatDefault(2, SubjectNeuroimaging.getPropSettings(prop));
				case 1 % SubjectNeuroimaging.ELCLASS
					prop_default = 'SubjectNeuroimaging';
				case 2 % SubjectNeuroimaging.NAME
					prop_default = 'Subject Neuroimaging';
				case 3 % SubjectNeuroimaging.DESCRIPTION
					prop_default = 'Subject with a NIfTI files containing brain imaging data.';
				case 5 % SubjectNeuroimaging.ID
					prop_default = 'SubjectNeuroimaging ID';
				case 6 % SubjectNeuroimaging.LABEL
					prop_default = 'SubjectNeuroimaging label';
				case 7 % SubjectNeuroimaging.NOTES
					prop_default = 'SubjectNeuroimaging notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectNeuroimaging.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectNeuroimaging.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectNeuroimaging, POINTER) returns the conditioned default value of POINTER of SubjectNeuroimaging.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectNeuroimaging, POINTER) returns the conditioned default value of POINTER of SubjectNeuroimaging.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectNeuroimaging.getPropProp(pointer);
			
			prop_default = SubjectNeuroimaging.conditioning(prop, SubjectNeuroimaging.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SUB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SUB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SUB.
			%  CHECK = Element.CHECKPROP(SubjectNeuroimaging, PROP, VALUE) checks VALUE format for PROP of SubjectNeuroimaging.
			%  CHECK = SUB.CHECKPROP(SubjectNeuroimaging, PROP, VALUE) checks VALUE format for PROP of SubjectNeuroimaging.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SubjectNeuroimaging:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: BRAPH2:SubjectNeuroimaging:WrongInput
			%  Element.CHECKPROP(SubjectNeuroimaging, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectNeuroimaging.
			%   Error id: BRAPH2:SubjectNeuroimaging:WrongInput
			%  SUB.CHECKPROP(SubjectNeuroimaging, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectNeuroimaging.
			%   Error id: BRAPH2:SubjectNeuroimaging:WrongInput]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectNeuroimaging')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectNeuroimaging.getPropProp(pointer);
			
			switch prop
				case 10 % SubjectNeuroimaging.NIFTI_FILE
					check = Format.checkFormat(2, value, SubjectNeuroimaging.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectNeuroimaging:' 'WrongInput'], ...
					['BRAPH2' ':SubjectNeuroimaging:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectNeuroimaging.getPropTag(prop) ' (' SubjectNeuroimaging.getFormatTag(SubjectNeuroimaging.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.TXT', ...
			        'Label', 'Import TXT ...', ...
			        'Callback', {@cb_importer_TXT});
			end
			function cb_importer_TXT(~, ~)
			    try
			        im = ImporterGroupSubjectCON_TXT( ...
			            'ID', 'Import Group of SubjectCons from TXT', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectCONs in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.XLS', ...
			        'Label', 'Import XLS ...', ...
			        'Callback', {@cb_importer_XLS});
			end
			function cb_importer_XLS(~, ~)
			    try
			        im = ImporterGroupSubjectCON_XLS( ...
			            'ID', 'Import Group of SubjectCons from XLS', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectCONs in XLS format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.TXT', ...
			        'Label', 'Export TXT ...', ...
			        'Callback', {@cb_exporter_TXT});
			end
			function cb_exporter_TXT(~, ~)
			    ex = ExporterGroupSubjectCON_TXT( ...
			        'ID', 'Export Brain Group of SubjectCons to TXT', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.XLS', ...
			        'Label', 'Export XLS ...', ...
			        'Callback', {@cb_exporter_XLS});
			end
			function cb_exporter_XLS(~, ~)
			    ex = ExporterGroupSubjectCON_XLS( ...
			        'ID', 'Export Brain Group of SubjectCons to XLS', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
