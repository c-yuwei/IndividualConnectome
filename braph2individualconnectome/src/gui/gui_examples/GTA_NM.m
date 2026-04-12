classdef GTA_NM < ConcreteElement
	%GTA_NM tests PanelPropMatrix.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_NM tests PanelPropMatrix.
	%
	% GTA_NM methods (constructor):
	%  GTA_NM - constructor
	%
	% GTA_NM methods:
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
	% GTA_NM methods (display):
	%  tostring - string with information about the test A PanelPropMatrix
	%  disp - displays information about the test A PanelPropMatrix
	%  tree - displays the tree of the test A PanelPropMatrix
	%
	% GTA_NM methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropMatrix are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropMatrix
	%
	% GTA_NM methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropMatrix as b2 file
	%  load - loads a BRAPH2 test A PanelPropMatrix from a b2 file
	%
	% GTA_NM method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropMatrix
	%
	% GTA_NM method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropMatrix
	%
	% GTA_NM methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropMatrix
	%  getSubclasses - returns all subclasses of GTA_NM
	%  getProps - returns the property list of the test A PanelPropMatrix
	%  getPropNumber - returns the property number of the test A PanelPropMatrix
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
	% GTA_NM methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_NM methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_NM methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_NM methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_NM; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_NM constants</a>.
	%
	%
	% See also PanelPropMatrix.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		NM_C = ConcreteElement.getPropNumber() + 1;
		NM_C_TAG = 'NM_C';
		NM_C_CATEGORY = Category.CONSTANT;
		NM_C_FORMAT = Format.MATRIX;
		
		NM_M = ConcreteElement.getPropNumber() + 2;
		NM_M_TAG = 'NM_M';
		NM_M_CATEGORY = Category.METADATA;
		NM_M_FORMAT = Format.MATRIX;
		
		NM_P = ConcreteElement.getPropNumber() + 3;
		NM_P_TAG = 'NM_P';
		NM_P_CATEGORY = Category.PARAMETER;
		NM_P_FORMAT = Format.MATRIX;
		
		NM_D = ConcreteElement.getPropNumber() + 4;
		NM_D_TAG = 'NM_D';
		NM_D_CATEGORY = Category.DATA;
		NM_D_FORMAT = Format.MATRIX;
		
		NM_R = ConcreteElement.getPropNumber() + 5;
		NM_R_TAG = 'NM_R';
		NM_R_CATEGORY = Category.RESULT;
		NM_R_FORMAT = Format.MATRIX;
		
		NM_Q = ConcreteElement.getPropNumber() + 6;
		NM_Q_TAG = 'NM_Q';
		NM_Q_CATEGORY = Category.QUERY;
		NM_Q_FORMAT = Format.MATRIX;
		
		NM_E = ConcreteElement.getPropNumber() + 7;
		NM_E_TAG = 'NM_E';
		NM_E_CATEGORY = Category.EVANESCENT;
		NM_E_FORMAT = Format.MATRIX;
		
		NM_F = ConcreteElement.getPropNumber() + 8;
		NM_F_TAG = 'NM_F';
		NM_F_CATEGORY = Category.FIGURE;
		NM_F_FORMAT = Format.MATRIX;
		
		NM_G = ConcreteElement.getPropNumber() + 9;
		NM_G_TAG = 'NM_G';
		NM_G_CATEGORY = Category.GUI;
		NM_G_FORMAT = Format.MATRIX;
	end
	methods % constructor
		function gt = GTA_NM(varargin)
			%GTA_NM() creates a test A PanelPropMatrix.
			%
			% GTA_NM(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_NM(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the test A PanelPropMatrix.
			%
			% BUILD = GTA_NM.GETBUILD() returns the build of 'GTA_NM'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropMatrix GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_NM') returns the build of 'GTA_NM'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_NM')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropMatrix.
			%
			% CLASS = GTA_NM.GETCLASS() returns the class 'GTA_NM'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropMatrix GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_NM') returns 'GTA_NM'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_NM')
			%  are less computationally efficient.
			
			gt_class = 'GTA_NM';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropMatrix.
			%
			% LIST = GTA_NM.GETSUBCLASSES() returns all subclasses of 'GTA_NM'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropMatrix GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_NM') returns all subclasses of 'GTA_NM'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_NM')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GTA_NM', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropMatrix.
			%
			% PROPS = GTA_NM.GETPROPS() returns the property list of test A PanelPropMatrix
			%  as a row vector.
			%
			% PROPS = GTA_NM.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropMatrix GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_NM'[, CATEGORY]) returns the property list of 'GTA_NM'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GTA_NM.NM_C ...
						GTA_NM.NM_M ...
						GTA_NM.NM_P ...
						GTA_NM.NM_D ...
						GTA_NM.NM_R ...
						GTA_NM.NM_Q ...
						GTA_NM.NM_E ...
						GTA_NM.NM_F ...
						GTA_NM.NM_G ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						GTA_NM.NM_C ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						GTA_NM.NM_M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						GTA_NM.NM_P ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						GTA_NM.NM_D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						GTA_NM.NM_R ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GTA_NM.NM_Q ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GTA_NM.NM_E ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						GTA_NM.NM_F ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GTA_NM.NM_G ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropMatrix.
			%
			% N = GTA_NM.GETPROPNUMBER() returns the property number of test A PanelPropMatrix.
			%
			% N = GTA_NM.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropMatrix
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropMatrix GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_NM') returns the property number of 'GTA_NM'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GTA_NM.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropMatrix/error.
			%
			% CHECK = GTA_NM.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_NM, PROP) checks whether PROP exists for GTA_NM.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSPROP(GTA_NM, PROP) throws error if PROP does NOT exist for GTA_NM.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GTA_NM.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_NM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_NM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_NM.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropMatrix/error.
			%
			% CHECK = GTA_NM.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_NM, TAG) checks whether TAG exists for GTA_NM.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSTAG(GTA_NM, TAG) throws error if TAG does NOT exist for GTA_NM.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gta_nm_tag_list = cellfun(@(x) GTA_NM.getPropTag(x), num2cell(GTA_NM.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gta_nm_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_NM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_NM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GTA_NM.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_NM, POINTER) returns property number of POINTER of GTA_NM.
			%  PROPERTY = GT.GETPROPPROP(GTA_NM, POINTER) returns property number of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gta_nm_tag_list = cellfun(@(x) GTA_NM.getPropTag(x), num2cell(GTA_NM.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gta_nm_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GTA_NM, POINTER) returns tag of POINTER of GTA_NM.
			%  TAG = GT.GETPROPTAG(GTA_NM, POINTER) returns tag of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GTA_NM.NM_C
						tag = GTA_NM.NM_C_TAG;
					case GTA_NM.NM_M
						tag = GTA_NM.NM_M_TAG;
					case GTA_NM.NM_P
						tag = GTA_NM.NM_P_TAG;
					case GTA_NM.NM_D
						tag = GTA_NM.NM_D_TAG;
					case GTA_NM.NM_R
						tag = GTA_NM.NM_R_TAG;
					case GTA_NM.NM_Q
						tag = GTA_NM.NM_Q_TAG;
					case GTA_NM.NM_E
						tag = GTA_NM.NM_E_TAG;
					case GTA_NM.NM_F
						tag = GTA_NM.NM_F_TAG;
					case GTA_NM.NM_G
						tag = GTA_NM.NM_G_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_NM, POINTER) returns category of POINTER of GTA_NM.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_NM, POINTER) returns category of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_NM')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop
				case GTA_NM.NM_C
					prop_category = GTA_NM.NM_C_CATEGORY;
				case GTA_NM.NM_M
					prop_category = GTA_NM.NM_M_CATEGORY;
				case GTA_NM.NM_P
					prop_category = GTA_NM.NM_P_CATEGORY;
				case GTA_NM.NM_D
					prop_category = GTA_NM.NM_D_CATEGORY;
				case GTA_NM.NM_R
					prop_category = GTA_NM.NM_R_CATEGORY;
				case GTA_NM.NM_Q
					prop_category = GTA_NM.NM_Q_CATEGORY;
				case GTA_NM.NM_E
					prop_category = GTA_NM.NM_E_CATEGORY;
				case GTA_NM.NM_F
					prop_category = GTA_NM.NM_F_CATEGORY;
				case GTA_NM.NM_G
					prop_category = GTA_NM.NM_G_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_NM, POINTER) returns format of POINTER of GTA_NM.
			%  FORMAT = GT.GETPROPFORMAT(GTA_NM, POINTER) returns format of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_NM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop
				case GTA_NM.NM_C
					prop_format = GTA_NM.NM_C_FORMAT;
				case GTA_NM.NM_M
					prop_format = GTA_NM.NM_M_FORMAT;
				case GTA_NM.NM_P
					prop_format = GTA_NM.NM_P_FORMAT;
				case GTA_NM.NM_D
					prop_format = GTA_NM.NM_D_FORMAT;
				case GTA_NM.NM_R
					prop_format = GTA_NM.NM_R_FORMAT;
				case GTA_NM.NM_Q
					prop_format = GTA_NM.NM_Q_FORMAT;
				case GTA_NM.NM_E
					prop_format = GTA_NM.NM_E_FORMAT;
				case GTA_NM.NM_F
					prop_format = GTA_NM.NM_F_FORMAT;
				case GTA_NM.NM_G
					prop_format = GTA_NM.NM_G_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_NM, POINTER) returns description of POINTER of GTA_NM.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_NM, POINTER) returns description of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop
				case GTA_NM.NM_C
					prop_description = 'NM_C (constant, matrix) is a prop constant matrix.';
				case GTA_NM.NM_M
					prop_description = 'NM_M (metadata, matrix) is a prop metadata matrix.';
				case GTA_NM.NM_P
					prop_description = 'NM_P (parameter, matrix) is a prop parameter matrix.';
				case GTA_NM.NM_D
					prop_description = 'NM_D (data, matrix) is a prop data matrix.';
				case GTA_NM.NM_R
					prop_description = 'NM_R (result, matrix) is a prop result matrix.';
				case GTA_NM.NM_Q
					prop_description = 'NM_Q (query, matrix) is a prop query matrix.';
				case GTA_NM.NM_E
					prop_description = 'NM_E (evanescent, matrix) is a prop evanescent matrix.';
				case GTA_NM.NM_F
					prop_description = 'NM_F (figure, matrix) is a prop figure matrix.';
				case GTA_NM.NM_G
					prop_description = 'NM_G (gui, matrix) is a prop gui matrix.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_NM, POINTER) returns settings of POINTER of GTA_NM.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_NM, POINTER) returns settings of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop
				case GTA_NM.NM_C
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_M
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_P
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_D
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_R
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_Q
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_E
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_F
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case GTA_NM.NM_G
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_NM, POINTER) returns the default value of POINTER of GTA_NM.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_NM, POINTER) returns the default value of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop
				case GTA_NM.NM_C
					prop_default = eye(10);
				case GTA_NM.NM_M
					prop_default = eye(10);
				case GTA_NM.NM_P
					prop_default = eye(10);
				case GTA_NM.NM_D
					prop_default = eye(10);
				case GTA_NM.NM_R
					prop_default = Format.getFormatDefault(Format.MATRIX, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_Q
					prop_default = Format.getFormatDefault(Format.MATRIX, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_E
					prop_default = Format.getFormatDefault(Format.MATRIX, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_F
					prop_default = eye(10);
				case GTA_NM.NM_G
					prop_default = eye(10);
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_NM, POINTER) returns the conditioned default value of POINTER of GTA_NM.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_NM, POINTER) returns the conditioned default value of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_NM')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			prop_default = GTA_NM.conditioning(prop, GTA_NM.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_NM, PROP, VALUE) checks VALUE format for PROP of GTA_NM.
			%  CHECK = GT.CHECKPROP(GTA_NM, PROP, VALUE) checks VALUE format for PROP of GTA_NM.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GTA_NM:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: €BRAPH2.STR€:GTA_NM:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GTA_NM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NM.
			%   Error id: €BRAPH2.STR€:GTA_NM:€BRAPH2.WRONG_INPUT€
			%  GT.CHECKPROP(GTA_NM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NM.
			%   Error id: €BRAPH2.STR€:GTA_NM:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_NM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop
				case GTA_NM.NM_C % __GTA_NM.NM_C__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_M % __GTA_NM.NM_M__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_P % __GTA_NM.NM_P__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_D % __GTA_NM.NM_D__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_R % __GTA_NM.NM_R__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_Q % __GTA_NM.NM_Q__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_E % __GTA_NM.NM_E__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_F % __GTA_NM.NM_F__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				case GTA_NM.NM_G % __GTA_NM.NM_G__
					check = Format.checkFormat(Format.MATRIX, value, GTA_NM.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GTA_NM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GTA_NM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_NM.getPropTag(prop) ' (' GTA_NM.getFormatTag(GTA_NM.getPropFormat(prop)) ').'] ...
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
				case GTA_NM.NM_R % __GTA_NM.NM_R__
					rng_settings_ = rng(); rng(gt.getPropSeed(GTA_NM.NM_R), 'twister')
					
					value = randi(10, 10);
					
					rng(rng_settings_)
					
				case GTA_NM.NM_Q % __GTA_NM.NM_Q__
					value = randi(10, 10);
					
				case GTA_NM.NM_E % __GTA_NM.NM_E__
					value = randi(10, 10);
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(gt, prop, varargin{:});
					else
						value = calculateValue@Element(gt, prop, varargin{:});
					end
			end
			
		end
	end
end
