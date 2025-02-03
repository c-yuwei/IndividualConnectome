classdef IndividualDeviationConConstructor < IndividualConConstructorBase
	%IndividualDeviationConConstructor Construct deviation based brain connecome from subjects with nifti files.
	% It is a subclass of <a href="matlab:help IndividualConConstructorBase">IndividualConConstructorBase</a>.
	%
	% IndividualDeviationConConstructor imports a group of subjects with regional SUVR  
	%  (standarize uptake value ratio) data from a series of Nifti files 
	%  contained in a folder named "group_data". All these files must be in the same 
	%  folder; also, no other files should be in the folder. Each file contains a 
	%  matrix of values corresponding to the intensity distribution of brain regions.
	%  The connectivity matrix constructed based on Mahanlanobis Distance is returned
	%  from ImporterIndividual_Distance_XLS.
	% The variables of interest are from another XLS/XLSX file named "SUVR_GROUP_MAT.vois.xlsx" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% The list of IndividualDeviationConConstructor properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the CON subject group importer from XLS/XLSX.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the CON subject group importer from XLS/XLSX.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the CON subject individual importer from XLS/XLSX.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the CON subject individual importer from XLS/XLSX.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the CON subject individual importer from XLS/XLSX.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the CON subject individual importer from XLS/XLSX.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the CON subject individual importer from XLS/XLSX.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
	%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
	%  <strong>12</strong> <strong>CONNECTOME_CONSTUCT_METHOD</strong> 	CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for z-scoring individual connectome construction.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
	%
	% IndividualDeviationConConstructor methods (constructor):
	%  IndividualDeviationConConstructor - constructor
	%
	% IndividualDeviationConConstructor methods:
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
	% IndividualDeviationConConstructor methods (display):
	%  tostring - string with information about the deviation-based subject individual brain connectome Constructor
	%  disp - displays information about the deviation-based subject individual brain connectome Constructor
	%  tree - displays the tree of the deviation-based subject individual brain connectome Constructor
	%
	% IndividualDeviationConConstructor methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two deviation-based subject individual brain connectome Constructor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the deviation-based subject individual brain connectome Constructor
	%
	% IndividualDeviationConConstructor methods (save/load, Static):
	%  save - saves BRAPH2 deviation-based subject individual brain connectome Constructor as b2 file
	%  load - loads a BRAPH2 deviation-based subject individual brain connectome Constructor from a b2 file
	%
	% IndividualDeviationConConstructor method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the deviation-based subject individual brain connectome Constructor
	%
	% IndividualDeviationConConstructor method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the deviation-based subject individual brain connectome Constructor
	%
	% IndividualDeviationConConstructor methods (inspection, Static):
	%  getClass - returns the class of the deviation-based subject individual brain connectome Constructor
	%  getSubclasses - returns all subclasses of IndividualDeviationConConstructor
	%  getProps - returns the property list of the deviation-based subject individual brain connectome Constructor
	%  getPropNumber - returns the property number of the deviation-based subject individual brain connectome Constructor
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
	% IndividualDeviationConConstructor methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% IndividualDeviationConConstructor methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% IndividualDeviationConConstructor methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% IndividualDeviationConConstructor methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?IndividualDeviationConConstructor; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">IndividualDeviationConConstructor constants</a>.
	%
	%
	% See also Group, SubjectCON, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 6 class_name 1
	
	methods % constructor
		function icdd = IndividualDeviationConConstructor(varargin)
			%IndividualDeviationConConstructor() creates a deviation-based subject individual brain connectome Constructor.
			%
			% IndividualDeviationConConstructor(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% IndividualDeviationConConstructor(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of IndividualDeviationConConstructor properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the CON subject group importer from XLS/XLSX.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the CON subject group importer from XLS/XLSX.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the CON subject individual importer from XLS/XLSX.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the CON subject individual importer from XLS/XLSX.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the CON subject individual importer from XLS/XLSX.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the CON subject individual importer from XLS/XLSX.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the CON subject individual importer from XLS/XLSX.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
			%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
			%  <strong>12</strong> <strong>CONNECTOME_CONSTUCT_METHOD</strong> 	CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for z-scoring individual connectome construction.
			%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
			%
			% See also Category, Format.
			
			icdd = icdd@IndividualConConstructorBase(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the deviation-based subject individual brain connectome Constructor.
			%
			% BUILD = IndividualDeviationConConstructor.GETBUILD() returns the build of 'IndividualDeviationConConstructor'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ICDD.GETBUILD() returns the build of the deviation-based subject individual brain connectome Constructor ICDD.
			%  BUILD = Element.GETBUILD(ICDD) returns the build of 'ICDD'.
			%  BUILD = Element.GETBUILD('IndividualDeviationConConstructor') returns the build of 'IndividualDeviationConConstructor'.
			%
			% Note that the Element.GETBUILD(ICDD) and Element.GETBUILD('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			
			build = 1;
		end
		function icdd_class = getClass()
			%GETCLASS returns the class of the deviation-based subject individual brain connectome Constructor.
			%
			% CLASS = IndividualDeviationConConstructor.GETCLASS() returns the class 'IndividualDeviationConConstructor'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ICDD.GETCLASS() returns the class of the deviation-based subject individual brain connectome Constructor ICDD.
			%  CLASS = Element.GETCLASS(ICDD) returns the class of 'ICDD'.
			%  CLASS = Element.GETCLASS('IndividualDeviationConConstructor') returns 'IndividualDeviationConConstructor'.
			%
			% Note that the Element.GETCLASS(ICDD) and Element.GETCLASS('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			
			icdd_class = 'IndividualDeviationConConstructor';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the deviation-based subject individual brain connectome Constructor.
			%
			% LIST = IndividualDeviationConConstructor.GETSUBCLASSES() returns all subclasses of 'IndividualDeviationConConstructor'.
			%
			% Alternative forms to call this method are:
			%  LIST = ICDD.GETSUBCLASSES() returns all subclasses of the deviation-based subject individual brain connectome Constructor ICDD.
			%  LIST = Element.GETSUBCLASSES(ICDD) returns all subclasses of 'ICDD'.
			%  LIST = Element.GETSUBCLASSES('IndividualDeviationConConstructor') returns all subclasses of 'IndividualDeviationConConstructor'.
			%
			% Note that the Element.GETSUBCLASSES(ICDD) and Element.GETSUBCLASSES('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'IndividualDeviationConConstructor' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of deviation-based subject individual brain connectome Constructor.
			%
			% PROPS = IndividualDeviationConConstructor.GETPROPS() returns the property list of deviation-based subject individual brain connectome Constructor
			%  as a row vector.
			%
			% PROPS = IndividualDeviationConConstructor.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ICDD.GETPROPS([CATEGORY]) returns the property list of the deviation-based subject individual brain connectome Constructor ICDD.
			%  PROPS = Element.GETPROPS(ICDD[, CATEGORY]) returns the property list of 'ICDD'.
			%  PROPS = Element.GETPROPS('IndividualDeviationConConstructor'[, CATEGORY]) returns the property list of 'IndividualDeviationConConstructor'.
			%
			% Note that the Element.GETPROPS(ICDD) and Element.GETPROPS('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
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
			%GETPROPNUMBER returns the property number of deviation-based subject individual brain connectome Constructor.
			%
			% N = IndividualDeviationConConstructor.GETPROPNUMBER() returns the property number of deviation-based subject individual brain connectome Constructor.
			%
			% N = IndividualDeviationConConstructor.GETPROPNUMBER(CATEGORY) returns the property number of deviation-based subject individual brain connectome Constructor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ICDD.GETPROPNUMBER([CATEGORY]) returns the property number of the deviation-based subject individual brain connectome Constructor ICDD.
			%  N = Element.GETPROPNUMBER(ICDD) returns the property number of 'ICDD'.
			%  N = Element.GETPROPNUMBER('IndividualDeviationConConstructor') returns the property number of 'IndividualDeviationConConstructor'.
			%
			% Note that the Element.GETPROPNUMBER(ICDD) and Element.GETPROPNUMBER('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
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
			%EXISTSPROP checks whether property exists in deviation-based subject individual brain connectome Constructor/error.
			%
			% CHECK = IndividualDeviationConConstructor.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ICDD.EXISTSPROP(PROP) checks whether PROP exists for ICDD.
			%  CHECK = Element.EXISTSPROP(ICDD, PROP) checks whether PROP exists for ICDD.
			%  CHECK = Element.EXISTSPROP(IndividualDeviationConConstructor, PROP) checks whether PROP exists for IndividualDeviationConConstructor.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ICDD.EXISTSPROP(PROP) throws error if PROP does NOT exist for ICDD.
			%   Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%  Element.EXISTSPROP(ICDD, PROP) throws error if PROP does NOT exist for ICDD.
			%   Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%  Element.EXISTSPROP(IndividualDeviationConConstructor, PROP) throws error if PROP does NOT exist for IndividualDeviationConConstructor.
			%   Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ICDD) and Element.EXISTSPROP('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualDeviationConConstructor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualDeviationConConstructor:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for IndividualDeviationConConstructor.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in deviation-based subject individual brain connectome Constructor/error.
			%
			% CHECK = IndividualDeviationConConstructor.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ICDD.EXISTSTAG(TAG) checks whether TAG exists for ICDD.
			%  CHECK = Element.EXISTSTAG(ICDD, TAG) checks whether TAG exists for ICDD.
			%  CHECK = Element.EXISTSTAG(IndividualDeviationConConstructor, TAG) checks whether TAG exists for IndividualDeviationConConstructor.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ICDD.EXISTSTAG(TAG) throws error if TAG does NOT exist for ICDD.
			%   Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%  Element.EXISTSTAG(ICDD, TAG) throws error if TAG does NOT exist for ICDD.
			%   Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%  Element.EXISTSTAG(IndividualDeviationConConstructor, TAG) throws error if TAG does NOT exist for IndividualDeviationConConstructor.
			%   Error id: [BRAPH2:IndividualDeviationConConstructor:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ICDD) and Element.EXISTSTAG('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualDeviationConConstructor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualDeviationConConstructor:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for IndividualDeviationConConstructor.'] ...
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
			%  PROPERTY = ICDD.GETPROPPROP(POINTER) returns property number of POINTER of ICDD.
			%  PROPERTY = Element.GETPROPPROP(IndividualDeviationConConstructor, POINTER) returns property number of POINTER of IndividualDeviationConConstructor.
			%  PROPERTY = ICDD.GETPROPPROP(IndividualDeviationConConstructor, POINTER) returns property number of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPPROP(ICDD) and Element.GETPROPPROP('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = ICDD.GETPROPTAG(POINTER) returns tag of POINTER of ICDD.
			%  TAG = Element.GETPROPTAG(IndividualDeviationConConstructor, POINTER) returns tag of POINTER of IndividualDeviationConConstructor.
			%  TAG = ICDD.GETPROPTAG(IndividualDeviationConConstructor, POINTER) returns tag of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPTAG(ICDD) and Element.GETPROPTAG('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				individualdeviationconconstructor_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' };
				tag = individualdeviationconconstructor_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = ICDD.GETPROPCATEGORY(POINTER) returns category of POINTER of ICDD.
			%  CATEGORY = Element.GETPROPCATEGORY(IndividualDeviationConConstructor, POINTER) returns category of POINTER of IndividualDeviationConConstructor.
			%  CATEGORY = ICDD.GETPROPCATEGORY(IndividualDeviationConConstructor, POINTER) returns category of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPCATEGORY(ICDD) and Element.GETPROPCATEGORY('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualDeviationConConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualdeviationconconstructor_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = individualdeviationconconstructor_category_list{prop};
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
			%  FORMAT = ICDD.GETPROPFORMAT(POINTER) returns format of POINTER of ICDD.
			%  FORMAT = Element.GETPROPFORMAT(IndividualDeviationConConstructor, POINTER) returns format of POINTER of IndividualDeviationConConstructor.
			%  FORMAT = ICDD.GETPROPFORMAT(IndividualDeviationConConstructor, POINTER) returns format of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPFORMAT(ICDD) and Element.GETPROPFORMAT('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualDeviationConConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualdeviationconconstructor_format_list = { 2  2  2  8  2  2  2  2  4  8  8  16  8 };
			prop_format = individualdeviationconconstructor_format_list{prop};
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
			%  DESCRIPTION = ICDD.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ICDD.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(IndividualDeviationConConstructor, POINTER) returns description of POINTER of IndividualDeviationConConstructor.
			%  DESCRIPTION = ICDD.GETPROPDESCRIPTION(IndividualDeviationConConstructor, POINTER) returns description of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPDESCRIPTION(ICDD) and Element.GETPROPDESCRIPTION('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualDeviationConConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualdeviationconconstructor_description_list = { 'ELCLASS (constant, string) is the class of the CON subject group importer from XLS/XLSX.'  'NAME (constant, string) is the name of the CON subject group importer from XLS/XLSX.'  'DESCRIPTION (constant, string) is the description of the CON subject individual importer from XLS/XLSX.'  'TEMPLATE (parameter, item) is the template of the CON subject individual importer from XLS/XLSX.'  'ID (data, string) is a few-letter code for the CON subject individual importer from XLS/XLSX.'  'LABEL (metadata, string) is an extended label of the CON subject individual importer from XLS/XLSX.'  'NOTES (metadata, string) are some specific notes about the CON subject individual importer from XLS/XLSX.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR_SUVR (data, item) is a group of subjects with mean SUVR data.'  'GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.'  'CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for z-scoring individual connectome construction.'  'GR (result, item) is a group of subjects with connectivity data.' };
			prop_description = individualdeviationconconstructor_description_list{prop};
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
			%  SETTINGS = ICDD.GETPROPSETTINGS(POINTER) returns settings of POINTER of ICDD.
			%  SETTINGS = Element.GETPROPSETTINGS(IndividualDeviationConConstructor, POINTER) returns settings of POINTER of IndividualDeviationConConstructor.
			%  SETTINGS = ICDD.GETPROPSETTINGS(IndividualDeviationConConstructor, POINTER) returns settings of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPSETTINGS(ICDD) and Element.GETPROPSETTINGS('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualDeviationConConstructor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % IndividualDeviationConConstructor.TEMPLATE
					prop_settings = 'IndividualDeviationConConstructor';
				otherwise
					prop_settings = getPropSettings@IndividualConConstructorBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = IndividualDeviationConConstructor.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualDeviationConConstructor.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ICDD.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ICDD.
			%  DEFAULT = Element.GETPROPDEFAULT(IndividualDeviationConConstructor, POINTER) returns the default value of POINTER of IndividualDeviationConConstructor.
			%  DEFAULT = ICDD.GETPROPDEFAULT(IndividualDeviationConConstructor, POINTER) returns the default value of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPDEFAULT(ICDD) and Element.GETPROPDEFAULT('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndividualDeviationConConstructor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % IndividualDeviationConConstructor.ELCLASS
					prop_default = 'IndividualDeviationConConstructor';
				case 2 % IndividualDeviationConConstructor.NAME
					prop_default = 'Individual Subject Deviation Connectome Constructor';
				case 3 % IndividualDeviationConConstructor.DESCRIPTION
					prop_default = 'IndividualDeviationConConstructor imports a group of subjects with connectivity data from a series of XLS/XLSX file. The variables of interest can be loaded from another XLS/XLSX file.';
				case 4 % IndividualDeviationConConstructor.TEMPLATE
					prop_default = Format.getFormatDefault(8, IndividualDeviationConConstructor.getPropSettings(prop));
				case 5 % IndividualDeviationConConstructor.ID
					prop_default = 'IndividualDeviationConConstructor ID';
				case 6 % IndividualDeviationConConstructor.LABEL
					prop_default = 'IndividualDeviationConConstructor label';
				case 7 % IndividualDeviationConConstructor.NOTES
					prop_default = 'IndividualDeviationConstructor notes';
				otherwise
					prop_default = getPropDefault@IndividualConConstructorBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = IndividualDeviationConConstructor.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualDeviationConConstructor.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ICDD.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ICDD.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(IndividualDeviationConConstructor, POINTER) returns the conditioned default value of POINTER of IndividualDeviationConConstructor.
			%  DEFAULT = ICDD.GETPROPDEFAULTCONDITIONED(IndividualDeviationConConstructor, POINTER) returns the conditioned default value of POINTER of IndividualDeviationConConstructor.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ICDD) and Element.GETPROPDEFAULTCONDITIONED('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = IndividualDeviationConConstructor.getPropProp(pointer);
			
			prop_default = IndividualDeviationConConstructor.conditioning(prop, IndividualDeviationConConstructor.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ICDD.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ICDD.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ICDD.
			%  CHECK = Element.CHECKPROP(IndividualDeviationConConstructor, PROP, VALUE) checks VALUE format for PROP of IndividualDeviationConConstructor.
			%  CHECK = ICDD.CHECKPROP(IndividualDeviationConConstructor, PROP, VALUE) checks VALUE format for PROP of IndividualDeviationConConstructor.
			% 
			% ICDD.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:IndividualDeviationConConstructor:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ICDD.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ICDD.
			%   Error id: BRAPH2:IndividualDeviationConConstructor:WrongInput
			%  Element.CHECKPROP(IndividualDeviationConConstructor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualDeviationConConstructor.
			%   Error id: BRAPH2:IndividualDeviationConConstructor:WrongInput
			%  ICDD.CHECKPROP(IndividualDeviationConConstructor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualDeviationConConstructor.
			%   Error id: BRAPH2:IndividualDeviationConConstructor:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ICDD) and Element.CHECKPROP('IndividualDeviationConConstructor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = IndividualDeviationConConstructor.getPropProp(pointer);
			
			switch prop
				case 4 % IndividualDeviationConConstructor.TEMPLATE
					check = Format.checkFormat(8, value, IndividualDeviationConConstructor.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@IndividualConConstructorBase(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualDeviationConConstructor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualDeviationConConstructor:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' IndividualDeviationConConstructor.getPropTag(prop) ' (' IndividualDeviationConConstructor.getFormatTag(IndividualDeviationConConstructor.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(icdd, prop, varargin)
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
				case 12 % IndividualDeviationConConstructor.CONNECTOME_CONSTUCT_METHOD
					if isempty(varargin) && isempty(icdd.get('GR_SUVR').get('SUB_DICT').get('IT_LIST'))
					    value = {};
					    return
					end
					gr_suvr = icdd.get('GR_SUVR');
					gr_suvr_reference = icdd.get('GR_SUVR_REF');
					% healthy subjects
					healthySUVRValues = [];
					for i = 1:1:gr_suvr_reference.get('SUB_DICT').get('LENGTH')
					    meanSUVR_values_region = gr_suvr_reference.get('SUB_DICT').get('IT',i).get('ST');
					    healthySUVRValues = [healthySUVRValues, meanSUVR_values_region];
					end
					
					% Calculate global mean and std deviation for each region across healthy subjects
					globalMeanHealthySUVR = mean(healthySUVRValues, 2); % Mean across subjects for each region
					globalStdHealthySUVR = std(healthySUVRValues, 0, 2); % Std deviation across subjects for each region
					zscorematrix_cross_subjects = {};
					for i = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
					    meanSUVR_values_region = gr_suvr.get('SUB_DICT').get('IT',i).get('ST');
					    sub_id = gr_suvr.get('SUB_DICT').get('IT',i).get('ID');
					    numROIs = length(meanSUVR_values_region);
					    zScoreConnectivityMatrix = zeros(numROIs, numROIs);
					    % Compute z-scores for each ROI pair
					    for m = 1:numROIs
					        for n = 1:numROIs
					            if m ~= n % Avoid diagonal
					                avgSUVR_m = meanSUVR_values_region(m);
					                avgSUVR_n = meanSUVR_values_region(n);
					                zScore_m = (avgSUVR_m - globalMeanHealthySUVR(m)) / globalStdHealthySUVR(m);
					                zScore_n = (avgSUVR_n - globalMeanHealthySUVR(n)) / globalStdHealthySUVR(n);
					
					                %if zScore_m * zScore_n > 0
					                zScoreConnectivityMatrix(m, n) = (abs(zScore_m)+abs(zScore_n))/2;
					            else
					                zScoreConnectivityMatrix(m, n) = 0;
					            end
					        end
					    end
					    zscorematrix_cross_subjects{i} = zScoreConnectivityMatrix;
					end
					value = zscorematrix_cross_subjects;
					
				otherwise
					if prop <= 13
						value = calculateValue@IndividualConConstructorBase(icdd, prop, varargin{:});
					else
						value = calculateValue@Element(icdd, prop, varargin{:});
					end
			end
			
		end
	end
end
