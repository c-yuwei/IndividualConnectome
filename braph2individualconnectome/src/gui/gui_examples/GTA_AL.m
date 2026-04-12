classdef GTA_AL < ConcreteElement
	%GTA_AL tests PanelPropAlpha.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_AL tests PanelPropAlpha.
	%
	% GTA_AL methods (constructor):
	%  GTA_AL - constructor
	%
	% GTA_AL methods:
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
	% GTA_AL methods (display):
	%  tostring - string with information about the test A PanelPropAlpha
	%  disp - displays information about the test A PanelPropAlpha
	%  tree - displays the tree of the test A PanelPropAlpha
	%
	% GTA_AL methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropAlpha are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropAlpha
	%
	% GTA_AL methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropAlpha as b2 file
	%  load - loads a BRAPH2 test A PanelPropAlpha from a b2 file
	%
	% GTA_AL method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropAlpha
	%
	% GTA_AL method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropAlpha
	%
	% GTA_AL methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropAlpha
	%  getSubclasses - returns all subclasses of GTA_AL
	%  getProps - returns the property list of the test A PanelPropAlpha
	%  getPropNumber - returns the property number of the test A PanelPropAlpha
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
	% GTA_AL methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_AL methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_AL methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_AL methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_AL; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_AL constants</a>.
	%
	%
	% See also PanelPropAlpha.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		AL_C = ConcreteElement.getPropNumber() + 1;
		AL_C_TAG = 'AL_C';
		AL_C_CATEGORY = Category.CONSTANT;
		AL_C_FORMAT = Format.ALPHA;
		
		AL_M = ConcreteElement.getPropNumber() + 2;
		AL_M_TAG = 'AL_M';
		AL_M_CATEGORY = Category.METADATA;
		AL_M_FORMAT = Format.ALPHA;
		
		AL_P = ConcreteElement.getPropNumber() + 3;
		AL_P_TAG = 'AL_P';
		AL_P_CATEGORY = Category.PARAMETER;
		AL_P_FORMAT = Format.ALPHA;
		
		AL_D = ConcreteElement.getPropNumber() + 4;
		AL_D_TAG = 'AL_D';
		AL_D_CATEGORY = Category.DATA;
		AL_D_FORMAT = Format.ALPHA;
		
		AL_R = ConcreteElement.getPropNumber() + 5;
		AL_R_TAG = 'AL_R';
		AL_R_CATEGORY = Category.RESULT;
		AL_R_FORMAT = Format.ALPHA;
		
		AL_Q = ConcreteElement.getPropNumber() + 6;
		AL_Q_TAG = 'AL_Q';
		AL_Q_CATEGORY = Category.QUERY;
		AL_Q_FORMAT = Format.ALPHA;
		
		AL_E = ConcreteElement.getPropNumber() + 7;
		AL_E_TAG = 'AL_E';
		AL_E_CATEGORY = Category.EVANESCENT;
		AL_E_FORMAT = Format.ALPHA;
		
		AL_F = ConcreteElement.getPropNumber() + 8;
		AL_F_TAG = 'AL_F';
		AL_F_CATEGORY = Category.FIGURE;
		AL_F_FORMAT = Format.ALPHA;
		
		AL_G = ConcreteElement.getPropNumber() + 9;
		AL_G_TAG = 'AL_G';
		AL_G_CATEGORY = Category.GUI;
		AL_G_FORMAT = Format.ALPHA;
	end
	methods % constructor
		function gt = GTA_AL(varargin)
			%GTA_AL() creates a test A PanelPropAlpha.
			%
			% GTA_AL(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_AL(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropAlpha.
			%
			% BUILD = GTA_AL.GETBUILD() returns the build of 'GTA_AL'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropAlpha GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_AL') returns the build of 'GTA_AL'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_AL')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropAlpha.
			%
			% CLASS = GTA_AL.GETCLASS() returns the class 'GTA_AL'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropAlpha GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_AL') returns 'GTA_AL'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_AL')
			%  are less computationally efficient.
			
			gt_class = 'GTA_AL';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropAlpha.
			%
			% LIST = GTA_AL.GETSUBCLASSES() returns all subclasses of 'GTA_AL'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropAlpha GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_AL') returns all subclasses of 'GTA_AL'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_AL')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_AL', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropAlpha.
			%
			% PROPS = GTA_AL.GETPROPS() returns the property list of test A PanelPropAlpha
			%  as a row vector.
			%
			% PROPS = GTA_AL.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropAlpha GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_AL'[, CATEGORY]) returns the property list of 'GTA_AL'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_AL.AL_C ...
						GTA_AL.AL_M ...
						GTA_AL.AL_P ...
						GTA_AL.AL_D ...
						GTA_AL.AL_R ...
						GTA_AL.AL_Q ...
						GTA_AL.AL_E ...
						GTA_AL.AL_F ...
						GTA_AL.AL_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_AL.AL_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_AL.AL_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_AL.AL_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_AL.AL_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_AL.AL_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_AL.AL_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_AL.AL_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_AL.AL_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_AL.AL_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropAlpha.
			%
			% N = GTA_AL.GETPROPNUMBER() returns the property number of test A PanelPropAlpha.
			%
			% N = GTA_AL.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropAlpha
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropAlpha GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_AL') returns the property number of 'GTA_AL'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_AL.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropAlpha/error.
			%
			% CHECK = GTA_AL.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_AL, PROP) checks whether PROP exists for GTA_AL.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_AL:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_AL:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_AL:WrongInput]
			%  Element.EXISTSPROP(GTA_AL, PROP) throws error if PROP does NOT exist for GTA_AL.
			%   Error id: [BRAPH2:GTA_AL:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_AL.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_AL:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_AL:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_AL.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropAlpha/error.
			%
			% CHECK = GTA_AL.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_AL, TAG) checks whether TAG exists for GTA_AL.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_AL:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_AL:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_AL:WrongInput]
			%  Element.EXISTSTAG(GTA_AL, TAG) throws error if TAG does NOT exist for GTA_AL.
			%   Error id: [BRAPH2:GTA_AL:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_al_tag_list = cellfun(@(x) GTA_AL.getPropTag(x), num2cell(GTA_AL.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_al_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_AL:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_AL:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_AL.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_AL, POINTER) returns property number of POINTER of GTA_AL.
			%  PROPERTY = GT.GETPROPPROP(GTA_AL, POINTER) returns property number of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_al_tag_list = cellfun(@(x) GTA_AL.getPropTag(x), num2cell(GTA_AL.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_al_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_AL, POINTER) returns tag of POINTER of GTA_AL.
			%  TAG = GT.GETPROPTAG(GTA_AL, POINTER) returns tag of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_AL.AL_C
						tag = GTA_AL.AL_C_TAG;
					case GTA_AL.AL_M
						tag = GTA_AL.AL_M_TAG;
					case GTA_AL.AL_P
						tag = GTA_AL.AL_P_TAG;
					case GTA_AL.AL_D
						tag = GTA_AL.AL_D_TAG;
					case GTA_AL.AL_R
						tag = GTA_AL.AL_R_TAG;
					case GTA_AL.AL_Q
						tag = GTA_AL.AL_Q_TAG;
					case GTA_AL.AL_E
						tag = GTA_AL.AL_E_TAG;
					case GTA_AL.AL_F
						tag = GTA_AL.AL_F_TAG;
					case GTA_AL.AL_G
						tag = GTA_AL.AL_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_AL, POINTER) returns category of POINTER of GTA_AL.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_AL, POINTER) returns category of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_AL')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_AL.getPropProp(pointer);
			
			switch prop
				case GTA_AL.AL_C
					prop_category = GTA_AL.AL_C_CATEGORY;
				case GTA_AL.AL_M
					prop_category = GTA_AL.AL_M_CATEGORY;
				case GTA_AL.AL_P
					prop_category = GTA_AL.AL_P_CATEGORY;
				case GTA_AL.AL_D
					prop_category = GTA_AL.AL_D_CATEGORY;
				case GTA_AL.AL_R
					prop_category = GTA_AL.AL_R_CATEGORY;
				case GTA_AL.AL_Q
					prop_category = GTA_AL.AL_Q_CATEGORY;
				case GTA_AL.AL_E
					prop_category = GTA_AL.AL_E_CATEGORY;
				case GTA_AL.AL_F
					prop_category = GTA_AL.AL_F_CATEGORY;
				case GTA_AL.AL_G
					prop_category = GTA_AL.AL_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_AL, POINTER) returns format of POINTER of GTA_AL.
			%  FORMAT = GT.GETPROPFORMAT(GTA_AL, POINTER) returns format of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_AL')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_AL.getPropProp(pointer);
			
			switch prop
				case GTA_AL.AL_C
					prop_format = GTA_AL.AL_C_FORMAT;
				case GTA_AL.AL_M
					prop_format = GTA_AL.AL_M_FORMAT;
				case GTA_AL.AL_P
					prop_format = GTA_AL.AL_P_FORMAT;
				case GTA_AL.AL_D
					prop_format = GTA_AL.AL_D_FORMAT;
				case GTA_AL.AL_R
					prop_format = GTA_AL.AL_R_FORMAT;
				case GTA_AL.AL_Q
					prop_format = GTA_AL.AL_Q_FORMAT;
				case GTA_AL.AL_E
					prop_format = GTA_AL.AL_E_FORMAT;
				case GTA_AL.AL_F
					prop_format = GTA_AL.AL_F_FORMAT;
				case GTA_AL.AL_G
					prop_format = GTA_AL.AL_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_AL, POINTER) returns description of POINTER of GTA_AL.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_AL, POINTER) returns description of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_AL.getPropProp(pointer);
			
			switch prop
				case GTA_AL.AL_C
					prop_description = 'AL_C (constant, alpha) is a prop constant alpha.';
				case GTA_AL.AL_M
					prop_description = 'AL_M (metadata, alpha) is a prop metadata alpha.';
				case GTA_AL.AL_P
					prop_description = 'AL_P (parameter, alpha) is a prop parameter alpha.';
				case GTA_AL.AL_D
					prop_description = 'AL_D (data, alpha) is a prop data alpha.';
				case GTA_AL.AL_R
					prop_description = 'AL_R (result, alpha) is a prop result alpha.';
				case GTA_AL.AL_Q
					prop_description = 'AL_Q (query, alpha) is a prop query alpha.';
				case GTA_AL.AL_E
					prop_description = 'AL_E (evanescent, alpha) is a prop evanescent alpha.';
				case GTA_AL.AL_F
					prop_description = 'AL_F (figure, alpha) is a prop figure alpha.';
				case GTA_AL.AL_G
					prop_description = 'AL_G (gui, alpha) is a prop gui alpha.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_AL, POINTER) returns settings of POINTER of GTA_AL.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_AL, POINTER) returns settings of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_AL.getPropProp(pointer);
			
			switch prop
				case GTA_AL.AL_C
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_M
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_P
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_D
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_R
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_Q
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_E
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_F
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case GTA_AL.AL_G
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_AL.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_AL.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_AL, POINTER) returns the default value of POINTER of GTA_AL.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_AL, POINTER) returns the default value of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_AL')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_AL.getPropProp(pointer);
			
			switch prop
				case GTA_AL.AL_C
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_M
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_P
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_D
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_R
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_Q
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_E
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_F
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_G
					prop_default = Format.getFormatDefault(Format.ALPHA, GTA_AL.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_AL.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_AL.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_AL, POINTER) returns the conditioned default value of POINTER of GTA_AL.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_AL, POINTER) returns the conditioned default value of POINTER of GTA_AL.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_AL')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_AL.getPropProp(pointer);
			
			prop_default = GTA_AL.conditioning(prop, GTA_AL.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_AL, PROP, VALUE) checks VALUE format for PROP of GTA_AL.
			%  CHECK = GT.CHECKPROP(GTA_AL, PROP, VALUE) checks VALUE format for PROP of GTA_AL.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_AL:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_AL:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_AL, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_AL.
			%   Error id: €BRAPH2.STR€:GTA_AL:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_AL, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_AL.
			%   Error id: €BRAPH2.STR€:GTA_AL:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_AL')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_AL.getPropProp(pointer);
			
			switch prop
				case GTA_AL.AL_C % __GTA_AL.AL_C__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_M % __GTA_AL.AL_M__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_P % __GTA_AL.AL_P__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_D % __GTA_AL.AL_D__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_R % __GTA_AL.AL_R__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_Q % __GTA_AL.AL_Q__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_E % __GTA_AL.AL_E__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_F % __GTA_AL.AL_F__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				case GTA_AL.AL_G % __GTA_AL.AL_G__
					check = Format.checkFormat(Format.ALPHA, value, GTA_AL.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_AL:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_AL:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_AL.getPropTag(prop) ' (' GTA_AL.getFormatTag(GTA_AL.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
