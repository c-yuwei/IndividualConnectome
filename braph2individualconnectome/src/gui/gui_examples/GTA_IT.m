classdef GTA_IT < ConcreteElement
	%GTA_IT tests PanelPropItem.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_IT tests PanelPropItem.
	%
	% GTA_IT methods (constructor):
	%  GTA_IT - constructor
	%
	% GTA_IT methods:
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
	% GTA_IT methods (display):
	%  tostring - string with information about the test A PanelPropItem
	%  disp - displays information about the test A PanelPropItem
	%  tree - displays the tree of the test A PanelPropItem
	%
	% GTA_IT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropItem are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropItem
	%
	% GTA_IT methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropItem as b2 file
	%  load - loads a BRAPH2 test A PanelPropItem from a b2 file
	%
	% GTA_IT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropItem
	%
	% GTA_IT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropItem
	%
	% GTA_IT methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropItem
	%  getSubclasses - returns all subclasses of GTA_IT
	%  getProps - returns the property list of the test A PanelPropItem
	%  getPropNumber - returns the property number of the test A PanelPropItem
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
	% GTA_IT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_IT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_IT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_IT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_IT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_IT constants</a>.
	%
	%
	% See also PanelPropItem.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		IT_C = ConcreteElement.getPropNumber() + 1;
		IT_C_TAG = 'IT_C';
		IT_C_CATEGORY = Category.CONSTANT;
		IT_C_FORMAT = Format.ITEM;
		
		IT_M = ConcreteElement.getPropNumber() + 2;
		IT_M_TAG = 'IT_M';
		IT_M_CATEGORY = Category.METADATA;
		IT_M_FORMAT = Format.ITEM;
		
		IT_P = ConcreteElement.getPropNumber() + 3;
		IT_P_TAG = 'IT_P';
		IT_P_CATEGORY = Category.PARAMETER;
		IT_P_FORMAT = Format.ITEM;
		
		IT_D = ConcreteElement.getPropNumber() + 4;
		IT_D_TAG = 'IT_D';
		IT_D_CATEGORY = Category.DATA;
		IT_D_FORMAT = Format.ITEM;
		
		IT_R = ConcreteElement.getPropNumber() + 5;
		IT_R_TAG = 'IT_R';
		IT_R_CATEGORY = Category.RESULT;
		IT_R_FORMAT = Format.ITEM;
		
		IT_Q = ConcreteElement.getPropNumber() + 6;
		IT_Q_TAG = 'IT_Q';
		IT_Q_CATEGORY = Category.QUERY;
		IT_Q_FORMAT = Format.ITEM;
		
		IT_E = ConcreteElement.getPropNumber() + 7;
		IT_E_TAG = 'IT_E';
		IT_E_CATEGORY = Category.EVANESCENT;
		IT_E_FORMAT = Format.ITEM;
		
		IT_F = ConcreteElement.getPropNumber() + 8;
		IT_F_TAG = 'IT_F';
		IT_F_CATEGORY = Category.FIGURE;
		IT_F_FORMAT = Format.ITEM;
		
		IT_G = ConcreteElement.getPropNumber() + 9;
		IT_G_TAG = 'IT_G';
		IT_G_CATEGORY = Category.GUI;
		IT_G_FORMAT = Format.ITEM;
	end
	methods % constructor
		function gt = GTA_IT(varargin)
			%GTA_IT() creates a test A PanelPropItem.
			%
			% GTA_IT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_IT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropItem.
			%
			% BUILD = GTA_IT.GETBUILD() returns the build of 'GTA_IT'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropItem GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_IT') returns the build of 'GTA_IT'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_IT')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropItem.
			%
			% CLASS = GTA_IT.GETCLASS() returns the class 'GTA_IT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropItem GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_IT') returns 'GTA_IT'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_IT')
			%  are less computationally efficient.
			
			gt_class = 'GTA_IT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropItem.
			%
			% LIST = GTA_IT.GETSUBCLASSES() returns all subclasses of 'GTA_IT'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropItem GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_IT') returns all subclasses of 'GTA_IT'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_IT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_IT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropItem.
			%
			% PROPS = GTA_IT.GETPROPS() returns the property list of test A PanelPropItem
			%  as a row vector.
			%
			% PROPS = GTA_IT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropItem GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_IT'[, CATEGORY]) returns the property list of 'GTA_IT'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_IT.IT_C ...
						GTA_IT.IT_M ...
						GTA_IT.IT_P ...
						GTA_IT.IT_D ...
						GTA_IT.IT_R ...
						GTA_IT.IT_Q ...
						GTA_IT.IT_E ...
						GTA_IT.IT_F ...
						GTA_IT.IT_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_IT.IT_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_IT.IT_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_IT.IT_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_IT.IT_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_IT.IT_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_IT.IT_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_IT.IT_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_IT.IT_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_IT.IT_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropItem.
			%
			% N = GTA_IT.GETPROPNUMBER() returns the property number of test A PanelPropItem.
			%
			% N = GTA_IT.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropItem
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropItem GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_IT') returns the property number of 'GTA_IT'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_IT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropItem/error.
			%
			% CHECK = GTA_IT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_IT, PROP) checks whether PROP exists for GTA_IT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_IT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_IT:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_IT:WrongInput]
			%  Element.EXISTSPROP(GTA_IT, PROP) throws error if PROP does NOT exist for GTA_IT.
			%   Error id: [BRAPH2:GTA_IT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_IT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_IT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_IT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_IT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropItem/error.
			%
			% CHECK = GTA_IT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_IT, TAG) checks whether TAG exists for GTA_IT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_IT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_IT:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_IT:WrongInput]
			%  Element.EXISTSTAG(GTA_IT, TAG) throws error if TAG does NOT exist for GTA_IT.
			%   Error id: [BRAPH2:GTA_IT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_it_tag_list = cellfun(@(x) GTA_IT.getPropTag(x), num2cell(GTA_IT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_it_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_IT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_IT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_IT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_IT, POINTER) returns property number of POINTER of GTA_IT.
			%  PROPERTY = GT.GETPROPPROP(GTA_IT, POINTER) returns property number of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_it_tag_list = cellfun(@(x) GTA_IT.getPropTag(x), num2cell(GTA_IT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_it_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_IT, POINTER) returns tag of POINTER of GTA_IT.
			%  TAG = GT.GETPROPTAG(GTA_IT, POINTER) returns tag of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_IT.IT_C
						tag = GTA_IT.IT_C_TAG;
					case GTA_IT.IT_M
						tag = GTA_IT.IT_M_TAG;
					case GTA_IT.IT_P
						tag = GTA_IT.IT_P_TAG;
					case GTA_IT.IT_D
						tag = GTA_IT.IT_D_TAG;
					case GTA_IT.IT_R
						tag = GTA_IT.IT_R_TAG;
					case GTA_IT.IT_Q
						tag = GTA_IT.IT_Q_TAG;
					case GTA_IT.IT_E
						tag = GTA_IT.IT_E_TAG;
					case GTA_IT.IT_F
						tag = GTA_IT.IT_F_TAG;
					case GTA_IT.IT_G
						tag = GTA_IT.IT_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_IT, POINTER) returns category of POINTER of GTA_IT.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_IT, POINTER) returns category of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_IT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_IT.getPropProp(pointer);
			
			switch prop
				case GTA_IT.IT_C
					prop_category = GTA_IT.IT_C_CATEGORY;
				case GTA_IT.IT_M
					prop_category = GTA_IT.IT_M_CATEGORY;
				case GTA_IT.IT_P
					prop_category = GTA_IT.IT_P_CATEGORY;
				case GTA_IT.IT_D
					prop_category = GTA_IT.IT_D_CATEGORY;
				case GTA_IT.IT_R
					prop_category = GTA_IT.IT_R_CATEGORY;
				case GTA_IT.IT_Q
					prop_category = GTA_IT.IT_Q_CATEGORY;
				case GTA_IT.IT_E
					prop_category = GTA_IT.IT_E_CATEGORY;
				case GTA_IT.IT_F
					prop_category = GTA_IT.IT_F_CATEGORY;
				case GTA_IT.IT_G
					prop_category = GTA_IT.IT_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_IT, POINTER) returns format of POINTER of GTA_IT.
			%  FORMAT = GT.GETPROPFORMAT(GTA_IT, POINTER) returns format of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_IT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_IT.getPropProp(pointer);
			
			switch prop
				case GTA_IT.IT_C
					prop_format = GTA_IT.IT_C_FORMAT;
				case GTA_IT.IT_M
					prop_format = GTA_IT.IT_M_FORMAT;
				case GTA_IT.IT_P
					prop_format = GTA_IT.IT_P_FORMAT;
				case GTA_IT.IT_D
					prop_format = GTA_IT.IT_D_FORMAT;
				case GTA_IT.IT_R
					prop_format = GTA_IT.IT_R_FORMAT;
				case GTA_IT.IT_Q
					prop_format = GTA_IT.IT_Q_FORMAT;
				case GTA_IT.IT_E
					prop_format = GTA_IT.IT_E_FORMAT;
				case GTA_IT.IT_F
					prop_format = GTA_IT.IT_F_FORMAT;
				case GTA_IT.IT_G
					prop_format = GTA_IT.IT_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_IT, POINTER) returns description of POINTER of GTA_IT.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_IT, POINTER) returns description of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_IT.getPropProp(pointer);
			
			switch prop
				case GTA_IT.IT_C
					prop_description = 'IT_C (constant, item) is a prop constant item.';
				case GTA_IT.IT_M
					prop_description = 'IT_M (metadata, item) is a prop metadata item.';
				case GTA_IT.IT_P
					prop_description = 'IT_P (parameter, item) is a prop parameter item.';
				case GTA_IT.IT_D
					prop_description = 'IT_D (data, item) is a prop data item.';
				case GTA_IT.IT_R
					prop_description = 'IT_R (result, item) is a prop result item.';
				case GTA_IT.IT_Q
					prop_description = 'IT_Q (query, item) is a prop query item.';
				case GTA_IT.IT_E
					prop_description = 'IT_E (evanescent, item) is a prop evanescent item.';
				case GTA_IT.IT_F
					prop_description = 'IT_F (figure, item) is a prop figure item.';
				case GTA_IT.IT_G
					prop_description = 'IT_G (gui, item) is a prop gui item.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_IT, POINTER) returns settings of POINTER of GTA_IT.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_IT, POINTER) returns settings of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_IT.getPropProp(pointer);
			
			switch prop
				case GTA_IT.IT_C
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_M
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_P
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_D
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_R
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_Q
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_E
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_F
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case GTA_IT.IT_G
					prop_settings = Format.getFormatSettings(Format.ITEM);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_IT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_IT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_IT, POINTER) returns the default value of POINTER of GTA_IT.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_IT, POINTER) returns the default value of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_IT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_IT.getPropProp(pointer);
			
			switch prop
				case GTA_IT.IT_C
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_M
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_P
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_D
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_R
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_Q
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_E
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_F
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_G
					prop_default = Format.getFormatDefault(Format.ITEM, GTA_IT.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_IT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_IT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_IT, POINTER) returns the conditioned default value of POINTER of GTA_IT.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_IT, POINTER) returns the conditioned default value of POINTER of GTA_IT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_IT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_IT.getPropProp(pointer);
			
			prop_default = GTA_IT.conditioning(prop, GTA_IT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_IT, PROP, VALUE) checks VALUE format for PROP of GTA_IT.
			%  CHECK = GT.CHECKPROP(GTA_IT, PROP, VALUE) checks VALUE format for PROP of GTA_IT.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_IT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_IT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_IT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_IT.
			%   Error id: €BRAPH2.STR€:GTA_IT:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_IT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_IT.
			%   Error id: €BRAPH2.STR€:GTA_IT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_IT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_IT.getPropProp(pointer);
			
			switch prop
				case GTA_IT.IT_C % __GTA_IT.IT_C__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_M % __GTA_IT.IT_M__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_P % __GTA_IT.IT_P__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_D % __GTA_IT.IT_D__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_R % __GTA_IT.IT_R__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_Q % __GTA_IT.IT_Q__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_E % __GTA_IT.IT_E__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_F % __GTA_IT.IT_F__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				case GTA_IT.IT_G % __GTA_IT.IT_G__
					check = Format.checkFormat(Format.ITEM, value, GTA_IT.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_IT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_IT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_IT.getPropTag(prop) ' (' GTA_IT.getFormatTag(GTA_IT.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
