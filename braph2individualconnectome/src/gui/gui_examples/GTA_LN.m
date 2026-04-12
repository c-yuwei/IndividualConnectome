classdef GTA_LN < ConcreteElement
	%GTA_LN tests PanelPropLine.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_LN tests PanelPropLine.
	%
	% GTA_LN methods (constructor):
	%  GTA_LN - constructor
	%
	% GTA_LN methods:
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
	% GTA_LN methods (display):
	%  tostring - string with information about the test A PanelPropLine
	%  disp - displays information about the test A PanelPropLine
	%  tree - displays the tree of the test A PanelPropLine
	%
	% GTA_LN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropLine are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropLine
	%
	% GTA_LN methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropLine as b2 file
	%  load - loads a BRAPH2 test A PanelPropLine from a b2 file
	%
	% GTA_LN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropLine
	%
	% GTA_LN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropLine
	%
	% GTA_LN methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropLine
	%  getSubclasses - returns all subclasses of GTA_LN
	%  getProps - returns the property list of the test A PanelPropLine
	%  getPropNumber - returns the property number of the test A PanelPropLine
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
	% GTA_LN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_LN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_LN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_LN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_LN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_LN constants</a>.
	%
	%
	% See also PanelPropLine.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		LN_C = ConcreteElement.getPropNumber() + 1;
		LN_C_TAG = 'LN_C';
		LN_C_CATEGORY = Category.CONSTANT;
		LN_C_FORMAT = Format.LINE;
		
		LN_M = ConcreteElement.getPropNumber() + 2;
		LN_M_TAG = 'LN_M';
		LN_M_CATEGORY = Category.METADATA;
		LN_M_FORMAT = Format.LINE;
		
		LN_P = ConcreteElement.getPropNumber() + 3;
		LN_P_TAG = 'LN_P';
		LN_P_CATEGORY = Category.PARAMETER;
		LN_P_FORMAT = Format.LINE;
		
		LN_D = ConcreteElement.getPropNumber() + 4;
		LN_D_TAG = 'LN_D';
		LN_D_CATEGORY = Category.DATA;
		LN_D_FORMAT = Format.LINE;
		
		LN_R = ConcreteElement.getPropNumber() + 5;
		LN_R_TAG = 'LN_R';
		LN_R_CATEGORY = Category.RESULT;
		LN_R_FORMAT = Format.LINE;
		
		LN_Q = ConcreteElement.getPropNumber() + 6;
		LN_Q_TAG = 'LN_Q';
		LN_Q_CATEGORY = Category.QUERY;
		LN_Q_FORMAT = Format.LINE;
		
		LN_E = ConcreteElement.getPropNumber() + 7;
		LN_E_TAG = 'LN_E';
		LN_E_CATEGORY = Category.EVANESCENT;
		LN_E_FORMAT = Format.LINE;
		
		LN_F = ConcreteElement.getPropNumber() + 8;
		LN_F_TAG = 'LN_F';
		LN_F_CATEGORY = Category.FIGURE;
		LN_F_FORMAT = Format.LINE;
		
		LN_G = ConcreteElement.getPropNumber() + 9;
		LN_G_TAG = 'LN_G';
		LN_G_CATEGORY = Category.GUI;
		LN_G_FORMAT = Format.LINE;
	end
	methods % constructor
		function gt = GTA_LN(varargin)
			%GTA_LN() creates a test A PanelPropLine.
			%
			% GTA_LN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_LN(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropLine.
			%
			% BUILD = GTA_LN.GETBUILD() returns the build of 'GTA_LN'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropLine GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_LN') returns the build of 'GTA_LN'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_LN')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropLine.
			%
			% CLASS = GTA_LN.GETCLASS() returns the class 'GTA_LN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropLine GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_LN') returns 'GTA_LN'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_LN')
			%  are less computationally efficient.
			
			gt_class = 'GTA_LN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropLine.
			%
			% LIST = GTA_LN.GETSUBCLASSES() returns all subclasses of 'GTA_LN'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropLine GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_LN') returns all subclasses of 'GTA_LN'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_LN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_LN', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropLine.
			%
			% PROPS = GTA_LN.GETPROPS() returns the property list of test A PanelPropLine
			%  as a row vector.
			%
			% PROPS = GTA_LN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropLine GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_LN'[, CATEGORY]) returns the property list of 'GTA_LN'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_LN.LN_C ...
						GTA_LN.LN_M ...
						GTA_LN.LN_P ...
						GTA_LN.LN_D ...
						GTA_LN.LN_R ...
						GTA_LN.LN_Q ...
						GTA_LN.LN_E ...
						GTA_LN.LN_F ...
						GTA_LN.LN_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_LN.LN_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_LN.LN_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_LN.LN_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_LN.LN_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_LN.LN_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_LN.LN_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_LN.LN_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_LN.LN_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_LN.LN_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropLine.
			%
			% N = GTA_LN.GETPROPNUMBER() returns the property number of test A PanelPropLine.
			%
			% N = GTA_LN.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropLine
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropLine GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_LN') returns the property number of 'GTA_LN'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_LN.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropLine/error.
			%
			% CHECK = GTA_LN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_LN, PROP) checks whether PROP exists for GTA_LN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSPROP(GTA_LN, PROP) throws error if PROP does NOT exist for GTA_LN.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_LN.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_LN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropLine/error.
			%
			% CHECK = GTA_LN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_LN, TAG) checks whether TAG exists for GTA_LN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSTAG(GTA_LN, TAG) throws error if TAG does NOT exist for GTA_LN.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_ln_tag_list = cellfun(@(x) GTA_LN.getPropTag(x), num2cell(GTA_LN.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_ln_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_LN.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_LN, POINTER) returns property number of POINTER of GTA_LN.
			%  PROPERTY = GT.GETPROPPROP(GTA_LN, POINTER) returns property number of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_ln_tag_list = cellfun(@(x) GTA_LN.getPropTag(x), num2cell(GTA_LN.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_ln_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_LN, POINTER) returns tag of POINTER of GTA_LN.
			%  TAG = GT.GETPROPTAG(GTA_LN, POINTER) returns tag of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_LN.LN_C
						tag = GTA_LN.LN_C_TAG;
					case GTA_LN.LN_M
						tag = GTA_LN.LN_M_TAG;
					case GTA_LN.LN_P
						tag = GTA_LN.LN_P_TAG;
					case GTA_LN.LN_D
						tag = GTA_LN.LN_D_TAG;
					case GTA_LN.LN_R
						tag = GTA_LN.LN_R_TAG;
					case GTA_LN.LN_Q
						tag = GTA_LN.LN_Q_TAG;
					case GTA_LN.LN_E
						tag = GTA_LN.LN_E_TAG;
					case GTA_LN.LN_F
						tag = GTA_LN.LN_F_TAG;
					case GTA_LN.LN_G
						tag = GTA_LN.LN_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_LN, POINTER) returns category of POINTER of GTA_LN.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_LN, POINTER) returns category of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_LN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop
				case GTA_LN.LN_C
					prop_category = GTA_LN.LN_C_CATEGORY;
				case GTA_LN.LN_M
					prop_category = GTA_LN.LN_M_CATEGORY;
				case GTA_LN.LN_P
					prop_category = GTA_LN.LN_P_CATEGORY;
				case GTA_LN.LN_D
					prop_category = GTA_LN.LN_D_CATEGORY;
				case GTA_LN.LN_R
					prop_category = GTA_LN.LN_R_CATEGORY;
				case GTA_LN.LN_Q
					prop_category = GTA_LN.LN_Q_CATEGORY;
				case GTA_LN.LN_E
					prop_category = GTA_LN.LN_E_CATEGORY;
				case GTA_LN.LN_F
					prop_category = GTA_LN.LN_F_CATEGORY;
				case GTA_LN.LN_G
					prop_category = GTA_LN.LN_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_LN, POINTER) returns format of POINTER of GTA_LN.
			%  FORMAT = GT.GETPROPFORMAT(GTA_LN, POINTER) returns format of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_LN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop
				case GTA_LN.LN_C
					prop_format = GTA_LN.LN_C_FORMAT;
				case GTA_LN.LN_M
					prop_format = GTA_LN.LN_M_FORMAT;
				case GTA_LN.LN_P
					prop_format = GTA_LN.LN_P_FORMAT;
				case GTA_LN.LN_D
					prop_format = GTA_LN.LN_D_FORMAT;
				case GTA_LN.LN_R
					prop_format = GTA_LN.LN_R_FORMAT;
				case GTA_LN.LN_Q
					prop_format = GTA_LN.LN_Q_FORMAT;
				case GTA_LN.LN_E
					prop_format = GTA_LN.LN_E_FORMAT;
				case GTA_LN.LN_F
					prop_format = GTA_LN.LN_F_FORMAT;
				case GTA_LN.LN_G
					prop_format = GTA_LN.LN_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_LN, POINTER) returns description of POINTER of GTA_LN.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_LN, POINTER) returns description of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop
				case GTA_LN.LN_C
					prop_description = 'LN_C (constant, line) is a prop constant line.';
				case GTA_LN.LN_M
					prop_description = 'LN_M (metadata, line) is a prop metadata line.';
				case GTA_LN.LN_P
					prop_description = 'LN_P (parameter, line) is a prop parameter line.';
				case GTA_LN.LN_D
					prop_description = 'LN_D (data, line) is a prop data line.';
				case GTA_LN.LN_R
					prop_description = 'LN_R (result, line) is a prop result line.';
				case GTA_LN.LN_Q
					prop_description = 'LN_Q (query, line) is a prop query line.';
				case GTA_LN.LN_E
					prop_description = 'LN_E (evanescent, line) is a prop evanescent line.';
				case GTA_LN.LN_F
					prop_description = 'LN_F (figure, line) is a prop figure line.';
				case GTA_LN.LN_G
					prop_description = 'LN_G (gui, line) is a prop gui line.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_LN, POINTER) returns settings of POINTER of GTA_LN.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_LN, POINTER) returns settings of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop
				case GTA_LN.LN_C
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_M
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_P
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_D
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_R
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_Q
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_E
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_F
					prop_settings = Format.getFormatSettings(Format.LINE);
				case GTA_LN.LN_G
					prop_settings = Format.getFormatSettings(Format.LINE);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_LN, POINTER) returns the default value of POINTER of GTA_LN.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_LN, POINTER) returns the default value of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop
				case GTA_LN.LN_C
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_M
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_P
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_D
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_R
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_Q
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_E
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_F
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_G
					prop_default = Format.getFormatDefault(Format.LINE, GTA_LN.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_LN, POINTER) returns the conditioned default value of POINTER of GTA_LN.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_LN, POINTER) returns the conditioned default value of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_LN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			prop_default = GTA_LN.conditioning(prop, GTA_LN.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_LN, PROP, VALUE) checks VALUE format for PROP of GTA_LN.
			%  CHECK = GT.CHECKPROP(GTA_LN, PROP, VALUE) checks VALUE format for PROP of GTA_LN.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_LN:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_LN:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_LN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LN.
			%   Error id: €BRAPH2.STR€:GTA_LN:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_LN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LN.
			%   Error id: €BRAPH2.STR€:GTA_LN:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_LN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop
				case GTA_LN.LN_C % __GTA_LN.LN_C__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_M % __GTA_LN.LN_M__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_P % __GTA_LN.LN_P__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_D % __GTA_LN.LN_D__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_R % __GTA_LN.LN_R__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_Q % __GTA_LN.LN_Q__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_E % __GTA_LN.LN_E__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_F % __GTA_LN.LN_F__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				case GTA_LN.LN_G % __GTA_LN.LN_G__
					check = Format.checkFormat(Format.LINE, value, GTA_LN.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_LN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_LN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_LN.getPropTag(prop) ' (' GTA_LN.getFormatTag(GTA_LN.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
