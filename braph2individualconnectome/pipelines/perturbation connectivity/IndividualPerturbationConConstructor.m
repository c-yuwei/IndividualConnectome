classdef IndividualPerturbationConConstructor < IndividualConConstructorBase
	%IndividualPerturbationConConstructor Construct perturbation-based brain connectome from subjects with SUVR data.
	% It is a subclass of <a href="matlab:help IndividualConConstructorBase">IndividualConConstructorBase</a>.
	%
	% IndividualPerturbationConConstructor constructs individual connectomes by perturbation using partial correlation with selected VOIs, adjusting for mean-centered age and education if selected.
	%
	% The list of IndividualPerturbationConConstructor properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the perturbation-based connectome constructor.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the perturbation-based connectome constructor.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the perturbation-based connectome constructor.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the perturbation-based connectome constructor.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the perturbation-based connectome constructor.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the perturbation-based connectome constructor.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the perturbation-based connectome constructor.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
	%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
	%  <strong>12</strong> <strong>CONNECTOME_CONSTRUCT_METHOD</strong> 	CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for constructing individual connectomes using perturbation with partial correlation using selected VOIs.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
	%  <strong>14</strong> <strong>VOI_SELECTION</strong> 	VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.
	%
	% IndividualPerturbationConConstructor methods (constructor):
	%  IndividualPerturbationConConstructor - constructor
	%
	% IndividualPerturbationConConstructor methods:
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
	% IndividualPerturbationConConstructor methods (display):
	%  tostring - string with information about the perturbation-based subject individual brain connectome Constructor
	%  disp - displays information about the perturbation-based subject individual brain connectome Constructor
	%  tree - displays the tree of the perturbation-based subject individual brain connectome Constructor
	%
	% IndividualPerturbationConConstructor methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two perturbation-based subject individual brain connectome Constructor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the perturbation-based subject individual brain connectome Constructor
	%
	% IndividualPerturbationConConstructor methods (save/load, Static):
	%  save - saves BRAPH2 perturbation-based subject individual brain connectome Constructor as b2 file
	%  load - loads a BRAPH2 perturbation-based subject individual brain connectome Constructor from a b2 file
	%
	% IndividualPerturbationConConstructor method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the perturbation-based subject individual brain connectome Constructor
	%
	% IndividualPerturbationConConstructor method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the perturbation-based subject individual brain connectome Constructor
	%
	% IndividualPerturbationConConstructor methods (inspection, Static):
	%  getClass - returns the class of the perturbation-based subject individual brain connectome Constructor
	%  getSubclasses - returns all subclasses of IndividualPerturbationConConstructor
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
	% IndividualPerturbationConConstructor methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% IndividualPerturbationConConstructor methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% IndividualPerturbationConConstructor methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% IndividualPerturbationConConstructor methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?IndividualPerturbationConConstructor; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">IndividualPerturbationConConstructor constants</a>.
	%
	%
	% See also Group, SubjectST, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		VOI_SELECTION = 14; %CET: Computational Efficiency Trick
		VOI_SELECTION_TAG = 'VOI_SELECTION';
		VOI_SELECTION_CATEGORY = 3;
		VOI_SELECTION_FORMAT = 3;
	end
	methods % constructor
		function ipc = IndividualPerturbationConConstructor(varargin)
			%IndividualPerturbationConConstructor() creates a perturbation-based subject individual brain connectome Constructor.
			%
			% IndividualPerturbationConConstructor(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% IndividualPerturbationConConstructor(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of IndividualPerturbationConConstructor properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the perturbation-based connectome constructor.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the perturbation-based connectome constructor.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the perturbation-based connectome constructor.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the perturbation-based connectome constructor.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the perturbation-based connectome constructor.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the perturbation-based connectome constructor.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the perturbation-based connectome constructor.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
			%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
			%  <strong>12</strong> <strong>CONNECTOME_CONSTRUCT_METHOD</strong> 	CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for constructing individual connectomes using perturbation with partial correlation using selected VOIs.
			%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
			%  <strong>14</strong> <strong>VOI_SELECTION</strong> 	VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.
			%
			% See also Category, Format.
			
			ipc = ipc@IndividualConConstructorBase(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the perturbation-based subject individual brain connectome Constructor.
			%
			% BUILD = IndividualPerturbationConConstructor.GETBUILD() returns the build of 'IndividualPerturbationConConstructor'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IPC.GETBUILD() returns the build of the perturbation-based subject individual brain connectome Constructor IPC.
			%  BUILD = Element.GETBUILD(IPC) returns the build of 'IPC'.
			%  BUILD = Element.GETBUILD('IndividualPerturbationConConstructor') returns the build of 'IndividualPerturbationConConstructor'.
			%
			% Note that the Element.GETBUILD(IPC) and Element.GETBUILD('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			
			build = 1;
		end
		function ipc_class = getClass()
			%GETCLASS returns the class of the perturbation-based subject individual brain connectome Constructor.
			%
			% CLASS = IndividualPerturbationConConstructor.GETCLASS() returns the class 'IndividualPerturbationConConstructor'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IPC.GETCLASS() returns the class of the perturbation-based subject individual brain connectome Constructor IPC.
			%  CLASS = Element.GETCLASS(IPC) returns the class of 'IPC'.
			%  CLASS = Element.GETCLASS('IndividualPerturbationConConstructor') returns 'IndividualPerturbationConConstructor'.
			%
			% Note that the Element.GETCLASS(IPC) and Element.GETCLASS('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			
			ipc_class = 'IndividualPerturbationConConstructor';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the perturbation-based subject individual brain connectome Constructor.
			%
			% LIST = IndividualPerturbationConConstructor.GETSUBCLASSES() returns all subclasses of 'IndividualPerturbationConConstructor'.
			%
			% Alternative forms to call this method are:
			%  LIST = IPC.GETSUBCLASSES() returns all subclasses of the perturbation-based subject individual brain connectome Constructor IPC.
			%  LIST = Element.GETSUBCLASSES(IPC) returns all subclasses of 'IPC'.
			%  LIST = Element.GETSUBCLASSES('IndividualPerturbationConConstructor') returns all subclasses of 'IndividualPerturbationConConstructor'.
			%
			% Note that the Element.GETSUBCLASSES(IPC) and Element.GETSUBCLASSES('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'IndividualPerturbationConConstructor' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of perturbation-based subject individual brain connectome Constructor.
			%
			% PROPS = IndividualPerturbationConConstructor.GETPROPS() returns the property list of perturbation-based subject individual brain connectome Constructor
			%  as a row vector.
			%
			% PROPS = IndividualPerturbationConConstructor.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IPC.GETPROPS([CATEGORY]) returns the property list of the perturbation-based subject individual brain connectome Constructor IPC.
			%  PROPS = Element.GETPROPS(IPC[, CATEGORY]) returns the property list of 'IPC'.
			%  PROPS = Element.GETPROPS('IndividualPerturbationConConstructor'[, CATEGORY]) returns the property list of 'IndividualPerturbationConConstructor'.
			%
			% Note that the Element.GETPROPS(IPC) and Element.GETPROPS('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 14];
				case 4 % Category.DATA
					prop_list = [5 10 11];
				case 5 % Category.RESULT
					prop_list = 13;
				case 6 % Category.QUERY
					prop_list = [8 12];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of perturbation-based subject individual brain connectome Constructor.
			%
			% N = IndividualPerturbationConConstructor.GETPROPNUMBER() returns the property number of perturbation-based subject individual brain connectome Constructor.
			%
			% N = IndividualPerturbationConConstructor.GETPROPNUMBER(CATEGORY) returns the property number of perturbation-based subject individual brain connectome Constructor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IPC.GETPROPNUMBER([CATEGORY]) returns the property number of the perturbation-based subject individual brain connectome Constructor IPC.
			%  N = Element.GETPROPNUMBER(IPC) returns the property number of 'IPC'.
			%  N = Element.GETPROPNUMBER('IndividualPerturbationConConstructor') returns the property number of 'IndividualPerturbationConConstructor'.
			%
			% Note that the Element.GETPROPNUMBER(IPC) and Element.GETPROPNUMBER('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 14;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in perturbation-based subject individual brain connectome Constructor/error.
			%
			% CHECK = IndividualPerturbationConConstructor.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IPC.EXISTSPROP(PROP) checks whether PROP exists for IPC.
			%  CHECK = Element.EXISTSPROP(IPC, PROP) checks whether PROP exists for IPC.
			%  CHECK = Element.EXISTSPROP(IndividualPerturbationConConstructor, PROP) checks whether PROP exists for IndividualPerturbationConConstructor.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IPC.EXISTSPROP(PROP) throws error if PROP does NOT exist for IPC.
			%   Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%  Element.EXISTSPROP(IPC, PROP) throws error if PROP does NOT exist for IPC.
			%   Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%  Element.EXISTSPROP(IndividualPerturbationConConstructor, PROP) throws error if PROP does NOT exist for IndividualPerturbationConConstructor.
			%   Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IPC) and Element.EXISTSPROP('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualPerturbationConConstructor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualPerturbationConConstructor:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for IndividualPerturbationConConstructor.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in perturbation-based subject individual brain connectome Constructor/error.
			%
			% CHECK = IndividualPerturbationConConstructor.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IPC.EXISTSTAG(TAG) checks whether TAG exists for IPC.
			%  CHECK = Element.EXISTSTAG(IPC, TAG) checks whether TAG exists for IPC.
			%  CHECK = Element.EXISTSTAG(IndividualPerturbationConConstructor, TAG) checks whether TAG exists for IndividualPerturbationConConstructor.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IPC.EXISTSTAG(TAG) throws error if TAG does NOT exist for IPC.
			%   Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%  Element.EXISTSTAG(IPC, TAG) throws error if TAG does NOT exist for IPC.
			%   Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%  Element.EXISTSTAG(IndividualPerturbationConConstructor, TAG) throws error if TAG does NOT exist for IndividualPerturbationConConstructor.
			%   Error id: [BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IPC) and Element.EXISTSTAG('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTRUCT_METHOD'  'GR'  'VOI_SELECTION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualPerturbationConConstructor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualPerturbationConConstructor:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for IndividualPerturbationConConstructor.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(IndividualPerturbationConConstructor, POINTER) returns property number of POINTER of IndividualPerturbationConConstructor.
			%  PROPERTY = IPC.GETPROPPROP(IndividualPerturbationConConstructor, POINTER) returns property number of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPPROP(IPC) and Element.GETPROPPROP('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTRUCT_METHOD'  'GR'  'VOI_SELECTION' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(IndividualPerturbationConConstructor, POINTER) returns tag of POINTER of IndividualPerturbationConConstructor.
			%  TAG = IPC.GETPROPTAG(IndividualPerturbationConConstructor, POINTER) returns tag of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPTAG(IPC) and Element.GETPROPTAG('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				individualperturbationconconstructor_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTRUCT_METHOD'  'GR'  'VOI_SELECTION' };
				tag = individualperturbationconconstructor_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(IndividualPerturbationConConstructor, POINTER) returns category of POINTER of IndividualPerturbationConConstructor.
			%  CATEGORY = IPC.GETPROPCATEGORY(IndividualPerturbationConConstructor, POINTER) returns category of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPCATEGORY(IPC) and Element.GETPROPCATEGORY('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualPerturbationConConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualperturbationconconstructor_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5  3 };
			prop_category = individualperturbationconconstructor_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(IndividualPerturbationConConstructor, POINTER) returns format of POINTER of IndividualPerturbationConConstructor.
			%  FORMAT = IPC.GETPROPFORMAT(IndividualPerturbationConConstructor, POINTER) returns format of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPFORMAT(IPC) and Element.GETPROPFORMAT('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualPerturbationConConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualperturbationconconstructor_format_list = { 2  2  2  8  2  2  2  2  4  8  8  16  8  3 };
			prop_format = individualperturbationconconstructor_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(IndividualPerturbationConConstructor, POINTER) returns description of POINTER of IndividualPerturbationConConstructor.
			%  DESCRIPTION = IPC.GETPROPDESCRIPTION(IndividualPerturbationConConstructor, POINTER) returns description of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPDESCRIPTION(IPC) and Element.GETPROPDESCRIPTION('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualPerturbationConConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualperturbationconconstructor_description_list = { 'ELCLASS (constant, string) is the class of the perturbation-based connectome constructor.'  'NAME (constant, string) is the name of the perturbation-based connectome constructor.'  'DESCRIPTION (constant, string) is the description of the perturbation-based connectome constructor.'  'TEMPLATE (parameter, item) is the template of the perturbation-based connectome constructor.'  'ID (data, string) is a few-letter code for the perturbation-based connectome constructor.'  'LABEL (metadata, string) is an extended label of the perturbation-based connectome constructor.'  'NOTES (metadata, string) are some specific notes about the perturbation-based connectome constructor.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR_SUVR (data, item) is a group of subjects with mean SUVR data.'  'GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.'  'CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for constructing individual connectomes using perturbation with partial correlation using selected VOIs.'  'GR (result, item) is a group of subjects with connectivity data.'  'VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.' };
			prop_description = individualperturbationconconstructor_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(IndividualPerturbationConConstructor, POINTER) returns settings of POINTER of IndividualPerturbationConConstructor.
			%  SETTINGS = IPC.GETPROPSETTINGS(IndividualPerturbationConConstructor, POINTER) returns settings of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPSETTINGS(IPC) and Element.GETPROPSETTINGS('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualPerturbationConConstructor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % IndividualPerturbationConConstructor.VOI_SELECTION
					prop_settings = Format.getFormatSettings(3);
				case 4 % IndividualPerturbationConConstructor.TEMPLATE
					prop_settings = 'IndividualPerturbationConConstructor';
				otherwise
					prop_settings = getPropSettings@IndividualConConstructorBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = IndividualPerturbationConConstructor.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualPerturbationConConstructor.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IPC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IPC.
			%  DEFAULT = Element.GETPROPDEFAULT(IndividualPerturbationConConstructor, POINTER) returns the default value of POINTER of IndividualPerturbationConConstructor.
			%  DEFAULT = IPC.GETPROPDEFAULT(IndividualPerturbationConConstructor, POINTER) returns the default value of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPDEFAULT(IPC) and Element.GETPROPDEFAULT('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndividualPerturbationConConstructor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % IndividualPerturbationConConstructor.VOI_SELECTION
					prop_default = {'Age', 'Sex', 'Education'}; % Example: Default selected VOIs;
				case 1 % IndividualPerturbationConConstructor.ELCLASS
					prop_default = 'IndividualPerturbationConConstructor';
				case 2 % IndividualPerturbationConConstructor.NAME
					prop_default = 'Individual Perturbation Connectome Constructor';
				case 3 % IndividualPerturbationConConstructor.DESCRIPTION
					prop_default = 'IndividualPerturbationConConstructor constructs individual connectomes using perturbation method with partial correlation using selected VOIs';
				case 4 % IndividualPerturbationConConstructor.TEMPLATE
					prop_default = Format.getFormatDefault(8, IndividualPerturbationConConstructor.getPropSettings(prop));
				case 5 % IndividualPerturbationConConstructor.ID
					prop_default = 'IndividualPerturbationConConstructor ID';
				case 6 % IndividualPerturbationConConstructor.LABEL
					prop_default = 'IndividualPerturbationConConstructor label';
				case 7 % IndividualPerturbationConConstructor.NOTES
					prop_default = 'IndividualPerturbationConConstructor notes';
				otherwise
					prop_default = getPropDefault@IndividualConConstructorBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = IndividualPerturbationConConstructor.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualPerturbationConConstructor.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IPC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IPC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(IndividualPerturbationConConstructor, POINTER) returns the conditioned default value of POINTER of IndividualPerturbationConConstructor.
			%  DEFAULT = IPC.GETPROPDEFAULTCONDITIONED(IndividualPerturbationConConstructor, POINTER) returns the conditioned default value of POINTER of IndividualPerturbationConConstructor.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IPC) and Element.GETPROPDEFAULTCONDITIONED('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = IndividualPerturbationConConstructor.getPropProp(pointer);
			
			prop_default = IndividualPerturbationConConstructor.conditioning(prop, IndividualPerturbationConConstructor.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(IndividualPerturbationConConstructor, PROP, VALUE) checks VALUE format for PROP of IndividualPerturbationConConstructor.
			%  CHECK = IPC.CHECKPROP(IndividualPerturbationConConstructor, PROP, VALUE) checks VALUE format for PROP of IndividualPerturbationConConstructor.
			% 
			% IPC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:IndividualPerturbationConConstructor:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IPC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IPC.
			%   Error id: BRAPH2:IndividualPerturbationConConstructor:WrongInput
			%  Element.CHECKPROP(IndividualPerturbationConConstructor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualPerturbationConConstructor.
			%   Error id: BRAPH2:IndividualPerturbationConConstructor:WrongInput
			%  IPC.CHECKPROP(IndividualPerturbationConConstructor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualPerturbationConConstructor.
			%   Error id: BRAPH2:IndividualPerturbationConConstructor:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IPC) and Element.CHECKPROP('IndividualPerturbationConConstructor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = IndividualPerturbationConConstructor.getPropProp(pointer);
			
			switch prop
				case 14 % IndividualPerturbationConConstructor.VOI_SELECTION
					check = Format.checkFormat(3, value, IndividualPerturbationConConstructor.getPropSettings(prop));
				case 4 % IndividualPerturbationConConstructor.TEMPLATE
					check = Format.checkFormat(8, value, IndividualPerturbationConConstructor.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@IndividualConConstructorBase(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualPerturbationConConstructor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualPerturbationConConstructor:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' IndividualPerturbationConConstructor.getPropTag(prop) ' (' IndividualPerturbationConConstructor.getFormatTag(IndividualPerturbationConConstructor.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ipc, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 12 % IndividualPerturbationConConstructor.CONNECTOME_CONSTRUCT_METHOD
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
					DiagMask = diag(ones(num_regions, 1));
					R_adjusted = R - DiagMask;
					
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
					if prop <= 13
						value = calculateValue@IndividualConConstructorBase(ipc, prop, varargin{:});
					else
						value = calculateValue@Element(ipc, prop, varargin{:});
					end
			end
			
		end
	end
end
