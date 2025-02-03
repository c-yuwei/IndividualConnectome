classdef IndividualDistanceConConsturctor < IndividualConConstructorBase
	%IndividualDistanceConConsturctor imports a group of subjects with regional SUVR data from a series of XLS/XLSX file.
	% It is a subclass of <a href="matlab:help IndividualConConstructorBase">IndividualConConstructorBase</a>.
	%
	% IndividualDistanceConConsturctor imports a group of subjects with mean SUVR  
	%  (standarize uptake value ratio) data from a series of nifti files 
	%  contained in a folder named "group_data". All these files must be in the same 
	%  folder; also, no other files should be in the folder. Each file contains a 
	%  matrix of values corresponding to the intensity distribution of brain regions.
	%  The connectivity matrix constructed based on Mahanlanobis Distance is returned
	%  from ImporterIndividual_Distance_XLS.
	% The variables of interest are from another Nifti file named "SUVR_GROUP_MAT.vois.xlsx" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% The list of IndividualDistanceConConsturctor properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject individual distance based connectivity constructor.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject individual distance based connectivity constructor.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject individual distance based connectivity constructor.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject individual distance based connectivity constructor.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject individual distance based connectivity constructor.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject individual distance based connectivity constructor.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject individual distance based connectivity constructor.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
	%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
	%  <strong>12</strong> <strong>CONNECTOME_CONSTUCT_METHOD</strong> 	CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for Mahalanobis distance individual connectome construction.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
	%
	% IndividualDistanceConConsturctor methods (constructor):
	%  IndividualDistanceConConsturctor - constructor
	%
	% IndividualDistanceConConsturctor methods:
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
	% IndividualDistanceConConsturctor methods (display):
	%  tostring - string with information about the importer of SUVR subject group from .mat
	%  disp - displays information about the importer of SUVR subject group from .mat
	%  tree - displays the tree of the importer of SUVR subject group from .mat
	%
	% IndividualDistanceConConsturctor methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of SUVR subject group from .mat are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of SUVR subject group from .mat
	%
	% IndividualDistanceConConsturctor methods (save/load, Static):
	%  save - saves BRAPH2 importer of SUVR subject group from .mat as b2 file
	%  load - loads a BRAPH2 importer of SUVR subject group from .mat from a b2 file
	%
	% IndividualDistanceConConsturctor method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of SUVR subject group from .mat
	%
	% IndividualDistanceConConsturctor method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of SUVR subject group from .mat
	%
	% IndividualDistanceConConsturctor methods (inspection, Static):
	%  getClass - returns the class of the importer of SUVR subject group from .mat
	%  getSubclasses - returns all subclasses of IndividualDistanceConConsturctor
	%  getProps - returns the property list of the importer of SUVR subject group from .mat
	%  getPropNumber - returns the property number of the importer of SUVR subject group from .mat
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
	% IndividualDistanceConConsturctor methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% IndividualDistanceConConsturctor methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% IndividualDistanceConConsturctor methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% IndividualDistanceConConsturctor methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?IndividualDistanceConConsturctor; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">IndividualDistanceConConsturctor constants</a>.
	%
	%
	% See also Group, SubjectCON, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 6 class_name 1
	
	methods % constructor
		function icd = IndividualDistanceConConsturctor(varargin)
			%IndividualDistanceConConsturctor() creates a importer of SUVR subject group from .mat.
			%
			% IndividualDistanceConConsturctor(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% IndividualDistanceConConsturctor(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of IndividualDistanceConConsturctor properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject individual distance based connectivity constructor.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject individual distance based connectivity constructor.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject individual distance based connectivity constructor.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject individual distance based connectivity constructor.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject individual distance based connectivity constructor.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject individual distance based connectivity constructor.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject individual distance based connectivity constructor.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR_SUVR</strong> 	GR_SUVR (data, item) is a group of subjects with mean SUVR data.
			%  <strong>11</strong> <strong>GR_SUVR_REF</strong> 	GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.
			%  <strong>12</strong> <strong>CONNECTOME_CONSTUCT_METHOD</strong> 	CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for Mahalanobis distance individual connectome construction.
			%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity data.
			%
			% See also Category, Format.
			
			icd = icd@IndividualConConstructorBase(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the importer of SUVR subject group from .mat.
			%
			% BUILD = IndividualDistanceConConsturctor.GETBUILD() returns the build of 'IndividualDistanceConConsturctor'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ICD.GETBUILD() returns the build of the importer of SUVR subject group from .mat ICD.
			%  BUILD = Element.GETBUILD(ICD) returns the build of 'ICD'.
			%  BUILD = Element.GETBUILD('IndividualDistanceConConsturctor') returns the build of 'IndividualDistanceConConsturctor'.
			%
			% Note that the Element.GETBUILD(ICD) and Element.GETBUILD('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			
			build = 1;
		end
		function icd_class = getClass()
			%GETCLASS returns the class of the importer of SUVR subject group from .mat.
			%
			% CLASS = IndividualDistanceConConsturctor.GETCLASS() returns the class 'IndividualDistanceConConsturctor'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ICD.GETCLASS() returns the class of the importer of SUVR subject group from .mat ICD.
			%  CLASS = Element.GETCLASS(ICD) returns the class of 'ICD'.
			%  CLASS = Element.GETCLASS('IndividualDistanceConConsturctor') returns 'IndividualDistanceConConsturctor'.
			%
			% Note that the Element.GETCLASS(ICD) and Element.GETCLASS('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			
			icd_class = 'IndividualDistanceConConsturctor';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of SUVR subject group from .mat.
			%
			% LIST = IndividualDistanceConConsturctor.GETSUBCLASSES() returns all subclasses of 'IndividualDistanceConConsturctor'.
			%
			% Alternative forms to call this method are:
			%  LIST = ICD.GETSUBCLASSES() returns all subclasses of the importer of SUVR subject group from .mat ICD.
			%  LIST = Element.GETSUBCLASSES(ICD) returns all subclasses of 'ICD'.
			%  LIST = Element.GETSUBCLASSES('IndividualDistanceConConsturctor') returns all subclasses of 'IndividualDistanceConConsturctor'.
			%
			% Note that the Element.GETSUBCLASSES(ICD) and Element.GETSUBCLASSES('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'IndividualDistanceConConsturctor' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of SUVR subject group from .mat.
			%
			% PROPS = IndividualDistanceConConsturctor.GETPROPS() returns the property list of importer of SUVR subject group from .mat
			%  as a row vector.
			%
			% PROPS = IndividualDistanceConConsturctor.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ICD.GETPROPS([CATEGORY]) returns the property list of the importer of SUVR subject group from .mat ICD.
			%  PROPS = Element.GETPROPS(ICD[, CATEGORY]) returns the property list of 'ICD'.
			%  PROPS = Element.GETPROPS('IndividualDistanceConConsturctor'[, CATEGORY]) returns the property list of 'IndividualDistanceConConsturctor'.
			%
			% Note that the Element.GETPROPS(ICD) and Element.GETPROPS('IndividualDistanceConConsturctor')
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
			%GETPROPNUMBER returns the property number of importer of SUVR subject group from .mat.
			%
			% N = IndividualDistanceConConsturctor.GETPROPNUMBER() returns the property number of importer of SUVR subject group from .mat.
			%
			% N = IndividualDistanceConConsturctor.GETPROPNUMBER(CATEGORY) returns the property number of importer of SUVR subject group from .mat
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ICD.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of SUVR subject group from .mat ICD.
			%  N = Element.GETPROPNUMBER(ICD) returns the property number of 'ICD'.
			%  N = Element.GETPROPNUMBER('IndividualDistanceConConsturctor') returns the property number of 'IndividualDistanceConConsturctor'.
			%
			% Note that the Element.GETPROPNUMBER(ICD) and Element.GETPROPNUMBER('IndividualDistanceConConsturctor')
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
			%EXISTSPROP checks whether property exists in importer of SUVR subject group from .mat/error.
			%
			% CHECK = IndividualDistanceConConsturctor.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ICD.EXISTSPROP(PROP) checks whether PROP exists for ICD.
			%  CHECK = Element.EXISTSPROP(ICD, PROP) checks whether PROP exists for ICD.
			%  CHECK = Element.EXISTSPROP(IndividualDistanceConConsturctor, PROP) checks whether PROP exists for IndividualDistanceConConsturctor.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ICD.EXISTSPROP(PROP) throws error if PROP does NOT exist for ICD.
			%   Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%  Element.EXISTSPROP(ICD, PROP) throws error if PROP does NOT exist for ICD.
			%   Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%  Element.EXISTSPROP(IndividualDistanceConConsturctor, PROP) throws error if PROP does NOT exist for IndividualDistanceConConsturctor.
			%   Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ICD) and Element.EXISTSPROP('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualDistanceConConsturctor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualDistanceConConsturctor:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for IndividualDistanceConConsturctor.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of SUVR subject group from .mat/error.
			%
			% CHECK = IndividualDistanceConConsturctor.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ICD.EXISTSTAG(TAG) checks whether TAG exists for ICD.
			%  CHECK = Element.EXISTSTAG(ICD, TAG) checks whether TAG exists for ICD.
			%  CHECK = Element.EXISTSTAG(IndividualDistanceConConsturctor, TAG) checks whether TAG exists for IndividualDistanceConConsturctor.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ICD.EXISTSTAG(TAG) throws error if TAG does NOT exist for ICD.
			%   Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%  Element.EXISTSTAG(ICD, TAG) throws error if TAG does NOT exist for ICD.
			%   Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%  Element.EXISTSTAG(IndividualDistanceConConsturctor, TAG) throws error if TAG does NOT exist for IndividualDistanceConConsturctor.
			%   Error id: [BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ICD) and Element.EXISTSTAG('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualDistanceConConsturctor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualDistanceConConsturctor:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for IndividualDistanceConConsturctor.'] ...
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
			%  PROPERTY = ICD.GETPROPPROP(POINTER) returns property number of POINTER of ICD.
			%  PROPERTY = Element.GETPROPPROP(IndividualDistanceConConsturctor, POINTER) returns property number of POINTER of IndividualDistanceConConsturctor.
			%  PROPERTY = ICD.GETPROPPROP(IndividualDistanceConConsturctor, POINTER) returns property number of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPPROP(ICD) and Element.GETPROPPROP('IndividualDistanceConConsturctor')
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
			%  TAG = ICD.GETPROPTAG(POINTER) returns tag of POINTER of ICD.
			%  TAG = Element.GETPROPTAG(IndividualDistanceConConsturctor, POINTER) returns tag of POINTER of IndividualDistanceConConsturctor.
			%  TAG = ICD.GETPROPTAG(IndividualDistanceConConsturctor, POINTER) returns tag of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPTAG(ICD) and Element.GETPROPTAG('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				individualdistanceconconsturctor_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_SUVR'  'GR_SUVR_REF'  'CONNECTOME_CONSTUCT_METHOD'  'GR' };
				tag = individualdistanceconconsturctor_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = ICD.GETPROPCATEGORY(POINTER) returns category of POINTER of ICD.
			%  CATEGORY = Element.GETPROPCATEGORY(IndividualDistanceConConsturctor, POINTER) returns category of POINTER of IndividualDistanceConConsturctor.
			%  CATEGORY = ICD.GETPROPCATEGORY(IndividualDistanceConConsturctor, POINTER) returns category of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPCATEGORY(ICD) and Element.GETPROPCATEGORY('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualDistanceConConsturctor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualdistanceconconsturctor_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = individualdistanceconconsturctor_category_list{prop};
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
			%  FORMAT = ICD.GETPROPFORMAT(POINTER) returns format of POINTER of ICD.
			%  FORMAT = Element.GETPROPFORMAT(IndividualDistanceConConsturctor, POINTER) returns format of POINTER of IndividualDistanceConConsturctor.
			%  FORMAT = ICD.GETPROPFORMAT(IndividualDistanceConConsturctor, POINTER) returns format of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPFORMAT(ICD) and Element.GETPROPFORMAT('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualDistanceConConsturctor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualdistanceconconsturctor_format_list = { 2  2  2  8  2  2  2  2  4  8  8  16  8 };
			prop_format = individualdistanceconconsturctor_format_list{prop};
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
			%  DESCRIPTION = ICD.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ICD.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(IndividualDistanceConConsturctor, POINTER) returns description of POINTER of IndividualDistanceConConsturctor.
			%  DESCRIPTION = ICD.GETPROPDESCRIPTION(IndividualDistanceConConsturctor, POINTER) returns description of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPDESCRIPTION(ICD) and Element.GETPROPDESCRIPTION('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = IndividualDistanceConConsturctor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			individualdistanceconconsturctor_description_list = { 'ELCLASS (constant, string) is the class of the subject individual distance based connectivity constructor.'  'NAME (constant, string) is the name of the subject individual distance based connectivity constructor.'  'DESCRIPTION (constant, string) is the description of the subject individual distance based connectivity constructor.'  'TEMPLATE (parameter, item) is the template of the subject individual distance based connectivity constructor.'  'ID (data, string) is a few-letter code for the subject individual distance based connectivity constructor.'  'LABEL (metadata, string) is an extended label of the subject individual distance based connectivity constructor.'  'NOTES (metadata, string) are some specific notes about the subject individual distance based connectivity constructor.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR_SUVR (data, item) is a group of subjects with mean SUVR data.'  'GR_SUVR_REF (data, item) is a group of subjects with mean SUVR data for deviation reference.'  'CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for Mahalanobis distance individual connectome construction.'  'GR (result, item) is a group of subjects with connectivity data.' };
			prop_description = individualdistanceconconsturctor_description_list{prop};
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
			%  SETTINGS = ICD.GETPROPSETTINGS(POINTER) returns settings of POINTER of ICD.
			%  SETTINGS = Element.GETPROPSETTINGS(IndividualDistanceConConsturctor, POINTER) returns settings of POINTER of IndividualDistanceConConsturctor.
			%  SETTINGS = ICD.GETPROPSETTINGS(IndividualDistanceConConsturctor, POINTER) returns settings of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPSETTINGS(ICD) and Element.GETPROPSETTINGS('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = IndividualDistanceConConsturctor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % IndividualDistanceConConsturctor.TEMPLATE
					prop_settings = 'IndividualDistanceConConsturctor';
				otherwise
					prop_settings = getPropSettings@IndividualConConstructorBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = IndividualDistanceConConsturctor.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualDistanceConConsturctor.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ICD.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ICD.
			%  DEFAULT = Element.GETPROPDEFAULT(IndividualDistanceConConsturctor, POINTER) returns the default value of POINTER of IndividualDistanceConConsturctor.
			%  DEFAULT = ICD.GETPROPDEFAULT(IndividualDistanceConConsturctor, POINTER) returns the default value of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPDEFAULT(ICD) and Element.GETPROPDEFAULT('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndividualDistanceConConsturctor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % IndividualDistanceConConsturctor.ELCLASS
					prop_default = 'IndividualDistanceConConsturctor';
				case 2 % IndividualDistanceConConsturctor.NAME
					prop_default = 'Distance based connectivity constructor';
				case 3 % IndividualDistanceConConsturctor.DESCRIPTION
					prop_default = 'IndividualDistanceConConsturctor construct distance based connectome for a group of subjects with nifti file.';
				case 4 % IndividualDistanceConConsturctor.TEMPLATE
					prop_default = Format.getFormatDefault(8, IndividualDistanceConConsturctor.getPropSettings(prop));
				case 5 % IndividualDistanceConConsturctor.ID
					prop_default = 'IndividualDistanceConConsturctor ID';
				case 6 % IndividualDistanceConConsturctor.LABEL
					prop_default = 'IndividualDistanceConConsturctor label';
				case 7 % IndividualDistanceConConsturctor.NOTES
					prop_default = 'IndividualDistanceConConsturctor notes';
				otherwise
					prop_default = getPropDefault@IndividualConConstructorBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = IndividualDistanceConConsturctor.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = IndividualDistanceConConsturctor.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ICD.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ICD.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(IndividualDistanceConConsturctor, POINTER) returns the conditioned default value of POINTER of IndividualDistanceConConsturctor.
			%  DEFAULT = ICD.GETPROPDEFAULTCONDITIONED(IndividualDistanceConConsturctor, POINTER) returns the conditioned default value of POINTER of IndividualDistanceConConsturctor.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ICD) and Element.GETPROPDEFAULTCONDITIONED('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = IndividualDistanceConConsturctor.getPropProp(pointer);
			
			prop_default = IndividualDistanceConConsturctor.conditioning(prop, IndividualDistanceConConsturctor.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ICD.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ICD.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ICD.
			%  CHECK = Element.CHECKPROP(IndividualDistanceConConsturctor, PROP, VALUE) checks VALUE format for PROP of IndividualDistanceConConsturctor.
			%  CHECK = ICD.CHECKPROP(IndividualDistanceConConsturctor, PROP, VALUE) checks VALUE format for PROP of IndividualDistanceConConsturctor.
			% 
			% ICD.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:IndividualDistanceConConsturctor:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ICD.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ICD.
			%   Error id: BRAPH2:IndividualDistanceConConsturctor:WrongInput
			%  Element.CHECKPROP(IndividualDistanceConConsturctor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualDistanceConConsturctor.
			%   Error id: BRAPH2:IndividualDistanceConConsturctor:WrongInput
			%  ICD.CHECKPROP(IndividualDistanceConConsturctor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndividualDistanceConConsturctor.
			%   Error id: BRAPH2:IndividualDistanceConConsturctor:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ICD) and Element.CHECKPROP('IndividualDistanceConConsturctor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = IndividualDistanceConConsturctor.getPropProp(pointer);
			
			switch prop
				case 4 % IndividualDistanceConConsturctor.TEMPLATE
					check = Format.checkFormat(8, value, IndividualDistanceConConsturctor.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@IndividualConConstructorBase(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndividualDistanceConConsturctor:' 'WrongInput'], ...
					['BRAPH2' ':IndividualDistanceConConsturctor:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' IndividualDistanceConConsturctor.getPropTag(prop) ' (' IndividualDistanceConConsturctor.getFormatTag(IndividualDistanceConConsturctor.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(icd, prop, varargin)
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
				case 12 % IndividualDistanceConConsturctor.CONNECTOME_CONSTUCT_METHOD
					if isempty(varargin) && isempty(icd.get('GR_SUVR').get('SUB_DICT').get('IT_LIST'))
					    value = {};
					    return
					end
					gr_suvr = icd.get('GR_SUVR');
					for i = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
					    subj_suvrs{i} = gr_suvr.get('SUB_DICT').get('IT',i).get('ST');
					end
					
					maxMahalDistAcrossSubjects = 0;
					mahalDistances_cross_subjects = {};
					for i = 1:1:length(subj_suvrs)
					    subj_suvr = subj_suvrs{i};
					    uniqueROIs = size(subj_suvr,1);
					    % Calculate the global mean SUVR value for the subject
					    globalMeanSUVR = mean(subj_suvr, 'all');
					    % Subtract the global mean from each SUVR value to center the data
					    centeredSUVRMatrix = subj_suvr - globalMeanSUVR;
					    % Calculate the covariance matrix of the centered SUVR data
					    covMatrix = cov(centeredSUVRMatrix');
					    invCovMatrix = inv(covMatrix); % Inverse of the covariance matrix
					    mahalDistances = zeros(uniqueROIs, uniqueROIs); % To store Mahalanobis distances for each ROI
					    for roi1 = 1:uniqueROIs
					        for roi2 = 1:uniqueROIs
					            if roi1 ~= roi2
					                % For each ROI, the diffVector is its centered SUVR values
					                diffVector_first = centeredSUVRMatrix(roi1);
					                mahalDist1 = sqrt((diffVector_first * invCovMatrix) * diffVector_first'); % Mahalanobis distance calculation
					                diffVector_second = centeredSUVRMatrix(roi2);
					                mahalDist2 = sqrt((diffVector_second * invCovMatrix) * diffVector_second'); % Mahalanobis distance calculation
					                mahalDistances(roi1,roi2) = (mahalDist1+mahalDist2)/2; % Store the computed distance
					            else
					                mahalDistances(roi1,roi2) = 0;
					            end
					        end
					    end
					    % Update maxMahalDistAcrossSubjects if a larger distance is found
					    currentMax = max(mahalDistances(:));
					    if currentMax > maxMahalDistAcrossSubjects
					        maxMahalDistAcrossSubjects = currentMax;
					    end
					    mahalDistances_cross_subjects{i} = mahalDistances;
					
					end
					scaledMahalDistMatrix_cross_subjects = {};
					for i = 1:length(mahalDistances_cross_subjects)
					    mahalDistMatrix = mahalDistances_cross_subjects{i};
					    % Scale the Mahalanobis distances
					    scaledMahalDistMatrix_cross_subjects{i} = 1 - mahalDistMatrix / ceil(maxMahalDistAcrossSubjects);
					end
					value = scaledMahalDistMatrix_cross_subjects;
					
				otherwise
					if prop <= 13
						value = calculateValue@IndividualConConstructorBase(icd, prop, varargin{:});
					else
						value = calculateValue@Element(icd, prop, varargin{:});
					end
			end
			
		end
	end
end
