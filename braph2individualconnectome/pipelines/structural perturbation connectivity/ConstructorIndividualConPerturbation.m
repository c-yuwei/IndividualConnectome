classdef ConstructorIndividualConPerturbation < ConstructorIndividualConBase
	%ConstructorIndividualConPerturbation Construct perturbation-based brain connectome from subjects with SUVR data.
	% It is a subclass of <a href="matlab:help ConstructorIndividualConBase">ConstructorIndividualConBase</a>.
	%
	% IndividualPerturbationConConstructor constructs individual connectomes by perturbation using partial correlation with selected VOIs, adjusting for mean-centered age and education if selected.
	%
	% ConstructorIndividualConPerturbation methods (constructor):
	%  ConstructorIndividualConPerturbation - constructor
	%
	% ConstructorIndividualConPerturbation methods:
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
	% ConstructorIndividualConPerturbation methods (display):
	%  tostring - string with information about the perturbation-based subject individual brain connectome Constructor
	%  disp - displays information about the perturbation-based subject individual brain connectome Constructor
	%  tree - displays the tree of the perturbation-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConPerturbation methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two perturbation-based subject individual brain connectome Constructor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the perturbation-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConPerturbation methods (save/load, Static):
	%  save - saves BRAPH2 perturbation-based subject individual brain connectome Constructor as b2 file
	%  load - loads a BRAPH2 perturbation-based subject individual brain connectome Constructor from a b2 file
	%
	% ConstructorIndividualConPerturbation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the perturbation-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConPerturbation method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the perturbation-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConPerturbation methods (inspection, Static):
	%  getClass - returns the class of the perturbation-based subject individual brain connectome Constructor
	%  getSubclasses - returns all subclasses of ConstructorIndividualConPerturbation
	%  getProps - returns the property list of the perturbation-based subject individual brain connectome Constructor
	%  getPropNumber - returns the property number of the perturbation-based subject individual brain connectome Constructor
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
	% ConstructorIndividualConPerturbation methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConstructorIndividualConPerturbation methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConstructorIndividualConPerturbation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConstructorIndividualConPerturbation methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConstructorIndividualConPerturbation; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConstructorIndividualConPerturbation constants</a>.
	%
	%
	% See also Group, SubjectST, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		VOI_SELECTION = ConstructorIndividualConBase.getPropNumber() + 1;
		VOI_SELECTION_TAG = 'VOI_SELECTION';
		VOI_SELECTION_CATEGORY = Category.PARAMETER;
		VOI_SELECTION_FORMAT = Format.STRINGLIST;
	end
	methods % constructor
		function ipc = ConstructorIndividualConPerturbation(varargin)
			%ConstructorIndividualConPerturbation() creates a perturbation-based subject individual brain connectome Constructor.
			%
			% ConstructorIndividualConPerturbation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConstructorIndividualConPerturbation(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			ipc = ipc@ConstructorIndividualConBase(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the perturbation-based subject individual brain connectome Constructor.
			%
			% BUILD = ConstructorIndividualConPerturbation.GETBUILD() returns the build of 'ConstructorIndividualConPerturbation'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IPC.GETBUILD() returns the build of the perturbation-based subject individual brain connectome Constructor IPC.
			%  BUILD = Element.GETBUILD(IPC) returns the build of 'IPC'.
			%  BUILD = Element.GETBUILD('ConstructorIndividualConPerturbation') returns the build of 'ConstructorIndividualConPerturbation'.
			%
			% Note that the Element.GETBUILD(IPC) and Element.GETBUILD('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			
			build = 1;
		end
		function ipc_class = getClass()
			%GETCLASS returns the class of the perturbation-based subject individual brain connectome Constructor.
			%
			% CLASS = ConstructorIndividualConPerturbation.GETCLASS() returns the class 'ConstructorIndividualConPerturbation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IPC.GETCLASS() returns the class of the perturbation-based subject individual brain connectome Constructor IPC.
			%  CLASS = Element.GETCLASS(IPC) returns the class of 'IPC'.
			%  CLASS = Element.GETCLASS('ConstructorIndividualConPerturbation') returns 'ConstructorIndividualConPerturbation'.
			%
			% Note that the Element.GETCLASS(IPC) and Element.GETCLASS('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			
			ipc_class = 'ConstructorIndividualConPerturbation';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the perturbation-based subject individual brain connectome Constructor.
			%
			% LIST = ConstructorIndividualConPerturbation.GETSUBCLASSES() returns all subclasses of 'ConstructorIndividualConPerturbation'.
			%
			% Alternative forms to call this method are:
			%  LIST = IPC.GETSUBCLASSES() returns all subclasses of the perturbation-based subject individual brain connectome Constructor IPC.
			%  LIST = Element.GETSUBCLASSES(IPC) returns all subclasses of 'IPC'.
			%  LIST = Element.GETSUBCLASSES('ConstructorIndividualConPerturbation') returns all subclasses of 'ConstructorIndividualConPerturbation'.
			%
			% Note that the Element.GETSUBCLASSES(IPC) and Element.GETSUBCLASSES('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ConstructorIndividualConPerturbation', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of perturbation-based subject individual brain connectome Constructor.
			%
			% PROPS = ConstructorIndividualConPerturbation.GETPROPS() returns the property list of perturbation-based subject individual brain connectome Constructor
			%  as a row vector.
			%
			% PROPS = ConstructorIndividualConPerturbation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IPC.GETPROPS([CATEGORY]) returns the property list of the perturbation-based subject individual brain connectome Constructor IPC.
			%  PROPS = Element.GETPROPS(IPC[, CATEGORY]) returns the property list of 'IPC'.
			%  PROPS = Element.GETPROPS('ConstructorIndividualConPerturbation'[, CATEGORY]) returns the property list of 'ConstructorIndividualConPerturbation'.
			%
			% Note that the Element.GETPROPS(IPC) and Element.GETPROPS('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConstructorIndividualConBase.getProps() ...
						ConstructorIndividualConPerturbation.VOI_SELECTION ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.PARAMETER) ...
						ConstructorIndividualConPerturbation.VOI_SELECTION ...
						];
				case Category.DATA
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ConstructorIndividualConBase.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of perturbation-based subject individual brain connectome Constructor.
			%
			% N = ConstructorIndividualConPerturbation.GETPROPNUMBER() returns the property number of perturbation-based subject individual brain connectome Constructor.
			%
			% N = ConstructorIndividualConPerturbation.GETPROPNUMBER(CATEGORY) returns the property number of perturbation-based subject individual brain connectome Constructor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IPC.GETPROPNUMBER([CATEGORY]) returns the property number of the perturbation-based subject individual brain connectome Constructor IPC.
			%  N = Element.GETPROPNUMBER(IPC) returns the property number of 'IPC'.
			%  N = Element.GETPROPNUMBER('ConstructorIndividualConPerturbation') returns the property number of 'ConstructorIndividualConPerturbation'.
			%
			% Note that the Element.GETPROPNUMBER(IPC) and Element.GETPROPNUMBER('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ConstructorIndividualConPerturbation.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in perturbation-based subject individual brain connectome Constructor/error.
			%
			% CHECK = ConstructorIndividualConPerturbation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IPC.EXISTSPROP(PROP) checks whether PROP exists for IPC.
			%  CHECK = Element.EXISTSPROP(IPC, PROP) checks whether PROP exists for IPC.
			%  CHECK = Element.EXISTSPROP(ConstructorIndividualConPerturbation, PROP) checks whether PROP exists for ConstructorIndividualConPerturbation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IPC.EXISTSPROP(PROP) throws error if PROP does NOT exist for IPC.
			%   Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%  Element.EXISTSPROP(IPC, PROP) throws error if PROP does NOT exist for IPC.
			%   Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%  Element.EXISTSPROP(ConstructorIndividualConPerturbation, PROP) throws error if PROP does NOT exist for ConstructorIndividualConPerturbation.
			%   Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IPC) and Element.EXISTSPROP('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ConstructorIndividualConPerturbation.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConPerturbation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConPerturbation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConstructorIndividualConPerturbation.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in perturbation-based subject individual brain connectome Constructor/error.
			%
			% CHECK = ConstructorIndividualConPerturbation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IPC.EXISTSTAG(TAG) checks whether TAG exists for IPC.
			%  CHECK = Element.EXISTSTAG(IPC, TAG) checks whether TAG exists for IPC.
			%  CHECK = Element.EXISTSTAG(ConstructorIndividualConPerturbation, TAG) checks whether TAG exists for ConstructorIndividualConPerturbation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IPC.EXISTSTAG(TAG) throws error if TAG does NOT exist for IPC.
			%   Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%  Element.EXISTSTAG(IPC, TAG) throws error if TAG does NOT exist for IPC.
			%   Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%  Element.EXISTSTAG(ConstructorIndividualConPerturbation, TAG) throws error if TAG does NOT exist for ConstructorIndividualConPerturbation.
			%   Error id: [BRAPH2:ConstructorIndividualConPerturbation:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IPC) and Element.EXISTSTAG('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			constructorindividualconperturbation_tag_list = cellfun(@(x) ConstructorIndividualConPerturbation.getPropTag(x), num2cell(ConstructorIndividualConPerturbation.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, constructorindividualconperturbation_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConPerturbation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConPerturbation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ConstructorIndividualConPerturbation.'] ...
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
			%  PROPERTY = IPC.GETPROPPROP(POINTER) returns property number of POINTER of IPC.
			%  PROPERTY = Element.GETPROPPROP(ConstructorIndividualConPerturbation, POINTER) returns property number of POINTER of ConstructorIndividualConPerturbation.
			%  PROPERTY = IPC.GETPROPPROP(ConstructorIndividualConPerturbation, POINTER) returns property number of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPPROP(IPC) and Element.GETPROPPROP('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				constructorindividualconperturbation_tag_list = cellfun(@(x) ConstructorIndividualConPerturbation.getPropTag(x), num2cell(ConstructorIndividualConPerturbation.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, constructorindividualconperturbation_tag_list)); % tag = pointer
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
			%  TAG = IPC.GETPROPTAG(POINTER) returns tag of POINTER of IPC.
			%  TAG = Element.GETPROPTAG(ConstructorIndividualConPerturbation, POINTER) returns tag of POINTER of ConstructorIndividualConPerturbation.
			%  TAG = IPC.GETPROPTAG(ConstructorIndividualConPerturbation, POINTER) returns tag of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPTAG(IPC) and Element.GETPROPTAG('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ConstructorIndividualConPerturbation.VOI_SELECTION
						tag = ConstructorIndividualConPerturbation.VOI_SELECTION_TAG;
					otherwise
						tag = getPropTag@ConstructorIndividualConBase(prop);
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
			%  CATEGORY = IPC.GETPROPCATEGORY(POINTER) returns category of POINTER of IPC.
			%  CATEGORY = Element.GETPROPCATEGORY(ConstructorIndividualConPerturbation, POINTER) returns category of POINTER of ConstructorIndividualConPerturbation.
			%  CATEGORY = IPC.GETPROPCATEGORY(ConstructorIndividualConPerturbation, POINTER) returns category of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPCATEGORY(IPC) and Element.GETPROPCATEGORY('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConPerturbation.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConPerturbation.VOI_SELECTION
					prop_category = ConstructorIndividualConPerturbation.VOI_SELECTION_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConstructorIndividualConBase(prop);
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
			%  FORMAT = IPC.GETPROPFORMAT(POINTER) returns format of POINTER of IPC.
			%  FORMAT = Element.GETPROPFORMAT(ConstructorIndividualConPerturbation, POINTER) returns format of POINTER of ConstructorIndividualConPerturbation.
			%  FORMAT = IPC.GETPROPFORMAT(ConstructorIndividualConPerturbation, POINTER) returns format of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPFORMAT(IPC) and Element.GETPROPFORMAT('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConPerturbation.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConPerturbation.VOI_SELECTION
					prop_format = ConstructorIndividualConPerturbation.VOI_SELECTION_FORMAT;
				otherwise
					prop_format = getPropFormat@ConstructorIndividualConBase(prop);
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
			%  DESCRIPTION = IPC.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IPC.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConstructorIndividualConPerturbation, POINTER) returns description of POINTER of ConstructorIndividualConPerturbation.
			%  DESCRIPTION = IPC.GETPROPDESCRIPTION(ConstructorIndividualConPerturbation, POINTER) returns description of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPDESCRIPTION(IPC) and Element.GETPROPDESCRIPTION('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConPerturbation.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConPerturbation.VOI_SELECTION
					prop_description = 'VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.';
				case ConstructorIndividualConPerturbation.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the perturbation-based connectome constructor.';
				case ConstructorIndividualConPerturbation.NAME
					prop_description = 'NAME (constant, string) is the name of the perturbation-based connectome constructor.';
				case ConstructorIndividualConPerturbation.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the perturbation-based connectome constructor.';
				case ConstructorIndividualConPerturbation.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the perturbation-based connectome constructor.';
				case ConstructorIndividualConPerturbation.ID
					prop_description = 'ID (data, string) is a few-letter code for the perturbation-based connectome constructor.';
				case ConstructorIndividualConPerturbation.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the perturbation-based connectome constructor.';
				case ConstructorIndividualConPerturbation.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the perturbation-based connectome constructor.';
				case ConstructorIndividualConPerturbation.CONNECTOME_CONSTRUCT_METHOD
					prop_description = 'CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for constructing individual connectomes using perturbation with partial correlation using selected VOIs.';
				otherwise
					prop_description = getPropDescription@ConstructorIndividualConBase(prop);
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
			%  SETTINGS = IPC.GETPROPSETTINGS(POINTER) returns settings of POINTER of IPC.
			%  SETTINGS = Element.GETPROPSETTINGS(ConstructorIndividualConPerturbation, POINTER) returns settings of POINTER of ConstructorIndividualConPerturbation.
			%  SETTINGS = IPC.GETPROPSETTINGS(ConstructorIndividualConPerturbation, POINTER) returns settings of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPSETTINGS(IPC) and Element.GETPROPSETTINGS('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConPerturbation.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConPerturbation.VOI_SELECTION
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case ConstructorIndividualConPerturbation.TEMPLATE
					prop_settings = 'IndividualPerturbationConConstructor';
				otherwise
					prop_settings = getPropSettings@ConstructorIndividualConBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConstructorIndividualConPerturbation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConstructorIndividualConPerturbation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IPC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IPC.
			%  DEFAULT = Element.GETPROPDEFAULT(ConstructorIndividualConPerturbation, POINTER) returns the default value of POINTER of ConstructorIndividualConPerturbation.
			%  DEFAULT = IPC.GETPROPDEFAULT(ConstructorIndividualConPerturbation, POINTER) returns the default value of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPDEFAULT(IPC) and Element.GETPROPDEFAULT('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConstructorIndividualConPerturbation.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConPerturbation.VOI_SELECTION
					prop_default = {'Age', 'Sex', 'Education'}; % Example: Default selected VOIs;
				case ConstructorIndividualConPerturbation.ELCLASS
					prop_default = 'ConstructorIndividualConPerturbation';
				case ConstructorIndividualConPerturbation.NAME
					prop_default = 'Individual Perturbation Connectome Constructor';
				case ConstructorIndividualConPerturbation.DESCRIPTION
					prop_default = 'IndividualPerturbationConConstructor constructs individual connectomes using perturbation method with partial correlation using selected VOIs';
				case ConstructorIndividualConPerturbation.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ConstructorIndividualConPerturbation.getPropSettings(prop));
				case ConstructorIndividualConPerturbation.ID
					prop_default = 'IndividualPerturbationConConstructor ID';
				case ConstructorIndividualConPerturbation.LABEL
					prop_default = 'IndividualPerturbationConConstructor label';
				case ConstructorIndividualConPerturbation.NOTES
					prop_default = 'IndividualPerturbationConConstructor notes';
				otherwise
					prop_default = getPropDefault@ConstructorIndividualConBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConstructorIndividualConPerturbation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConstructorIndividualConPerturbation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IPC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IPC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConstructorIndividualConPerturbation, POINTER) returns the conditioned default value of POINTER of ConstructorIndividualConPerturbation.
			%  DEFAULT = IPC.GETPROPDEFAULTCONDITIONED(ConstructorIndividualConPerturbation, POINTER) returns the conditioned default value of POINTER of ConstructorIndividualConPerturbation.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IPC) and Element.GETPROPDEFAULTCONDITIONED('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConstructorIndividualConPerturbation.getPropProp(pointer);
			
			prop_default = ConstructorIndividualConPerturbation.conditioning(prop, ConstructorIndividualConPerturbation.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IPC.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IPC.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IPC.
			%  CHECK = Element.CHECKPROP(ConstructorIndividualConPerturbation, PROP, VALUE) checks VALUE format for PROP of ConstructorIndividualConPerturbation.
			%  CHECK = IPC.CHECKPROP(ConstructorIndividualConPerturbation, PROP, VALUE) checks VALUE format for PROP of ConstructorIndividualConPerturbation.
			% 
			% IPC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ConstructorIndividualConPerturbation:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IPC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IPC.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConPerturbation:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ConstructorIndividualConPerturbation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConPerturbation.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConPerturbation:€BRAPH2.WRONG_INPUT€
			%  IPC.CHECKPROP(ConstructorIndividualConPerturbation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConPerturbation.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConPerturbation:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IPC) and Element.CHECKPROP('ConstructorIndividualConPerturbation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConstructorIndividualConPerturbation.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConPerturbation.VOI_SELECTION % __ConstructorIndividualConPerturbation.VOI_SELECTION__
					check = Format.checkFormat(Format.STRINGLIST, value, ConstructorIndividualConPerturbation.getPropSettings(prop));
				case ConstructorIndividualConPerturbation.TEMPLATE % __ConstructorIndividualConPerturbation.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ConstructorIndividualConPerturbation.getPropSettings(prop));
				otherwise
					if prop <= ConstructorIndividualConBase.getPropNumber()
						check = checkProp@ConstructorIndividualConBase(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConPerturbation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConPerturbation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConstructorIndividualConPerturbation.getPropTag(prop) ' (' ConstructorIndividualConPerturbation.getFormatTag(ConstructorIndividualConPerturbation.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ipc, prop, varargin)
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
				case ConstructorIndividualConPerturbation.CONNECTOME_CONSTRUCT_METHOD % __ConstructorIndividualConPerturbation.CONNECTOME_CONSTRUCT_METHOD__
					if isempty(varargin) && isempty(ipc.get('GR_SUVR').get('SUB_DICT').get('IT_LIST'))
					    value = {};
					    return
					end
					gr_suvr = ipc.get('GR_SUVR');
					gr_suvr_ref = ipc.get('GR_SUVR_REF');
					
					% Get selected VOIs
					selected_vois = ipc.get('VOI_SELECTION');
					
					% Extract SUVR and selected VOI data for healthy reference group
					N = gr_suvr_ref.get('SUB_DICT').get('LENGTH');
					healthy_SUVR = [];
					healthy_vois = [];
					for i = 1:N
					    sub = gr_suvr_ref.get('SUB_DICT').get('IT', i);
					    suvr_i = sub.get('ST')';
					    healthy_SUVR = [healthy_SUVR; suvr_i];
					    
					    voi_dict = sub.get('VOI_DICT');
					    voi_values = [];
					    for v = 1:length(selected_vois)
					        voi = selected_vois{v};
					        voi_value = voi_dict.get('IT', voi).get('V');
					        voi_values = [voi_values, voi_value];
					    end
					    healthy_vois = [healthy_vois; voi_values];
					end
					
					% Mean-center selected VOIs for reference group (if any selected)
					if ~isempty(selected_vois)
					    mean_vois_ref = mean(healthy_vois);
					    healthy_vois_centered = healthy_vois - mean_vois_ref;
					else
					    healthy_vois_centered = [];
					end
					
					% Compute reference correlation matrix R
					if ~isempty(healthy_vois_centered)
					    R = partialcorr(healthy_SUVR, healthy_vois_centered);
					else
					    R = corr(healthy_SUVR);
					end
					
					% Create diagonal mask
					num_regions = size(healthy_SUVR, 2);
					% DiagMask = diag(ones(num_regions, 1));
					% R_adjusted = R - DiagMask;
					
					% Compute normalization factor F
					F = (1 - (R .^ 2)) / (N - 1);
					F(F == 0) = eps; % Avoid division by zero
					
					connectome_matrices = {};
					for k = 1:gr_suvr.get('SUB_DICT').get('LENGTH')
					    sub = gr_suvr.get('SUB_DICT').get('IT', k);
					    suvr_k = sub.get('ST')';
					    
					    % Combine with healthy reference data
					    perturbed_SUVR = [healthy_SUVR; suvr_k];
					    
					    % Extract selected VOIs for the perturbed subject
					    voi_dict = sub.get('VOI_DICT');
					    voi_values = [];
					    for v = 1:length(selected_vois)
					        voi = selected_vois{v};
					        voi_value = voi_dict.get('IT', voi).get('V');
					        voi_values = [voi_values, voi_value];
					    end
					    perturbed_vois = [healthy_vois; voi_values];
					    
					    % Mean-center perturbed VOIs relative to reference group
					    if ~isempty(selected_vois)
					        perturbed_vois_centered = perturbed_vois - mean_vois_ref;
					    else
					        perturbed_vois_centered = [];
					    end
					    
					    % Compute perturbed correlation matrix P
					    if ~isempty(perturbed_vois_centered)
					        P = partialcorr(perturbed_SUVR, perturbed_vois_centered);
					    else
					        P = corr(perturbed_SUVR);
					    end
					
					    % Compute difference and normalize, then vectorize
					    D = P - R;
					    C = D ./ F;%* (N - 1); % element-wise division and scaling
					    connectome_matrices{k} = C;
					end
					value = connectome_matrices;
					
				otherwise
					if prop <= ConstructorIndividualConBase.getPropNumber()
						value = calculateValue@ConstructorIndividualConBase(ipc, prop, varargin{:});
					else
						value = calculateValue@Element(ipc, prop, varargin{:});
					end
			end
			
		end
	end
end
