classdef GTA_DI < ConcreteElement
	%GTA_DI tests PanelPropIDict.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_DI tests PanelPropIDict.
	%
	% GTA_DI methods (constructor):
	%  GTA_DI - constructor
	%
	% GTA_DI methods:
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
	% GTA_DI methods (display):
	%  tostring - string with information about the test A PanelPropIDict
	%  disp - displays information about the test A PanelPropIDict
	%  tree - displays the tree of the test A PanelPropIDict
	%
	% GTA_DI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropIDict are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropIDict
	%
	% GTA_DI methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropIDict as b2 file
	%  load - loads a BRAPH2 test A PanelPropIDict from a b2 file
	%
	% GTA_DI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropIDict
	%
	% GTA_DI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropIDict
	%
	% GTA_DI methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropIDict
	%  getSubclasses - returns all subclasses of GTA_DI
	%  getProps - returns the property list of the test A PanelPropIDict
	%  getPropNumber - returns the property number of the test A PanelPropIDict
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
	% GTA_DI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_DI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_DI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_DI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_DI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_DI constants</a>.
	%
	%
	% See also PanelPropIDict.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		DI_C = ConcreteElement.getPropNumber() + 1;
		DI_C_TAG = 'DI_C';
		DI_C_CATEGORY = Category.CONSTANT;
		DI_C_FORMAT = Format.IDICT;
		
		DI_M = ConcreteElement.getPropNumber() + 2;
		DI_M_TAG = 'DI_M';
		DI_M_CATEGORY = Category.METADATA;
		DI_M_FORMAT = Format.IDICT;
		
		DI_P = ConcreteElement.getPropNumber() + 3;
		DI_P_TAG = 'DI_P';
		DI_P_CATEGORY = Category.PARAMETER;
		DI_P_FORMAT = Format.IDICT;
		
		DI_D = ConcreteElement.getPropNumber() + 4;
		DI_D_TAG = 'DI_D';
		DI_D_CATEGORY = Category.DATA;
		DI_D_FORMAT = Format.IDICT;
		
		DI_R = ConcreteElement.getPropNumber() + 5;
		DI_R_TAG = 'DI_R';
		DI_R_CATEGORY = Category.RESULT;
		DI_R_FORMAT = Format.IDICT;
		
		DI_Q = ConcreteElement.getPropNumber() + 6;
		DI_Q_TAG = 'DI_Q';
		DI_Q_CATEGORY = Category.QUERY;
		DI_Q_FORMAT = Format.IDICT;
		
		DI_E = ConcreteElement.getPropNumber() + 7;
		DI_E_TAG = 'DI_E';
		DI_E_CATEGORY = Category.EVANESCENT;
		DI_E_FORMAT = Format.IDICT;
		
		DI_F = ConcreteElement.getPropNumber() + 8;
		DI_F_TAG = 'DI_F';
		DI_F_CATEGORY = Category.FIGURE;
		DI_F_FORMAT = Format.IDICT;
		
		DI_G = ConcreteElement.getPropNumber() + 9;
		DI_G_TAG = 'DI_G';
		DI_G_CATEGORY = Category.GUI;
		DI_G_FORMAT = Format.IDICT;
	end
	methods % constructor
		function gt = GTA_DI(varargin)
			%GTA_DI() creates a test A PanelPropIDict.
			%
			% GTA_DI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_DI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropIDict.
			%
			% BUILD = GTA_DI.GETBUILD() returns the build of 'GTA_DI'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropIDict GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_DI') returns the build of 'GTA_DI'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_DI')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropIDict.
			%
			% CLASS = GTA_DI.GETCLASS() returns the class 'GTA_DI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropIDict GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_DI') returns 'GTA_DI'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_DI')
			%  are less computationally efficient.
			
			gt_class = 'GTA_DI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropIDict.
			%
			% LIST = GTA_DI.GETSUBCLASSES() returns all subclasses of 'GTA_DI'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropIDict GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_DI') returns all subclasses of 'GTA_DI'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_DI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_DI', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropIDict.
			%
			% PROPS = GTA_DI.GETPROPS() returns the property list of test A PanelPropIDict
			%  as a row vector.
			%
			% PROPS = GTA_DI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropIDict GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_DI'[, CATEGORY]) returns the property list of 'GTA_DI'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_DI.DI_C ...
						GTA_DI.DI_M ...
						GTA_DI.DI_P ...
						GTA_DI.DI_D ...
						GTA_DI.DI_R ...
						GTA_DI.DI_Q ...
						GTA_DI.DI_E ...
						GTA_DI.DI_F ...
						GTA_DI.DI_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_DI.DI_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_DI.DI_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_DI.DI_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_DI.DI_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_DI.DI_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_DI.DI_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_DI.DI_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_DI.DI_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_DI.DI_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropIDict.
			%
			% N = GTA_DI.GETPROPNUMBER() returns the property number of test A PanelPropIDict.
			%
			% N = GTA_DI.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropIDict
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropIDict GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_DI') returns the property number of 'GTA_DI'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_DI.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropIDict/error.
			%
			% CHECK = GTA_DI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_DI, PROP) checks whether PROP exists for GTA_DI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSPROP(GTA_DI, PROP) throws error if PROP does NOT exist for GTA_DI.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_DI.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_DI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_DI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_DI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropIDict/error.
			%
			% CHECK = GTA_DI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_DI, TAG) checks whether TAG exists for GTA_DI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSTAG(GTA_DI, TAG) throws error if TAG does NOT exist for GTA_DI.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_di_tag_list = cellfun(@(x) GTA_DI.getPropTag(x), num2cell(GTA_DI.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_di_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_DI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_DI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_DI.'] ...
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
			%  PROPERTY = GT.GETPROPPROP(POINTER) returns property number of POINTER of GT.
			%  PROPERTY = Element.GETPROPPROP(GTA_DI, POINTER) returns property number of POINTER of GTA_DI.
			%  PROPERTY = GT.GETPROPPROP(GTA_DI, POINTER) returns property number of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_di_tag_list = cellfun(@(x) GTA_DI.getPropTag(x), num2cell(GTA_DI.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_di_tag_list)); % tag = pointer
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
			%  TAG = GT.GETPROPTAG(POINTER) returns tag of POINTER of GT.
			%  TAG = Element.GETPROPTAG(GTA_DI, POINTER) returns tag of POINTER of GTA_DI.
			%  TAG = GT.GETPROPTAG(GTA_DI, POINTER) returns tag of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_DI.DI_C
						tag = GTA_DI.DI_C_TAG;
					case GTA_DI.DI_M
						tag = GTA_DI.DI_M_TAG;
					case GTA_DI.DI_P
						tag = GTA_DI.DI_P_TAG;
					case GTA_DI.DI_D
						tag = GTA_DI.DI_D_TAG;
					case GTA_DI.DI_R
						tag = GTA_DI.DI_R_TAG;
					case GTA_DI.DI_Q
						tag = GTA_DI.DI_Q_TAG;
					case GTA_DI.DI_E
						tag = GTA_DI.DI_E_TAG;
					case GTA_DI.DI_F
						tag = GTA_DI.DI_F_TAG;
					case GTA_DI.DI_G
						tag = GTA_DI.DI_G_TAG;
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
			%  CATEGORY = GT.GETPROPCATEGORY(POINTER) returns category of POINTER of GT.
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_DI, POINTER) returns category of POINTER of GTA_DI.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_DI, POINTER) returns category of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_DI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop
				case GTA_DI.DI_C
					prop_category = GTA_DI.DI_C_CATEGORY;
				case GTA_DI.DI_M
					prop_category = GTA_DI.DI_M_CATEGORY;
				case GTA_DI.DI_P
					prop_category = GTA_DI.DI_P_CATEGORY;
				case GTA_DI.DI_D
					prop_category = GTA_DI.DI_D_CATEGORY;
				case GTA_DI.DI_R
					prop_category = GTA_DI.DI_R_CATEGORY;
				case GTA_DI.DI_Q
					prop_category = GTA_DI.DI_Q_CATEGORY;
				case GTA_DI.DI_E
					prop_category = GTA_DI.DI_E_CATEGORY;
				case GTA_DI.DI_F
					prop_category = GTA_DI.DI_F_CATEGORY;
				case GTA_DI.DI_G
					prop_category = GTA_DI.DI_G_CATEGORY;
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
			%  FORMAT = GT.GETPROPFORMAT(POINTER) returns format of POINTER of GT.
			%  FORMAT = Element.GETPROPFORMAT(GTA_DI, POINTER) returns format of POINTER of GTA_DI.
			%  FORMAT = GT.GETPROPFORMAT(GTA_DI, POINTER) returns format of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_DI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop
				case GTA_DI.DI_C
					prop_format = GTA_DI.DI_C_FORMAT;
				case GTA_DI.DI_M
					prop_format = GTA_DI.DI_M_FORMAT;
				case GTA_DI.DI_P
					prop_format = GTA_DI.DI_P_FORMAT;
				case GTA_DI.DI_D
					prop_format = GTA_DI.DI_D_FORMAT;
				case GTA_DI.DI_R
					prop_format = GTA_DI.DI_R_FORMAT;
				case GTA_DI.DI_Q
					prop_format = GTA_DI.DI_Q_FORMAT;
				case GTA_DI.DI_E
					prop_format = GTA_DI.DI_E_FORMAT;
				case GTA_DI.DI_F
					prop_format = GTA_DI.DI_F_FORMAT;
				case GTA_DI.DI_G
					prop_format = GTA_DI.DI_G_FORMAT;
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
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(POINTER) returns description of POINTER of GT.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_DI, POINTER) returns description of POINTER of GTA_DI.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_DI, POINTER) returns description of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop
				case GTA_DI.DI_C
					prop_description = 'DI_C (constant, idict) is a prop constant idict.';
				case GTA_DI.DI_M
					prop_description = 'DI_M (metadata, idict) is a prop metadata idict.';
				case GTA_DI.DI_P
					prop_description = 'DI_P (parameter, idict) is a prop parameter idict.';
				case GTA_DI.DI_D
					prop_description = 'DI_D (data, idict) is a prop data idict.';
				case GTA_DI.DI_R
					prop_description = 'DI_R (result, idict) is a prop result idict.';
				case GTA_DI.DI_Q
					prop_description = 'DI_Q (query, idict) is a prop query idict.';
				case GTA_DI.DI_E
					prop_description = 'DI_E (evanescent, idict) is a prop evanescent idict.';
				case GTA_DI.DI_F
					prop_description = 'DI_F (figure, idict) is a prop figure idict.';
				case GTA_DI.DI_G
					prop_description = 'DI_G (gui, idict) is a prop gui idict.';
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
			%  SETTINGS = GT.GETPROPSETTINGS(POINTER) returns settings of POINTER of GT.
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_DI, POINTER) returns settings of POINTER of GTA_DI.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_DI, POINTER) returns settings of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop
				case GTA_DI.DI_C
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_M
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_P
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_D
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_R
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_Q
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_E
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_F
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case GTA_DI.DI_G
					prop_settings = Format.getFormatSettings(Format.IDICT);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_DI, POINTER) returns the default value of POINTER of GTA_DI.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_DI, POINTER) returns the default value of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop
				case GTA_DI.DI_C
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_M
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_P
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_D
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_R
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_Q
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_E
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_F
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_G
					prop_default = Format.getFormatDefault(Format.IDICT, GTA_DI.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_DI, POINTER) returns the conditioned default value of POINTER of GTA_DI.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_DI, POINTER) returns the conditioned default value of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_DI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			prop_default = GTA_DI.conditioning(prop, GTA_DI.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = GT.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = GT.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of GT.
			%  CHECK = Element.CHECKPROP(GTA_DI, PROP, VALUE) checks VALUE format for PROP of GTA_DI.
			%  CHECK = GT.CHECKPROP(GTA_DI, PROP, VALUE) checks VALUE format for PROP of GTA_DI.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_DI:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_DI:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_DI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_DI.
			%   Error id: €BRAPH2.STR€:GTA_DI:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_DI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_DI.
			%   Error id: €BRAPH2.STR€:GTA_DI:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_DI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop
				case GTA_DI.DI_C % __GTA_DI.DI_C__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_M % __GTA_DI.DI_M__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_P % __GTA_DI.DI_P__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_D % __GTA_DI.DI_D__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_R % __GTA_DI.DI_R__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_Q % __GTA_DI.DI_Q__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_E % __GTA_DI.DI_E__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_F % __GTA_DI.DI_F__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				case GTA_DI.DI_G % __GTA_DI.DI_G__
					check = Format.checkFormat(Format.IDICT, value, GTA_DI.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_DI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_DI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_DI.getPropTag(prop) ' (' GTA_DI.getFormatTag(GTA_DI.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
