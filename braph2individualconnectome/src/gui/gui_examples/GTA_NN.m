classdef GTA_NN < ConcreteElement
	%GTA_NN tests PanelPropScalar.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_NN tests PanelPropScalar.
	%
	% GTA_NN methods (constructor):
	%  GTA_NN - constructor
	%
	% GTA_NN methods:
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
	% GTA_NN methods (display):
	%  tostring - string with information about the test A PanelPropScalar
	%  disp - displays information about the test A PanelPropScalar
	%  tree - displays the tree of the test A PanelPropScalar
	%
	% GTA_NN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropScalar are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropScalar
	%
	% GTA_NN methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropScalar as b2 file
	%  load - loads a BRAPH2 test A PanelPropScalar from a b2 file
	%
	% GTA_NN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropScalar
	%
	% GTA_NN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropScalar
	%
	% GTA_NN methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropScalar
	%  getSubclasses - returns all subclasses of GTA_NN
	%  getProps - returns the property list of the test A PanelPropScalar
	%  getPropNumber - returns the property number of the test A PanelPropScalar
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
	% GTA_NN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_NN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_NN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_NN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_NN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_NN constants</a>.
	%
	%
	% See also PanelPropScalar.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		NN_C = ConcreteElement.getPropNumber() + 1;
		NN_C_TAG = 'NN_C';
		NN_C_CATEGORY = Category.CONSTANT;
		NN_C_FORMAT = Format.SCALAR;
		
		NN_M = ConcreteElement.getPropNumber() + 2;
		NN_M_TAG = 'NN_M';
		NN_M_CATEGORY = Category.METADATA;
		NN_M_FORMAT = Format.SCALAR;
		
		NN_P = ConcreteElement.getPropNumber() + 3;
		NN_P_TAG = 'NN_P';
		NN_P_CATEGORY = Category.PARAMETER;
		NN_P_FORMAT = Format.SCALAR;
		
		NN_D = ConcreteElement.getPropNumber() + 4;
		NN_D_TAG = 'NN_D';
		NN_D_CATEGORY = Category.DATA;
		NN_D_FORMAT = Format.SCALAR;
		
		NN_R = ConcreteElement.getPropNumber() + 5;
		NN_R_TAG = 'NN_R';
		NN_R_CATEGORY = Category.RESULT;
		NN_R_FORMAT = Format.SCALAR;
		
		NN_Q = ConcreteElement.getPropNumber() + 6;
		NN_Q_TAG = 'NN_Q';
		NN_Q_CATEGORY = Category.QUERY;
		NN_Q_FORMAT = Format.SCALAR;
		
		NN_E = ConcreteElement.getPropNumber() + 7;
		NN_E_TAG = 'NN_E';
		NN_E_CATEGORY = Category.EVANESCENT;
		NN_E_FORMAT = Format.SCALAR;
		
		NN_F = ConcreteElement.getPropNumber() + 8;
		NN_F_TAG = 'NN_F';
		NN_F_CATEGORY = Category.FIGURE;
		NN_F_FORMAT = Format.SCALAR;
		
		NN_G = ConcreteElement.getPropNumber() + 9;
		NN_G_TAG = 'NN_G';
		NN_G_CATEGORY = Category.GUI;
		NN_G_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function gt = GTA_NN(varargin)
			%GTA_NN() creates a test A PanelPropScalar.
			%
			% GTA_NN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_NN(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropScalar.
			%
			% BUILD = GTA_NN.GETBUILD() returns the build of 'GTA_NN'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropScalar GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_NN') returns the build of 'GTA_NN'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_NN')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropScalar.
			%
			% CLASS = GTA_NN.GETCLASS() returns the class 'GTA_NN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropScalar GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_NN') returns 'GTA_NN'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_NN')
			%  are less computationally efficient.
			
			gt_class = 'GTA_NN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropScalar.
			%
			% LIST = GTA_NN.GETSUBCLASSES() returns all subclasses of 'GTA_NN'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropScalar GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_NN') returns all subclasses of 'GTA_NN'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_NN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_NN', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropScalar.
			%
			% PROPS = GTA_NN.GETPROPS() returns the property list of test A PanelPropScalar
			%  as a row vector.
			%
			% PROPS = GTA_NN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropScalar GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_NN'[, CATEGORY]) returns the property list of 'GTA_NN'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_NN.NN_C ...
						GTA_NN.NN_M ...
						GTA_NN.NN_P ...
						GTA_NN.NN_D ...
						GTA_NN.NN_R ...
						GTA_NN.NN_Q ...
						GTA_NN.NN_E ...
						GTA_NN.NN_F ...
						GTA_NN.NN_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_NN.NN_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_NN.NN_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_NN.NN_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_NN.NN_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_NN.NN_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_NN.NN_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_NN.NN_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_NN.NN_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_NN.NN_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropScalar.
			%
			% N = GTA_NN.GETPROPNUMBER() returns the property number of test A PanelPropScalar.
			%
			% N = GTA_NN.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropScalar
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropScalar GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_NN') returns the property number of 'GTA_NN'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_NN.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropScalar/error.
			%
			% CHECK = GTA_NN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_NN, PROP) checks whether PROP exists for GTA_NN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSPROP(GTA_NN, PROP) throws error if PROP does NOT exist for GTA_NN.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_NN.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_NN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_NN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_NN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropScalar/error.
			%
			% CHECK = GTA_NN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_NN, TAG) checks whether TAG exists for GTA_NN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSTAG(GTA_NN, TAG) throws error if TAG does NOT exist for GTA_NN.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_nn_tag_list = cellfun(@(x) GTA_NN.getPropTag(x), num2cell(GTA_NN.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_nn_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_NN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_NN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_NN.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_NN, POINTER) returns property number of POINTER of GTA_NN.
			%  PROPERTY = GT.GETPROPPROP(GTA_NN, POINTER) returns property number of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_nn_tag_list = cellfun(@(x) GTA_NN.getPropTag(x), num2cell(GTA_NN.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_nn_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_NN, POINTER) returns tag of POINTER of GTA_NN.
			%  TAG = GT.GETPROPTAG(GTA_NN, POINTER) returns tag of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_NN.NN_C
						tag = GTA_NN.NN_C_TAG;
					case GTA_NN.NN_M
						tag = GTA_NN.NN_M_TAG;
					case GTA_NN.NN_P
						tag = GTA_NN.NN_P_TAG;
					case GTA_NN.NN_D
						tag = GTA_NN.NN_D_TAG;
					case GTA_NN.NN_R
						tag = GTA_NN.NN_R_TAG;
					case GTA_NN.NN_Q
						tag = GTA_NN.NN_Q_TAG;
					case GTA_NN.NN_E
						tag = GTA_NN.NN_E_TAG;
					case GTA_NN.NN_F
						tag = GTA_NN.NN_F_TAG;
					case GTA_NN.NN_G
						tag = GTA_NN.NN_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_NN, POINTER) returns category of POINTER of GTA_NN.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_NN, POINTER) returns category of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_NN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop
				case GTA_NN.NN_C
					prop_category = GTA_NN.NN_C_CATEGORY;
				case GTA_NN.NN_M
					prop_category = GTA_NN.NN_M_CATEGORY;
				case GTA_NN.NN_P
					prop_category = GTA_NN.NN_P_CATEGORY;
				case GTA_NN.NN_D
					prop_category = GTA_NN.NN_D_CATEGORY;
				case GTA_NN.NN_R
					prop_category = GTA_NN.NN_R_CATEGORY;
				case GTA_NN.NN_Q
					prop_category = GTA_NN.NN_Q_CATEGORY;
				case GTA_NN.NN_E
					prop_category = GTA_NN.NN_E_CATEGORY;
				case GTA_NN.NN_F
					prop_category = GTA_NN.NN_F_CATEGORY;
				case GTA_NN.NN_G
					prop_category = GTA_NN.NN_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_NN, POINTER) returns format of POINTER of GTA_NN.
			%  FORMAT = GT.GETPROPFORMAT(GTA_NN, POINTER) returns format of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_NN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop
				case GTA_NN.NN_C
					prop_format = GTA_NN.NN_C_FORMAT;
				case GTA_NN.NN_M
					prop_format = GTA_NN.NN_M_FORMAT;
				case GTA_NN.NN_P
					prop_format = GTA_NN.NN_P_FORMAT;
				case GTA_NN.NN_D
					prop_format = GTA_NN.NN_D_FORMAT;
				case GTA_NN.NN_R
					prop_format = GTA_NN.NN_R_FORMAT;
				case GTA_NN.NN_Q
					prop_format = GTA_NN.NN_Q_FORMAT;
				case GTA_NN.NN_E
					prop_format = GTA_NN.NN_E_FORMAT;
				case GTA_NN.NN_F
					prop_format = GTA_NN.NN_F_FORMAT;
				case GTA_NN.NN_G
					prop_format = GTA_NN.NN_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_NN, POINTER) returns description of POINTER of GTA_NN.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_NN, POINTER) returns description of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop
				case GTA_NN.NN_C
					prop_description = 'NN_C (constant, scalar) is a prop constant scalar.';
				case GTA_NN.NN_M
					prop_description = 'NN_M (metadata, scalar) is a prop metadata scalar.';
				case GTA_NN.NN_P
					prop_description = 'NN_P (parameter, scalar) is a prop parameter scalar.';
				case GTA_NN.NN_D
					prop_description = 'NN_D (data, scalar) is a prop data scalar.';
				case GTA_NN.NN_R
					prop_description = 'NN_R (result, scalar) is a prop result scalar.';
				case GTA_NN.NN_Q
					prop_description = 'NN_Q (query, scalar) is a prop query scalar.';
				case GTA_NN.NN_E
					prop_description = 'NN_E (evanescent, scalar) is a prop evanescent scalar.';
				case GTA_NN.NN_F
					prop_description = 'NN_F (figure, scalar) is a prop figure scalar.';
				case GTA_NN.NN_G
					prop_description = 'NN_G (gui, scalar) is a prop gui scalar.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_NN, POINTER) returns settings of POINTER of GTA_NN.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_NN, POINTER) returns settings of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop
				case GTA_NN.NN_C
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_M
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_D
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_R
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_Q
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_E
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_F
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GTA_NN.NN_G
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_NN, POINTER) returns the default value of POINTER of GTA_NN.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_NN, POINTER) returns the default value of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop
				case GTA_NN.NN_C
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_M
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_P
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_D
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_R
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_Q
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_E
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_F
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_G
					prop_default = Format.getFormatDefault(Format.SCALAR, GTA_NN.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_NN, POINTER) returns the conditioned default value of POINTER of GTA_NN.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_NN, POINTER) returns the conditioned default value of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_NN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			prop_default = GTA_NN.conditioning(prop, GTA_NN.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_NN, PROP, VALUE) checks VALUE format for PROP of GTA_NN.
			%  CHECK = GT.CHECKPROP(GTA_NN, PROP, VALUE) checks VALUE format for PROP of GTA_NN.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_NN:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_NN:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_NN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NN.
			%   Error id: €BRAPH2.STR€:GTA_NN:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_NN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NN.
			%   Error id: €BRAPH2.STR€:GTA_NN:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_NN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop
				case GTA_NN.NN_C % __GTA_NN.NN_C__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_M % __GTA_NN.NN_M__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_P % __GTA_NN.NN_P__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_D % __GTA_NN.NN_D__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_R % __GTA_NN.NN_R__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_Q % __GTA_NN.NN_Q__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_E % __GTA_NN.NN_E__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_F % __GTA_NN.NN_F__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				case GTA_NN.NN_G % __GTA_NN.NN_G__
					check = Format.checkFormat(Format.SCALAR, value, GTA_NN.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_NN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_NN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_NN.getPropTag(prop) ' (' GTA_NN.getFormatTag(GTA_NN.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
