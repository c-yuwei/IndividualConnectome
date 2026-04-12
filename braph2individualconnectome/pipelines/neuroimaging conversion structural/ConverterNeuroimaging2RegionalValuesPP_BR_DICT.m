classdef ConverterNeuroimaging2RegionalValuesPP_BR_DICT < PanelProp
	%ConverterNeuroimaging2RegionalValuesPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% SUVRConstructorPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.
	% It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (constructor):
	%  ConverterNeuroimaging2RegionalValuesPP_BR_DICT - constructor
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods:
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
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (display):
	%  tostring - string with information about the graph and measure plot
	%  disp - displays information about the graph and measure plot
	%  tree - displays the tree of the graph and measure plot
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph and measure plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph and measure plot
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (save/load, Static):
	%  save - saves BRAPH2 graph and measure plot as b2 file
	%  load - loads a BRAPH2 graph and measure plot from a b2 file
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (inspection, Static):
	%  getClass - returns the class of the graph and measure plot
	%  getSubclasses - returns all subclasses of ConverterNeuroimaging2RegionalValuesPP_BR_DICT
	%  getProps - returns the property list of the graph and measure plot
	%  getPropNumber - returns the property number of the graph and measure plot
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
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConverterNeuroimaging2RegionalValuesPP_BR_DICT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConverterNeuroimaging2RegionalValuesPP_BR_DICT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConverterNeuroimaging2RegionalValuesPP_BR_DICT constants</a>.
	%
	%
	% See also uitable, AnalyzeEnsemble, Graph, Measure.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		TABLE_HEIGHT = PanelProp.getPropNumber() + 1;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		SELECTED = PanelProp.getPropNumber() + 2;
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = Category.GUI;
		SELECTED_FORMAT = Format.CVECTOR;
		
		TABLE = PanelProp.getPropNumber() + 3;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 4;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = ConverterNeuroimaging2RegionalValuesPP_BR_DICT(varargin)
			%ConverterNeuroimaging2RegionalValuesPP_BR_DICT() creates a graph and measure plot.
			%
			% ConverterNeuroimaging2RegionalValuesPP_BR_DICT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConverterNeuroimaging2RegionalValuesPP_BR_DICT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph and measure plot.
			%
			% BUILD = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETBUILD() returns the build of 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the graph and measure plot PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('ConverterNeuroimaging2RegionalValuesPP_BR_DICT') returns the build of 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the graph and measure plot.
			%
			% CLASS = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETCLASS() returns the class 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the graph and measure plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('ConverterNeuroimaging2RegionalValuesPP_BR_DICT') returns 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			
			pr_class = 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph and measure plot.
			%
			% LIST = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETSUBCLASSES() returns all subclasses of 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the graph and measure plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('ConverterNeuroimaging2RegionalValuesPP_BR_DICT') returns all subclasses of 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ConverterNeuroimaging2RegionalValuesPP_BR_DICT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph and measure plot.
			%
			% PROPS = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPS() returns the property list of graph and measure plot
			%  as a row vector.
			%
			% PROPS = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the graph and measure plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('ConverterNeuroimaging2RegionalValuesPP_BR_DICT'[, CATEGORY]) returns the property list of 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelProp.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelProp.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelProp.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelProp.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelProp.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelProp.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT ...
						ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph and measure plot.
			%
			% N = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPNUMBER() returns the property number of graph and measure plot.
			%
			% N = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPNUMBER(CATEGORY) returns the property number of graph and measure plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the graph and measure plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('ConverterNeuroimaging2RegionalValuesPP_BR_DICT') returns the property number of 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph and measure plot/error.
			%
			% CHECK = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, PROP) checks whether PROP exists for ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%  Element.EXISTSPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, PROP) throws error if PROP does NOT exist for ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValuesPP_BR_DICT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValuesPP_BR_DICT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConverterNeuroimaging2RegionalValuesPP_BR_DICT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph and measure plot/error.
			%
			% CHECK = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, TAG) checks whether TAG exists for ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%  Element.EXISTSTAG(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, TAG) throws error if TAG does NOT exist for ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			converterneuroimaging2regionalvaluespp_br_dict_tag_list = cellfun(@(x) ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropTag(x), num2cell(ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, converterneuroimaging2regionalvaluespp_br_dict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValuesPP_BR_DICT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValuesPP_BR_DICT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ConverterNeuroimaging2RegionalValuesPP_BR_DICT.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns property number of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  PROPERTY = PR.GETPROPPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns property number of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				converterneuroimaging2regionalvaluespp_br_dict_tag_list = cellfun(@(x) ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropTag(x), num2cell(ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, converterneuroimaging2regionalvaluespp_br_dict_tag_list)); % tag = pointer
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns tag of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  TAG = PR.GETPROPTAG(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns tag of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT
						tag = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT_TAG;
					case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED
						tag = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED_TAG;
					case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE
						tag = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_TAG;
					case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU
						tag = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU_TAG;
					otherwise
						tag = getPropTag@PanelProp(prop);
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns category of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  CATEGORY = PR.GETPROPCATEGORY(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns category of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT
					prop_category = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT_CATEGORY;
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED
					prop_category = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED_CATEGORY;
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE
					prop_category = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_CATEGORY;
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU
					prop_category = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelProp(prop);
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns format of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  FORMAT = PR.GETPROPFORMAT(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns format of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT
					prop_format = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT_FORMAT;
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED
					prop_format = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED_FORMAT;
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE
					prop_format = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_FORMAT;
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU
					prop_format = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelProp(prop);
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns description of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns description of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.NAME
					prop_description = 'NAME (constant, string) is the name of the graph and measure panel.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph and measure panel.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph and measure panel.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph and measure panel.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph and measure panel.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph and measure panel.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.EL
					prop_description = 'EL (data, item) is the element.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.';
				otherwise
					prop_description = getPropDescription@PanelProp(prop);
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns settings of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  SETTINGS = PR.GETPROPSETTINGS(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns settings of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TEMPLATE
					prop_settings = 'SUVRConstructorPP_BR_DICT';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns the default value of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  DEFAULT = PR.GETPROPDEFAULT(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns the default value of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT
					prop_default = s(30);
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.ELCLASS
					prop_default = 'ConverterNeuroimaging2RegionalValuesPP_BR_DICT';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.NAME
					prop_default = 'SUVRConstructorPP_BR_DICT';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.DESCRIPTION
					prop_default = 'SUVRConstructorPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.ID
					prop_default = 'SUVRConstructorPP_BR_DICT';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.LABEL
					prop_default = 'SUVRConstructorPP_BR_DICT label';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.NOTES
					prop_default = 'SUVRConstructorPP_BR_DICT';
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.EL
					prop_default = SUVRConstructor();
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.PROP
					prop_default = SUVRConstructor.REF_BR_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns the conditioned default value of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, POINTER) returns the conditioned default value of POINTER of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			prop_default = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.conditioning(prop, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED__
					if isrow(value)
					    value = value';
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = conditioning@PanelProp(pointer, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, PROP, VALUE) checks VALUE format for PROP of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%  CHECK = PR.CHECKPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, PROP, VALUE) checks VALUE format for PROP of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%   Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(ConverterNeuroimaging2RegionalValuesPP_BR_DICT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterNeuroimaging2RegionalValuesPP_BR_DICT.
			%   Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValuesPP_BR_DICT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('ConverterNeuroimaging2RegionalValuesPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TEMPLATE % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValuesPP_BR_DICT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValuesPP_BR_DICT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropTag(prop) ' (' ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getFormatTag(ConverterNeuroimaging2RegionalValuesPP_BR_DICT.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.TABLE__
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Brain Region', 'ID', 'Label', 'Notes', 'Description'}, ...
					    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false false false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Measures', ...
					    'MenuSelectedFcn', {@cb_select_all} ...
					    );
					menu_clear_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_CLEAR_SELECTION', ...
					    'Text', 'Clear Selection', ...
					    'MenuSelectedFcn', {@cb_clear_selection} ...
					    );
					menu_invert_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_INVERT_SELECTION', ...
					    'Text', 'Invert Selection', ...
					    'MenuSelectedFcn', {@cb_invert_selection} ...
					    );
					menu_set = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_CALCULATE', ...
					    'Text', 'Set Selected Brain Regions', ...
						'MenuSelectedFcn', {@cb_set} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.X_DRAW % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					    
					    % % Create the button
					    % uicontrol('Parent', pr.get('H'), ...
					    %     'Style', 'pushbutton', ...
					    %     'String', 'Load Region-Index Files', ...
					    %     'Position', [10, 10, 120, 30], ...
					    %     'Callback', @cb_load_mapping_files);
					end
					% %% ¡calculate_callbacks!
					% function cb_load_mapping_files(~, ~)
					%     roic = pr.get('EL');
					%     [files, path] = uigetfile('*.csv', 'Select Region-Index CSV Files', 'MultiSelect', 'on');
					%     if ~isequal(files, 0)
					%         if ~iscell(files)
					%             files = {files};
					%         end
					%         % Construct IndexedDictionary for MAPPING_PATH_DICT
					%         mapping_paths = cellfun(@(f) FILE_PATH('PATH', fullfile(path, f)), files, 'UniformOutput', false);
					%         mapping_dict = IndexedDictionary('IT_CLASS', 'FILE_PATH', 'IT_LIST', mapping_paths);
					%         roic.set('MAPPING_PATH_DICT', mapping_dict);
					%     end
					% end
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.UPDATE % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
						el = pr.get('EL');
					    prop = pr.get('PROP');
					    set_table()
					    pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
					    set(pr.get('TABLE'), 'Visible', 'on')
					end
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.REDRAW % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SHOW % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.HIDE % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.DELETE % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CLOSE % __ConverterNeuroimaging2RegionalValuesPP_BR_DICT.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_table(~, event) % (src, event)
			    % only needs to update the selector
			
			        i = event.Indices(1);
			        
			        selected = pr.get('SELECTED');
			        if event.NewData == 1
			            pr.set('SELECTED', sort(unique([selected; i])));
			        else
			            pr.set('SELECTED', selected(selected ~= i));
			        end
			        
			        pr.get('UPDATE')    
			end
			function cb_select_all(~, ~)
			    roic = pr.get('EL');
			    
			    % Get the list of brain atlases
			    ba_list = roic.get('BA');
			    br_it_list = {};
			    for i = 1:length(ba_list)
			        ba = ba_list{i};
			        br_dict = ba.get('BR_DICT');
			        br_it = br_dict.get('IT_LIST');
			        br_it_list{i} = br_it;
			    end
			    br_it_list = [br_it_list{:}];
			    % Select all brain regions
			    pr.set('SELECTED', [1:1:length(br_it_list)]);
			    
			    % Update the panel
			    pr.get('UPDATE');
			end
			function cb_clear_selection(~, ~)
			    pr.set('SELECTED', [])
			    
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~)
			    roic = pr.get('EL');
			    
			    % Get the list of brain atlases
			    ba_list = roic.get('BA');
			    br_it_list = {};
			    for i = 1:length(ba_list)
			        ba = ba_list{i};
			        br_dict = ba.get('BR_DICT');
			        br_it = br_dict.get('IT_LIST');
			        br_it_list{i} = br_it;
			    end
			    br_it_list = [br_it_list{:}];
			    % Invert the current selection
			    selected = pr.get('SELECTED');
			    all_indices = [1:1:length(br_it_list)];
			    selected_tmp = setdiff(all_indices, selected);
			    pr.set('SELECTED', selected_tmp);
			    
			    % Update the panel
			    pr.get('UPDATE');
			end
			function cb_set(~, ~)
			    roic = pr.get('EL');
			    prop = pr.get('PROP');
			    eff_br_dict = roic.get(prop);
			    
			    % Get the list of brain atlases and aggregate brain regions
			    ba_list = roic.get('BA');
			    br_it_list = {};
			    for i = 1:length(ba_list)
			        ba = ba_list{i};
			        br_dict = ba.get('BR_DICT');
			        br_it = br_dict.get('IT_LIST');
			        br_it_list{i} = br_it;
			    end
			    br_it_list = [br_it_list{:}];
			    % Get selected indices
			    selected = pr.get('SELECTED');
			    
			    % Clear existing REF_BR_DICT
			    eff_br_dict.get('REMOVE_ALL', 1:eff_br_dict.get('LENGTH'));
			    
			    % Add selected brain regions
			    for s = 1:length(selected)
			        br = br_it_list{selected(s)};
			        eff_br_dict.get('ADD', br);
			    end
			    
			    % Update the element and refresh the panel
			    roic.set(prop, eff_br_dict);
			    pr.get('UPDATE');
			end
			function set_table()
			    % Retrieve core objects and properties
			    roic = pr.get('EL');
			    prop = pr.get('PROP');
			    ba_list = roic.get('BA');
			    
			    % Determine which atlases to use based on prop
			    if prop == 14  % REF_BR_DICT: Use all atlases
			        selected_atlases = ba_list;
			    elseif prop == 19  % SUVR_REGION_SELECTION: Use one atlas
			        atlas_index = roic.get('ATLAS_INDEX');
			        if atlas_index < 1 || atlas_index > length(ba_list)
			            warning('Invalid ATLAS_INDEX. No atlas selected.');
			            return;
			        end
			        selected_atlases = {ba_list{atlas_index}};
			    else
			        warning('Invalid property number.');
			        return;
			    end
			    
			    % Aggregate brain regions and atlas IDs
			    br_it_list = {};
			    atlas_ids = {};
			    for i = 1:length(selected_atlases)
			        ba = selected_atlases{i};
			        atlas_id = ba.get('ID');
			        br_dict = ba.get('BR_DICT');
			        br_it = br_dict.get('IT_LIST');
			        br_it_list{i} =  br_it;
			        atlas_ids = [atlas_ids; repmat({atlas_id}, length(br_it), 1)];
			    end
			    br_it_list = [br_it_list{:}];
			    % Extract brain region IDs
			
			    if ~isempty(br_it_list)
			        br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
			    else
			        br_list = {};
			    end
			    % br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
			    % Get the effective (selected) brain regions
			    if isa(roic.getr(prop), 'NoValue')
			        eff_br_list = {};
			    else
			        eff_br_list = cellfun(@(x) x.get('ID'), roic.get(prop).get('IT_LIST'), 'UniformOutput', false);
			    end
			    % Prepare table data with 6 columns (same for both properties)
			    data = cell(length(br_list), 6);
			    for bri = 1:length(br_list)
			        data{bri, 1} = any(pr.get('SELECTED') == bri);         % Checkbox
			        data{bri, 2} = atlas_ids{bri};                         % Atlas
			        data{bri, 3} = br_it_list{bri}.get('ID');              % ID
			        data{bri, 4} = br_it_list{bri}.get('LABEL');           % Label
			        data{bri, 5} = br_it_list{bri}.get('NOTES');           % Notes
			        data{bri, 6} = br_it_list{bri}.get('DESCRIPTION');     % Description
			    end
			    
			    % Configure the table with the same columns and format
			    set(pr.get('TABLE'), ...
			        'Data', data, ...
			        'ColumnName', {'', 'Atlas', 'ID', 'Label', 'Notes', 'Description'}, ...
			        'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
			        'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto', 'auto'} ...
			        )
			    
			    % Set row names to indicate selected regions
			    rowname = cell(length(br_list), 1);
			    for bri = 1:length(br_list)
			        if any(ismember(eff_br_list, br_list{bri})) && ~isa(roic.get(prop).get('IT', br_list{bri}).getr('X'), 'NoValue')
			            rowname{bri} = 'S';  % Selected
			        else
			            rowname{bri} = '';   % Unselected
			        end
			    end
			    set(pr.get('TABLE'), 'RowName', rowname);
			    
			    % Style selected rows
			    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			    if ~isempty(styles_row)
			        removeStyle(pr.get('TABLE'), styles_row)
			    end
			    if ~isempty(pr.get('SELECTED'))
			        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			    end
			end
		end
	end
end
