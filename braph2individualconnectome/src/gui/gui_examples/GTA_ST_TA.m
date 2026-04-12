classdef GTA_ST_TA < ConcreteElement
	%GTA_ST_TA tests PanelPropStringTextArea.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_ST_TA tests PanelPropStringTextArea.
	%
	% GTA_ST_TA methods (constructor):
	%  GTA_ST_TA - constructor
	%
	% GTA_ST_TA methods:
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
	% GTA_ST_TA methods (display):
	%  tostring - string with information about the test A PanelPropStringTextArea
	%  disp - displays information about the test A PanelPropStringTextArea
	%  tree - displays the tree of the test A PanelPropStringTextArea
	%
	% GTA_ST_TA methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropStringTextArea are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropStringTextArea
	%
	% GTA_ST_TA methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropStringTextArea as b2 file
	%  load - loads a BRAPH2 test A PanelPropStringTextArea from a b2 file
	%
	% GTA_ST_TA method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropStringTextArea
	%
	% GTA_ST_TA method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropStringTextArea
	%
	% GTA_ST_TA methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropStringTextArea
	%  getSubclasses - returns all subclasses of GTA_ST_TA
	%  getProps - returns the property list of the test A PanelPropStringTextArea
	%  getPropNumber - returns the property number of the test A PanelPropStringTextArea
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
	% GTA_ST_TA methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_ST_TA methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_ST_TA methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_ST_TA methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_ST_TA; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_ST_TA constants</a>.
	%
	%
	% See also PanelPropStringTextArea.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		ST_C = ConcreteElement.getPropNumber() + 1;
		ST_C_TAG = 'ST_C';
		ST_C_CATEGORY = Category.CONSTANT;
		ST_C_FORMAT = Format.STRING;
		
		ST_M = ConcreteElement.getPropNumber() + 2;
		ST_M_TAG = 'ST_M';
		ST_M_CATEGORY = Category.METADATA;
		ST_M_FORMAT = Format.STRING;
		
		ST_P = ConcreteElement.getPropNumber() + 3;
		ST_P_TAG = 'ST_P';
		ST_P_CATEGORY = Category.PARAMETER;
		ST_P_FORMAT = Format.STRING;
		
		ST_D = ConcreteElement.getPropNumber() + 4;
		ST_D_TAG = 'ST_D';
		ST_D_CATEGORY = Category.DATA;
		ST_D_FORMAT = Format.STRING;
		
		ST_R = ConcreteElement.getPropNumber() + 5;
		ST_R_TAG = 'ST_R';
		ST_R_CATEGORY = Category.RESULT;
		ST_R_FORMAT = Format.STRING;
		
		ST_Q = ConcreteElement.getPropNumber() + 6;
		ST_Q_TAG = 'ST_Q';
		ST_Q_CATEGORY = Category.QUERY;
		ST_Q_FORMAT = Format.STRING;
		
		ST_E = ConcreteElement.getPropNumber() + 7;
		ST_E_TAG = 'ST_E';
		ST_E_CATEGORY = Category.EVANESCENT;
		ST_E_FORMAT = Format.STRING;
		
		ST_F = ConcreteElement.getPropNumber() + 8;
		ST_F_TAG = 'ST_F';
		ST_F_CATEGORY = Category.FIGURE;
		ST_F_FORMAT = Format.STRING;
		
		ST_G = ConcreteElement.getPropNumber() + 9;
		ST_G_TAG = 'ST_G';
		ST_G_CATEGORY = Category.GUI;
		ST_G_FORMAT = Format.STRING;
	end
	methods % constructor
		function gt = GTA_ST_TA(varargin)
			%GTA_ST_TA() creates a test A PanelPropStringTextArea.
			%
			% GTA_ST_TA(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_ST_TA(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropStringTextArea.
			%
			% BUILD = GTA_ST_TA.GETBUILD() returns the build of 'GTA_ST_TA'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropStringTextArea GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_ST_TA') returns the build of 'GTA_ST_TA'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_ST_TA')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropStringTextArea.
			%
			% CLASS = GTA_ST_TA.GETCLASS() returns the class 'GTA_ST_TA'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropStringTextArea GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_ST_TA') returns 'GTA_ST_TA'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_ST_TA')
			%  are less computationally efficient.
			
			gt_class = 'GTA_ST_TA';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropStringTextArea.
			%
			% LIST = GTA_ST_TA.GETSUBCLASSES() returns all subclasses of 'GTA_ST_TA'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropStringTextArea GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_ST_TA') returns all subclasses of 'GTA_ST_TA'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_ST_TA', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropStringTextArea.
			%
			% PROPS = GTA_ST_TA.GETPROPS() returns the property list of test A PanelPropStringTextArea
			%  as a row vector.
			%
			% PROPS = GTA_ST_TA.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropStringTextArea GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_ST_TA'[, CATEGORY]) returns the property list of 'GTA_ST_TA'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_ST_TA.ST_C ...
						GTA_ST_TA.ST_M ...
						GTA_ST_TA.ST_P ...
						GTA_ST_TA.ST_D ...
						GTA_ST_TA.ST_R ...
						GTA_ST_TA.ST_Q ...
						GTA_ST_TA.ST_E ...
						GTA_ST_TA.ST_F ...
						GTA_ST_TA.ST_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_ST_TA.ST_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_ST_TA.ST_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_ST_TA.ST_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_ST_TA.ST_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_ST_TA.ST_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_ST_TA.ST_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_ST_TA.ST_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_ST_TA.ST_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_ST_TA.ST_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropStringTextArea.
			%
			% N = GTA_ST_TA.GETPROPNUMBER() returns the property number of test A PanelPropStringTextArea.
			%
			% N = GTA_ST_TA.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropStringTextArea
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropStringTextArea GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_ST_TA') returns the property number of 'GTA_ST_TA'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_ST_TA.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropStringTextArea/error.
			%
			% CHECK = GTA_ST_TA.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_ST_TA, PROP) checks whether PROP exists for GTA_ST_TA.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSPROP(GTA_ST_TA, PROP) throws error if PROP does NOT exist for GTA_ST_TA.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_ST_TA.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_ST_TA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_ST_TA:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_ST_TA.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropStringTextArea/error.
			%
			% CHECK = GTA_ST_TA.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_ST_TA, TAG) checks whether TAG exists for GTA_ST_TA.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSTAG(GTA_ST_TA, TAG) throws error if TAG does NOT exist for GTA_ST_TA.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_st_ta_tag_list = cellfun(@(x) GTA_ST_TA.getPropTag(x), num2cell(GTA_ST_TA.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_st_ta_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_ST_TA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_ST_TA:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_ST_TA.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_ST_TA, POINTER) returns property number of POINTER of GTA_ST_TA.
			%  PROPERTY = GT.GETPROPPROP(GTA_ST_TA, POINTER) returns property number of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_st_ta_tag_list = cellfun(@(x) GTA_ST_TA.getPropTag(x), num2cell(GTA_ST_TA.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_st_ta_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_ST_TA, POINTER) returns tag of POINTER of GTA_ST_TA.
			%  TAG = GT.GETPROPTAG(GTA_ST_TA, POINTER) returns tag of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_ST_TA.ST_C
						tag = GTA_ST_TA.ST_C_TAG;
					case GTA_ST_TA.ST_M
						tag = GTA_ST_TA.ST_M_TAG;
					case GTA_ST_TA.ST_P
						tag = GTA_ST_TA.ST_P_TAG;
					case GTA_ST_TA.ST_D
						tag = GTA_ST_TA.ST_D_TAG;
					case GTA_ST_TA.ST_R
						tag = GTA_ST_TA.ST_R_TAG;
					case GTA_ST_TA.ST_Q
						tag = GTA_ST_TA.ST_Q_TAG;
					case GTA_ST_TA.ST_E
						tag = GTA_ST_TA.ST_E_TAG;
					case GTA_ST_TA.ST_F
						tag = GTA_ST_TA.ST_F_TAG;
					case GTA_ST_TA.ST_G
						tag = GTA_ST_TA.ST_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_ST_TA, POINTER) returns category of POINTER of GTA_ST_TA.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_ST_TA, POINTER) returns category of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop
				case GTA_ST_TA.ST_C
					prop_category = GTA_ST_TA.ST_C_CATEGORY;
				case GTA_ST_TA.ST_M
					prop_category = GTA_ST_TA.ST_M_CATEGORY;
				case GTA_ST_TA.ST_P
					prop_category = GTA_ST_TA.ST_P_CATEGORY;
				case GTA_ST_TA.ST_D
					prop_category = GTA_ST_TA.ST_D_CATEGORY;
				case GTA_ST_TA.ST_R
					prop_category = GTA_ST_TA.ST_R_CATEGORY;
				case GTA_ST_TA.ST_Q
					prop_category = GTA_ST_TA.ST_Q_CATEGORY;
				case GTA_ST_TA.ST_E
					prop_category = GTA_ST_TA.ST_E_CATEGORY;
				case GTA_ST_TA.ST_F
					prop_category = GTA_ST_TA.ST_F_CATEGORY;
				case GTA_ST_TA.ST_G
					prop_category = GTA_ST_TA.ST_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_ST_TA, POINTER) returns format of POINTER of GTA_ST_TA.
			%  FORMAT = GT.GETPROPFORMAT(GTA_ST_TA, POINTER) returns format of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop
				case GTA_ST_TA.ST_C
					prop_format = GTA_ST_TA.ST_C_FORMAT;
				case GTA_ST_TA.ST_M
					prop_format = GTA_ST_TA.ST_M_FORMAT;
				case GTA_ST_TA.ST_P
					prop_format = GTA_ST_TA.ST_P_FORMAT;
				case GTA_ST_TA.ST_D
					prop_format = GTA_ST_TA.ST_D_FORMAT;
				case GTA_ST_TA.ST_R
					prop_format = GTA_ST_TA.ST_R_FORMAT;
				case GTA_ST_TA.ST_Q
					prop_format = GTA_ST_TA.ST_Q_FORMAT;
				case GTA_ST_TA.ST_E
					prop_format = GTA_ST_TA.ST_E_FORMAT;
				case GTA_ST_TA.ST_F
					prop_format = GTA_ST_TA.ST_F_FORMAT;
				case GTA_ST_TA.ST_G
					prop_format = GTA_ST_TA.ST_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_ST_TA, POINTER) returns description of POINTER of GTA_ST_TA.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_ST_TA, POINTER) returns description of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop
				case GTA_ST_TA.ST_C
					prop_description = 'ST_C (constant, string) is a prop constant string.';
				case GTA_ST_TA.ST_M
					prop_description = 'ST_M (metadata, string) is a prop metadata string.';
				case GTA_ST_TA.ST_P
					prop_description = 'ST_P (parameter, string) is a prop parameter string.';
				case GTA_ST_TA.ST_D
					prop_description = 'ST_D (data, string) is a prop data string.';
				case GTA_ST_TA.ST_R
					prop_description = 'ST_R (result, string) is a prop result string.';
				case GTA_ST_TA.ST_Q
					prop_description = 'ST_Q (query, string) is a prop query string.';
				case GTA_ST_TA.ST_E
					prop_description = 'ST_E (evanescent, string) is a prop evanescent string.';
				case GTA_ST_TA.ST_F
					prop_description = 'ST_F (figure, string) is a prop figure string.';
				case GTA_ST_TA.ST_G
					prop_description = 'ST_G (gui, string) is a prop gui string.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_ST_TA, POINTER) returns settings of POINTER of GTA_ST_TA.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_ST_TA, POINTER) returns settings of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop
				case GTA_ST_TA.ST_C
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_M
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_P
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_D
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_R
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_Q
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_E
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_F
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_ST_TA.ST_G
					prop_settings = Format.getFormatSettings(Format.STRING);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_ST_TA, POINTER) returns the default value of POINTER of GTA_ST_TA.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_ST_TA, POINTER) returns the default value of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop
				case GTA_ST_TA.ST_C
					prop_default = Format.getFormatDefault(Format.STRING, GTA_ST_TA.getPropSettings(prop));
				case GTA_ST_TA.ST_M
					prop_default = 'M\nM\nM\n';
				case GTA_ST_TA.ST_P
					prop_default = 'P\nP\nP\n';
				case GTA_ST_TA.ST_D
					prop_default = 'D\nD\nD\n';
				case GTA_ST_TA.ST_R
					prop_default = 'result\ndefault\n';
				case GTA_ST_TA.ST_Q
					prop_default = 'query\ndefault\n';
				case GTA_ST_TA.ST_E
					prop_default = 'evanescent\ndefault\n';
				case GTA_ST_TA.ST_F
					prop_default = 'F\nF\nF\n';
				case GTA_ST_TA.ST_G
					prop_default = 'G\nG\nG\n';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_ST_TA, POINTER) returns the conditioned default value of POINTER of GTA_ST_TA.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_ST_TA, POINTER) returns the conditioned default value of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			prop_default = GTA_ST_TA.conditioning(prop, GTA_ST_TA.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_ST_TA, PROP, VALUE) checks VALUE format for PROP of GTA_ST_TA.
			%  CHECK = GT.CHECKPROP(GTA_ST_TA, PROP, VALUE) checks VALUE format for PROP of GTA_ST_TA.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_ST_TA:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_ST_TA:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_ST_TA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_ST_TA.
			%   Error id: €BRAPH2.STR€:GTA_ST_TA:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_ST_TA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_ST_TA.
			%   Error id: €BRAPH2.STR€:GTA_ST_TA:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop
				case GTA_ST_TA.ST_C % __GTA_ST_TA.ST_C__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
				case GTA_ST_TA.ST_M % __GTA_ST_TA.ST_M__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case GTA_ST_TA.ST_P % __GTA_ST_TA.ST_P__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case GTA_ST_TA.ST_D % __GTA_ST_TA.ST_D__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case GTA_ST_TA.ST_R % __GTA_ST_TA.ST_R__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
				case GTA_ST_TA.ST_Q % __GTA_ST_TA.ST_Q__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
				case GTA_ST_TA.ST_E % __GTA_ST_TA.ST_E__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
				case GTA_ST_TA.ST_F % __GTA_ST_TA.ST_F__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case GTA_ST_TA.ST_G % __GTA_ST_TA.ST_G__
					check = Format.checkFormat(Format.STRING, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_ST_TA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_ST_TA:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_ST_TA.getPropTag(prop) ' (' GTA_ST_TA.getFormatTag(GTA_ST_TA.getPropFormat(prop)) ').'] ...
					)
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
				case GTA_ST_TA.ST_R % __GTA_ST_TA.ST_R__
					rng_settings_ = rng(); rng(gt.getPropSeed(GTA_ST_TA.ST_R), 'twister')
					
					value = 'result\ncalculated\n';
					
					rng(rng_settings_)
					
				case GTA_ST_TA.ST_Q % __GTA_ST_TA.ST_Q__
					value = 'query\ncalculated\n';
					
				case GTA_ST_TA.ST_E % __GTA_ST_TA.ST_E__
					value = 'evanescent\ncalculated\n';
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(gt, prop, varargin{:});
					else
						value = calculateValue@Element(gt, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(gt, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case GTA_ST_TA.ST_C % __GTA_ST_TA.ST_C__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_C, varargin{:});
					
				case GTA_ST_TA.ST_M % __GTA_ST_TA.ST_M__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_M, varargin{:});
					
				case GTA_ST_TA.ST_P % __GTA_ST_TA.ST_P__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_P, varargin{:});
					
				case GTA_ST_TA.ST_D % __GTA_ST_TA.ST_D__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_D, varargin{:});
					
				case GTA_ST_TA.ST_R % __GTA_ST_TA.ST_R__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_R, varargin{:});
					
				case GTA_ST_TA.ST_Q % __GTA_ST_TA.ST_Q__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_Q, varargin{:});
					
				case GTA_ST_TA.ST_E % __GTA_ST_TA.ST_E__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_E, varargin{:});
					
				case GTA_ST_TA.ST_F % __GTA_ST_TA.ST_F__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_F, varargin{:});
					
				case GTA_ST_TA.ST_G % __GTA_ST_TA.ST_G__
					pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_G, varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(gt, prop, varargin{:});
					
			end
		end
	end
end
