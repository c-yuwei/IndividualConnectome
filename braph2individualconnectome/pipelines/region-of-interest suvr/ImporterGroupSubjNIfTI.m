classdef ImporterGroupSubjNIfTI < Importer
	%ImporterGroupSubjNIfTI imports a group of subjects with image data from a series of Nifti files.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjNIfTI imports the directory to a group of subjects Nifti files 
	%  in a folder. All these files must be in the same folder; also, no other files 
	%  should be in the folder. Each file contains a 3D brain volume matrix.
	% The variables of interest are from another XLS/XLSX file named "SUVR_GROUP_MAT.vois.xlsx" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% The list of ImporterGroupSubjNIfTI properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject image group importer for Nifti.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject image group importer for Nifti.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject image importer for Nifti.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject image importer for Nifti.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject image importer for Nifti.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of subject image importer for Nifti.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about subject image importer for Nifti.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory containing the Nifti subject group files from which to load the subject group.
	%  <strong>11</strong> <strong>NIFTI_TYPE</strong> 	NIFTI_TYPE (data, stringlist) describes the including modality types of each Nifti file for single subject.
	%  <strong>12</strong> <strong>GET_DIR</strong> 	GET_DIR (query, item) opens a dialog box to set the directory from where to load the Nifti files of the subject group.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with Nifti image data.
	%
	% ImporterGroupSubjNIfTI methods (constructor):
	%  ImporterGroupSubjNIfTI - constructor
	%
	% ImporterGroupSubjNIfTI methods:
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
	% ImporterGroupSubjNIfTI methods (display):
	%  tostring - string with information about the importer of SUVR subject group from .mat
	%  disp - displays information about the importer of SUVR subject group from .mat
	%  tree - displays the tree of the importer of SUVR subject group from .mat
	%
	% ImporterGroupSubjNIfTI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of SUVR subject group from .mat are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of SUVR subject group from .mat
	%
	% ImporterGroupSubjNIfTI methods (save/load, Static):
	%  save - saves BRAPH2 importer of SUVR subject group from .mat as b2 file
	%  load - loads a BRAPH2 importer of SUVR subject group from .mat from a b2 file
	%
	% ImporterGroupSubjNIfTI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of SUVR subject group from .mat
	%
	% ImporterGroupSubjNIfTI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of SUVR subject group from .mat
	%
	% ImporterGroupSubjNIfTI methods (inspection, Static):
	%  getClass - returns the class of the importer of SUVR subject group from .mat
	%  getSubclasses - returns all subclasses of ImporterGroupSubjNIfTI
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
	% ImporterGroupSubjNIfTI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjNIfTI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjNIfTI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjNIfTI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjNIfTI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjNIfTI constants</a>.
	%
	%
	% See also Group, SubjectCON, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		DIRECTORY = 10; %CET: Computational Efficiency Trick
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = 4;
		DIRECTORY_FORMAT = 2;
		
		NIFTI_TYPE = 11; %CET: Computational Efficiency Trick
		NIFTI_TYPE_TAG = 'NIFTI_TYPE';
		NIFTI_TYPE_CATEGORY = 4;
		NIFTI_TYPE_FORMAT = 3;
		
		GET_DIR = 12; %CET: Computational Efficiency Trick
		GET_DIR_TAG = 'GET_DIR';
		GET_DIR_CATEGORY = 6;
		GET_DIR_FORMAT = 8;
		
		GR = 13; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 5;
		GR_FORMAT = 8;
	end
	methods % constructor
		function im = ImporterGroupSubjNIfTI(varargin)
			%ImporterGroupSubjNIfTI() creates a importer of SUVR subject group from .mat.
			%
			% ImporterGroupSubjNIfTI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjNIfTI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterGroupSubjNIfTI properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject image group importer for Nifti.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject image group importer for Nifti.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject image importer for Nifti.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject image importer for Nifti.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject image importer for Nifti.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of subject image importer for Nifti.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about subject image importer for Nifti.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory containing the Nifti subject group files from which to load the subject group.
			%  <strong>11</strong> <strong>NIFTI_TYPE</strong> 	NIFTI_TYPE (data, stringlist) describes the including modality types of each Nifti file for single subject.
			%  <strong>12</strong> <strong>GET_DIR</strong> 	GET_DIR (query, item) opens a dialog box to set the directory from where to load the Nifti files of the subject group.
			%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with Nifti image data.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the importer of SUVR subject group from .mat.
			%
			% BUILD = ImporterGroupSubjNIfTI.GETBUILD() returns the build of 'ImporterGroupSubjNIfTI'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the importer of SUVR subject group from .mat IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('ImporterGroupSubjNIfTI') returns the build of 'ImporterGroupSubjNIfTI'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the importer of SUVR subject group from .mat.
			%
			% CLASS = ImporterGroupSubjNIfTI.GETCLASS() returns the class 'ImporterGroupSubjNIfTI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of SUVR subject group from .mat IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjNIfTI') returns 'ImporterGroupSubjNIfTI'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjNIfTI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of SUVR subject group from .mat.
			%
			% LIST = ImporterGroupSubjNIfTI.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjNIfTI'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of SUVR subject group from .mat IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjNIfTI') returns all subclasses of 'ImporterGroupSubjNIfTI'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterGroupSubjNIfTI' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of SUVR subject group from .mat.
			%
			% PROPS = ImporterGroupSubjNIfTI.GETPROPS() returns the property list of importer of SUVR subject group from .mat
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjNIfTI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of SUVR subject group from .mat IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjNIfTI'[, CATEGORY]) returns the property list of 'ImporterGroupSubjNIfTI'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjNIfTI')
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
			% N = ImporterGroupSubjNIfTI.GETPROPNUMBER() returns the property number of importer of SUVR subject group from .mat.
			%
			% N = ImporterGroupSubjNIfTI.GETPROPNUMBER(CATEGORY) returns the property number of importer of SUVR subject group from .mat
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of SUVR subject group from .mat IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjNIfTI') returns the property number of 'ImporterGroupSubjNIfTI'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjNIfTI')
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
			% CHECK = ImporterGroupSubjNIfTI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjNIfTI, PROP) checks whether PROP exists for ImporterGroupSubjNIfTI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjNIfTI, PROP) throws error if PROP does NOT exist for ImporterGroupSubjNIfTI.
			%   Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjNIfTI:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjNIfTI:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjNIfTI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of SUVR subject group from .mat/error.
			%
			% CHECK = ImporterGroupSubjNIfTI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjNIfTI, TAG) checks whether TAG exists for ImporterGroupSubjNIfTI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjNIfTI, TAG) throws error if TAG does NOT exist for ImporterGroupSubjNIfTI.
			%   Error id: [BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'NIFTI_TYPE'  'GET_DIR'  'GR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjNIfTI:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjNIfTI:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjNIfTI.'] ...
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
			%  PROPERTY = IM.GETPROPPROP(POINTER) returns property number of POINTER of IM.
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjNIfTI, POINTER) returns property number of POINTER of ImporterGroupSubjNIfTI.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjNIfTI, POINTER) returns property number of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'NIFTI_TYPE'  'GET_DIR'  'GR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = IM.GETPROPTAG(POINTER) returns tag of POINTER of IM.
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjNIfTI, POINTER) returns tag of POINTER of ImporterGroupSubjNIfTI.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjNIfTI, POINTER) returns tag of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importergroupsubjnifti_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'NIFTI_TYPE'  'GET_DIR'  'GR' };
				tag = importergroupsubjnifti_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = IM.GETPROPCATEGORY(POINTER) returns category of POINTER of IM.
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjNIfTI, POINTER) returns category of POINTER of ImporterGroupSubjNIfTI.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjNIfTI, POINTER) returns category of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjnifti_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = importergroupsubjnifti_category_list{prop};
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
			%  FORMAT = IM.GETPROPFORMAT(POINTER) returns format of POINTER of IM.
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjNIfTI, POINTER) returns format of POINTER of ImporterGroupSubjNIfTI.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjNIfTI, POINTER) returns format of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjnifti_format_list = { 2  2  2  8  2  2  2  2  4  2  3  8  8 };
			prop_format = importergroupsubjnifti_format_list{prop};
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
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjNIfTI, POINTER) returns description of POINTER of ImporterGroupSubjNIfTI.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjNIfTI, POINTER) returns description of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjnifti_description_list = { 'ELCLASS (constant, string) is the class of the subject image group importer for Nifti.'  'NAME (constant, string) is the name of the subject image group importer for Nifti.'  'DESCRIPTION (constant, string) is the description of the subject image importer for Nifti.'  'TEMPLATE (parameter, item) is the template of the subject image importer for Nifti.'  'ID (data, string) is a few-letter code for the subject image importer for Nifti.'  'LABEL (metadata, string) is an extended label of subject image importer for Nifti.'  'NOTES (metadata, string) are some specific notes about subject image importer for Nifti.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'DIRECTORY (data, string) is the directory containing the Nifti subject group files from which to load the subject group.'  'NIFTI_TYPE (data, stringlist) describes the including modality types of each Nifti file for single subject.'  'GET_DIR (query, item) opens a dialog box to set the directory from where to load the Nifti files of the subject group.'  'GR (result, item) is a group of subjects with Nifti image data.' };
			prop_description = importergroupsubjnifti_description_list{prop};
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
			%  SETTINGS = IM.GETPROPSETTINGS(POINTER) returns settings of POINTER of IM.
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjNIfTI, POINTER) returns settings of POINTER of ImporterGroupSubjNIfTI.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjNIfTI, POINTER) returns settings of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterGroupSubjNIfTI.DIRECTORY
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterGroupSubjNIfTI.NIFTI_TYPE
					prop_settings = Format.getFormatSettings(3);
				case 12 % ImporterGroupSubjNIfTI.GET_DIR
					prop_settings = 'ImporterGroupSubjNIfTI';
				case 13 % ImporterGroupSubjNIfTI.GR
					prop_settings = 'Group';
				case 4 % ImporterGroupSubjNIfTI.TEMPLATE
					prop_settings = 'ImporterGroupSubjNIfTI';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjNIfTI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjNIfTI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjNIfTI, POINTER) returns the default value of POINTER of ImporterGroupSubjNIfTI.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjNIfTI, POINTER) returns the default value of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterGroupSubjNIfTI.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case 11 % ImporterGroupSubjNIfTI.NIFTI_TYPE
					prop_default = {'GM', 'WM', 'PET'};
				case 12 % ImporterGroupSubjNIfTI.GET_DIR
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case 13 % ImporterGroupSubjNIfTI.GR
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNIfTI'));
				case 1 % ImporterGroupSubjNIfTI.ELCLASS
					prop_default = 'ImporterGroupSubjNIfTI';
				case 2 % ImporterGroupSubjNIfTI.NAME
					prop_default = 'Subject Nifti Image Importer';
				case 3 % ImporterGroupSubjNIfTI.DESCRIPTION
					prop_default = 'ImporterGroupSubjNIfTI imports a group of subjects with image data from a series of Nifti file.';
				case 4 % ImporterGroupSubjNIfTI.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case 5 % ImporterGroupSubjNIfTI.ID
					prop_default = 'ImporterGroupSubjNIfTI ID';
				case 6 % ImporterGroupSubjNIfTI.LABEL
					prop_default = 'ImporterGroupSubjNIfTI label';
				case 7 % ImporterGroupSubjNIfTI.NOTES
					prop_default = 'ImporterGroupSubjNIfTI notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjNIfTI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjNIfTI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjNIfTI, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjNIfTI.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjNIfTI, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjNIfTI.conditioning(prop, ImporterGroupSubjNIfTI.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IM.
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjNIfTI, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjNIfTI.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjNIfTI, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjNIfTI.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterGroupSubjNIfTI:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterGroupSubjNIfTI:WrongInput
			%  Element.CHECKPROP(ImporterGroupSubjNIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjNIfTI.
			%   Error id: BRAPH2:ImporterGroupSubjNIfTI:WrongInput
			%  IM.CHECKPROP(ImporterGroupSubjNIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjNIfTI.
			%   Error id: BRAPH2:ImporterGroupSubjNIfTI:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterGroupSubjNIfTI.DIRECTORY
					check = Format.checkFormat(2, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case 11 % ImporterGroupSubjNIfTI.NIFTI_TYPE
					check = Format.checkFormat(3, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case 12 % ImporterGroupSubjNIfTI.GET_DIR
					check = Format.checkFormat(8, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case 13 % ImporterGroupSubjNIfTI.GR
					check = Format.checkFormat(8, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case 4 % ImporterGroupSubjNIfTI.TEMPLATE
					check = Format.checkFormat(8, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjNIfTI:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjNIfTI:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjNIfTI.getPropTag(prop) ' (' ImporterGroupSubjNIfTI.getFormatTag(ImporterGroupSubjNIfTI.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop, varargin)
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
				case 12 % ImporterGroupSubjNIfTI.GET_DIR
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    im.set('DIRECTORY', directory);
					end
					value = im;
					
				case 13 % ImporterGroupSubjNIfTI.GR
					rng_settings_ = rng(); rng(im.getPropSeed(13), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectNIfTI', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNIfTI') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					directory = im.get('DIRECTORY');
					Niftitype = im.get('NIFTI_TYPE');
					if isfolder(directory)
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
					    [~, gr_name] = fileparts(directory);
					    gr.set( ...
					        'ID', gr_name, ...
					        'LABEL', gr_name, ...
					        'NOTES', ['Group loaded from ' directory] ...
					        );
					
					    try
					        braph2waitbar(wb, .15, 'Loading subject group ...') % making a waitbar for VOIs
					        
					        % analyzes file
					        files = [dir(fullfile(directory))];
					        files = files(~(ismember({files.name},'.') | ismember({files.name},'..')));
					        files = files([files.isdir]);
					        if ~isempty(files)
					            % adds subjects
					            sub_dict = gr.memorize('SUB_DICT');
					            for i = 1:1:length(files)
					                braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading subject directory' num2str(i) ' of ' num2str(length(files)) ' ...'])
					                sub_id = files(i).name;
					                subject_nifty_folder = [files(i).folder filesep files(i).name];
					                subject_nifty_file = dir(fullfile(subject_nifty_folder, '*.nii'));
					                subject_nifty_full_path = strcat(subject_nifty_file(1).folder, filesep,{subject_nifty_file.name});
					                sub = SubjectNIfTI( ...
					                    'ID', sub_id);
					                hasMatch  = false;
					                for f = 1:length(subject_nifty_full_path)
					                    % Initialize an empty logical array to store matching results
					                    isMatch = false(1, length(Niftitype));
					
					                    % Loop through each element of the Niftitype array to check for substring match
					                    for i = 1:length(Niftitype)
					                        if contains(subject_nifty_full_path{f}, Niftitype{i}) % Check if current path contains any of Niftitype elements
					                            isMatch(i) = true;
					                        end
					                    end
					
					                    % Get the index of the matching element(s)
					                    matchingIndex = find(isMatch);
					
					                    if ~isempty(matchingIndex) % If there's at least one match
					                        % Use the first match found in Niftitype
					                        file_id = convertStringsToChars(Niftitype{matchingIndex(1)});
					
					                        % Add the file path to the subject's nifty dictionary
					                        sub.memorize('NIFTI_PATH_DICT').get('ADD', FILE_PATH('ID', file_id, 'PATH', convertStringsToChars(subject_nifty_full_path{f})));
					
					                        % Mark that at least one match was found for this subject
					                        hasMatch = true;
					                    end
					                end
					
					                % After looping through all file paths, check if no matches were found
					                if ~hasMatch
					                    % Raise a warning if no NIFTI type was found for the subject
					                    warning(sprintf([sub_id, ' does not have the required type of data, skip']));
					                    return;
					                end
					                sub_dict.get('ADD', sub);
					            end
					        end
					
					        % variables of interest
					        vois = [];
					        if isfile([directory '.vois.xls'])
					            [~, ~, vois] = xlsread([directory '.vois.xls']);
					        elseif isfile([directory '.vois.xlsx'])
					            [~, ~, vois] = xlsread([directory '.vois.xlsx']);
					        end
					        if ~isempty(vois)
					            for i = 3:1:size(vois, 1)
					                braph2waitbar(wb, .15 + .85 * (i-2) / (size(vois, 1)-2), ['Loading VOIs of subject ' num2str(i-2) ' of ' num2str(size(vois, 1)-2) ' ...'])
					                % Extract the subject ID string from the 'vois' data
					                target_id = vois{i, 1};
					
					                % Get the IT_LIST from sub_dict
					                IT_LIST = sub_dict.get('IT_LIST');
					
					                % Initialize sub_id as empty
					                sub_id = [];
					
					                % Iterate over IT_LIST to find the matching ID
					                for j = 1:length(IT_LIST)
					                    subject_nifti = IT_LIST{j}; % Get the SubjectNifti object
					                    current_id = subject_nifti.get('ID'); % Extract the 'ID' property
					                    if strcmp(current_id, target_id)
					                        sub_id = j; % Store the index if IDs match
					                        break; % Exit the loop as we found the subject
					                    end
					                end
					
					                % Check if sub_id was found
					                if isempty(sub_id)
					                    error('BRAPH2:MyElement:SubjectNotFound', 'Subject ID %s not found in sub_dict.', target_id);
					                end
					
					                % Retrieve the subject from sub_dict using the matched index
					                sub = sub_dict.get('IT', sub_id);
					
					                % Iterate over VOIs for this subject
					                for v = 2:1:size(vois, 2)
					                    voi_id = vois{1, v};
					                    if isnumeric(vois{2, v}) % VOINumeric
					                        sub.memorize('VOI_DICT').get('ADD', ...
					                            VOINumeric( ...
					                            'ID', voi_id, ...
					                            'V', vois{i, v} ...
					                            ) ...
					                            );
					                    elseif ischar(vois{2, v}) % VOICategoric
					                        sub.memorize('VOI_DICT').get('ADD', ...
					                            VOICategoric( ...
					                            'ID', voi_id, ...
					                            'CATEGORIES', str2cell(vois{2, v}), ...
					                            'V', find(strcmp(vois{i, v}, str2cell(vois{2, v}))) ...
					                            ) ...
					                            );
					                    end
					                end
					            end
					        end
					    catch e
					        braph2waitbar(wb, 'close')
					
					        rethrow(e)
					    end
					
					    braph2waitbar(wb, 'close')
					else
					    error(['BRAPH2' ':ImporterGroupSubjectCON_XLS:' 'ErrorIO'], ...
					        ['BRAPH2' ':ImporterGroupSubjectCON_XLS:' 'ErrorIO' '\n' ...
					        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
					        );
					end
					
					value = gr;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 9
						value = calculateValue@Importer(im, prop, varargin{:});
					else
						value = calculateValue@Element(im, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(im, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(im) ' ' im.getPropTag(prop) '.'];
			
			switch prop
				case 13 % ImporterGroupSubjNIfTI.GR
					check = any(strcmp(value.get('SUB_CLASS'), subclasses('SubjectNIfTI', [], [], true))); % Format.checkFormat(8, value, 'Group') already checked
					
				otherwise
					if prop <= 9
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
