classdef GTA_OP < ConcreteElement
	%GTA_OP tests PanelPropOption.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_OP tests PanelPropOption.
	%
	% GTA_OP methods (constructor):
	%  GTA_OP - constructor
	%
	% GTA_OP methods:
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
	% GTA_OP methods (display):
	%  tostring - string with information about the test A PanelPropOption
	%  disp - displays information about the test A PanelPropOption
	%  tree - displays the tree of the test A PanelPropOption
	%
	% GTA_OP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropOption are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropOption
	%
	% GTA_OP methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropOption as b2 file
	%  load - loads a BRAPH2 test A PanelPropOption from a b2 file
	%
	% GTA_OP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropOption
	%
	% GTA_OP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropOption
	%
	% GTA_OP methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropOption
	%  getSubclasses - returns all subclasses of GTA_OP
	%  getProps - returns the property list of the test A PanelPropOption
	%  getPropNumber - returns the property number of the test A PanelPropOption
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
	% GTA_OP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_OP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_OP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_OP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_OP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_OP constants</a>.
	%
	%
	% See also PanelPropOption.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		OP_C = ConcreteElement.getPropNumber() + 1;
		OP_C_TAG = 'OP_C';
		OP_C_CATEGORY = Category.CONSTANT;
		OP_C_FORMAT = Format.OPTION;
		
		OP_M = ConcreteElement.getPropNumber() + 2;
		OP_M_TAG = 'OP_M';
		OP_M_CATEGORY = Category.METADATA;
		OP_M_FORMAT = Format.OPTION;
		
		OP_P = ConcreteElement.getPropNumber() + 3;
		OP_P_TAG = 'OP_P';
		OP_P_CATEGORY = Category.PARAMETER;
		OP_P_FORMAT = Format.OPTION;
		
		OP_D = ConcreteElement.getPropNumber() + 4;
		OP_D_TAG = 'OP_D';
		OP_D_CATEGORY = Category.DATA;
		OP_D_FORMAT = Format.OPTION;
		
		OP_R = ConcreteElement.getPropNumber() + 5;
		OP_R_TAG = 'OP_R';
		OP_R_CATEGORY = Category.RESULT;
		OP_R_FORMAT = Format.OPTION;
		
		OP_Q = ConcreteElement.getPropNumber() + 6;
		OP_Q_TAG = 'OP_Q';
		OP_Q_CATEGORY = Category.QUERY;
		OP_Q_FORMAT = Format.OPTION;
		
		OP_E = ConcreteElement.getPropNumber() + 7;
		OP_E_TAG = 'OP_E';
		OP_E_CATEGORY = Category.EVANESCENT;
		OP_E_FORMAT = Format.OPTION;
		
		OP_F = ConcreteElement.getPropNumber() + 8;
		OP_F_TAG = 'OP_F';
		OP_F_CATEGORY = Category.FIGURE;
		OP_F_FORMAT = Format.OPTION;
		
		OP_G = ConcreteElement.getPropNumber() + 9;
		OP_G_TAG = 'OP_G';
		OP_G_CATEGORY = Category.GUI;
		OP_G_FORMAT = Format.OPTION;
	end
	methods % constructor
		function gt = GTA_OP(varargin)
			%GTA_OP() creates a test A PanelPropOption.
			%
			% GTA_OP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_OP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropOption.
			%
			% BUILD = GTA_OP.GETBUILD() returns the build of 'GTA_OP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropOption GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_OP') returns the build of 'GTA_OP'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_OP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropOption.
			%
			% CLASS = GTA_OP.GETCLASS() returns the class 'GTA_OP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropOption GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_OP') returns 'GTA_OP'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_OP')
			%  are less computationally efficient.
			
			gt_class = 'GTA_OP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropOption.
			%
			% LIST = GTA_OP.GETSUBCLASSES() returns all subclasses of 'GTA_OP'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropOption GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_OP') returns all subclasses of 'GTA_OP'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_OP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_OP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropOption.
			%
			% PROPS = GTA_OP.GETPROPS() returns the property list of test A PanelPropOption
			%  as a row vector.
			%
			% PROPS = GTA_OP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropOption GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_OP'[, CATEGORY]) returns the property list of 'GTA_OP'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_OP.OP_C ...
						GTA_OP.OP_M ...
						GTA_OP.OP_P ...
						GTA_OP.OP_D ...
						GTA_OP.OP_R ...
						GTA_OP.OP_Q ...
						GTA_OP.OP_E ...
						GTA_OP.OP_F ...
						GTA_OP.OP_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_OP.OP_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_OP.OP_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_OP.OP_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_OP.OP_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_OP.OP_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_OP.OP_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_OP.OP_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_OP.OP_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_OP.OP_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropOption.
			%
			% N = GTA_OP.GETPROPNUMBER() returns the property number of test A PanelPropOption.
			%
			% N = GTA_OP.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropOption
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropOption GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_OP') returns the property number of 'GTA_OP'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_OP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropOption/error.
			%
			% CHECK = GTA_OP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_OP, PROP) checks whether PROP exists for GTA_OP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSPROP(GTA_OP, PROP) throws error if PROP does NOT exist for GTA_OP.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_OP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_OP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_OP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_OP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropOption/error.
			%
			% CHECK = GTA_OP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_OP, TAG) checks whether TAG exists for GTA_OP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSTAG(GTA_OP, TAG) throws error if TAG does NOT exist for GTA_OP.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_op_tag_list = cellfun(@(x) GTA_OP.getPropTag(x), num2cell(GTA_OP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_op_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_OP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_OP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_OP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_OP, POINTER) returns property number of POINTER of GTA_OP.
			%  PROPERTY = GT.GETPROPPROP(GTA_OP, POINTER) returns property number of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_op_tag_list = cellfun(@(x) GTA_OP.getPropTag(x), num2cell(GTA_OP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_op_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_OP, POINTER) returns tag of POINTER of GTA_OP.
			%  TAG = GT.GETPROPTAG(GTA_OP, POINTER) returns tag of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_OP.OP_C
						tag = GTA_OP.OP_C_TAG;
					case GTA_OP.OP_M
						tag = GTA_OP.OP_M_TAG;
					case GTA_OP.OP_P
						tag = GTA_OP.OP_P_TAG;
					case GTA_OP.OP_D
						tag = GTA_OP.OP_D_TAG;
					case GTA_OP.OP_R
						tag = GTA_OP.OP_R_TAG;
					case GTA_OP.OP_Q
						tag = GTA_OP.OP_Q_TAG;
					case GTA_OP.OP_E
						tag = GTA_OP.OP_E_TAG;
					case GTA_OP.OP_F
						tag = GTA_OP.OP_F_TAG;
					case GTA_OP.OP_G
						tag = GTA_OP.OP_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_OP, POINTER) returns category of POINTER of GTA_OP.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_OP, POINTER) returns category of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_OP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop
				case GTA_OP.OP_C
					prop_category = GTA_OP.OP_C_CATEGORY;
				case GTA_OP.OP_M
					prop_category = GTA_OP.OP_M_CATEGORY;
				case GTA_OP.OP_P
					prop_category = GTA_OP.OP_P_CATEGORY;
				case GTA_OP.OP_D
					prop_category = GTA_OP.OP_D_CATEGORY;
				case GTA_OP.OP_R
					prop_category = GTA_OP.OP_R_CATEGORY;
				case GTA_OP.OP_Q
					prop_category = GTA_OP.OP_Q_CATEGORY;
				case GTA_OP.OP_E
					prop_category = GTA_OP.OP_E_CATEGORY;
				case GTA_OP.OP_F
					prop_category = GTA_OP.OP_F_CATEGORY;
				case GTA_OP.OP_G
					prop_category = GTA_OP.OP_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_OP, POINTER) returns format of POINTER of GTA_OP.
			%  FORMAT = GT.GETPROPFORMAT(GTA_OP, POINTER) returns format of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_OP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop
				case GTA_OP.OP_C
					prop_format = GTA_OP.OP_C_FORMAT;
				case GTA_OP.OP_M
					prop_format = GTA_OP.OP_M_FORMAT;
				case GTA_OP.OP_P
					prop_format = GTA_OP.OP_P_FORMAT;
				case GTA_OP.OP_D
					prop_format = GTA_OP.OP_D_FORMAT;
				case GTA_OP.OP_R
					prop_format = GTA_OP.OP_R_FORMAT;
				case GTA_OP.OP_Q
					prop_format = GTA_OP.OP_Q_FORMAT;
				case GTA_OP.OP_E
					prop_format = GTA_OP.OP_E_FORMAT;
				case GTA_OP.OP_F
					prop_format = GTA_OP.OP_F_FORMAT;
				case GTA_OP.OP_G
					prop_format = GTA_OP.OP_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_OP, POINTER) returns description of POINTER of GTA_OP.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_OP, POINTER) returns description of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop
				case GTA_OP.OP_C
					prop_description = 'OP_C (constant, option) is a prop constant option.';
				case GTA_OP.OP_M
					prop_description = 'OP_M (metadata, option) is a prop metadata option.';
				case GTA_OP.OP_P
					prop_description = 'OP_P (parameter, option) is a prop parameter option.';
				case GTA_OP.OP_D
					prop_description = 'OP_D (data, option) is a prop data option.';
				case GTA_OP.OP_R
					prop_description = 'OP_R (result, option) is a prop result option.';
				case GTA_OP.OP_Q
					prop_description = 'OP_Q (query, option) is a prop query option.';
				case GTA_OP.OP_E
					prop_description = 'OP_E (evanescent, option) is a prop evanescent option.';
				case GTA_OP.OP_F
					prop_description = 'OP_F (figure, option) is a prop figure option.';
				case GTA_OP.OP_G
					prop_description = 'OP_G (gui, option) is a prop gui option.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_OP, POINTER) returns settings of POINTER of GTA_OP.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_OP, POINTER) returns settings of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop
				case GTA_OP.OP_C
					prop_settings = Format.getFormatSettings(Format.OPTION);
				case GTA_OP.OP_M
					prop_settings = {'M_A', 'M_B', 'M_C', 'M_D', 'M_E', 'M_F', 'M_G', 'M_H', 'M_J', 'M_K'};
				case GTA_OP.OP_P
					prop_settings = {'P_A', 'P_B', 'P_C', 'P_D', 'P_E', 'P_F', 'P_G', 'P_H', 'P_J', 'P_K'};
				case GTA_OP.OP_D
					prop_settings = {'D_A', 'D_B', 'D_C', 'D_D', 'D_E', 'D_F', 'D_G', 'D_H', 'D_J', 'D_K'};
				case GTA_OP.OP_R
					prop_settings = {'R_A', 'R_B', 'R_C', 'R_D', 'R_E', 'R_F', 'R_G', 'R_H', 'R_J', 'R_K'};
				case GTA_OP.OP_Q
					prop_settings = {'Q_A', 'Q_B', 'Q_C', 'Q_D', 'Q_E', 'Q_F', 'Q_G', 'Q_H', 'Q_J', 'Q_K'};
				case GTA_OP.OP_E
					prop_settings = {'E_A', 'E_B', 'E_C', 'E_D', 'E_E', 'E_F', 'E_G', 'E_H', 'E_J', 'E_K'};
				case GTA_OP.OP_F
					prop_settings = {'F_A', 'F_B', 'F_C', 'F_D', 'F_E', 'F_F', 'F_G', 'F_H', 'F_J', 'F_K'};
				case GTA_OP.OP_G
					prop_settings = {'G_A', 'G_B', 'G_C', 'G_D', 'G_E', 'G_F', 'G_G', 'G_H', 'G_J', 'G_K'};
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_OP, POINTER) returns the default value of POINTER of GTA_OP.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_OP, POINTER) returns the default value of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop
				case GTA_OP.OP_C
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_M
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_P
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_D
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_R
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_Q
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_E
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_F
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_G
					prop_default = Format.getFormatDefault(Format.OPTION, GTA_OP.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_OP, POINTER) returns the conditioned default value of POINTER of GTA_OP.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_OP, POINTER) returns the conditioned default value of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_OP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			prop_default = GTA_OP.conditioning(prop, GTA_OP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_OP, PROP, VALUE) checks VALUE format for PROP of GTA_OP.
			%  CHECK = GT.CHECKPROP(GTA_OP, PROP, VALUE) checks VALUE format for PROP of GTA_OP.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_OP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_OP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_OP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_OP.
			%   Error id: €BRAPH2.STR€:GTA_OP:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_OP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_OP.
			%   Error id: €BRAPH2.STR€:GTA_OP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_OP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop
				case GTA_OP.OP_C % __GTA_OP.OP_C__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_M % __GTA_OP.OP_M__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_P % __GTA_OP.OP_P__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_D % __GTA_OP.OP_D__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_R % __GTA_OP.OP_R__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_Q % __GTA_OP.OP_Q__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_E % __GTA_OP.OP_E__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_F % __GTA_OP.OP_F__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				case GTA_OP.OP_G % __GTA_OP.OP_G__
					check = Format.checkFormat(Format.OPTION, value, GTA_OP.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_OP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_OP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_OP.getPropTag(prop) ' (' GTA_OP.getFormatTag(GTA_OP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(gt, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case GTA_OP.OP_M % __GTA_OP.OP_M__
					if strcmp(gt.get('OP_M'), 'M_B')
					    gt.set( ...
					        'OP_P', 'P_B', ...
					        'OP_D', 'D_B', ...
					        'OP_F', 'F_B', ...
					        'OP_G', 'G_B' ...
					        )
					end
					
				case GTA_OP.OP_P % __GTA_OP.OP_P__
					if strcmp(gt.get('OP_P'), 'P_C')
					    gt.set( ...
					        'OP_M', 'M_C', ...
					        'OP_D', 'D_C', ...
					        'OP_F', 'F_C', ...
					        'OP_G', 'G_C' ...
					        )
					end
					
				case GTA_OP.OP_D % __GTA_OP.OP_D__
					if strcmp(gt.get('OP_D'), 'D_D')
					    gt.set( ...
					        'OP_M', 'M_D', ...
					        'OP_P', 'P_D', ...
					        'OP_F', 'F_D', ...
					        'OP_G', 'G_D' ...
					        )
					end
					
				case GTA_OP.OP_F % __GTA_OP.OP_F__
					if strcmp(gt.get('OP_F'), 'F_E')
					    gt.set( ...
					        'OP_M', 'M_E', ...
					        'OP_P', 'P_E', ...
					        'OP_D', 'D_E', ...
					        'OP_G', 'G_E' ...
					        )
					end
					
				case GTA_OP.OP_G % __GTA_OP.OP_G__
					if strcmp(gt.get('OP_G'), 'G_F')
					    gt.set( ...
					        'OP_M', 'M_F', ...
					        'OP_P', 'P_F', ...
					        'OP_D', 'D_F', ...
					        'OP_F', 'F_F' ...
					        )
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(gt, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(gt, prop, varargin)
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
				case GTA_OP.OP_R % __GTA_OP.OP_R__
					rng_settings_ = rng(); rng(gt.getPropSeed(GTA_OP.OP_R), 'twister')
					
					settings = GTA_OP.getPropSettings('OP_R');
					index = randi(length(settings));
					value = settings{index};
					
					rng(rng_settings_)
					
				case GTA_OP.OP_Q % __GTA_OP.OP_Q__
					settings = GTA_OP.getPropSettings('OP_Q');
					index = randi(length(settings));
					value = settings{index};
					
				case GTA_OP.OP_E % __GTA_OP.OP_E__
					settings = GTA_OP.getPropSettings('OP_E');
					index = randi(length(settings));
					value = settings{index};
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(gt, prop, varargin{:});
					else
						value = calculateValue@Element(gt, prop, varargin{:});
					end
			end
			
		end
	end
end
