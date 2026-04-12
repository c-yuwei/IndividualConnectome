classdef GTA_MR < ConcreteElement
	%GTA_MR tests PanelPropMarker.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_MR tests PanelPropMarker.
	%
	% GTA_MR methods (constructor):
	%  GTA_MR - constructor
	%
	% GTA_MR methods:
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
	% GTA_MR methods (display):
	%  tostring - string with information about the test A PanelPropMarker
	%  disp - displays information about the test A PanelPropMarker
	%  tree - displays the tree of the test A PanelPropMarker
	%
	% GTA_MR methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropMarker are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropMarker
	%
	% GTA_MR methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropMarker as b2 file
	%  load - loads a BRAPH2 test A PanelPropMarker from a b2 file
	%
	% GTA_MR method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropMarker
	%
	% GTA_MR method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropMarker
	%
	% GTA_MR methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropMarker
	%  getSubclasses - returns all subclasses of GTA_MR
	%  getProps - returns the property list of the test A PanelPropMarker
	%  getPropNumber - returns the property number of the test A PanelPropMarker
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
	% GTA_MR methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_MR methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_MR methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_MR methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_MR; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_MR constants</a>.
	%
	%
	% See also PanelPropMarker.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		MR_C = ConcreteElement.getPropNumber() + 1;
		MR_C_TAG = 'MR_C';
		MR_C_CATEGORY = Category.CONSTANT;
		MR_C_FORMAT = Format.MARKER;
		
		MR_M = ConcreteElement.getPropNumber() + 2;
		MR_M_TAG = 'MR_M';
		MR_M_CATEGORY = Category.METADATA;
		MR_M_FORMAT = Format.MARKER;
		
		MR_P = ConcreteElement.getPropNumber() + 3;
		MR_P_TAG = 'MR_P';
		MR_P_CATEGORY = Category.PARAMETER;
		MR_P_FORMAT = Format.MARKER;
		
		MR_D = ConcreteElement.getPropNumber() + 4;
		MR_D_TAG = 'MR_D';
		MR_D_CATEGORY = Category.DATA;
		MR_D_FORMAT = Format.MARKER;
		
		MR_R = ConcreteElement.getPropNumber() + 5;
		MR_R_TAG = 'MR_R';
		MR_R_CATEGORY = Category.RESULT;
		MR_R_FORMAT = Format.MARKER;
		
		MR_Q = ConcreteElement.getPropNumber() + 6;
		MR_Q_TAG = 'MR_Q';
		MR_Q_CATEGORY = Category.QUERY;
		MR_Q_FORMAT = Format.MARKER;
		
		MR_E = ConcreteElement.getPropNumber() + 7;
		MR_E_TAG = 'MR_E';
		MR_E_CATEGORY = Category.EVANESCENT;
		MR_E_FORMAT = Format.MARKER;
		
		MR_F = ConcreteElement.getPropNumber() + 8;
		MR_F_TAG = 'MR_F';
		MR_F_CATEGORY = Category.FIGURE;
		MR_F_FORMAT = Format.MARKER;
		
		MR_G = ConcreteElement.getPropNumber() + 9;
		MR_G_TAG = 'MR_G';
		MR_G_CATEGORY = Category.GUI;
		MR_G_FORMAT = Format.MARKER;
	end
	methods % constructor
		function gt = GTA_MR(varargin)
			%GTA_MR() creates a test A PanelPropMarker.
			%
			% GTA_MR(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_MR(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropMarker.
			%
			% BUILD = GTA_MR.GETBUILD() returns the build of 'GTA_MR'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropMarker GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_MR') returns the build of 'GTA_MR'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_MR')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropMarker.
			%
			% CLASS = GTA_MR.GETCLASS() returns the class 'GTA_MR'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropMarker GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_MR') returns 'GTA_MR'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_MR')
			%  are less computationally efficient.
			
			gt_class = 'GTA_MR';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropMarker.
			%
			% LIST = GTA_MR.GETSUBCLASSES() returns all subclasses of 'GTA_MR'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropMarker GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_MR') returns all subclasses of 'GTA_MR'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_MR')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_MR', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropMarker.
			%
			% PROPS = GTA_MR.GETPROPS() returns the property list of test A PanelPropMarker
			%  as a row vector.
			%
			% PROPS = GTA_MR.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropMarker GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_MR'[, CATEGORY]) returns the property list of 'GTA_MR'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_MR.MR_C ...
						GTA_MR.MR_M ...
						GTA_MR.MR_P ...
						GTA_MR.MR_D ...
						GTA_MR.MR_R ...
						GTA_MR.MR_Q ...
						GTA_MR.MR_E ...
						GTA_MR.MR_F ...
						GTA_MR.MR_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_MR.MR_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_MR.MR_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_MR.MR_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_MR.MR_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_MR.MR_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_MR.MR_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_MR.MR_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_MR.MR_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_MR.MR_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropMarker.
			%
			% N = GTA_MR.GETPROPNUMBER() returns the property number of test A PanelPropMarker.
			%
			% N = GTA_MR.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropMarker
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropMarker GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_MR') returns the property number of 'GTA_MR'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_MR.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropMarker/error.
			%
			% CHECK = GTA_MR.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_MR, PROP) checks whether PROP exists for GTA_MR.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSPROP(GTA_MR, PROP) throws error if PROP does NOT exist for GTA_MR.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_MR.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_MR:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_MR:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_MR.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropMarker/error.
			%
			% CHECK = GTA_MR.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_MR, TAG) checks whether TAG exists for GTA_MR.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSTAG(GTA_MR, TAG) throws error if TAG does NOT exist for GTA_MR.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_mr_tag_list = cellfun(@(x) GTA_MR.getPropTag(x), num2cell(GTA_MR.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_mr_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_MR:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_MR:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_MR.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_MR, POINTER) returns property number of POINTER of GTA_MR.
			%  PROPERTY = GT.GETPROPPROP(GTA_MR, POINTER) returns property number of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_mr_tag_list = cellfun(@(x) GTA_MR.getPropTag(x), num2cell(GTA_MR.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_mr_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_MR, POINTER) returns tag of POINTER of GTA_MR.
			%  TAG = GT.GETPROPTAG(GTA_MR, POINTER) returns tag of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_MR.MR_C
						tag = GTA_MR.MR_C_TAG;
					case GTA_MR.MR_M
						tag = GTA_MR.MR_M_TAG;
					case GTA_MR.MR_P
						tag = GTA_MR.MR_P_TAG;
					case GTA_MR.MR_D
						tag = GTA_MR.MR_D_TAG;
					case GTA_MR.MR_R
						tag = GTA_MR.MR_R_TAG;
					case GTA_MR.MR_Q
						tag = GTA_MR.MR_Q_TAG;
					case GTA_MR.MR_E
						tag = GTA_MR.MR_E_TAG;
					case GTA_MR.MR_F
						tag = GTA_MR.MR_F_TAG;
					case GTA_MR.MR_G
						tag = GTA_MR.MR_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_MR, POINTER) returns category of POINTER of GTA_MR.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_MR, POINTER) returns category of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_MR')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop
				case GTA_MR.MR_C
					prop_category = GTA_MR.MR_C_CATEGORY;
				case GTA_MR.MR_M
					prop_category = GTA_MR.MR_M_CATEGORY;
				case GTA_MR.MR_P
					prop_category = GTA_MR.MR_P_CATEGORY;
				case GTA_MR.MR_D
					prop_category = GTA_MR.MR_D_CATEGORY;
				case GTA_MR.MR_R
					prop_category = GTA_MR.MR_R_CATEGORY;
				case GTA_MR.MR_Q
					prop_category = GTA_MR.MR_Q_CATEGORY;
				case GTA_MR.MR_E
					prop_category = GTA_MR.MR_E_CATEGORY;
				case GTA_MR.MR_F
					prop_category = GTA_MR.MR_F_CATEGORY;
				case GTA_MR.MR_G
					prop_category = GTA_MR.MR_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_MR, POINTER) returns format of POINTER of GTA_MR.
			%  FORMAT = GT.GETPROPFORMAT(GTA_MR, POINTER) returns format of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_MR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop
				case GTA_MR.MR_C
					prop_format = GTA_MR.MR_C_FORMAT;
				case GTA_MR.MR_M
					prop_format = GTA_MR.MR_M_FORMAT;
				case GTA_MR.MR_P
					prop_format = GTA_MR.MR_P_FORMAT;
				case GTA_MR.MR_D
					prop_format = GTA_MR.MR_D_FORMAT;
				case GTA_MR.MR_R
					prop_format = GTA_MR.MR_R_FORMAT;
				case GTA_MR.MR_Q
					prop_format = GTA_MR.MR_Q_FORMAT;
				case GTA_MR.MR_E
					prop_format = GTA_MR.MR_E_FORMAT;
				case GTA_MR.MR_F
					prop_format = GTA_MR.MR_F_FORMAT;
				case GTA_MR.MR_G
					prop_format = GTA_MR.MR_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_MR, POINTER) returns description of POINTER of GTA_MR.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_MR, POINTER) returns description of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop
				case GTA_MR.MR_C
					prop_description = 'MR_C (constant, marker) is a prop constant marker.';
				case GTA_MR.MR_M
					prop_description = 'MR_M (metadata, marker) is a prop metadata marker.';
				case GTA_MR.MR_P
					prop_description = 'MR_P (parameter, marker) is a prop parameter marker.';
				case GTA_MR.MR_D
					prop_description = 'MR_D (data, marker) is a prop data marker.';
				case GTA_MR.MR_R
					prop_description = 'MR_R (result, marker) is a prop result marker.';
				case GTA_MR.MR_Q
					prop_description = 'MR_Q (query, marker) is a prop query marker.';
				case GTA_MR.MR_E
					prop_description = 'MR_E (evanescent, marker) is a prop evanescent marker.';
				case GTA_MR.MR_F
					prop_description = 'MR_F (figure, marker) is a prop figure marker.';
				case GTA_MR.MR_G
					prop_description = 'MR_G (gui, marker) is a prop gui marker.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_MR, POINTER) returns settings of POINTER of GTA_MR.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_MR, POINTER) returns settings of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop
				case GTA_MR.MR_C
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_M
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_P
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_D
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_R
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_Q
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_E
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_F
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case GTA_MR.MR_G
					prop_settings = Format.getFormatSettings(Format.MARKER);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_MR, POINTER) returns the default value of POINTER of GTA_MR.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_MR, POINTER) returns the default value of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop
				case GTA_MR.MR_C
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_M
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_P
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_D
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_R
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_Q
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_E
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_F
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_G
					prop_default = Format.getFormatDefault(Format.MARKER, GTA_MR.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_MR, POINTER) returns the conditioned default value of POINTER of GTA_MR.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_MR, POINTER) returns the conditioned default value of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_MR')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			prop_default = GTA_MR.conditioning(prop, GTA_MR.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_MR, PROP, VALUE) checks VALUE format for PROP of GTA_MR.
			%  CHECK = GT.CHECKPROP(GTA_MR, PROP, VALUE) checks VALUE format for PROP of GTA_MR.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_MR:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_MR:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_MR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_MR.
			%   Error id: €BRAPH2.STR€:GTA_MR:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_MR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_MR.
			%   Error id: €BRAPH2.STR€:GTA_MR:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_MR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop
				case GTA_MR.MR_C % __GTA_MR.MR_C__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_M % __GTA_MR.MR_M__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_P % __GTA_MR.MR_P__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_D % __GTA_MR.MR_D__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_R % __GTA_MR.MR_R__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_Q % __GTA_MR.MR_Q__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_E % __GTA_MR.MR_E__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_F % __GTA_MR.MR_F__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				case GTA_MR.MR_G % __GTA_MR.MR_G__
					check = Format.checkFormat(Format.MARKER, value, GTA_MR.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_MR:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_MR:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_MR.getPropTag(prop) ' (' GTA_MR.getFormatTag(GTA_MR.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
