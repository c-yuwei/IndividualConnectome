classdef GTA_LL < ConcreteElement
	%GTA_LL tests PanelPropCell.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_LL tests PanelPropCell.
	%
	% GTA_LL methods (constructor):
	%  GTA_LL - constructor
	%
	% GTA_LL methods:
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
	% GTA_LL methods (display):
	%  tostring - string with information about the test A PanelPropCell
	%  disp - displays information about the test A PanelPropCell
	%  tree - displays the tree of the test A PanelPropCell
	%
	% GTA_LL methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropCell are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropCell
	%
	% GTA_LL methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropCell as b2 file
	%  load - loads a BRAPH2 test A PanelPropCell from a b2 file
	%
	% GTA_LL method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropCell
	%
	% GTA_LL method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropCell
	%
	% GTA_LL methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropCell
	%  getSubclasses - returns all subclasses of GTA_LL
	%  getProps - returns the property list of the test A PanelPropCell
	%  getPropNumber - returns the property number of the test A PanelPropCell
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
	% GTA_LL methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_LL methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_LL methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_LL methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_LL; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_LL constants</a>.
	%
	%
	% See also PanelPropCell.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		LL_C = ConcreteElement.getPropNumber() + 1;
		LL_C_TAG = 'LL_C';
		LL_C_CATEGORY = Category.CONSTANT;
		LL_C_FORMAT = Format.CELL;
		
		LL_M = ConcreteElement.getPropNumber() + 2;
		LL_M_TAG = 'LL_M';
		LL_M_CATEGORY = Category.METADATA;
		LL_M_FORMAT = Format.CELL;
		
		LL_P = ConcreteElement.getPropNumber() + 3;
		LL_P_TAG = 'LL_P';
		LL_P_CATEGORY = Category.PARAMETER;
		LL_P_FORMAT = Format.CELL;
		
		LL_D = ConcreteElement.getPropNumber() + 4;
		LL_D_TAG = 'LL_D';
		LL_D_CATEGORY = Category.DATA;
		LL_D_FORMAT = Format.CELL;
		
		LL_R = ConcreteElement.getPropNumber() + 5;
		LL_R_TAG = 'LL_R';
		LL_R_CATEGORY = Category.RESULT;
		LL_R_FORMAT = Format.CELL;
		
		LL_Q = ConcreteElement.getPropNumber() + 6;
		LL_Q_TAG = 'LL_Q';
		LL_Q_CATEGORY = Category.QUERY;
		LL_Q_FORMAT = Format.CELL;
		
		LL_E = ConcreteElement.getPropNumber() + 7;
		LL_E_TAG = 'LL_E';
		LL_E_CATEGORY = Category.EVANESCENT;
		LL_E_FORMAT = Format.CELL;
		
		LL_F = ConcreteElement.getPropNumber() + 8;
		LL_F_TAG = 'LL_F';
		LL_F_CATEGORY = Category.FIGURE;
		LL_F_FORMAT = Format.CELL;
		
		LL_G = ConcreteElement.getPropNumber() + 9;
		LL_G_TAG = 'LL_G';
		LL_G_CATEGORY = Category.GUI;
		LL_G_FORMAT = Format.CELL;
	end
	methods % constructor
		function gt = GTA_LL(varargin)
			%GTA_LL() creates a test A PanelPropCell.
			%
			% GTA_LL(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_LL(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropCell.
			%
			% BUILD = GTA_LL.GETBUILD() returns the build of 'GTA_LL'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropCell GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_LL') returns the build of 'GTA_LL'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_LL')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropCell.
			%
			% CLASS = GTA_LL.GETCLASS() returns the class 'GTA_LL'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropCell GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_LL') returns 'GTA_LL'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_LL')
			%  are less computationally efficient.
			
			gt_class = 'GTA_LL';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropCell.
			%
			% LIST = GTA_LL.GETSUBCLASSES() returns all subclasses of 'GTA_LL'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropCell GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_LL') returns all subclasses of 'GTA_LL'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_LL')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_LL', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropCell.
			%
			% PROPS = GTA_LL.GETPROPS() returns the property list of test A PanelPropCell
			%  as a row vector.
			%
			% PROPS = GTA_LL.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropCell GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_LL'[, CATEGORY]) returns the property list of 'GTA_LL'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_LL.LL_C ...
						GTA_LL.LL_M ...
						GTA_LL.LL_P ...
						GTA_LL.LL_D ...
						GTA_LL.LL_R ...
						GTA_LL.LL_Q ...
						GTA_LL.LL_E ...
						GTA_LL.LL_F ...
						GTA_LL.LL_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_LL.LL_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_LL.LL_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_LL.LL_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_LL.LL_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_LL.LL_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_LL.LL_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_LL.LL_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_LL.LL_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_LL.LL_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropCell.
			%
			% N = GTA_LL.GETPROPNUMBER() returns the property number of test A PanelPropCell.
			%
			% N = GTA_LL.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropCell
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropCell GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_LL') returns the property number of 'GTA_LL'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_LL.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropCell/error.
			%
			% CHECK = GTA_LL.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_LL, PROP) checks whether PROP exists for GTA_LL.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSPROP(GTA_LL, PROP) throws error if PROP does NOT exist for GTA_LL.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_LL.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LL:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LL:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_LL.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropCell/error.
			%
			% CHECK = GTA_LL.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_LL, TAG) checks whether TAG exists for GTA_LL.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSTAG(GTA_LL, TAG) throws error if TAG does NOT exist for GTA_LL.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_ll_tag_list = cellfun(@(x) GTA_LL.getPropTag(x), num2cell(GTA_LL.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_ll_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LL:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LL:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_LL.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_LL, POINTER) returns property number of POINTER of GTA_LL.
			%  PROPERTY = GT.GETPROPPROP(GTA_LL, POINTER) returns property number of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_ll_tag_list = cellfun(@(x) GTA_LL.getPropTag(x), num2cell(GTA_LL.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_ll_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_LL, POINTER) returns tag of POINTER of GTA_LL.
			%  TAG = GT.GETPROPTAG(GTA_LL, POINTER) returns tag of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_LL.LL_C
						tag = GTA_LL.LL_C_TAG;
					case GTA_LL.LL_M
						tag = GTA_LL.LL_M_TAG;
					case GTA_LL.LL_P
						tag = GTA_LL.LL_P_TAG;
					case GTA_LL.LL_D
						tag = GTA_LL.LL_D_TAG;
					case GTA_LL.LL_R
						tag = GTA_LL.LL_R_TAG;
					case GTA_LL.LL_Q
						tag = GTA_LL.LL_Q_TAG;
					case GTA_LL.LL_E
						tag = GTA_LL.LL_E_TAG;
					case GTA_LL.LL_F
						tag = GTA_LL.LL_F_TAG;
					case GTA_LL.LL_G
						tag = GTA_LL.LL_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_LL, POINTER) returns category of POINTER of GTA_LL.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_LL, POINTER) returns category of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_LL')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop
				case GTA_LL.LL_C
					prop_category = GTA_LL.LL_C_CATEGORY;
				case GTA_LL.LL_M
					prop_category = GTA_LL.LL_M_CATEGORY;
				case GTA_LL.LL_P
					prop_category = GTA_LL.LL_P_CATEGORY;
				case GTA_LL.LL_D
					prop_category = GTA_LL.LL_D_CATEGORY;
				case GTA_LL.LL_R
					prop_category = GTA_LL.LL_R_CATEGORY;
				case GTA_LL.LL_Q
					prop_category = GTA_LL.LL_Q_CATEGORY;
				case GTA_LL.LL_E
					prop_category = GTA_LL.LL_E_CATEGORY;
				case GTA_LL.LL_F
					prop_category = GTA_LL.LL_F_CATEGORY;
				case GTA_LL.LL_G
					prop_category = GTA_LL.LL_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_LL, POINTER) returns format of POINTER of GTA_LL.
			%  FORMAT = GT.GETPROPFORMAT(GTA_LL, POINTER) returns format of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_LL')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop
				case GTA_LL.LL_C
					prop_format = GTA_LL.LL_C_FORMAT;
				case GTA_LL.LL_M
					prop_format = GTA_LL.LL_M_FORMAT;
				case GTA_LL.LL_P
					prop_format = GTA_LL.LL_P_FORMAT;
				case GTA_LL.LL_D
					prop_format = GTA_LL.LL_D_FORMAT;
				case GTA_LL.LL_R
					prop_format = GTA_LL.LL_R_FORMAT;
				case GTA_LL.LL_Q
					prop_format = GTA_LL.LL_Q_FORMAT;
				case GTA_LL.LL_E
					prop_format = GTA_LL.LL_E_FORMAT;
				case GTA_LL.LL_F
					prop_format = GTA_LL.LL_F_FORMAT;
				case GTA_LL.LL_G
					prop_format = GTA_LL.LL_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_LL, POINTER) returns description of POINTER of GTA_LL.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_LL, POINTER) returns description of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop
				case GTA_LL.LL_C
					prop_description = 'LL_C (constant, cell) is a prop constant cell.';
				case GTA_LL.LL_M
					prop_description = 'LL_M (metadata, cell) is a prop metadata cell.';
				case GTA_LL.LL_P
					prop_description = 'LL_P (parameter, cell) is a prop parameter cell.';
				case GTA_LL.LL_D
					prop_description = 'LL_D (data, cell) is a prop data cell.';
				case GTA_LL.LL_R
					prop_description = 'LL_R (result, cell) is a prop result cell.';
				case GTA_LL.LL_Q
					prop_description = 'LL_Q (query, cell) is a prop query cell.';
				case GTA_LL.LL_E
					prop_description = 'LL_E (evanescent, cell) is a prop evanescent cell.';
				case GTA_LL.LL_F
					prop_description = 'LL_F (figure, cell) is a prop figure cell.';
				case GTA_LL.LL_G
					prop_description = 'LL_G (gui, cell) is a prop gui cell.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_LL, POINTER) returns settings of POINTER of GTA_LL.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_LL, POINTER) returns settings of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop
				case GTA_LL.LL_C
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_M
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_P
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_D
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_R
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_Q
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_E
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_F
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GTA_LL.LL_G
					prop_settings = Format.getFormatSettings(Format.CELL);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_LL, POINTER) returns the default value of POINTER of GTA_LL.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_LL, POINTER) returns the default value of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop
				case GTA_LL.LL_C
					prop_default = {ones(3, 5)};
				case GTA_LL.LL_M
					prop_default = {ones(2, 3) 2*ones(3, 2) 3*ones(4, 1)};
				case GTA_LL.LL_P
					prop_default = {ones(2, 3); 2*ones(3, 2); 3*ones(4, 1)};
				case GTA_LL.LL_D
					prop_default = {1.1*ones(1, 1) 1.2*ones(1, 2); 2.1*ones(2, 1) 2.2*ones(2, 2); 3.1*ones(3, 1) 3.2*ones(3, 2)};
				case GTA_LL.LL_R
					prop_default = Format.getFormatDefault(Format.CELL, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_Q
					prop_default = Format.getFormatDefault(Format.CELL, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_E
					prop_default = Format.getFormatDefault(Format.CELL, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_F
					prop_default = {1.1*ones(1, 1) 1.2*ones(1, 2); 2.1*ones(2, 1) 2.2*ones(2, 2)};
				case GTA_LL.LL_G
					prop_default = Format.getFormatDefault(Format.CELL, GTA_LL.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_LL, POINTER) returns the conditioned default value of POINTER of GTA_LL.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_LL, POINTER) returns the conditioned default value of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_LL')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			prop_default = GTA_LL.conditioning(prop, GTA_LL.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_LL, PROP, VALUE) checks VALUE format for PROP of GTA_LL.
			%  CHECK = GT.CHECKPROP(GTA_LL, PROP, VALUE) checks VALUE format for PROP of GTA_LL.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_LL:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_LL:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_LL, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LL.
			%   Error id: €BRAPH2.STR€:GTA_LL:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_LL, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LL.
			%   Error id: €BRAPH2.STR€:GTA_LL:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_LL')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop
				case GTA_LL.LL_C % __GTA_LL.LL_C__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_M % __GTA_LL.LL_M__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_P % __GTA_LL.LL_P__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_D % __GTA_LL.LL_D__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_R % __GTA_LL.LL_R__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_Q % __GTA_LL.LL_Q__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_E % __GTA_LL.LL_E__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_F % __GTA_LL.LL_F__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				case GTA_LL.LL_G % __GTA_LL.LL_G__
					check = Format.checkFormat(Format.CELL, value, GTA_LL.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LL:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LL:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_LL.getPropTag(prop) ' (' GTA_LL.getFormatTag(GTA_LL.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
