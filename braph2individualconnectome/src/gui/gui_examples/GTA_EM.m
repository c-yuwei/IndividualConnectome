classdef GTA_EM < ConcreteElement
	%GTA_EM tests PanelProp.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_EM tests the PanelProp.
	%
	% GTA_EM methods (constructor):
	%  GTA_EM - constructor
	%
	% GTA_EM methods:
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
	% GTA_EM methods (display):
	%  tostring - string with information about the test A PanelProp
	%  disp - displays information about the test A PanelProp
	%  tree - displays the tree of the test A PanelProp
	%
	% GTA_EM methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelProp are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelProp
	%
	% GTA_EM methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelProp as b2 file
	%  load - loads a BRAPH2 test A PanelProp from a b2 file
	%
	% GTA_EM method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelProp
	%
	% GTA_EM method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelProp
	%
	% GTA_EM methods (inspection, Static):
	%  getClass - returns the class of the test A PanelProp
	%  getSubclasses - returns all subclasses of GTA_EM
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
	% GTA_EM methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_EM methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_EM methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_EM methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_EM; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_EM constants</a>.
	%
	%
	% See also PanelPropEmpty.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		EM_C = ConcreteElement.getPropNumber() + 1;
		EM_C_TAG = 'EM_C';
		EM_C_CATEGORY = Category.CONSTANT;
		EM_C_FORMAT = Format.EMPTY;
		
		EM_M = ConcreteElement.getPropNumber() + 2;
		EM_M_TAG = 'EM_M';
		EM_M_CATEGORY = Category.METADATA;
		EM_M_FORMAT = Format.EMPTY;
		
		EM_P = ConcreteElement.getPropNumber() + 3;
		EM_P_TAG = 'EM_P';
		EM_P_CATEGORY = Category.PARAMETER;
		EM_P_FORMAT = Format.EMPTY;
		
		EM_D = ConcreteElement.getPropNumber() + 4;
		EM_D_TAG = 'EM_D';
		EM_D_CATEGORY = Category.DATA;
		EM_D_FORMAT = Format.EMPTY;
		
		EM_R = ConcreteElement.getPropNumber() + 5;
		EM_R_TAG = 'EM_R';
		EM_R_CATEGORY = Category.RESULT;
		EM_R_FORMAT = Format.EMPTY;
		
		EM_Q = ConcreteElement.getPropNumber() + 6;
		EM_Q_TAG = 'EM_Q';
		EM_Q_CATEGORY = Category.QUERY;
		EM_Q_FORMAT = Format.EMPTY;
		
		EM_E = ConcreteElement.getPropNumber() + 7;
		EM_E_TAG = 'EM_E';
		EM_E_CATEGORY = Category.EVANESCENT;
		EM_E_FORMAT = Format.EMPTY;
		
		EM_F = ConcreteElement.getPropNumber() + 8;
		EM_F_TAG = 'EM_F';
		EM_F_CATEGORY = Category.FIGURE;
		EM_F_FORMAT = Format.EMPTY;
		
		EM_G = ConcreteElement.getPropNumber() + 9;
		EM_G_TAG = 'EM_G';
		EM_G_CATEGORY = Category.GUI;
		EM_G_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function gt = GTA_EM(varargin)
			%GTA_EM() creates a test A PanelProp.
			%
			% GTA_EM(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_EM(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% BUILD = GTA_EM.GETBUILD() returns the build of 'GTA_EM'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelProp GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_EM') returns the build of 'GTA_EM'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_EM')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelProp.
			%
			% CLASS = GTA_EM.GETCLASS() returns the class 'GTA_EM'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelProp GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_EM') returns 'GTA_EM'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_EM')
			%  are less computationally efficient.
			
			gt_class = 'GTA_EM';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelProp.
			%
			% LIST = GTA_EM.GETSUBCLASSES() returns all subclasses of 'GTA_EM'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelProp GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_EM') returns all subclasses of 'GTA_EM'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_EM')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_EM', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelProp.
			%
			% PROPS = GTA_EM.GETPROPS() returns the property list of test A PanelProp
			%  as a row vector.
			%
			% PROPS = GTA_EM.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelProp GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_EM'[, CATEGORY]) returns the property list of 'GTA_EM'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_EM.EM_C ...
						GTA_EM.EM_M ...
						GTA_EM.EM_P ...
						GTA_EM.EM_D ...
						GTA_EM.EM_R ...
						GTA_EM.EM_Q ...
						GTA_EM.EM_E ...
						GTA_EM.EM_F ...
						GTA_EM.EM_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_EM.EM_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_EM.EM_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_EM.EM_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_EM.EM_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_EM.EM_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_EM.EM_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_EM.EM_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_EM.EM_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_EM.EM_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelProp.
			%
			% N = GTA_EM.GETPROPNUMBER() returns the property number of test A PanelProp.
			%
			% N = GTA_EM.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelProp
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelProp GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_EM') returns the property number of 'GTA_EM'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_EM.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelProp/error.
			%
			% CHECK = GTA_EM.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_EM, PROP) checks whether PROP exists for GTA_EM.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_EM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_EM:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_EM:WrongInput]
			%  Element.EXISTSPROP(GTA_EM, PROP) throws error if PROP does NOT exist for GTA_EM.
			%   Error id: [BRAPH2:GTA_EM:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_EM.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_EM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_EM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_EM.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelProp/error.
			%
			% CHECK = GTA_EM.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_EM, TAG) checks whether TAG exists for GTA_EM.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_EM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_EM:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_EM:WrongInput]
			%  Element.EXISTSTAG(GTA_EM, TAG) throws error if TAG does NOT exist for GTA_EM.
			%   Error id: [BRAPH2:GTA_EM:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_em_tag_list = cellfun(@(x) GTA_EM.getPropTag(x), num2cell(GTA_EM.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_em_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_EM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_EM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_EM.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_EM, POINTER) returns property number of POINTER of GTA_EM.
			%  PROPERTY = GT.GETPROPPROP(GTA_EM, POINTER) returns property number of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_em_tag_list = cellfun(@(x) GTA_EM.getPropTag(x), num2cell(GTA_EM.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_em_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_EM, POINTER) returns tag of POINTER of GTA_EM.
			%  TAG = GT.GETPROPTAG(GTA_EM, POINTER) returns tag of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_EM.EM_C
						tag = GTA_EM.EM_C_TAG;
					case GTA_EM.EM_M
						tag = GTA_EM.EM_M_TAG;
					case GTA_EM.EM_P
						tag = GTA_EM.EM_P_TAG;
					case GTA_EM.EM_D
						tag = GTA_EM.EM_D_TAG;
					case GTA_EM.EM_R
						tag = GTA_EM.EM_R_TAG;
					case GTA_EM.EM_Q
						tag = GTA_EM.EM_Q_TAG;
					case GTA_EM.EM_E
						tag = GTA_EM.EM_E_TAG;
					case GTA_EM.EM_F
						tag = GTA_EM.EM_F_TAG;
					case GTA_EM.EM_G
						tag = GTA_EM.EM_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_EM, POINTER) returns category of POINTER of GTA_EM.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_EM, POINTER) returns category of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_EM')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_EM.getPropProp(pointer);
			
			switch prop
				case GTA_EM.EM_C
					prop_category = GTA_EM.EM_C_CATEGORY;
				case GTA_EM.EM_M
					prop_category = GTA_EM.EM_M_CATEGORY;
				case GTA_EM.EM_P
					prop_category = GTA_EM.EM_P_CATEGORY;
				case GTA_EM.EM_D
					prop_category = GTA_EM.EM_D_CATEGORY;
				case GTA_EM.EM_R
					prop_category = GTA_EM.EM_R_CATEGORY;
				case GTA_EM.EM_Q
					prop_category = GTA_EM.EM_Q_CATEGORY;
				case GTA_EM.EM_E
					prop_category = GTA_EM.EM_E_CATEGORY;
				case GTA_EM.EM_F
					prop_category = GTA_EM.EM_F_CATEGORY;
				case GTA_EM.EM_G
					prop_category = GTA_EM.EM_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_EM, POINTER) returns format of POINTER of GTA_EM.
			%  FORMAT = GT.GETPROPFORMAT(GTA_EM, POINTER) returns format of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_EM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_EM.getPropProp(pointer);
			
			switch prop
				case GTA_EM.EM_C
					prop_format = GTA_EM.EM_C_FORMAT;
				case GTA_EM.EM_M
					prop_format = GTA_EM.EM_M_FORMAT;
				case GTA_EM.EM_P
					prop_format = GTA_EM.EM_P_FORMAT;
				case GTA_EM.EM_D
					prop_format = GTA_EM.EM_D_FORMAT;
				case GTA_EM.EM_R
					prop_format = GTA_EM.EM_R_FORMAT;
				case GTA_EM.EM_Q
					prop_format = GTA_EM.EM_Q_FORMAT;
				case GTA_EM.EM_E
					prop_format = GTA_EM.EM_E_FORMAT;
				case GTA_EM.EM_F
					prop_format = GTA_EM.EM_F_FORMAT;
				case GTA_EM.EM_G
					prop_format = GTA_EM.EM_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_EM, POINTER) returns description of POINTER of GTA_EM.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_EM, POINTER) returns description of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_EM.getPropProp(pointer);
			
			switch prop
				case GTA_EM.EM_C
					prop_description = 'EM_C (constant, empty) is a prop constant empty.';
				case GTA_EM.EM_M
					prop_description = 'EM_M (metadata, empty) is a prop metadata empty.';
				case GTA_EM.EM_P
					prop_description = 'EM_P (parameter, empty) is a prop parameter empty.';
				case GTA_EM.EM_D
					prop_description = 'EM_D (data, empty) is a prop data empty.';
				case GTA_EM.EM_R
					prop_description = 'EM_R (result, empty) is a prop result empty.';
				case GTA_EM.EM_Q
					prop_description = 'EM_Q (query, empty) is a prop query empty.';
				case GTA_EM.EM_E
					prop_description = 'EM_E (evanescent, empty) is a prop evanescent empty.';
				case GTA_EM.EM_F
					prop_description = 'EM_F (figure, empty) is a prop figure empty.';
				case GTA_EM.EM_G
					prop_description = 'EM_G (gui, empty) is a prop gui empty.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_EM, POINTER) returns settings of POINTER of GTA_EM.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_EM, POINTER) returns settings of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_EM.getPropProp(pointer);
			
			switch prop
				case GTA_EM.EM_C
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_M
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_P
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_D
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_R
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_Q
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_E
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_F
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GTA_EM.EM_G
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_EM.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_EM.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_EM, POINTER) returns the default value of POINTER of GTA_EM.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_EM, POINTER) returns the default value of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_EM')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_EM.getPropProp(pointer);
			
			switch prop
				case GTA_EM.EM_C
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_M
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_P
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_D
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_R
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_Q
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_E
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_F
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_G
					prop_default = Format.getFormatDefault(Format.EMPTY, GTA_EM.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_EM.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_EM.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_EM, POINTER) returns the conditioned default value of POINTER of GTA_EM.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_EM, POINTER) returns the conditioned default value of POINTER of GTA_EM.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_EM')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_EM.getPropProp(pointer);
			
			prop_default = GTA_EM.conditioning(prop, GTA_EM.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_EM, PROP, VALUE) checks VALUE format for PROP of GTA_EM.
			%  CHECK = GT.CHECKPROP(GTA_EM, PROP, VALUE) checks VALUE format for PROP of GTA_EM.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_EM:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_EM:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_EM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_EM.
			%   Error id: €BRAPH2.STR€:GTA_EM:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_EM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_EM.
			%   Error id: €BRAPH2.STR€:GTA_EM:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_EM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_EM.getPropProp(pointer);
			
			switch prop
				case GTA_EM.EM_C % __GTA_EM.EM_C__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_M % __GTA_EM.EM_M__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_P % __GTA_EM.EM_P__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_D % __GTA_EM.EM_D__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_R % __GTA_EM.EM_R__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_Q % __GTA_EM.EM_Q__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_E % __GTA_EM.EM_E__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_F % __GTA_EM.EM_F__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				case GTA_EM.EM_G % __GTA_EM.EM_G__
					check = Format.checkFormat(Format.EMPTY, value, GTA_EM.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_EM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_EM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_EM.getPropTag(prop) ' (' GTA_EM.getFormatTag(GTA_EM.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
