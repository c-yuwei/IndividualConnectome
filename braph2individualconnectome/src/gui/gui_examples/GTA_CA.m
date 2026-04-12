classdef GTA_CA < ConcreteElement
	%GTA_CA tests PanelPropClass.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_CA tests PanelPropClass.
	%
	% GTA_CA methods (constructor):
	%  GTA_CA - constructor
	%
	% GTA_CA methods:
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
	% GTA_CA methods (display):
	%  tostring - string with information about the test A PanelPropClass
	%  disp - displays information about the test A PanelPropClass
	%  tree - displays the tree of the test A PanelPropClass
	%
	% GTA_CA methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropClass are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropClass
	%
	% GTA_CA methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropClass as b2 file
	%  load - loads a BRAPH2 test A PanelPropClass from a b2 file
	%
	% GTA_CA method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropClass
	%
	% GTA_CA method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropClass
	%
	% GTA_CA methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropClass
	%  getSubclasses - returns all subclasses of GTA_CA
	%  getProps - returns the property list of the test A PanelPropClass
	%  getPropNumber - returns the property number of the test A PanelPropClass
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
	% GTA_CA methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_CA methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_CA methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_CA methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_CA; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_CA constants</a>.
	%
	%
	% See also PanelPropClass.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		CA_C = ConcreteElement.getPropNumber() + 1;
		CA_C_TAG = 'CA_C';
		CA_C_CATEGORY = Category.CONSTANT;
		CA_C_FORMAT = Format.CLASS;
		
		CA_M = ConcreteElement.getPropNumber() + 2;
		CA_M_TAG = 'CA_M';
		CA_M_CATEGORY = Category.METADATA;
		CA_M_FORMAT = Format.CLASS;
		
		CA_P = ConcreteElement.getPropNumber() + 3;
		CA_P_TAG = 'CA_P';
		CA_P_CATEGORY = Category.PARAMETER;
		CA_P_FORMAT = Format.CLASS;
		
		CA_D = ConcreteElement.getPropNumber() + 4;
		CA_D_TAG = 'CA_D';
		CA_D_CATEGORY = Category.DATA;
		CA_D_FORMAT = Format.CLASS;
		
		CA_R = ConcreteElement.getPropNumber() + 5;
		CA_R_TAG = 'CA_R';
		CA_R_CATEGORY = Category.RESULT;
		CA_R_FORMAT = Format.CLASS;
		
		CA_Q = ConcreteElement.getPropNumber() + 6;
		CA_Q_TAG = 'CA_Q';
		CA_Q_CATEGORY = Category.QUERY;
		CA_Q_FORMAT = Format.CLASS;
		
		CA_E = ConcreteElement.getPropNumber() + 7;
		CA_E_TAG = 'CA_E';
		CA_E_CATEGORY = Category.EVANESCENT;
		CA_E_FORMAT = Format.CLASS;
		
		CA_F = ConcreteElement.getPropNumber() + 8;
		CA_F_TAG = 'CA_F';
		CA_F_CATEGORY = Category.FIGURE;
		CA_F_FORMAT = Format.CLASS;
		
		CA_G = ConcreteElement.getPropNumber() + 9;
		CA_G_TAG = 'CA_G';
		CA_G_CATEGORY = Category.GUI;
		CA_G_FORMAT = Format.CLASS;
	end
	methods % constructor
		function gt = GTA_CA(varargin)
			%GTA_CA() creates a test A PanelPropClass.
			%
			% GTA_CA(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_CA(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropClass.
			%
			% BUILD = GTA_CA.GETBUILD() returns the build of 'GTA_CA'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropClass GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_CA') returns the build of 'GTA_CA'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_CA')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropClass.
			%
			% CLASS = GTA_CA.GETCLASS() returns the class 'GTA_CA'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropClass GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_CA') returns 'GTA_CA'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_CA')
			%  are less computationally efficient.
			
			gt_class = 'GTA_CA';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropClass.
			%
			% LIST = GTA_CA.GETSUBCLASSES() returns all subclasses of 'GTA_CA'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropClass GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_CA') returns all subclasses of 'GTA_CA'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_CA')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_CA', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropClass.
			%
			% PROPS = GTA_CA.GETPROPS() returns the property list of test A PanelPropClass
			%  as a row vector.
			%
			% PROPS = GTA_CA.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropClass GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_CA'[, CATEGORY]) returns the property list of 'GTA_CA'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_CA.CA_C ...
						GTA_CA.CA_M ...
						GTA_CA.CA_P ...
						GTA_CA.CA_D ...
						GTA_CA.CA_R ...
						GTA_CA.CA_Q ...
						GTA_CA.CA_E ...
						GTA_CA.CA_F ...
						GTA_CA.CA_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_CA.CA_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_CA.CA_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_CA.CA_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_CA.CA_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_CA.CA_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_CA.CA_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_CA.CA_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_CA.CA_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_CA.CA_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropClass.
			%
			% N = GTA_CA.GETPROPNUMBER() returns the property number of test A PanelPropClass.
			%
			% N = GTA_CA.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropClass
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropClass GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_CA') returns the property number of 'GTA_CA'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_CA.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropClass/error.
			%
			% CHECK = GTA_CA.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_CA, PROP) checks whether PROP exists for GTA_CA.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_CA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CA:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CA:WrongInput]
			%  Element.EXISTSPROP(GTA_CA, PROP) throws error if PROP does NOT exist for GTA_CA.
			%   Error id: [BRAPH2:GTA_CA:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_CA.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_CA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_CA:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_CA.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropClass/error.
			%
			% CHECK = GTA_CA.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_CA, TAG) checks whether TAG exists for GTA_CA.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_CA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CA:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_CA:WrongInput]
			%  Element.EXISTSTAG(GTA_CA, TAG) throws error if TAG does NOT exist for GTA_CA.
			%   Error id: [BRAPH2:GTA_CA:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_ca_tag_list = cellfun(@(x) GTA_CA.getPropTag(x), num2cell(GTA_CA.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_ca_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_CA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_CA:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_CA.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_CA, POINTER) returns property number of POINTER of GTA_CA.
			%  PROPERTY = GT.GETPROPPROP(GTA_CA, POINTER) returns property number of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_ca_tag_list = cellfun(@(x) GTA_CA.getPropTag(x), num2cell(GTA_CA.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_ca_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_CA, POINTER) returns tag of POINTER of GTA_CA.
			%  TAG = GT.GETPROPTAG(GTA_CA, POINTER) returns tag of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_CA.CA_C
						tag = GTA_CA.CA_C_TAG;
					case GTA_CA.CA_M
						tag = GTA_CA.CA_M_TAG;
					case GTA_CA.CA_P
						tag = GTA_CA.CA_P_TAG;
					case GTA_CA.CA_D
						tag = GTA_CA.CA_D_TAG;
					case GTA_CA.CA_R
						tag = GTA_CA.CA_R_TAG;
					case GTA_CA.CA_Q
						tag = GTA_CA.CA_Q_TAG;
					case GTA_CA.CA_E
						tag = GTA_CA.CA_E_TAG;
					case GTA_CA.CA_F
						tag = GTA_CA.CA_F_TAG;
					case GTA_CA.CA_G
						tag = GTA_CA.CA_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_CA, POINTER) returns category of POINTER of GTA_CA.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_CA, POINTER) returns category of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_CA')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_CA.getPropProp(pointer);
			
			switch prop
				case GTA_CA.CA_C
					prop_category = GTA_CA.CA_C_CATEGORY;
				case GTA_CA.CA_M
					prop_category = GTA_CA.CA_M_CATEGORY;
				case GTA_CA.CA_P
					prop_category = GTA_CA.CA_P_CATEGORY;
				case GTA_CA.CA_D
					prop_category = GTA_CA.CA_D_CATEGORY;
				case GTA_CA.CA_R
					prop_category = GTA_CA.CA_R_CATEGORY;
				case GTA_CA.CA_Q
					prop_category = GTA_CA.CA_Q_CATEGORY;
				case GTA_CA.CA_E
					prop_category = GTA_CA.CA_E_CATEGORY;
				case GTA_CA.CA_F
					prop_category = GTA_CA.CA_F_CATEGORY;
				case GTA_CA.CA_G
					prop_category = GTA_CA.CA_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_CA, POINTER) returns format of POINTER of GTA_CA.
			%  FORMAT = GT.GETPROPFORMAT(GTA_CA, POINTER) returns format of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_CA')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_CA.getPropProp(pointer);
			
			switch prop
				case GTA_CA.CA_C
					prop_format = GTA_CA.CA_C_FORMAT;
				case GTA_CA.CA_M
					prop_format = GTA_CA.CA_M_FORMAT;
				case GTA_CA.CA_P
					prop_format = GTA_CA.CA_P_FORMAT;
				case GTA_CA.CA_D
					prop_format = GTA_CA.CA_D_FORMAT;
				case GTA_CA.CA_R
					prop_format = GTA_CA.CA_R_FORMAT;
				case GTA_CA.CA_Q
					prop_format = GTA_CA.CA_Q_FORMAT;
				case GTA_CA.CA_E
					prop_format = GTA_CA.CA_E_FORMAT;
				case GTA_CA.CA_F
					prop_format = GTA_CA.CA_F_FORMAT;
				case GTA_CA.CA_G
					prop_format = GTA_CA.CA_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_CA, POINTER) returns description of POINTER of GTA_CA.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_CA, POINTER) returns description of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_CA.getPropProp(pointer);
			
			switch prop
				case GTA_CA.CA_C
					prop_description = 'CA_C (constant, class) is a prop constant class.';
				case GTA_CA.CA_M
					prop_description = 'CA_M (metadata, class) is a prop metadata class.';
				case GTA_CA.CA_P
					prop_description = 'CA_P (parameter, class) is a prop parameter class.';
				case GTA_CA.CA_D
					prop_description = 'CA_D (data, class) is a prop data class.';
				case GTA_CA.CA_R
					prop_description = 'CA_R (result, class) is a prop result class.';
				case GTA_CA.CA_Q
					prop_description = 'CA_Q (query, class) is a prop query class.';
				case GTA_CA.CA_E
					prop_description = 'CA_E (evanescent, class) is a prop evanescent class.';
				case GTA_CA.CA_F
					prop_description = 'CA_F (figure, class) is a prop figure class.';
				case GTA_CA.CA_G
					prop_description = 'CA_G (gui, class) is a prop gui class.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_CA, POINTER) returns settings of POINTER of GTA_CA.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_CA, POINTER) returns settings of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_CA.getPropProp(pointer);
			
			switch prop
				case GTA_CA.CA_C
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_M
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_P
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_D
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_R
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_Q
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_E
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_F
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GTA_CA.CA_G
					prop_settings = Format.getFormatSettings(Format.CLASS);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_CA.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_CA.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_CA, POINTER) returns the default value of POINTER of GTA_CA.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_CA, POINTER) returns the default value of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_CA')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_CA.getPropProp(pointer);
			
			switch prop
				case GTA_CA.CA_C
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_M
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_P
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_D
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_R
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_Q
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_E
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_F
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_G
					prop_default = Format.getFormatDefault(Format.CLASS, GTA_CA.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_CA.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_CA.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_CA, POINTER) returns the conditioned default value of POINTER of GTA_CA.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_CA, POINTER) returns the conditioned default value of POINTER of GTA_CA.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_CA')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_CA.getPropProp(pointer);
			
			prop_default = GTA_CA.conditioning(prop, GTA_CA.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_CA, PROP, VALUE) checks VALUE format for PROP of GTA_CA.
			%  CHECK = GT.CHECKPROP(GTA_CA, PROP, VALUE) checks VALUE format for PROP of GTA_CA.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_CA:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_CA:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_CA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_CA.
			%   Error id: €BRAPH2.STR€:GTA_CA:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_CA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_CA.
			%   Error id: €BRAPH2.STR€:GTA_CA:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_CA')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_CA.getPropProp(pointer);
			
			switch prop
				case GTA_CA.CA_C % __GTA_CA.CA_C__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_M % __GTA_CA.CA_M__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_P % __GTA_CA.CA_P__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_D % __GTA_CA.CA_D__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_R % __GTA_CA.CA_R__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_Q % __GTA_CA.CA_Q__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_E % __GTA_CA.CA_E__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_F % __GTA_CA.CA_F__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				case GTA_CA.CA_G % __GTA_CA.CA_G__
					check = Format.checkFormat(Format.CLASS, value, GTA_CA.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_CA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_CA:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_CA.getPropTag(prop) ' (' GTA_CA.getFormatTag(GTA_CA.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
