classdef GTA_CO < ConcreteElement
	%GTA_CO tests PanelPropColor.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_CO tests PanelPropColor.
	%
	% GTA_CO methods (constructor):
	%  GTA_CO - constructor
	%
	% GTA_CO methods:
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
	% GTA_CO methods (display):
	%  tostring - string with information about the test A PanelPropColor
	%  disp - displays information about the test A PanelPropColor
	%  tree - displays the tree of the test A PanelPropColor
	%
	% GTA_CO methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropColor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropColor
	%
	% GTA_CO methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropColor as b2 file
	%  load - loads a BRAPH2 test A PanelPropColor from a b2 file
	%
	% GTA_CO method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropColor
	%
	% GTA_CO method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropColor
	%
	% GTA_CO methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropColor
	%  getSubclasses - returns all subclasses of GTA_CO
	%  getProps - returns the property list of the test A PanelPropColor
	%  getPropNumber - returns the property number of the test A PanelPropColor
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
	% GTA_CO methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_CO methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_CO methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_CO methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_CO; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_CO constants</a>.
	%
	%
	% See also PanelPropColor.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		CO_C = ConcreteElement.getPropNumber() + 1;
		CO_C_TAG = 'CO_C';
		CO_C_CATEGORY = Category.CONSTANT;
		CO_C_FORMAT = Format.COLOR;
		
		CO_M = ConcreteElement.getPropNumber() + 2;
		CO_M_TAG = 'CO_M';
		CO_M_CATEGORY = Category.METADATA;
		CO_M_FORMAT = Format.COLOR;
		
		CO_P = ConcreteElement.getPropNumber() + 3;
		CO_P_TAG = 'CO_P';
		CO_P_CATEGORY = Category.PARAMETER;
		CO_P_FORMAT = Format.COLOR;
		
		CO_D = ConcreteElement.getPropNumber() + 4;
		CO_D_TAG = 'CO_D';
		CO_D_CATEGORY = Category.DATA;
		CO_D_FORMAT = Format.COLOR;
		
		CO_R = ConcreteElement.getPropNumber() + 5;
		CO_R_TAG = 'CO_R';
		CO_R_CATEGORY = Category.RESULT;
		CO_R_FORMAT = Format.COLOR;
		
		CO_Q = ConcreteElement.getPropNumber() + 6;
		CO_Q_TAG = 'CO_Q';
		CO_Q_CATEGORY = Category.QUERY;
		CO_Q_FORMAT = Format.COLOR;
		
		CO_E = ConcreteElement.getPropNumber() + 7;
		CO_E_TAG = 'CO_E';
		CO_E_CATEGORY = Category.EVANESCENT;
		CO_E_FORMAT = Format.COLOR;
		
		CO_F = ConcreteElement.getPropNumber() + 8;
		CO_F_TAG = 'CO_F';
		CO_F_CATEGORY = Category.FIGURE;
		CO_F_FORMAT = Format.COLOR;
		
		CO_G = ConcreteElement.getPropNumber() + 9;
		CO_G_TAG = 'CO_G';
		CO_G_CATEGORY = Category.GUI;
		CO_G_FORMAT = Format.COLOR;
	end
	methods % constructor
		function gt = GTA_CO(varargin)
			%GTA_CO() creates a test A PanelPropColor.
			%
			% GTA_CO(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_CO(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropColor.
			%
			% BUILD = GTA_CO.GETBUILD() returns the build of 'GTA_CO'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropColor GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_CO') returns the build of 'GTA_CO'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_CO')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropColor.
			%
			% CLASS = GTA_CO.GETCLASS() returns the class 'GTA_CO'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropColor GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_CO') returns 'GTA_CO'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_CO')
			%  are less computationally efficient.
			
			gt_class = 'GTA_CO';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropColor.
			%
			% LIST = GTA_CO.GETSUBCLASSES() returns all subclasses of 'GTA_CO'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropColor GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_CO') returns all subclasses of 'GTA_CO'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_CO')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_CO', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropColor.
			%
			% PROPS = GTA_CO.GETPROPS() returns the property list of test A PanelPropColor
			%  as a row vector.
			%
			% PROPS = GTA_CO.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropColor GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_CO'[, CATEGORY]) returns the property list of 'GTA_CO'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_CO.CO_C ...
						GTA_CO.CO_M ...
						GTA_CO.CO_P ...
						GTA_CO.CO_D ...
						GTA_CO.CO_R ...
						GTA_CO.CO_Q ...
						GTA_CO.CO_E ...
						GTA_CO.CO_F ...
						GTA_CO.CO_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_CO.CO_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_CO.CO_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_CO.CO_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_CO.CO_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_CO.CO_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_CO.CO_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_CO.CO_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_CO.CO_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_CO.CO_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropColor.
			%
			% N = GTA_CO.GETPROPNUMBER() returns the property number of test A PanelPropColor.
			%
			% N = GTA_CO.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropColor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropColor GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_CO') returns the property number of 'GTA_CO'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_CO.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropColor/error.
			%
			% CHECK = GTA_CO.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_CO, PROP) checks whether PROP exists for GTA_CO.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_CO:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CO:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CO:WrongInput]
			%  Element.EXISTSPROP(GTA_CO, PROP) throws error if PROP does NOT exist for GTA_CO.
			%   Error id: [BRAPH2:GTA_CO:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_CO.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_CO:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_CO:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_CO.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropColor/error.
			%
			% CHECK = GTA_CO.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_CO, TAG) checks whether TAG exists for GTA_CO.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_CO:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CO:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CO:WrongInput]
			%  Element.EXISTSTAG(GTA_CO, TAG) throws error if TAG does NOT exist for GTA_CO.
			%   Error id: [BRAPH2:GTA_CO:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_co_tag_list = cellfun(@(x) GTA_CO.getPropTag(x), num2cell(GTA_CO.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_co_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_CO:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_CO:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_CO.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_CO, POINTER) returns property number of POINTER of GTA_CO.
			%  PROPERTY = GT.GETPROPPROP(GTA_CO, POINTER) returns property number of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_co_tag_list = cellfun(@(x) GTA_CO.getPropTag(x), num2cell(GTA_CO.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_co_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_CO, POINTER) returns tag of POINTER of GTA_CO.
			%  TAG = GT.GETPROPTAG(GTA_CO, POINTER) returns tag of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_CO.CO_C
						tag = GTA_CO.CO_C_TAG;
					case GTA_CO.CO_M
						tag = GTA_CO.CO_M_TAG;
					case GTA_CO.CO_P
						tag = GTA_CO.CO_P_TAG;
					case GTA_CO.CO_D
						tag = GTA_CO.CO_D_TAG;
					case GTA_CO.CO_R
						tag = GTA_CO.CO_R_TAG;
					case GTA_CO.CO_Q
						tag = GTA_CO.CO_Q_TAG;
					case GTA_CO.CO_E
						tag = GTA_CO.CO_E_TAG;
					case GTA_CO.CO_F
						tag = GTA_CO.CO_F_TAG;
					case GTA_CO.CO_G
						tag = GTA_CO.CO_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_CO, POINTER) returns category of POINTER of GTA_CO.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_CO, POINTER) returns category of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_CO')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_CO.getPropProp(pointer);
			
			switch prop
				case GTA_CO.CO_C
					prop_category = GTA_CO.CO_C_CATEGORY;
				case GTA_CO.CO_M
					prop_category = GTA_CO.CO_M_CATEGORY;
				case GTA_CO.CO_P
					prop_category = GTA_CO.CO_P_CATEGORY;
				case GTA_CO.CO_D
					prop_category = GTA_CO.CO_D_CATEGORY;
				case GTA_CO.CO_R
					prop_category = GTA_CO.CO_R_CATEGORY;
				case GTA_CO.CO_Q
					prop_category = GTA_CO.CO_Q_CATEGORY;
				case GTA_CO.CO_E
					prop_category = GTA_CO.CO_E_CATEGORY;
				case GTA_CO.CO_F
					prop_category = GTA_CO.CO_F_CATEGORY;
				case GTA_CO.CO_G
					prop_category = GTA_CO.CO_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_CO, POINTER) returns format of POINTER of GTA_CO.
			%  FORMAT = GT.GETPROPFORMAT(GTA_CO, POINTER) returns format of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_CO')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_CO.getPropProp(pointer);
			
			switch prop
				case GTA_CO.CO_C
					prop_format = GTA_CO.CO_C_FORMAT;
				case GTA_CO.CO_M
					prop_format = GTA_CO.CO_M_FORMAT;
				case GTA_CO.CO_P
					prop_format = GTA_CO.CO_P_FORMAT;
				case GTA_CO.CO_D
					prop_format = GTA_CO.CO_D_FORMAT;
				case GTA_CO.CO_R
					prop_format = GTA_CO.CO_R_FORMAT;
				case GTA_CO.CO_Q
					prop_format = GTA_CO.CO_Q_FORMAT;
				case GTA_CO.CO_E
					prop_format = GTA_CO.CO_E_FORMAT;
				case GTA_CO.CO_F
					prop_format = GTA_CO.CO_F_FORMAT;
				case GTA_CO.CO_G
					prop_format = GTA_CO.CO_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_CO, POINTER) returns description of POINTER of GTA_CO.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_CO, POINTER) returns description of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_CO.getPropProp(pointer);
			
			switch prop
				case GTA_CO.CO_C
					prop_description = 'CO_C (constant, color) is a prop constant color.';
				case GTA_CO.CO_M
					prop_description = 'CO_M (metadata, color) is a prop metadata color.';
				case GTA_CO.CO_P
					prop_description = 'CO_P (parameter, color) is a prop parameter color.';
				case GTA_CO.CO_D
					prop_description = 'CO_D (data, color) is a prop data color.';
				case GTA_CO.CO_R
					prop_description = 'CO_R (result, color) is a prop result color.';
				case GTA_CO.CO_Q
					prop_description = 'CO_Q (query, color) is a prop query color.';
				case GTA_CO.CO_E
					prop_description = 'CO_E (evanescent, color) is a prop evanescent color.';
				case GTA_CO.CO_F
					prop_description = 'CO_F (figure, color) is a prop figure color.';
				case GTA_CO.CO_G
					prop_description = 'CO_G (gui, color) is a prop gui color.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_CO, POINTER) returns settings of POINTER of GTA_CO.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_CO, POINTER) returns settings of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_CO.getPropProp(pointer);
			
			switch prop
				case GTA_CO.CO_C
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_M
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_P
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_D
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_R
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_Q
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_E
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_F
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GTA_CO.CO_G
					prop_settings = Format.getFormatSettings(Format.COLOR);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_CO.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_CO.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_CO, POINTER) returns the default value of POINTER of GTA_CO.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_CO, POINTER) returns the default value of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_CO')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_CO.getPropProp(pointer);
			
			switch prop
				case GTA_CO.CO_C
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_M
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_P
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_D
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_R
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_Q
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_E
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_F
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_G
					prop_default = Format.getFormatDefault(Format.COLOR, GTA_CO.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_CO.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_CO.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_CO, POINTER) returns the conditioned default value of POINTER of GTA_CO.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_CO, POINTER) returns the conditioned default value of POINTER of GTA_CO.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_CO')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_CO.getPropProp(pointer);
			
			prop_default = GTA_CO.conditioning(prop, GTA_CO.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_CO, PROP, VALUE) checks VALUE format for PROP of GTA_CO.
			%  CHECK = GT.CHECKPROP(GTA_CO, PROP, VALUE) checks VALUE format for PROP of GTA_CO.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_CO:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_CO:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_CO, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_CO.
			%   Error id: €BRAPH2.STR€:GTA_CO:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_CO, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_CO.
			%   Error id: €BRAPH2.STR€:GTA_CO:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_CO')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_CO.getPropProp(pointer);
			
			switch prop
				case GTA_CO.CO_C % __GTA_CO.CO_C__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_M % __GTA_CO.CO_M__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_P % __GTA_CO.CO_P__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_D % __GTA_CO.CO_D__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_R % __GTA_CO.CO_R__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_Q % __GTA_CO.CO_Q__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_E % __GTA_CO.CO_E__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_F % __GTA_CO.CO_F__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				case GTA_CO.CO_G % __GTA_CO.CO_G__
					check = Format.checkFormat(Format.COLOR, value, GTA_CO.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_CO:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_CO:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_CO.getPropTag(prop) ' (' GTA_CO.getFormatTag(GTA_CO.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
