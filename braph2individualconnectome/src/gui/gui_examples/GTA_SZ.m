classdef GTA_SZ < ConcreteElement
	%GTA_SZ tests PanelPropSize.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_SZ tests PanelPropSize.
	%
	% GTA_SZ methods (constructor):
	%  GTA_SZ - constructor
	%
	% GTA_SZ methods:
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
	% GTA_SZ methods (display):
	%  tostring - string with information about the test A PanelPropSize
	%  disp - displays information about the test A PanelPropSize
	%  tree - displays the tree of the test A PanelPropSize
	%
	% GTA_SZ methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropSize are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropSize
	%
	% GTA_SZ methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropSize as b2 file
	%  load - loads a BRAPH2 test A PanelPropSize from a b2 file
	%
	% GTA_SZ method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropSize
	%
	% GTA_SZ method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropSize
	%
	% GTA_SZ methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropSize
	%  getSubclasses - returns all subclasses of GTA_SZ
	%  getProps - returns the property list of the test A PanelPropSize
	%  getPropNumber - returns the property number of the test A PanelPropSize
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
	% GTA_SZ methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_SZ methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_SZ methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_SZ methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_SZ; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_SZ constants</a>.
	%
	%
	% See also PanelPropSize.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		SZ_C = ConcreteElement.getPropNumber() + 1;
		SZ_C_TAG = 'SZ_C';
		SZ_C_CATEGORY = Category.CONSTANT;
		SZ_C_FORMAT = Format.SIZE;
		
		SZ_M = ConcreteElement.getPropNumber() + 2;
		SZ_M_TAG = 'SZ_M';
		SZ_M_CATEGORY = Category.METADATA;
		SZ_M_FORMAT = Format.SIZE;
		
		SZ_P = ConcreteElement.getPropNumber() + 3;
		SZ_P_TAG = 'SZ_P';
		SZ_P_CATEGORY = Category.PARAMETER;
		SZ_P_FORMAT = Format.SIZE;
		
		SZ_D = ConcreteElement.getPropNumber() + 4;
		SZ_D_TAG = 'SZ_D';
		SZ_D_CATEGORY = Category.DATA;
		SZ_D_FORMAT = Format.SIZE;
		
		SZ_R = ConcreteElement.getPropNumber() + 5;
		SZ_R_TAG = 'SZ_R';
		SZ_R_CATEGORY = Category.RESULT;
		SZ_R_FORMAT = Format.SIZE;
		
		SZ_Q = ConcreteElement.getPropNumber() + 6;
		SZ_Q_TAG = 'SZ_Q';
		SZ_Q_CATEGORY = Category.QUERY;
		SZ_Q_FORMAT = Format.SIZE;
		
		SZ_E = ConcreteElement.getPropNumber() + 7;
		SZ_E_TAG = 'SZ_E';
		SZ_E_CATEGORY = Category.EVANESCENT;
		SZ_E_FORMAT = Format.SIZE;
		
		SZ_F = ConcreteElement.getPropNumber() + 8;
		SZ_F_TAG = 'SZ_F';
		SZ_F_CATEGORY = Category.FIGURE;
		SZ_F_FORMAT = Format.SIZE;
		
		SZ_G = ConcreteElement.getPropNumber() + 9;
		SZ_G_TAG = 'SZ_G';
		SZ_G_CATEGORY = Category.GUI;
		SZ_G_FORMAT = Format.SIZE;
	end
	methods % constructor
		function gt = GTA_SZ(varargin)
			%GTA_SZ() creates a test A PanelPropSize.
			%
			% GTA_SZ(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_SZ(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropSize.
			%
			% BUILD = GTA_SZ.GETBUILD() returns the build of 'GTA_SZ'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropSize GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_SZ') returns the build of 'GTA_SZ'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_SZ')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropSize.
			%
			% CLASS = GTA_SZ.GETCLASS() returns the class 'GTA_SZ'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropSize GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_SZ') returns 'GTA_SZ'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_SZ')
			%  are less computationally efficient.
			
			gt_class = 'GTA_SZ';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropSize.
			%
			% LIST = GTA_SZ.GETSUBCLASSES() returns all subclasses of 'GTA_SZ'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropSize GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_SZ') returns all subclasses of 'GTA_SZ'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_SZ', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropSize.
			%
			% PROPS = GTA_SZ.GETPROPS() returns the property list of test A PanelPropSize
			%  as a row vector.
			%
			% PROPS = GTA_SZ.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropSize GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_SZ'[, CATEGORY]) returns the property list of 'GTA_SZ'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_SZ.SZ_C ...
						GTA_SZ.SZ_M ...
						GTA_SZ.SZ_P ...
						GTA_SZ.SZ_D ...
						GTA_SZ.SZ_R ...
						GTA_SZ.SZ_Q ...
						GTA_SZ.SZ_E ...
						GTA_SZ.SZ_F ...
						GTA_SZ.SZ_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_SZ.SZ_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_SZ.SZ_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_SZ.SZ_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_SZ.SZ_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_SZ.SZ_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_SZ.SZ_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_SZ.SZ_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_SZ.SZ_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_SZ.SZ_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropSize.
			%
			% N = GTA_SZ.GETPROPNUMBER() returns the property number of test A PanelPropSize.
			%
			% N = GTA_SZ.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropSize
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropSize GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_SZ') returns the property number of 'GTA_SZ'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_SZ.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropSize/error.
			%
			% CHECK = GTA_SZ.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_SZ, PROP) checks whether PROP exists for GTA_SZ.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_SZ:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_SZ:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_SZ:WrongInput]
			%  Element.EXISTSPROP(GTA_SZ, PROP) throws error if PROP does NOT exist for GTA_SZ.
			%   Error id: [BRAPH2:GTA_SZ:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_SZ.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_SZ:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_SZ:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_SZ.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropSize/error.
			%
			% CHECK = GTA_SZ.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_SZ, TAG) checks whether TAG exists for GTA_SZ.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_SZ:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_SZ:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_SZ:WrongInput]
			%  Element.EXISTSTAG(GTA_SZ, TAG) throws error if TAG does NOT exist for GTA_SZ.
			%   Error id: [BRAPH2:GTA_SZ:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_sz_tag_list = cellfun(@(x) GTA_SZ.getPropTag(x), num2cell(GTA_SZ.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_sz_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_SZ:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_SZ:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_SZ.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_SZ, POINTER) returns property number of POINTER of GTA_SZ.
			%  PROPERTY = GT.GETPROPPROP(GTA_SZ, POINTER) returns property number of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_sz_tag_list = cellfun(@(x) GTA_SZ.getPropTag(x), num2cell(GTA_SZ.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_sz_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_SZ, POINTER) returns tag of POINTER of GTA_SZ.
			%  TAG = GT.GETPROPTAG(GTA_SZ, POINTER) returns tag of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_SZ.SZ_C
						tag = GTA_SZ.SZ_C_TAG;
					case GTA_SZ.SZ_M
						tag = GTA_SZ.SZ_M_TAG;
					case GTA_SZ.SZ_P
						tag = GTA_SZ.SZ_P_TAG;
					case GTA_SZ.SZ_D
						tag = GTA_SZ.SZ_D_TAG;
					case GTA_SZ.SZ_R
						tag = GTA_SZ.SZ_R_TAG;
					case GTA_SZ.SZ_Q
						tag = GTA_SZ.SZ_Q_TAG;
					case GTA_SZ.SZ_E
						tag = GTA_SZ.SZ_E_TAG;
					case GTA_SZ.SZ_F
						tag = GTA_SZ.SZ_F_TAG;
					case GTA_SZ.SZ_G
						tag = GTA_SZ.SZ_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_SZ, POINTER) returns category of POINTER of GTA_SZ.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_SZ, POINTER) returns category of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_SZ.getPropProp(pointer);
			
			switch prop
				case GTA_SZ.SZ_C
					prop_category = GTA_SZ.SZ_C_CATEGORY;
				case GTA_SZ.SZ_M
					prop_category = GTA_SZ.SZ_M_CATEGORY;
				case GTA_SZ.SZ_P
					prop_category = GTA_SZ.SZ_P_CATEGORY;
				case GTA_SZ.SZ_D
					prop_category = GTA_SZ.SZ_D_CATEGORY;
				case GTA_SZ.SZ_R
					prop_category = GTA_SZ.SZ_R_CATEGORY;
				case GTA_SZ.SZ_Q
					prop_category = GTA_SZ.SZ_Q_CATEGORY;
				case GTA_SZ.SZ_E
					prop_category = GTA_SZ.SZ_E_CATEGORY;
				case GTA_SZ.SZ_F
					prop_category = GTA_SZ.SZ_F_CATEGORY;
				case GTA_SZ.SZ_G
					prop_category = GTA_SZ.SZ_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_SZ, POINTER) returns format of POINTER of GTA_SZ.
			%  FORMAT = GT.GETPROPFORMAT(GTA_SZ, POINTER) returns format of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_SZ.getPropProp(pointer);
			
			switch prop
				case GTA_SZ.SZ_C
					prop_format = GTA_SZ.SZ_C_FORMAT;
				case GTA_SZ.SZ_M
					prop_format = GTA_SZ.SZ_M_FORMAT;
				case GTA_SZ.SZ_P
					prop_format = GTA_SZ.SZ_P_FORMAT;
				case GTA_SZ.SZ_D
					prop_format = GTA_SZ.SZ_D_FORMAT;
				case GTA_SZ.SZ_R
					prop_format = GTA_SZ.SZ_R_FORMAT;
				case GTA_SZ.SZ_Q
					prop_format = GTA_SZ.SZ_Q_FORMAT;
				case GTA_SZ.SZ_E
					prop_format = GTA_SZ.SZ_E_FORMAT;
				case GTA_SZ.SZ_F
					prop_format = GTA_SZ.SZ_F_FORMAT;
				case GTA_SZ.SZ_G
					prop_format = GTA_SZ.SZ_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_SZ, POINTER) returns description of POINTER of GTA_SZ.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_SZ, POINTER) returns description of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_SZ.getPropProp(pointer);
			
			switch prop
				case GTA_SZ.SZ_C
					prop_description = 'SZ_C (constant, size) is a prop constant size.';
				case GTA_SZ.SZ_M
					prop_description = 'SZ_M (metadata, size) is a prop metadata size.';
				case GTA_SZ.SZ_P
					prop_description = 'SZ_P (parameter, size) is a prop parameter size.';
				case GTA_SZ.SZ_D
					prop_description = 'SZ_D (data, size) is a prop data size.';
				case GTA_SZ.SZ_R
					prop_description = 'SZ_R (result, size) is a prop result size.';
				case GTA_SZ.SZ_Q
					prop_description = 'SZ_Q (query, size) is a prop query size.';
				case GTA_SZ.SZ_E
					prop_description = 'SZ_E (evanescent, size) is a prop evanescent size.';
				case GTA_SZ.SZ_F
					prop_description = 'SZ_F (figure, size) is a prop figure size.';
				case GTA_SZ.SZ_G
					prop_description = 'SZ_G (gui, size) is a prop gui size.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_SZ, POINTER) returns settings of POINTER of GTA_SZ.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_SZ, POINTER) returns settings of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_SZ.getPropProp(pointer);
			
			switch prop
				case GTA_SZ.SZ_C
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_M
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_P
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_D
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_R
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_Q
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_E
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_F
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GTA_SZ.SZ_G
					prop_settings = Format.getFormatSettings(Format.SIZE);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_SZ.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_SZ.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_SZ, POINTER) returns the default value of POINTER of GTA_SZ.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_SZ, POINTER) returns the default value of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_SZ.getPropProp(pointer);
			
			switch prop
				case GTA_SZ.SZ_C
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_M
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_P
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_D
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_R
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_Q
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_E
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_F
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_G
					prop_default = Format.getFormatDefault(Format.SIZE, GTA_SZ.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_SZ.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_SZ.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_SZ, POINTER) returns the conditioned default value of POINTER of GTA_SZ.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_SZ, POINTER) returns the conditioned default value of POINTER of GTA_SZ.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_SZ.getPropProp(pointer);
			
			prop_default = GTA_SZ.conditioning(prop, GTA_SZ.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_SZ, PROP, VALUE) checks VALUE format for PROP of GTA_SZ.
			%  CHECK = GT.CHECKPROP(GTA_SZ, PROP, VALUE) checks VALUE format for PROP of GTA_SZ.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_SZ:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_SZ:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_SZ, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_SZ.
			%   Error id: €BRAPH2.STR€:GTA_SZ:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_SZ, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_SZ.
			%   Error id: €BRAPH2.STR€:GTA_SZ:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_SZ')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_SZ.getPropProp(pointer);
			
			switch prop
				case GTA_SZ.SZ_C % __GTA_SZ.SZ_C__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_M % __GTA_SZ.SZ_M__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_P % __GTA_SZ.SZ_P__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_D % __GTA_SZ.SZ_D__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_R % __GTA_SZ.SZ_R__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_Q % __GTA_SZ.SZ_Q__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_E % __GTA_SZ.SZ_E__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_F % __GTA_SZ.SZ_F__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				case GTA_SZ.SZ_G % __GTA_SZ.SZ_G__
					check = Format.checkFormat(Format.SIZE, value, GTA_SZ.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_SZ:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_SZ:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_SZ.getPropTag(prop) ' (' GTA_SZ.getFormatTag(GTA_SZ.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
