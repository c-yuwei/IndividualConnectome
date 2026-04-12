classdef SubjectNIfTI < Subject
	%SubjectNIfTI is a subject with Nifti data (e.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with nifti files containing brain imaging data (e.g. obtained from PET).
	%
	% SubjectNIfTI methods (constructor):
	%  SubjectNIfTI - constructor
	%
	% SubjectNIfTI methods:
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
	% SubjectNIfTI methods (display):
	%  tostring - string with information about the subject with Nifti files
	%  disp - displays information about the subject with Nifti files
	%  tree - displays the tree of the subject with Nifti files
	%
	% SubjectNIfTI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with Nifti files are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with Nifti files
	%
	% SubjectNIfTI methods (save/load, Static):
	%  save - saves BRAPH2 subject with Nifti files as b2 file
	%  load - loads a BRAPH2 subject with Nifti files from a b2 file
	%
	% SubjectNIfTI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with Nifti files
	%
	% SubjectNIfTI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with Nifti files
	%
	% SubjectNIfTI methods (inspection, Static):
	%  getClass - returns the class of the subject with Nifti files
	%  getSubclasses - returns all subclasses of SubjectNIfTI
	%  getProps - returns the property list of the subject with Nifti files
	%  getPropNumber - returns the property number of the subject with Nifti files
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
	% SubjectNIfTI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectNIfTI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectNIfTI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectNIfTI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectNIfTI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectNIfTI constants</a>.
	%
	%
	% See also ImporterGroupSubjectCON_TXT, ExporterGroupSubjectCON_TXT, ImporterGroupSubjectCON_XLS, ExporterGroupSubjectCON_XLS, ImporterGroupSubjNIfTI.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		NIFTI_PATH_DICT = Subject.getPropNumber() + 1;
		NIFTI_PATH_DICT_TAG = 'NIFTI_PATH_DICT';
		NIFTI_PATH_DICT_CATEGORY = Category.DATA;
		NIFTI_PATH_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function sub = SubjectNIfTI(varargin)
			%SubjectNIfTI() creates a subject with Nifti files.
			%
			% SubjectNIfTI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectNIfTI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			sub = sub@Subject(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the subject with Nifti files.
			%
			% BUILD = SubjectNIfTI.GETBUILD() returns the build of 'SubjectNIfTI'.
			%
			% Alternative forms to call this method are:
			%  BUILD = SUB.GETBUILD() returns the build of the subject with Nifti files SUB.
			%  BUILD = Element.GETBUILD(SUB) returns the build of 'SUB'.
			%  BUILD = Element.GETBUILD('SubjectNIfTI') returns the build of 'SubjectNIfTI'.
			%
			% Note that the Element.GETBUILD(SUB) and Element.GETBUILD('SubjectNIfTI')
			%  are less computationally efficient.
			
			build = 1;
		end
		function sub_class = getClass()
			%GETCLASS returns the class of the subject with Nifti files.
			%
			% CLASS = SubjectNIfTI.GETCLASS() returns the class 'SubjectNIfTI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with Nifti files SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectNIfTI') returns 'SubjectNIfTI'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectNIfTI')
			%  are less computationally efficient.
			
			sub_class = 'SubjectNIfTI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with Nifti files.
			%
			% LIST = SubjectNIfTI.GETSUBCLASSES() returns all subclasses of 'SubjectNIfTI'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with Nifti files SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectNIfTI') returns all subclasses of 'SubjectNIfTI'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SubjectNIfTI', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with Nifti files.
			%
			% PROPS = SubjectNIfTI.GETPROPS() returns the property list of subject with Nifti files
			%  as a row vector.
			%
			% PROPS = SubjectNIfTI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with Nifti files SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectNIfTI'[, CATEGORY]) returns the property list of 'SubjectNIfTI'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Subject.getProps() ...
						SubjectNIfTI.NIFTI_PATH_DICT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Subject.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Subject.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Subject.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Subject.getProps(Category.DATA) ...
						SubjectNIfTI.NIFTI_PATH_DICT ...
						];
				case Category.RESULT
					prop_list = [
						Subject.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Subject.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Subject.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Subject.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Subject.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of subject with Nifti files.
			%
			% N = SubjectNIfTI.GETPROPNUMBER() returns the property number of subject with Nifti files.
			%
			% N = SubjectNIfTI.GETPROPNUMBER(CATEGORY) returns the property number of subject with Nifti files
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with Nifti files SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectNIfTI') returns the property number of 'SubjectNIfTI'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SubjectNIfTI.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with Nifti files/error.
			%
			% CHECK = SubjectNIfTI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectNIfTI, PROP) checks whether PROP exists for SubjectNIfTI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%  Element.EXISTSPROP(SubjectNIfTI, PROP) throws error if PROP does NOT exist for SubjectNIfTI.
			%   Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SubjectNIfTI.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectNIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectNIfTI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectNIfTI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with Nifti files/error.
			%
			% CHECK = SubjectNIfTI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectNIfTI, TAG) checks whether TAG exists for SubjectNIfTI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%  Element.EXISTSTAG(SubjectNIfTI, TAG) throws error if TAG does NOT exist for SubjectNIfTI.
			%   Error id: [BRAPH2:SubjectNIfTI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			subjectnifti_tag_list = cellfun(@(x) SubjectNIfTI.getPropTag(x), num2cell(SubjectNIfTI.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, subjectnifti_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectNIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectNIfTI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SubjectNIfTI.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SubjectNIfTI, POINTER) returns property number of POINTER of SubjectNIfTI.
			%  PROPERTY = SUB.GETPROPPROP(SubjectNIfTI, POINTER) returns property number of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				subjectnifti_tag_list = cellfun(@(x) SubjectNIfTI.getPropTag(x), num2cell(SubjectNIfTI.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, subjectnifti_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SubjectNIfTI, POINTER) returns tag of POINTER of SubjectNIfTI.
			%  TAG = SUB.GETPROPTAG(SubjectNIfTI, POINTER) returns tag of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SubjectNIfTI.NIFTI_PATH_DICT
						tag = SubjectNIfTI.NIFTI_PATH_DICT_TAG;
					otherwise
						tag = getPropTag@Subject(prop);
				end
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
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectNIfTI, POINTER) returns category of POINTER of SubjectNIfTI.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectNIfTI, POINTER) returns category of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectNIfTI.getPropProp(pointer);
			
			switch prop
				case SubjectNIfTI.NIFTI_PATH_DICT
					prop_category = SubjectNIfTI.NIFTI_PATH_DICT_CATEGORY;
				otherwise
					prop_category = getPropCategory@Subject(prop);
			end
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
			%  FORMAT = Element.GETPROPFORMAT(SubjectNIfTI, POINTER) returns format of POINTER of SubjectNIfTI.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectNIfTI, POINTER) returns format of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectNIfTI.getPropProp(pointer);
			
			switch prop
				case SubjectNIfTI.NIFTI_PATH_DICT
					prop_format = SubjectNIfTI.NIFTI_PATH_DICT_FORMAT;
				otherwise
					prop_format = getPropFormat@Subject(prop);
			end
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectNIfTI, POINTER) returns description of POINTER of SubjectNIfTI.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectNIfTI, POINTER) returns description of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectNIfTI.getPropProp(pointer);
			
			switch prop
				case SubjectNIfTI.NIFTI_PATH_DICT
					prop_description = 'NIFTI_PATH_DICT (data, idict) is direcotry to subject nifti data.';
				case SubjectNIfTI.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject.';
				case SubjectNIfTI.NAME
					prop_description = 'NAME (constant, string) is the name of the subject.';
				case SubjectNIfTI.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject.';
				case SubjectNIfTI.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject.';
				case SubjectNIfTI.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject.';
				case SubjectNIfTI.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject.';
				case SubjectNIfTI.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the subject.';
				otherwise
					prop_description = getPropDescription@Subject(prop);
			end
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
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectNIfTI, POINTER) returns settings of POINTER of SubjectNIfTI.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectNIfTI, POINTER) returns settings of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectNIfTI.getPropProp(pointer);
			
			switch prop
				case SubjectNIfTI.NIFTI_PATH_DICT
					prop_settings = 'FILE_PATH';
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectNIfTI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectNIfTI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectNIfTI, POINTER) returns the default value of POINTER of SubjectNIfTI.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectNIfTI, POINTER) returns the default value of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectNIfTI.getPropProp(pointer);
			
			switch prop
				case SubjectNIfTI.NIFTI_PATH_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, SubjectNIfTI.getPropSettings(prop));
				case SubjectNIfTI.ELCLASS
					prop_default = 'SubjectNIfTI';
				case SubjectNIfTI.NAME
					prop_default = 'Subject NIfTI';
				case SubjectNIfTI.DESCRIPTION
					prop_default = 'Subject with nifti files containing brain imaging data (e.g. obtained from PET).';
				case SubjectNIfTI.ID
					prop_default = 'SubjectNIfTI ID';
				case SubjectNIfTI.LABEL
					prop_default = 'SubjectNIfTI label';
				case SubjectNIfTI.NOTES
					prop_default = 'SubjectNIfTI notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectNIfTI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectNIfTI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectNIfTI, POINTER) returns the conditioned default value of POINTER of SubjectNIfTI.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectNIfTI, POINTER) returns the conditioned default value of POINTER of SubjectNIfTI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectNIfTI.getPropProp(pointer);
			
			prop_default = SubjectNIfTI.conditioning(prop, SubjectNIfTI.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SubjectNIfTI, PROP, VALUE) checks VALUE format for PROP of SubjectNIfTI.
			%  CHECK = SUB.CHECKPROP(SubjectNIfTI, PROP, VALUE) checks VALUE format for PROP of SubjectNIfTI.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SubjectNIfTI:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: €BRAPH2.STR€:SubjectNIfTI:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SubjectNIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectNIfTI.
			%   Error id: €BRAPH2.STR€:SubjectNIfTI:€BRAPH2.WRONG_INPUT€
			%  SUB.CHECKPROP(SubjectNIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectNIfTI.
			%   Error id: €BRAPH2.STR€:SubjectNIfTI:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectNIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectNIfTI.getPropProp(pointer);
			
			switch prop
				case SubjectNIfTI.NIFTI_PATH_DICT % __SubjectNIfTI.NIFTI_PATH_DICT__
					check = Format.checkFormat(Format.IDICT, value, SubjectNIfTI.getPropSettings(prop));
				otherwise
					if prop <= Subject.getPropNumber()
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectNIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectNIfTI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectNIfTI.getPropTag(prop) ' (' SubjectNIfTI.getFormatTag(SubjectNIfTI.getPropFormat(prop)) ').'] ...
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
