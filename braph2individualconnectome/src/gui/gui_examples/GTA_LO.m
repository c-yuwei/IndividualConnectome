classdef GTA_LO < ConcreteElement
	%GTA_LO tests PanelPropLogical.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_LO tests PanelPropLogical.
	%
	% GTA_LO methods (constructor):
	%  GTA_LO - constructor
	%
	% GTA_LO methods:
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
	% GTA_LO methods (display):
	%  tostring - string with information about the test A PanelPropLogical
	%  disp - displays information about the test A PanelPropLogical
	%  tree - displays the tree of the test A PanelPropLogical
	%
	% GTA_LO methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropLogical are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropLogical
	%
	% GTA_LO methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropLogical as b2 file
	%  load - loads a BRAPH2 test A PanelPropLogical from a b2 file
	%
	% GTA_LO method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropLogical
	%
	% GTA_LO method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropLogical
	%
	% GTA_LO methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropLogical
	%  getSubclasses - returns all subclasses of GTA_LO
	%  getProps - returns the property list of the test A PanelPropLogical
	%  getPropNumber - returns the property number of the test A PanelPropLogical
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
	% GTA_LO methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_LO methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_LO methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_LO methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_LO; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_LO constants</a>.
	%
	%
	% See also PanelPropLogical.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		LO_C = ConcreteElement.getPropNumber() + 1;
		LO_C_TAG = 'LO_C';
		LO_C_CATEGORY = Category.CONSTANT;
		LO_C_FORMAT = Format.LOGICAL;
		
		LO_M = ConcreteElement.getPropNumber() + 2;
		LO_M_TAG = 'LO_M';
		LO_M_CATEGORY = Category.METADATA;
		LO_M_FORMAT = Format.LOGICAL;
		
		LO_P = ConcreteElement.getPropNumber() + 3;
		LO_P_TAG = 'LO_P';
		LO_P_CATEGORY = Category.PARAMETER;
		LO_P_FORMAT = Format.LOGICAL;
		
		LO_D = ConcreteElement.getPropNumber() + 4;
		LO_D_TAG = 'LO_D';
		LO_D_CATEGORY = Category.DATA;
		LO_D_FORMAT = Format.LOGICAL;
		
		LO_R = ConcreteElement.getPropNumber() + 5;
		LO_R_TAG = 'LO_R';
		LO_R_CATEGORY = Category.RESULT;
		LO_R_FORMAT = Format.LOGICAL;
		
		LO_Q = ConcreteElement.getPropNumber() + 6;
		LO_Q_TAG = 'LO_Q';
		LO_Q_CATEGORY = Category.QUERY;
		LO_Q_FORMAT = Format.LOGICAL;
		
		LO_E = ConcreteElement.getPropNumber() + 7;
		LO_E_TAG = 'LO_E';
		LO_E_CATEGORY = Category.EVANESCENT;
		LO_E_FORMAT = Format.LOGICAL;
		
		LO_F = ConcreteElement.getPropNumber() + 8;
		LO_F_TAG = 'LO_F';
		LO_F_CATEGORY = Category.FIGURE;
		LO_F_FORMAT = Format.LOGICAL;
		
		LO_G = ConcreteElement.getPropNumber() + 9;
		LO_G_TAG = 'LO_G';
		LO_G_CATEGORY = Category.GUI;
		LO_G_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function gt = GTA_LO(varargin)
			%GTA_LO() creates a test A PanelPropLogical.
			%
			% GTA_LO(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_LO(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropLogical.
			%
			% BUILD = GTA_LO.GETBUILD() returns the build of 'GTA_LO'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropLogical GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_LO') returns the build of 'GTA_LO'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_LO')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropLogical.
			%
			% CLASS = GTA_LO.GETCLASS() returns the class 'GTA_LO'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropLogical GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_LO') returns 'GTA_LO'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_LO')
			%  are less computationally efficient.
			
			gt_class = 'GTA_LO';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropLogical.
			%
			% LIST = GTA_LO.GETSUBCLASSES() returns all subclasses of 'GTA_LO'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropLogical GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_LO') returns all subclasses of 'GTA_LO'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_LO')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_LO', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropLogical.
			%
			% PROPS = GTA_LO.GETPROPS() returns the property list of test A PanelPropLogical
			%  as a row vector.
			%
			% PROPS = GTA_LO.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropLogical GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_LO'[, CATEGORY]) returns the property list of 'GTA_LO'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_LO.LO_C ...
						GTA_LO.LO_M ...
						GTA_LO.LO_P ...
						GTA_LO.LO_D ...
						GTA_LO.LO_R ...
						GTA_LO.LO_Q ...
						GTA_LO.LO_E ...
						GTA_LO.LO_F ...
						GTA_LO.LO_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_LO.LO_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_LO.LO_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_LO.LO_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_LO.LO_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_LO.LO_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_LO.LO_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_LO.LO_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_LO.LO_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_LO.LO_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropLogical.
			%
			% N = GTA_LO.GETPROPNUMBER() returns the property number of test A PanelPropLogical.
			%
			% N = GTA_LO.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropLogical
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropLogical GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_LO') returns the property number of 'GTA_LO'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_LO.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropLogical/error.
			%
			% CHECK = GTA_LO.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_LO, PROP) checks whether PROP exists for GTA_LO.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSPROP(GTA_LO, PROP) throws error if PROP does NOT exist for GTA_LO.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_LO.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LO:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LO:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_LO.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropLogical/error.
			%
			% CHECK = GTA_LO.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_LO, TAG) checks whether TAG exists for GTA_LO.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSTAG(GTA_LO, TAG) throws error if TAG does NOT exist for GTA_LO.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_lo_tag_list = cellfun(@(x) GTA_LO.getPropTag(x), num2cell(GTA_LO.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_lo_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LO:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LO:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_LO.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_LO, POINTER) returns property number of POINTER of GTA_LO.
			%  PROPERTY = GT.GETPROPPROP(GTA_LO, POINTER) returns property number of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_lo_tag_list = cellfun(@(x) GTA_LO.getPropTag(x), num2cell(GTA_LO.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_lo_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_LO, POINTER) returns tag of POINTER of GTA_LO.
			%  TAG = GT.GETPROPTAG(GTA_LO, POINTER) returns tag of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_LO.LO_C
						tag = GTA_LO.LO_C_TAG;
					case GTA_LO.LO_M
						tag = GTA_LO.LO_M_TAG;
					case GTA_LO.LO_P
						tag = GTA_LO.LO_P_TAG;
					case GTA_LO.LO_D
						tag = GTA_LO.LO_D_TAG;
					case GTA_LO.LO_R
						tag = GTA_LO.LO_R_TAG;
					case GTA_LO.LO_Q
						tag = GTA_LO.LO_Q_TAG;
					case GTA_LO.LO_E
						tag = GTA_LO.LO_E_TAG;
					case GTA_LO.LO_F
						tag = GTA_LO.LO_F_TAG;
					case GTA_LO.LO_G
						tag = GTA_LO.LO_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_LO, POINTER) returns category of POINTER of GTA_LO.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_LO, POINTER) returns category of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_LO')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop
				case GTA_LO.LO_C
					prop_category = GTA_LO.LO_C_CATEGORY;
				case GTA_LO.LO_M
					prop_category = GTA_LO.LO_M_CATEGORY;
				case GTA_LO.LO_P
					prop_category = GTA_LO.LO_P_CATEGORY;
				case GTA_LO.LO_D
					prop_category = GTA_LO.LO_D_CATEGORY;
				case GTA_LO.LO_R
					prop_category = GTA_LO.LO_R_CATEGORY;
				case GTA_LO.LO_Q
					prop_category = GTA_LO.LO_Q_CATEGORY;
				case GTA_LO.LO_E
					prop_category = GTA_LO.LO_E_CATEGORY;
				case GTA_LO.LO_F
					prop_category = GTA_LO.LO_F_CATEGORY;
				case GTA_LO.LO_G
					prop_category = GTA_LO.LO_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_LO, POINTER) returns format of POINTER of GTA_LO.
			%  FORMAT = GT.GETPROPFORMAT(GTA_LO, POINTER) returns format of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_LO')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop
				case GTA_LO.LO_C
					prop_format = GTA_LO.LO_C_FORMAT;
				case GTA_LO.LO_M
					prop_format = GTA_LO.LO_M_FORMAT;
				case GTA_LO.LO_P
					prop_format = GTA_LO.LO_P_FORMAT;
				case GTA_LO.LO_D
					prop_format = GTA_LO.LO_D_FORMAT;
				case GTA_LO.LO_R
					prop_format = GTA_LO.LO_R_FORMAT;
				case GTA_LO.LO_Q
					prop_format = GTA_LO.LO_Q_FORMAT;
				case GTA_LO.LO_E
					prop_format = GTA_LO.LO_E_FORMAT;
				case GTA_LO.LO_F
					prop_format = GTA_LO.LO_F_FORMAT;
				case GTA_LO.LO_G
					prop_format = GTA_LO.LO_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_LO, POINTER) returns description of POINTER of GTA_LO.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_LO, POINTER) returns description of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop
				case GTA_LO.LO_C
					prop_description = 'LO_C (constant, logical) is a prop constant logical.';
				case GTA_LO.LO_M
					prop_description = 'LO_M (metadata, logical) is a prop metadata logical.';
				case GTA_LO.LO_P
					prop_description = 'LO_P (parameter, logical) is a prop parameter logical.';
				case GTA_LO.LO_D
					prop_description = 'LO_D (data, logical) is a prop data logical.';
				case GTA_LO.LO_R
					prop_description = 'LO_R (result, logical) is a prop result logical.';
				case GTA_LO.LO_Q
					prop_description = 'LO_Q (query, logical) is a prop query logical.';
				case GTA_LO.LO_E
					prop_description = 'LO_E (evanescent, logical) is a prop evanescent logical.';
				case GTA_LO.LO_F
					prop_description = 'LO_F (figure, logical) is a prop figure logical.';
				case GTA_LO.LO_G
					prop_description = 'LO_G (gui, logical) is a prop gui logical.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_LO, POINTER) returns settings of POINTER of GTA_LO.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_LO, POINTER) returns settings of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop
				case GTA_LO.LO_C
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_M
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_P
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_D
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_R
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_Q
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_E
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_F
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GTA_LO.LO_G
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_LO, POINTER) returns the default value of POINTER of GTA_LO.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_LO, POINTER) returns the default value of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop
				case GTA_LO.LO_C
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_M
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_P
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_D
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_R
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_Q
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_E
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_F
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_G
					prop_default = Format.getFormatDefault(Format.LOGICAL, GTA_LO.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_LO, POINTER) returns the conditioned default value of POINTER of GTA_LO.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_LO, POINTER) returns the conditioned default value of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_LO')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			prop_default = GTA_LO.conditioning(prop, GTA_LO.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_LO, PROP, VALUE) checks VALUE format for PROP of GTA_LO.
			%  CHECK = GT.CHECKPROP(GTA_LO, PROP, VALUE) checks VALUE format for PROP of GTA_LO.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_LO:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_LO:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_LO, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LO.
			%   Error id: €BRAPH2.STR€:GTA_LO:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_LO, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LO.
			%   Error id: €BRAPH2.STR€:GTA_LO:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_LO')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop
				case GTA_LO.LO_C % __GTA_LO.LO_C__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_M % __GTA_LO.LO_M__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_P % __GTA_LO.LO_P__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_D % __GTA_LO.LO_D__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_R % __GTA_LO.LO_R__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_Q % __GTA_LO.LO_Q__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_E % __GTA_LO.LO_E__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_F % __GTA_LO.LO_F__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				case GTA_LO.LO_G % __GTA_LO.LO_G__
					check = Format.checkFormat(Format.LOGICAL, value, GTA_LO.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LO:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LO:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_LO.getPropTag(prop) ' (' GTA_LO.getFormatTag(GTA_LO.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
