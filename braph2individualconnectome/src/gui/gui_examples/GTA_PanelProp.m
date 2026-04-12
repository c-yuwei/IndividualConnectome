classdef GTA_PanelProp < ConcreteElement
	%GTA_PanelProp tests PanelProp.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_PanelProp tests PanelProp.
	%
	% GTA_PanelProp methods (constructor):
	%  GTA_PanelProp - constructor
	%
	% GTA_PanelProp methods:
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
	% GTA_PanelProp methods (display):
	%  tostring - string with information about the test A PanelProp
	%  disp - displays information about the test A PanelProp
	%  tree - displays the tree of the test A PanelProp
	%
	% GTA_PanelProp methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelProp are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelProp
	%
	% GTA_PanelProp methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelProp as b2 file
	%  load - loads a BRAPH2 test A PanelProp from a b2 file
	%
	% GTA_PanelProp method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelProp
	%
	% GTA_PanelProp method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelProp
	%
	% GTA_PanelProp methods (inspection, Static):
	%  getClass - returns the class of the test A PanelProp
	%  getSubclasses - returns all subclasses of GTA_PanelProp
	%  getProps - returns the property list of the test A PanelProp
	%  getPropNumber - returns the property number of the test A PanelProp
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
	% GTA_PanelProp methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_PanelProp methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_PanelProp methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_PanelProp methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_PanelProp; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_PanelProp constants</a>.
	%
	%
	% See also PanelProp.
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
		function gt = GTA_PanelProp(varargin)
			%GTA_PanelProp() creates a test A PanelProp.
			%
			% GTA_PanelProp(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_PanelProp(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelProp.
			%
			% BUILD = GTA_PanelProp.GETBUILD() returns the build of 'GTA_PanelProp'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelProp GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_PanelProp') returns the build of 'GTA_PanelProp'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_PanelProp')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelProp.
			%
			% CLASS = GTA_PanelProp.GETCLASS() returns the class 'GTA_PanelProp'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelProp GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_PanelProp') returns 'GTA_PanelProp'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_PanelProp')
			%  are less computationally efficient.
			
			gt_class = 'GTA_PanelProp';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelProp.
			%
			% LIST = GTA_PanelProp.GETSUBCLASSES() returns all subclasses of 'GTA_PanelProp'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelProp GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_PanelProp') returns all subclasses of 'GTA_PanelProp'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_PanelProp', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelProp.
			%
			% PROPS = GTA_PanelProp.GETPROPS() returns the property list of test A PanelProp
			%  as a row vector.
			%
			% PROPS = GTA_PanelProp.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelProp GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_PanelProp'[, CATEGORY]) returns the property list of 'GTA_PanelProp'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_PanelProp.ST_C ...
						GTA_PanelProp.ST_M ...
						GTA_PanelProp.ST_P ...
						GTA_PanelProp.ST_D ...
						GTA_PanelProp.ST_R ...
						GTA_PanelProp.ST_Q ...
						GTA_PanelProp.ST_E ...
						GTA_PanelProp.ST_F ...
						GTA_PanelProp.ST_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_PanelProp.ST_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_PanelProp.ST_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_PanelProp.ST_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_PanelProp.ST_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_PanelProp.ST_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_PanelProp.ST_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_PanelProp.ST_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_PanelProp.ST_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_PanelProp.ST_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelProp.
			%
			% N = GTA_PanelProp.GETPROPNUMBER() returns the property number of test A PanelProp.
			%
			% N = GTA_PanelProp.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelProp
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelProp GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_PanelProp') returns the property number of 'GTA_PanelProp'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_PanelProp.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelProp/error.
			%
			% CHECK = GTA_PanelProp.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_PanelProp, PROP) checks whether PROP exists for GTA_PanelProp.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSPROP(GTA_PanelProp, PROP) throws error if PROP does NOT exist for GTA_PanelProp.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_PanelProp.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_PanelProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_PanelProp:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_PanelProp.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelProp/error.
			%
			% CHECK = GTA_PanelProp.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_PanelProp, TAG) checks whether TAG exists for GTA_PanelProp.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSTAG(GTA_PanelProp, TAG) throws error if TAG does NOT exist for GTA_PanelProp.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_panelprop_tag_list = cellfun(@(x) GTA_PanelProp.getPropTag(x), num2cell(GTA_PanelProp.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_panelprop_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_PanelProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_PanelProp:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_PanelProp.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_PanelProp, POINTER) returns property number of POINTER of GTA_PanelProp.
			%  PROPERTY = GT.GETPROPPROP(GTA_PanelProp, POINTER) returns property number of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_panelprop_tag_list = cellfun(@(x) GTA_PanelProp.getPropTag(x), num2cell(GTA_PanelProp.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_panelprop_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_PanelProp, POINTER) returns tag of POINTER of GTA_PanelProp.
			%  TAG = GT.GETPROPTAG(GTA_PanelProp, POINTER) returns tag of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_PanelProp.ST_C
						tag = GTA_PanelProp.ST_C_TAG;
					case GTA_PanelProp.ST_M
						tag = GTA_PanelProp.ST_M_TAG;
					case GTA_PanelProp.ST_P
						tag = GTA_PanelProp.ST_P_TAG;
					case GTA_PanelProp.ST_D
						tag = GTA_PanelProp.ST_D_TAG;
					case GTA_PanelProp.ST_R
						tag = GTA_PanelProp.ST_R_TAG;
					case GTA_PanelProp.ST_Q
						tag = GTA_PanelProp.ST_Q_TAG;
					case GTA_PanelProp.ST_E
						tag = GTA_PanelProp.ST_E_TAG;
					case GTA_PanelProp.ST_F
						tag = GTA_PanelProp.ST_F_TAG;
					case GTA_PanelProp.ST_G
						tag = GTA_PanelProp.ST_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_PanelProp, POINTER) returns category of POINTER of GTA_PanelProp.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_PanelProp, POINTER) returns category of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop
				case GTA_PanelProp.ST_C
					prop_category = GTA_PanelProp.ST_C_CATEGORY;
				case GTA_PanelProp.ST_M
					prop_category = GTA_PanelProp.ST_M_CATEGORY;
				case GTA_PanelProp.ST_P
					prop_category = GTA_PanelProp.ST_P_CATEGORY;
				case GTA_PanelProp.ST_D
					prop_category = GTA_PanelProp.ST_D_CATEGORY;
				case GTA_PanelProp.ST_R
					prop_category = GTA_PanelProp.ST_R_CATEGORY;
				case GTA_PanelProp.ST_Q
					prop_category = GTA_PanelProp.ST_Q_CATEGORY;
				case GTA_PanelProp.ST_E
					prop_category = GTA_PanelProp.ST_E_CATEGORY;
				case GTA_PanelProp.ST_F
					prop_category = GTA_PanelProp.ST_F_CATEGORY;
				case GTA_PanelProp.ST_G
					prop_category = GTA_PanelProp.ST_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_PanelProp, POINTER) returns format of POINTER of GTA_PanelProp.
			%  FORMAT = GT.GETPROPFORMAT(GTA_PanelProp, POINTER) returns format of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop
				case GTA_PanelProp.ST_C
					prop_format = GTA_PanelProp.ST_C_FORMAT;
				case GTA_PanelProp.ST_M
					prop_format = GTA_PanelProp.ST_M_FORMAT;
				case GTA_PanelProp.ST_P
					prop_format = GTA_PanelProp.ST_P_FORMAT;
				case GTA_PanelProp.ST_D
					prop_format = GTA_PanelProp.ST_D_FORMAT;
				case GTA_PanelProp.ST_R
					prop_format = GTA_PanelProp.ST_R_FORMAT;
				case GTA_PanelProp.ST_Q
					prop_format = GTA_PanelProp.ST_Q_FORMAT;
				case GTA_PanelProp.ST_E
					prop_format = GTA_PanelProp.ST_E_FORMAT;
				case GTA_PanelProp.ST_F
					prop_format = GTA_PanelProp.ST_F_FORMAT;
				case GTA_PanelProp.ST_G
					prop_format = GTA_PanelProp.ST_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_PanelProp, POINTER) returns description of POINTER of GTA_PanelProp.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_PanelProp, POINTER) returns description of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop
				case GTA_PanelProp.ST_C
					prop_description = 'ST_C (constant, string) is a prop constant string.';
				case GTA_PanelProp.ST_M
					prop_description = 'ST_M (metadata, string) is a prop metadata string.';
				case GTA_PanelProp.ST_P
					prop_description = 'ST_P (parameter, string) is a prop parameter string.';
				case GTA_PanelProp.ST_D
					prop_description = 'ST_D (data, string) is a prop data string.';
				case GTA_PanelProp.ST_R
					prop_description = 'ST_R (result, string) is a prop result string.';
				case GTA_PanelProp.ST_Q
					prop_description = 'ST_Q (query, string) is a prop query string.';
				case GTA_PanelProp.ST_E
					prop_description = 'ST_E (evanescent, string) is a prop evanescent string.';
				case GTA_PanelProp.ST_F
					prop_description = 'ST_F (figure, string) is a prop figure string.';
				case GTA_PanelProp.ST_G
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_PanelProp, POINTER) returns settings of POINTER of GTA_PanelProp.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_PanelProp, POINTER) returns settings of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop
				case GTA_PanelProp.ST_C
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_M
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_P
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_D
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_R
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_Q
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_E
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_F
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GTA_PanelProp.ST_G
					prop_settings = Format.getFormatSettings(Format.STRING);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_PanelProp, POINTER) returns the default value of POINTER of GTA_PanelProp.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_PanelProp, POINTER) returns the default value of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop
				case GTA_PanelProp.ST_C
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_M
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_P
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_D
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_R
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_Q
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_E
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_F
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_G
					prop_default = Format.getFormatDefault(Format.STRING, GTA_PanelProp.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_PanelProp, POINTER) returns the conditioned default value of POINTER of GTA_PanelProp.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_PanelProp, POINTER) returns the conditioned default value of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			prop_default = GTA_PanelProp.conditioning(prop, GTA_PanelProp.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_PanelProp, PROP, VALUE) checks VALUE format for PROP of GTA_PanelProp.
			%  CHECK = GT.CHECKPROP(GTA_PanelProp, PROP, VALUE) checks VALUE format for PROP of GTA_PanelProp.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_PanelProp:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_PanelProp:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_PanelProp.
			%   Error id: €BRAPH2.STR€:GTA_PanelProp:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_PanelProp.
			%   Error id: €BRAPH2.STR€:GTA_PanelProp:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop
				case GTA_PanelProp.ST_C % __GTA_PanelProp.ST_C__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_M % __GTA_PanelProp.ST_M__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_P % __GTA_PanelProp.ST_P__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_D % __GTA_PanelProp.ST_D__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_R % __GTA_PanelProp.ST_R__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_Q % __GTA_PanelProp.ST_Q__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_E % __GTA_PanelProp.ST_E__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_F % __GTA_PanelProp.ST_F__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				case GTA_PanelProp.ST_G % __GTA_PanelProp.ST_G__
					check = Format.checkFormat(Format.STRING, value, GTA_PanelProp.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_PanelProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_PanelProp:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_PanelProp.getPropTag(prop) ' (' GTA_PanelProp.getFormatTag(GTA_PanelProp.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
