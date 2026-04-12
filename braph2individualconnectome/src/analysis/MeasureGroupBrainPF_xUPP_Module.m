classdef MeasureGroupBrainPF_xUPP_Module < PanelProp
	%MeasureGroupBrainPF_xUPP_Module plots the panel to select a module for community structure.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% MeasureGroupBrainPF_xUPP_Module plots the panel to select a module from a drop-down list for community structure.
	% It is supposed to be used with the property MODULE of MeasureGroupBrainPF_NU, MeasureGroupBrainPF_BU, or MeasureGroupBrainPF_GU.
	%
	% MeasureGroupBrainPF_xUPP_Module methods (constructor):
	%  MeasureGroupBrainPF_xUPP_Module - constructor
	%
	% MeasureGroupBrainPF_xUPP_Module methods:
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
	% MeasureGroupBrainPF_xUPP_Module methods (display):
	%  tostring - string with information about the panel property MODULE
	%  disp - displays information about the panel property MODULE
	%  tree - displays the tree of the panel property MODULE
	%
	% MeasureGroupBrainPF_xUPP_Module methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property MODULE are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property MODULE
	%
	% MeasureGroupBrainPF_xUPP_Module methods (save/load, Static):
	%  save - saves BRAPH2 panel property MODULE as b2 file
	%  load - loads a BRAPH2 panel property MODULE from a b2 file
	%
	% MeasureGroupBrainPF_xUPP_Module method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property MODULE
	%
	% MeasureGroupBrainPF_xUPP_Module method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property MODULE
	%
	% MeasureGroupBrainPF_xUPP_Module methods (inspection, Static):
	%  getClass - returns the class of the panel property MODULE
	%  getSubclasses - returns all subclasses of MeasureGroupBrainPF_xUPP_Module
	%  getProps - returns the property list of the panel property MODULE
	%  getPropNumber - returns the property number of the panel property MODULE
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
	% MeasureGroupBrainPF_xUPP_Module methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureGroupBrainPF_xUPP_Module methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureGroupBrainPF_xUPP_Module methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureGroupBrainPF_xUPP_Module methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureGroupBrainPF_xUPP_Module; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureGroupBrainPF_xUPP_Module constants</a>.
	%
	%
	% See also uidropdown, GUI, MeasureGroupBrainPF_NU, MeasureGroupBrainPF_BU, MeasureGroupBrainPF_GU, CommunityStructure.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		DROPDOWN = PanelProp.getPropNumber() + 1;
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = MeasureGroupBrainPF_xUPP_Module(varargin)
			%MeasureGroupBrainPF_xUPP_Module() creates a panel property MODULE.
			%
			% MeasureGroupBrainPF_xUPP_Module(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureGroupBrainPF_xUPP_Module(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETBUILD returns the build of the panel property MODULE.
			%
			% BUILD = MeasureGroupBrainPF_xUPP_Module.GETBUILD() returns the build of 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the panel property MODULE PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('MeasureGroupBrainPF_xUPP_Module') returns the build of 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the panel property MODULE.
			%
			% CLASS = MeasureGroupBrainPF_xUPP_Module.GETCLASS() returns the class 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property MODULE PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('MeasureGroupBrainPF_xUPP_Module') returns 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			
			pr_class = 'MeasureGroupBrainPF_xUPP_Module';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property MODULE.
			%
			% LIST = MeasureGroupBrainPF_xUPP_Module.GETSUBCLASSES() returns all subclasses of 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property MODULE PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('MeasureGroupBrainPF_xUPP_Module') returns all subclasses of 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureGroupBrainPF_xUPP_Module', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property MODULE.
			%
			% PROPS = MeasureGroupBrainPF_xUPP_Module.GETPROPS() returns the property list of panel property MODULE
			%  as a row vector.
			%
			% PROPS = MeasureGroupBrainPF_xUPP_Module.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property MODULE PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('MeasureGroupBrainPF_xUPP_Module'[, CATEGORY]) returns the property list of 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						MeasureGroupBrainPF_xUPP_Module.DROPDOWN ...
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
						MeasureGroupBrainPF_xUPP_Module.DROPDOWN ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel property MODULE.
			%
			% N = MeasureGroupBrainPF_xUPP_Module.GETPROPNUMBER() returns the property number of panel property MODULE.
			%
			% N = MeasureGroupBrainPF_xUPP_Module.GETPROPNUMBER(CATEGORY) returns the property number of panel property MODULE
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property MODULE PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('MeasureGroupBrainPF_xUPP_Module') returns the property number of 'MeasureGroupBrainPF_xUPP_Module'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureGroupBrainPF_xUPP_Module.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property MODULE/error.
			%
			% CHECK = MeasureGroupBrainPF_xUPP_Module.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(MeasureGroupBrainPF_xUPP_Module, PROP) checks whether PROP exists for MeasureGroupBrainPF_xUPP_Module.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%  Element.EXISTSPROP(MeasureGroupBrainPF_xUPP_Module, PROP) throws error if PROP does NOT exist for MeasureGroupBrainPF_xUPP_Module.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureGroupBrainPF_xUPP_Module.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_xUPP_Module:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_xUPP_Module:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureGroupBrainPF_xUPP_Module.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property MODULE/error.
			%
			% CHECK = MeasureGroupBrainPF_xUPP_Module.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(MeasureGroupBrainPF_xUPP_Module, TAG) checks whether TAG exists for MeasureGroupBrainPF_xUPP_Module.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%  Element.EXISTSTAG(MeasureGroupBrainPF_xUPP_Module, TAG) throws error if TAG does NOT exist for MeasureGroupBrainPF_xUPP_Module.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_xUPP_Module:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measuregroupbrainpf_xupp_module_tag_list = cellfun(@(x) MeasureGroupBrainPF_xUPP_Module.getPropTag(x), num2cell(MeasureGroupBrainPF_xUPP_Module.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measuregroupbrainpf_xupp_module_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_xUPP_Module:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_xUPP_Module:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureGroupBrainPF_xUPP_Module.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureGroupBrainPF_xUPP_Module, POINTER) returns property number of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  PROPERTY = PR.GETPROPPROP(MeasureGroupBrainPF_xUPP_Module, POINTER) returns property number of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measuregroupbrainpf_xupp_module_tag_list = cellfun(@(x) MeasureGroupBrainPF_xUPP_Module.getPropTag(x), num2cell(MeasureGroupBrainPF_xUPP_Module.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measuregroupbrainpf_xupp_module_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureGroupBrainPF_xUPP_Module, POINTER) returns tag of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  TAG = PR.GETPROPTAG(MeasureGroupBrainPF_xUPP_Module, POINTER) returns tag of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureGroupBrainPF_xUPP_Module.DROPDOWN
						tag = MeasureGroupBrainPF_xUPP_Module.DROPDOWN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureGroupBrainPF_xUPP_Module, POINTER) returns category of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  CATEGORY = PR.GETPROPCATEGORY(MeasureGroupBrainPF_xUPP_Module, POINTER) returns category of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_xUPP_Module.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_xUPP_Module.DROPDOWN
					prop_category = MeasureGroupBrainPF_xUPP_Module.DROPDOWN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureGroupBrainPF_xUPP_Module, POINTER) returns format of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  FORMAT = PR.GETPROPFORMAT(MeasureGroupBrainPF_xUPP_Module, POINTER) returns format of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_xUPP_Module.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_xUPP_Module.DROPDOWN
					prop_format = MeasureGroupBrainPF_xUPP_Module.DROPDOWN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureGroupBrainPF_xUPP_Module, POINTER) returns description of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(MeasureGroupBrainPF_xUPP_Module, POINTER) returns description of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_xUPP_Module.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_xUPP_Module.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the dropdown for the MODULE.';
				case MeasureGroupBrainPF_xUPP_Module.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case MeasureGroupBrainPF_xUPP_Module.NAME
					prop_description = 'NAME (constant, string) is the name of the panel property MODULE.';
				case MeasureGroupBrainPF_xUPP_Module.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel property MODULE.';
				case MeasureGroupBrainPF_xUPP_Module.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel property MODULE.';
				case MeasureGroupBrainPF_xUPP_Module.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel property MODULE.';
				case MeasureGroupBrainPF_xUPP_Module.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel property MODULE.';
				case MeasureGroupBrainPF_xUPP_Module.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel property MODULE.';
				case MeasureGroupBrainPF_xUPP_Module.EL
					prop_description = 'EL (data, item) is the element.';
				case MeasureGroupBrainPF_xUPP_Module.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case MeasureGroupBrainPF_xUPP_Module.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case MeasureGroupBrainPF_xUPP_Module.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case MeasureGroupBrainPF_xUPP_Module.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case MeasureGroupBrainPF_xUPP_Module.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case MeasureGroupBrainPF_xUPP_Module.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureGroupBrainPF_xUPP_Module, POINTER) returns settings of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  SETTINGS = PR.GETPROPSETTINGS(MeasureGroupBrainPF_xUPP_Module, POINTER) returns settings of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_xUPP_Module.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_xUPP_Module.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureGroupBrainPF_xUPP_Module.TEMPLATE
					prop_settings = 'MeasureGroupBrainPF_xUPP_Module';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_xUPP_Module.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_xUPP_Module.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureGroupBrainPF_xUPP_Module, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  DEFAULT = PR.GETPROPDEFAULT(MeasureGroupBrainPF_xUPP_Module, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureGroupBrainPF_xUPP_Module.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_xUPP_Module.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureGroupBrainPF_xUPP_Module.getPropSettings(prop));
				case MeasureGroupBrainPF_xUPP_Module.ELCLASS
					prop_default = 'MeasureGroupBrainPF_xUPP_Module';
				case MeasureGroupBrainPF_xUPP_Module.NAME
					prop_default = 'MeasureGroupBrainPF_xUPP_Module';
				case MeasureGroupBrainPF_xUPP_Module.DESCRIPTION
					prop_default = 'MeasureGroupBrainPF_xUPP_Module plots the panel to select a module from a drop-down list for community structure. It is supposed to be used with the property MODULE of MeasureGroupBrainPF_NU, MeasureGroupBrainPF_BU, or MeasureGroupBrainPF_GU.';
				case MeasureGroupBrainPF_xUPP_Module.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureGroupBrainPF_xUPP_Module.getPropSettings(prop));
				case MeasureGroupBrainPF_xUPP_Module.ID
					prop_default = 'MeasureGroupBrainPF_xUPP_Module ID';
				case MeasureGroupBrainPF_xUPP_Module.LABEL
					prop_default = 'MeasureGroupBrainPF_xUPP_Module label';
				case MeasureGroupBrainPF_xUPP_Module.NOTES
					prop_default = 'MeasureGroupBrainPF_xUPP_Module notes';
				case MeasureGroupBrainPF_xUPP_Module.EL
					prop_default = MeasureGroupBrainPF_NU();
				case MeasureGroupBrainPF_xUPP_Module.PROP
					prop_default = MeasureGroupBrainPF_NU.MODULE;
				case MeasureGroupBrainPF_xUPP_Module.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_xUPP_Module.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_xUPP_Module.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_xUPP_Module, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_xUPP_Module, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_xUPP_Module.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureGroupBrainPF_xUPP_Module.getPropProp(pointer);
			
			prop_default = MeasureGroupBrainPF_xUPP_Module.conditioning(prop, MeasureGroupBrainPF_xUPP_Module.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureGroupBrainPF_xUPP_Module, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_xUPP_Module.
			%  CHECK = PR.CHECKPROP(MeasureGroupBrainPF_xUPP_Module, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_xUPP_Module.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureGroupBrainPF_xUPP_Module:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_xUPP_Module:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureGroupBrainPF_xUPP_Module, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_xUPP_Module.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_xUPP_Module:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(MeasureGroupBrainPF_xUPP_Module, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_xUPP_Module.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_xUPP_Module:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('MeasureGroupBrainPF_xUPP_Module')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureGroupBrainPF_xUPP_Module.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_xUPP_Module.DROPDOWN % __MeasureGroupBrainPF_xUPP_Module.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, MeasureGroupBrainPF_xUPP_Module.getPropSettings(prop));
				case MeasureGroupBrainPF_xUPP_Module.TEMPLATE % __MeasureGroupBrainPF_xUPP_Module.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureGroupBrainPF_xUPP_Module.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_xUPP_Module:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_xUPP_Module:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureGroupBrainPF_xUPP_Module.getPropTag(prop) ' (' MeasureGroupBrainPF_xUPP_Module.getFormatTag(MeasureGroupBrainPF_xUPP_Module.getPropFormat(prop)) ').'] ...
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
				case MeasureGroupBrainPF_xUPP_Module.DROPDOWN % __MeasureGroupBrainPF_xUPP_Module.DROPDOWN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown} ...
					    );
					
					value = dropdown;
					
				case MeasureGroupBrainPF_xUPP_Module.X_DRAW % __MeasureGroupBrainPF_xUPP_Module.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					end
					
				case MeasureGroupBrainPF_xUPP_Module.UPDATE % __MeasureGroupBrainPF_xUPP_Module.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    pf = pr.get('EL');
					    module = pr.get('PROP');
					    m_id = pf.get('M').get('ID');
					    if isequal(m_id, 'CommunityStructure') || isequal(m_id, 'MultilayerCommunity')
					        layer = pf.get('LAYER');
					        cs_values = pf.get('M').get('M');
					        [modules, ia, ic] = unique(cs_values{layer}, 'sorted');
					        keys = cellfun(@(module) ['module ' num2str(module)], num2cell(modules), 'UniformOutput', false);
					        keys{length(modules) + 1} = 'off';
					        set(pr.get('DROPDOWN'), ...
					            'Items', keys, ...
					            'ItemsData', [1:1:length(keys)], ...
					            'Value', pf.get(module) ...
					            )
					    else
					        set(pr.get('DROPDOWN'), ...
					            'Items', {'off'}, ...
					            'ItemsData', 1, ...
					            'Value', pf.get(module) ...
					            )
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					
					    prop_value = pf.getr(module);
					    if pf.isLocked(module) || isa(prop_value, 'Callback')
					        set(pr.get('DROPDOWN'), ...
					            'Items', {'off'}, ...
					            'ItemsData', 1, ...
					            'Value', pf.get(module) ...
					            )
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case MeasureGroupBrainPF_xUPP_Module.REDRAW % __MeasureGroupBrainPF_xUPP_Module.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case MeasureGroupBrainPF_xUPP_Module.DELETE % __MeasureGroupBrainPF_xUPP_Module.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_dropdown(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
			end
		end
	end
end
