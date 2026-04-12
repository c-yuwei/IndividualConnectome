classdef ConstructorIndividualConBase < ConcreteElement
	%ConstructorIndividualConBase is the base constructor for individual brain connectome.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% The IndividualConConstructorBase constructs individual brain connectome with SUVR (standard uptake value ratio) data.
	% 
	% Its subclasses need to implement some or all of the following props, including GR GR_REF CONNECTOME_METHOD.
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
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		GR_SUVR = ConcreteElement.getPropNumber() + 2;
		GR_SUVR_TAG = 'GR_SUVR';
		GR_SUVR_CATEGORY = Category.DATA;
		GR_SUVR_FORMAT = Format.ITEM;
		
		GR_SUVR_REF = ConcreteElement.getPropNumber() + 3;
		GR_SUVR_REF_TAG = 'GR_SUVR_REF';
		GR_SUVR_REF_CATEGORY = Category.DATA;
		GR_SUVR_REF_FORMAT = Format.ITEM;
		
		CONNECTOME_CONSTRUCT_METHOD = ConcreteElement.getPropNumber() + 4;
		CONNECTOME_CONSTRUCT_METHOD_TAG = 'CONNECTOME_CONSTRUCT_METHOD';
		CONNECTOME_CONSTRUCT_METHOD_CATEGORY = Category.QUERY;
		CONNECTOME_CONSTRUCT_METHOD_FORMAT = Format.CELL;
		
		GR = ConcreteElement.getPropNumber() + 5;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
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
			
			subclass_list = subclasses('ConstructorIndividualConBase', [], [], true);
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
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						ConstructorIndividualConBase.WAITBAR ...
						ConstructorIndividualConBase.GR_SUVR ...
						ConstructorIndividualConBase.GR_SUVR_REF ...
						ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD ...
						ConstructorIndividualConBase.GR ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						ConstructorIndividualConBase.GR_SUVR ...
						ConstructorIndividualConBase.GR_SUVR_REF ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						ConstructorIndividualConBase.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						ConstructorIndividualConBase.WAITBAR ...
						];
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
			
			prop_number = numel(ConstructorIndividualConBase.getProps(varargin{:}));
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
			
			check = any(prop == ConstructorIndividualConBase.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConBase:' BRAPH2.WRONG_INPUT '\n' ...
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
			
			constructorindividualconbase_tag_list = cellfun(@(x) ConstructorIndividualConBase.getPropTag(x), num2cell(ConstructorIndividualConBase.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, constructorindividualconbase_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConBase:' BRAPH2.WRONG_INPUT '\n' ...
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
				constructorindividualconbase_tag_list = cellfun(@(x) ConstructorIndividualConBase.getPropTag(x), num2cell(ConstructorIndividualConBase.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, constructorindividualconbase_tag_list)); % tag = pointer
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
				prop = pointer;
				
				switch prop
					case ConstructorIndividualConBase.WAITBAR
						tag = ConstructorIndividualConBase.WAITBAR_TAG;
					case ConstructorIndividualConBase.GR_SUVR
						tag = ConstructorIndividualConBase.GR_SUVR_TAG;
					case ConstructorIndividualConBase.GR_SUVR_REF
						tag = ConstructorIndividualConBase.GR_SUVR_REF_TAG;
					case ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
						tag = ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD_TAG;
					case ConstructorIndividualConBase.GR
						tag = ConstructorIndividualConBase.GR_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			
			switch prop
				case ConstructorIndividualConBase.WAITBAR
					prop_category = ConstructorIndividualConBase.WAITBAR_CATEGORY;
				case ConstructorIndividualConBase.GR_SUVR
					prop_category = ConstructorIndividualConBase.GR_SUVR_CATEGORY;
				case ConstructorIndividualConBase.GR_SUVR_REF
					prop_category = ConstructorIndividualConBase.GR_SUVR_REF_CATEGORY;
				case ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					prop_category = ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD_CATEGORY;
				case ConstructorIndividualConBase.GR
					prop_category = ConstructorIndividualConBase.GR_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			
			switch prop
				case ConstructorIndividualConBase.WAITBAR
					prop_format = ConstructorIndividualConBase.WAITBAR_FORMAT;
				case ConstructorIndividualConBase.GR_SUVR
					prop_format = ConstructorIndividualConBase.GR_SUVR_FORMAT;
				case ConstructorIndividualConBase.GR_SUVR_REF
					prop_format = ConstructorIndividualConBase.GR_SUVR_REF_FORMAT;
				case ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					prop_format = ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD_FORMAT;
				case ConstructorIndividualConBase.GR
					prop_format = ConstructorIndividualConBase.GR_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			
			switch prop
				case ConstructorIndividualConBase.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case ConstructorIndividualConBase.GR_SUVR
					prop_description = 'GR_SUVR (data, item) is a group of subjects with mean SUVR data.';
				case ConstructorIndividualConBase.GR_SUVR_REF
					prop_description = 'GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.';
				case ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					prop_description = 'CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for individual connectome construction.';
				case ConstructorIndividualConBase.GR
					prop_description = 'GR (result, item) is a group of subjects with connectivity data.';
				case ConstructorIndividualConBase.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of Individual Connectome Constructor Base.';
				case ConstructorIndividualConBase.NAME
					prop_description = 'NAME (constant, string) is the name of the Individual Connectome Constructor Base.';
				case ConstructorIndividualConBase.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Individual Connectome Constructor Base.';
				case ConstructorIndividualConBase.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Individual Connectome Constructor Base.';
				case ConstructorIndividualConBase.ID
					prop_description = 'ID (data, string) is a few-letter code for the Individual Connectome Constructor Base.';
				case ConstructorIndividualConBase.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Individual Connectome Constructor Base.';
				case ConstructorIndividualConBase.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Individual Connectome Constructor Base.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			
			switch prop
				case ConstructorIndividualConBase.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ConstructorIndividualConBase.GR_SUVR
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ConstructorIndividualConBase.GR_SUVR_REF
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ConstructorIndividualConBase.GR
					prop_settings = 'Group';
				case ConstructorIndividualConBase.TEMPLATE
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
			
			switch prop
				case ConstructorIndividualConBase.WAITBAR
					prop_default = true;
				case ConstructorIndividualConBase.GR_SUVR
					prop_default = Group('SUB_CLASS', 'SubjectST');
				case ConstructorIndividualConBase.GR_SUVR_REF
					prop_default = Group('SUB_CLASS', 'SubjectST');
				case ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD
					prop_default = {};
				case ConstructorIndividualConBase.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case ConstructorIndividualConBase.ELCLASS
					prop_default = 'ConstructorIndividualConBase';
				case ConstructorIndividualConBase.NAME
					prop_default = 'Individual Connectome Constructor Base';
				case ConstructorIndividualConBase.DESCRIPTION
					prop_default = 'A Individual Connectome Constructor Base (IndividualConConstructorBase) comprises brain connectome constructor with a specific dataset. Its subclasses need to implement the props GR, GR_REF and CONNECTOME_METHOD.';
				case ConstructorIndividualConBase.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ConstructorIndividualConBase.getPropSettings(prop));
				case ConstructorIndividualConBase.ID
					prop_default = 'IndividualConConstructorBase ID';
				case ConstructorIndividualConBase.LABEL
					prop_default = 'Individual Connectome Constructor Base label';
				case ConstructorIndividualConBase.NOTES
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
			%  Error id: €BRAPH2.STR€:ConstructorIndividualConBase:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BASE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BASE.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConBase:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ConstructorIndividualConBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConBase.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConBase:€BRAPH2.WRONG_INPUT€
			%  BASE.CHECKPROP(ConstructorIndividualConBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConBase.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConBase:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(BASE) and Element.CHECKPROP('ConstructorIndividualConBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConstructorIndividualConBase.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConBase.WAITBAR % __ConstructorIndividualConBase.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, ConstructorIndividualConBase.getPropSettings(prop));
				case ConstructorIndividualConBase.GR_SUVR % __ConstructorIndividualConBase.GR_SUVR__
					check = Format.checkFormat(Format.ITEM, value, ConstructorIndividualConBase.getPropSettings(prop));
				case ConstructorIndividualConBase.GR_SUVR_REF % __ConstructorIndividualConBase.GR_SUVR_REF__
					check = Format.checkFormat(Format.ITEM, value, ConstructorIndividualConBase.getPropSettings(prop));
				case ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD % __ConstructorIndividualConBase.CONNECTOME_CONSTRUCT_METHOD__
					check = Format.checkFormat(Format.CELL, value, ConstructorIndividualConBase.getPropSettings(prop));
				case ConstructorIndividualConBase.GR % __ConstructorIndividualConBase.GR__
					check = Format.checkFormat(Format.ITEM, value, ConstructorIndividualConBase.getPropSettings(prop));
				case ConstructorIndividualConBase.TEMPLATE % __ConstructorIndividualConBase.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ConstructorIndividualConBase.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConBase:' BRAPH2.WRONG_INPUT '\n' ...
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
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case ConstructorIndividualConBase.GR % __ConstructorIndividualConBase.GR__
					rng_settings_ = rng(); rng(base.getPropSeed(ConstructorIndividualConBase.GR), 'twister')
					
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
					if prop <= ConcreteElement.getPropNumber()
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
				case ConstructorIndividualConBase.GR % __ConstructorIndividualConBase.GR__
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(base, prop, value);
					end
			end
		end
	end
end
