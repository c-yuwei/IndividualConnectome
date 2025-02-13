classdef SUVRConstructor < ConcreteElement
	%SUVRConstructor calculates mean SUVR value of brain ROIs per subject.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% SUVRConstructor calculates mean value of brain ROIs. It loads the brain atlas for ROI identification,
	%  and ROI wisely calculate mean value.
	%
	% The list of SUVRConstructor properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject ROI constructor for Nifti.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject ROI constructor for Nifti.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject ROI constructor for Nifti.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject ROI constructor for Nifti.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject ROI constructor for Nifti.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of subject ROI constructor for Nifti.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about subject ROI constructor for Nifti.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>REF_REGION_LIST</strong> 	REF_REGION_LIST (data, cell) is the list containing the label list of reference region of brain Atlas for ROI constructor.
	%  <strong>10</strong> <strong>ATLAS_KIND</strong> 	ATLAS_KIND (parameter, stringlist) is the directory containing the Atlas needed for ROI analysis.
	%  <strong>11</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
	%  <strong>12</strong> <strong>ATLAS_INDEX</strong> 	ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.
	%  <strong>13</strong> <strong>ATLAS_PATH_DICT</strong> 	ATLAS_PATH_DICT (parameter, idict) is the directory containing the Atlas needed for ROI analysis.
	%  <strong>14</strong> <strong>GR_PET</strong> 	GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
	%  <strong>15</strong> <strong>GR_T1</strong> 	GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
	%  <strong>16</strong> <strong>SUVR_REGION_SELECTION</strong> 	SUVR_REGION_SELECTION (parameter, stringlist) is the list of selected brain regions.
	%  <strong>17</strong> <strong>CALC_SUBJ_SUVR</strong> 	CALC_SUBJ_SUVR (query, cell) generates suvr vectors per subject using subject PET and T1 data.
	%  <strong>18</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with SUVR analysis data.
	%  <strong>19</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%
	% SUVRConstructor methods (constructor):
	%  SUVRConstructor - constructor
	%
	% SUVRConstructor methods:
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
	% SUVRConstructor methods (display):
	%  tostring - string with information about the SUVR analysis constructor
	%  disp - displays information about the SUVR analysis constructor
	%  tree - displays the tree of the SUVR analysis constructor
	%
	% SUVRConstructor methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two SUVR analysis constructor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the SUVR analysis constructor
	%
	% SUVRConstructor methods (save/load, Static):
	%  save - saves BRAPH2 SUVR analysis constructor as b2 file
	%  load - loads a BRAPH2 SUVR analysis constructor from a b2 file
	%
	% SUVRConstructor method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the SUVR analysis constructor
	%
	% SUVRConstructor method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the SUVR analysis constructor
	%
	% SUVRConstructor methods (inspection, Static):
	%  getClass - returns the class of the SUVR analysis constructor
	%  getSubclasses - returns all subclasses of SUVRConstructor
	%  getProps - returns the property list of the SUVR analysis constructor
	%  getPropNumber - returns the property number of the SUVR analysis constructor
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
	% SUVRConstructor methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SUVRConstructor methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SUVRConstructor methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SUVRConstructor methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SUVRConstructor; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SUVRConstructor constants</a>.
	%
	%
	% See also Group, SubjectNIfTI, ExporterGroupSubjectCON_XLS, SubjectST.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		REF_REGION_LIST = 9; %CET: Computational Efficiency Trick
		REF_REGION_LIST_TAG = 'REF_REGION_LIST';
		REF_REGION_LIST_CATEGORY = 4;
		REF_REGION_LIST_FORMAT = 16;
		
		ATLAS_KIND = 10; %CET: Computational Efficiency Trick
		ATLAS_KIND_TAG = 'ATLAS_KIND';
		ATLAS_KIND_CATEGORY = 3;
		ATLAS_KIND_FORMAT = 3;
		
		BA = 11; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 4;
		BA_FORMAT = 8;
		
		ATLAS_INDEX = 12; %CET: Computational Efficiency Trick
		ATLAS_INDEX_TAG = 'ATLAS_INDEX';
		ATLAS_INDEX_CATEGORY = 3;
		ATLAS_INDEX_FORMAT = 11;
		
		ATLAS_PATH_DICT = 13; %CET: Computational Efficiency Trick
		ATLAS_PATH_DICT_TAG = 'ATLAS_PATH_DICT';
		ATLAS_PATH_DICT_CATEGORY = 3;
		ATLAS_PATH_DICT_FORMAT = 10;
		
		GR_PET = 14; %CET: Computational Efficiency Trick
		GR_PET_TAG = 'GR_PET';
		GR_PET_CATEGORY = 4;
		GR_PET_FORMAT = 8;
		
		GR_T1 = 15; %CET: Computational Efficiency Trick
		GR_T1_TAG = 'GR_T1';
		GR_T1_CATEGORY = 4;
		GR_T1_FORMAT = 8;
		
		SUVR_REGION_SELECTION = 16; %CET: Computational Efficiency Trick
		SUVR_REGION_SELECTION_TAG = 'SUVR_REGION_SELECTION';
		SUVR_REGION_SELECTION_CATEGORY = 3;
		SUVR_REGION_SELECTION_FORMAT = 3;
		
		CALC_SUBJ_SUVR = 17; %CET: Computational Efficiency Trick
		CALC_SUBJ_SUVR_TAG = 'CALC_SUBJ_SUVR';
		CALC_SUBJ_SUVR_CATEGORY = 6;
		CALC_SUBJ_SUVR_FORMAT = 16;
		
		GR = 18; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 5;
		GR_FORMAT = 8;
		
		WAITBAR = 19; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
	end
	methods % constructor
		function roic = SUVRConstructor(varargin)
			%SUVRConstructor() creates a SUVR analysis constructor.
			%
			% SUVRConstructor(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SUVRConstructor(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SUVRConstructor properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject ROI constructor for Nifti.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject ROI constructor for Nifti.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject ROI constructor for Nifti.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject ROI constructor for Nifti.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject ROI constructor for Nifti.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of subject ROI constructor for Nifti.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about subject ROI constructor for Nifti.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>REF_REGION_LIST</strong> 	REF_REGION_LIST (data, cell) is the list containing the label list of reference region of brain Atlas for ROI constructor.
			%  <strong>10</strong> <strong>ATLAS_KIND</strong> 	ATLAS_KIND (parameter, stringlist) is the directory containing the Atlas needed for ROI analysis.
			%  <strong>11</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
			%  <strong>12</strong> <strong>ATLAS_INDEX</strong> 	ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.
			%  <strong>13</strong> <strong>ATLAS_PATH_DICT</strong> 	ATLAS_PATH_DICT (parameter, idict) is the directory containing the Atlas needed for ROI analysis.
			%  <strong>14</strong> <strong>GR_PET</strong> 	GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
			%  <strong>15</strong> <strong>GR_T1</strong> 	GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
			%  <strong>16</strong> <strong>SUVR_REGION_SELECTION</strong> 	SUVR_REGION_SELECTION (parameter, stringlist) is the list of selected brain regions.
			%  <strong>17</strong> <strong>CALC_SUBJ_SUVR</strong> 	CALC_SUBJ_SUVR (query, cell) generates suvr vectors per subject using subject PET and T1 data.
			%  <strong>18</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with SUVR analysis data.
			%  <strong>19</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%
			% See also Category, Format.
			
			roic = roic@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the SUVR analysis constructor.
			%
			% BUILD = SUVRConstructor.GETBUILD() returns the build of 'SUVRConstructor'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ROIC.GETBUILD() returns the build of the SUVR analysis constructor ROIC.
			%  BUILD = Element.GETBUILD(ROIC) returns the build of 'ROIC'.
			%  BUILD = Element.GETBUILD('SUVRConstructor') returns the build of 'SUVRConstructor'.
			%
			% Note that the Element.GETBUILD(ROIC) and Element.GETBUILD('SUVRConstructor')
			%  are less computationally efficient.
			
			build = 1;
		end
		function roic_class = getClass()
			%GETCLASS returns the class of the SUVR analysis constructor.
			%
			% CLASS = SUVRConstructor.GETCLASS() returns the class 'SUVRConstructor'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ROIC.GETCLASS() returns the class of the SUVR analysis constructor ROIC.
			%  CLASS = Element.GETCLASS(ROIC) returns the class of 'ROIC'.
			%  CLASS = Element.GETCLASS('SUVRConstructor') returns 'SUVRConstructor'.
			%
			% Note that the Element.GETCLASS(ROIC) and Element.GETCLASS('SUVRConstructor')
			%  are less computationally efficient.
			
			roic_class = 'SUVRConstructor';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the SUVR analysis constructor.
			%
			% LIST = SUVRConstructor.GETSUBCLASSES() returns all subclasses of 'SUVRConstructor'.
			%
			% Alternative forms to call this method are:
			%  LIST = ROIC.GETSUBCLASSES() returns all subclasses of the SUVR analysis constructor ROIC.
			%  LIST = Element.GETSUBCLASSES(ROIC) returns all subclasses of 'ROIC'.
			%  LIST = Element.GETSUBCLASSES('SUVRConstructor') returns all subclasses of 'SUVRConstructor'.
			%
			% Note that the Element.GETSUBCLASSES(ROIC) and Element.GETSUBCLASSES('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SUVRConstructor' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of SUVR analysis constructor.
			%
			% PROPS = SUVRConstructor.GETPROPS() returns the property list of SUVR analysis constructor
			%  as a row vector.
			%
			% PROPS = SUVRConstructor.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ROIC.GETPROPS([CATEGORY]) returns the property list of the SUVR analysis constructor ROIC.
			%  PROPS = Element.GETPROPS(ROIC[, CATEGORY]) returns the property list of 'ROIC'.
			%  PROPS = Element.GETPROPS('SUVRConstructor'[, CATEGORY]) returns the property list of 'SUVRConstructor'.
			%
			% Note that the Element.GETPROPS(ROIC) and Element.GETPROPS('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 10 12 13 16];
				case 4 % Category.DATA
					prop_list = [5 9 11 14 15];
				case 5 % Category.RESULT
					prop_list = 18;
				case 6 % Category.QUERY
					prop_list = [8 17];
				case 9 % Category.GUI
					prop_list = 19;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of SUVR analysis constructor.
			%
			% N = SUVRConstructor.GETPROPNUMBER() returns the property number of SUVR analysis constructor.
			%
			% N = SUVRConstructor.GETPROPNUMBER(CATEGORY) returns the property number of SUVR analysis constructor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ROIC.GETPROPNUMBER([CATEGORY]) returns the property number of the SUVR analysis constructor ROIC.
			%  N = Element.GETPROPNUMBER(ROIC) returns the property number of 'ROIC'.
			%  N = Element.GETPROPNUMBER('SUVRConstructor') returns the property number of 'SUVRConstructor'.
			%
			% Note that the Element.GETPROPNUMBER(ROIC) and Element.GETPROPNUMBER('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 19;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 5;
				case 4 % Category.DATA
					prop_number = 5;
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
			%EXISTSPROP checks whether property exists in SUVR analysis constructor/error.
			%
			% CHECK = SUVRConstructor.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ROIC.EXISTSPROP(PROP) checks whether PROP exists for ROIC.
			%  CHECK = Element.EXISTSPROP(ROIC, PROP) checks whether PROP exists for ROIC.
			%  CHECK = Element.EXISTSPROP(SUVRConstructor, PROP) checks whether PROP exists for SUVRConstructor.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ROIC.EXISTSPROP(PROP) throws error if PROP does NOT exist for ROIC.
			%   Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%  Element.EXISTSPROP(ROIC, PROP) throws error if PROP does NOT exist for ROIC.
			%   Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%  Element.EXISTSPROP(SUVRConstructor, PROP) throws error if PROP does NOT exist for SUVRConstructor.
			%   Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ROIC) and Element.EXISTSPROP('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 19 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SUVRConstructor:' 'WrongInput'], ...
					['BRAPH2' ':SUVRConstructor:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SUVRConstructor.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in SUVR analysis constructor/error.
			%
			% CHECK = SUVRConstructor.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ROIC.EXISTSTAG(TAG) checks whether TAG exists for ROIC.
			%  CHECK = Element.EXISTSTAG(ROIC, TAG) checks whether TAG exists for ROIC.
			%  CHECK = Element.EXISTSTAG(SUVRConstructor, TAG) checks whether TAG exists for SUVRConstructor.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ROIC.EXISTSTAG(TAG) throws error if TAG does NOT exist for ROIC.
			%   Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%  Element.EXISTSTAG(ROIC, TAG) throws error if TAG does NOT exist for ROIC.
			%   Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%  Element.EXISTSTAG(SUVRConstructor, TAG) throws error if TAG does NOT exist for SUVRConstructor.
			%   Error id: [BRAPH2:SUVRConstructor:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ROIC) and Element.EXISTSTAG('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'REF_REGION_LIST'  'ATLAS_KIND'  'BA'  'ATLAS_INDEX'  'ATLAS_PATH_DICT'  'GR_PET'  'GR_T1'  'SUVR_REGION_SELECTION'  'CALC_SUBJ_SUVR'  'GR'  'WAITBAR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SUVRConstructor:' 'WrongInput'], ...
					['BRAPH2' ':SUVRConstructor:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SUVRConstructor.'] ...
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
			%  PROPERTY = ROIC.GETPROPPROP(POINTER) returns property number of POINTER of ROIC.
			%  PROPERTY = Element.GETPROPPROP(SUVRConstructor, POINTER) returns property number of POINTER of SUVRConstructor.
			%  PROPERTY = ROIC.GETPROPPROP(SUVRConstructor, POINTER) returns property number of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPPROP(ROIC) and Element.GETPROPPROP('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'REF_REGION_LIST'  'ATLAS_KIND'  'BA'  'ATLAS_INDEX'  'ATLAS_PATH_DICT'  'GR_PET'  'GR_T1'  'SUVR_REGION_SELECTION'  'CALC_SUBJ_SUVR'  'GR'  'WAITBAR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = ROIC.GETPROPTAG(POINTER) returns tag of POINTER of ROIC.
			%  TAG = Element.GETPROPTAG(SUVRConstructor, POINTER) returns tag of POINTER of SUVRConstructor.
			%  TAG = ROIC.GETPROPTAG(SUVRConstructor, POINTER) returns tag of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPTAG(ROIC) and Element.GETPROPTAG('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				suvrconstructor_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'REF_REGION_LIST'  'ATLAS_KIND'  'BA'  'ATLAS_INDEX'  'ATLAS_PATH_DICT'  'GR_PET'  'GR_T1'  'SUVR_REGION_SELECTION'  'CALC_SUBJ_SUVR'  'GR'  'WAITBAR' };
				tag = suvrconstructor_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = ROIC.GETPROPCATEGORY(POINTER) returns category of POINTER of ROIC.
			%  CATEGORY = Element.GETPROPCATEGORY(SUVRConstructor, POINTER) returns category of POINTER of SUVRConstructor.
			%  CATEGORY = ROIC.GETPROPCATEGORY(SUVRConstructor, POINTER) returns category of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPCATEGORY(ROIC) and Element.GETPROPCATEGORY('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SUVRConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			suvrconstructor_category_list = { 1  1  1  3  4  2  2  6  4  3  4  3  3  4  4  3  6  5  9 };
			prop_category = suvrconstructor_category_list{prop};
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
			%  FORMAT = ROIC.GETPROPFORMAT(POINTER) returns format of POINTER of ROIC.
			%  FORMAT = Element.GETPROPFORMAT(SUVRConstructor, POINTER) returns format of POINTER of SUVRConstructor.
			%  FORMAT = ROIC.GETPROPFORMAT(SUVRConstructor, POINTER) returns format of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPFORMAT(ROIC) and Element.GETPROPFORMAT('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SUVRConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			suvrconstructor_format_list = { 2  2  2  8  2  2  2  2  16  3  8  11  10  8  8  3  16  8  4 };
			prop_format = suvrconstructor_format_list{prop};
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
			%  DESCRIPTION = ROIC.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ROIC.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SUVRConstructor, POINTER) returns description of POINTER of SUVRConstructor.
			%  DESCRIPTION = ROIC.GETPROPDESCRIPTION(SUVRConstructor, POINTER) returns description of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPDESCRIPTION(ROIC) and Element.GETPROPDESCRIPTION('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SUVRConstructor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			suvrconstructor_description_list = { 'ELCLASS (constant, string) is the class of the subject ROI constructor for Nifti.'  'NAME (constant, string) is the name of the subject ROI constructor for Nifti.'  'DESCRIPTION (constant, string) is the description of the subject ROI constructor for Nifti.'  'TEMPLATE (parameter, item) is the template of the subject ROI constructor for Nifti.'  'ID (data, string) is a few-letter code for the subject ROI constructor for Nifti.'  'LABEL (metadata, string) is an extended label of subject ROI constructor for Nifti.'  'NOTES (metadata, string) are some specific notes about subject ROI constructor for Nifti.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'REF_REGION_LIST (data, cell) is the list containing the label list of reference region of brain Atlas for ROI constructor.'  'ATLAS_KIND (parameter, stringlist) is the directory containing the Atlas needed for ROI analysis.'  'BA (data, item) is a brain atlas.'  'ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.'  'ATLAS_PATH_DICT (parameter, idict) is the directory containing the Atlas needed for ROI analysis.'  'GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.'  'GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.'  'SUVR_REGION_SELECTION (parameter, stringlist) is the list of selected brain regions.'  'CALC_SUBJ_SUVR (query, cell) generates suvr vectors per subject using subject PET and T1 data.'  'GR (result, item) is a group of subjects with SUVR analysis data.'  'WAITBAR (gui, logical) determines whether to show the waitbar.' };
			prop_description = suvrconstructor_description_list{prop};
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
			%  SETTINGS = ROIC.GETPROPSETTINGS(POINTER) returns settings of POINTER of ROIC.
			%  SETTINGS = Element.GETPROPSETTINGS(SUVRConstructor, POINTER) returns settings of POINTER of SUVRConstructor.
			%  SETTINGS = ROIC.GETPROPSETTINGS(SUVRConstructor, POINTER) returns settings of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPSETTINGS(ROIC) and Element.GETPROPSETTINGS('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SUVRConstructor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % SUVRConstructor.REF_REGION_LIST
					prop_settings = Format.getFormatSettings(16);
				case 10 % SUVRConstructor.ATLAS_KIND
					prop_settings = Format.getFormatSettings(3);
				case 11 % SUVRConstructor.BA
					prop_settings = 'BrainAtlas';
				case 12 % SUVRConstructor.ATLAS_INDEX
					prop_settings = Format.getFormatSettings(11);
				case 13 % SUVRConstructor.ATLAS_PATH_DICT
					prop_settings = Format.getFormatSettings(10);
				case 14 % SUVRConstructor.GR_PET
					prop_settings = Format.getFormatSettings(8);
				case 15 % SUVRConstructor.GR_T1
					prop_settings = Format.getFormatSettings(8);
				case 16 % SUVRConstructor.SUVR_REGION_SELECTION
					prop_settings = Format.getFormatSettings(3);
				case 17 % SUVRConstructor.CALC_SUBJ_SUVR
					prop_settings = Format.getFormatSettings(16);
				case 18 % SUVRConstructor.GR
					prop_settings = Format.getFormatSettings(8);
				case 19 % SUVRConstructor.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 4 % SUVRConstructor.TEMPLATE
					prop_settings = 'SUVRConstructor';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SUVRConstructor.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SUVRConstructor.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ROIC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ROIC.
			%  DEFAULT = Element.GETPROPDEFAULT(SUVRConstructor, POINTER) returns the default value of POINTER of SUVRConstructor.
			%  DEFAULT = ROIC.GETPROPDEFAULT(SUVRConstructor, POINTER) returns the default value of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPDEFAULT(ROIC) and Element.GETPROPDEFAULT('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SUVRConstructor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % SUVRConstructor.REF_REGION_LIST
					prop_default = Format.getFormatDefault(16, SUVRConstructor.getPropSettings(prop));
				case 10 % SUVRConstructor.ATLAS_KIND
					prop_default = Format.getFormatDefault(3, SUVRConstructor.getPropSettings(prop));
				case 11 % SUVRConstructor.BA
					prop_default = Format.getFormatDefault(8, SUVRConstructor.getPropSettings(prop));
				case 12 % SUVRConstructor.ATLAS_INDEX
					prop_default = 1;

% %% ¡prop! % yuwei check this
% ATLAS_SUVR_LABEL (parameter, option) is the atlas defined by the user for SUVR ROI list, selected from ATLAS_KIND.
% %% ¡settings!
% roic.get('ATLAS_KIND')
% %% ¡default!
% roic.get('ATLAS_KIND'){1} % Default to the first atlas in ATLAS_KIND;
				case 13 % SUVRConstructor.ATLAS_PATH_DICT
					prop_default = Format.getFormatDefault(10, SUVRConstructor.getPropSettings(prop));
				case 14 % SUVRConstructor.GR_PET
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI');
				case 15 % SUVRConstructor.GR_T1
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI');
				case 16 % SUVRConstructor.SUVR_REGION_SELECTION
					prop_default = {};
				case 17 % SUVRConstructor.CALC_SUBJ_SUVR
					prop_default = Format.getFormatDefault(16, SUVRConstructor.getPropSettings(prop));
				case 18 % SUVRConstructor.GR
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case 19 % SUVRConstructor.WAITBAR
					prop_default = true;
				case 1 % SUVRConstructor.ELCLASS
					prop_default = 'SUVRConstructor';
				case 2 % SUVRConstructor.NAME
					prop_default = 'SUVR Constructor';
				case 3 % SUVRConstructor.DESCRIPTION
					prop_default = 'SUVRConstructor calculates a group of subjects mean value of ROI from imaging data from a series of Nifti file.';
				case 4 % SUVRConstructor.TEMPLATE
					prop_default = Format.getFormatDefault(8, SUVRConstructor.getPropSettings(prop));
				case 5 % SUVRConstructor.ID
					prop_default = 'SUVRConstructor ID';
				case 6 % SUVRConstructor.LABEL
					prop_default = 'SUVRConstructor label';
				case 7 % SUVRConstructor.NOTES
					prop_default = 'SUVRConstructor notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SUVRConstructor.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SUVRConstructor.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ROIC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ROIC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SUVRConstructor, POINTER) returns the conditioned default value of POINTER of SUVRConstructor.
			%  DEFAULT = ROIC.GETPROPDEFAULTCONDITIONED(SUVRConstructor, POINTER) returns the conditioned default value of POINTER of SUVRConstructor.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ROIC) and Element.GETPROPDEFAULTCONDITIONED('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SUVRConstructor.getPropProp(pointer);
			
			prop_default = SUVRConstructor.conditioning(prop, SUVRConstructor.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ROIC.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ROIC.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ROIC.
			%  CHECK = Element.CHECKPROP(SUVRConstructor, PROP, VALUE) checks VALUE format for PROP of SUVRConstructor.
			%  CHECK = ROIC.CHECKPROP(SUVRConstructor, PROP, VALUE) checks VALUE format for PROP of SUVRConstructor.
			% 
			% ROIC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SUVRConstructor:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ROIC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ROIC.
			%   Error id: BRAPH2:SUVRConstructor:WrongInput
			%  Element.CHECKPROP(SUVRConstructor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SUVRConstructor.
			%   Error id: BRAPH2:SUVRConstructor:WrongInput
			%  ROIC.CHECKPROP(SUVRConstructor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SUVRConstructor.
			%   Error id: BRAPH2:SUVRConstructor:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ROIC) and Element.CHECKPROP('SUVRConstructor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SUVRConstructor.getPropProp(pointer);
			
			switch prop
				case 9 % SUVRConstructor.REF_REGION_LIST
					check = Format.checkFormat(16, value, SUVRConstructor.getPropSettings(prop));
				case 10 % SUVRConstructor.ATLAS_KIND
					check = Format.checkFormat(3, value, SUVRConstructor.getPropSettings(prop));
				case 11 % SUVRConstructor.BA
					check = Format.checkFormat(8, value, SUVRConstructor.getPropSettings(prop));
				case 12 % SUVRConstructor.ATLAS_INDEX
					check = Format.checkFormat(11, value, SUVRConstructor.getPropSettings(prop));
				case 13 % SUVRConstructor.ATLAS_PATH_DICT
					check = Format.checkFormat(10, value, SUVRConstructor.getPropSettings(prop));
				case 14 % SUVRConstructor.GR_PET
					check = Format.checkFormat(8, value, SUVRConstructor.getPropSettings(prop));
				case 15 % SUVRConstructor.GR_T1
					check = Format.checkFormat(8, value, SUVRConstructor.getPropSettings(prop));
				case 16 % SUVRConstructor.SUVR_REGION_SELECTION
					check = Format.checkFormat(3, value, SUVRConstructor.getPropSettings(prop));
				case 17 % SUVRConstructor.CALC_SUBJ_SUVR
					check = Format.checkFormat(16, value, SUVRConstructor.getPropSettings(prop));
				case 18 % SUVRConstructor.GR
					check = Format.checkFormat(8, value, SUVRConstructor.getPropSettings(prop));
				case 19 % SUVRConstructor.WAITBAR
					check = Format.checkFormat(4, value, SUVRConstructor.getPropSettings(prop));
				case 4 % SUVRConstructor.TEMPLATE
					check = Format.checkFormat(8, value, SUVRConstructor.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SUVRConstructor:' 'WrongInput'], ...
					['BRAPH2' ':SUVRConstructor:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SUVRConstructor.getPropTag(prop) ' (' SUVRConstructor.getFormatTag(SUVRConstructor.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(roic, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case 16 % SUVRConstructor.SUVR_REGION_SELECTION
					ba = roic.get('BA'); % Ensure brain atlas is obtained correctly
					if isempty(roic.get('SUVR_REGION_SELECTION')) && ~isempty(ba.get('BR_DICT').get('IT_LIST'))
					    regions = ba.get('BR_DICT').get('LENGTH');
					    IT_LIST = cell(regions, 1); % Preallocate cell array
					    for i = 1:regions
					        IT_LIST{i} = ba.get('BR_DICT').get('IT', i).get('ID'); % Correct appending
					    end
					    roic.set('SUVR_REGION_SELECTION', IT_LIST)
					end
					
				otherwise
					if prop <= 8
						postprocessing@ConcreteElement(roic, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(roic, prop, varargin)
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
				case 17 % SUVRConstructor.CALC_SUBJ_SUVR
					if isempty(varargin)
					    value = {};
					    return
					end
					pet_data = varargin{1};
					t1_data = varargin{2};
					t1_data_union_mask = t1_data{1} > 0;
					for i = 2:length(t1_data)
					    t1_data_union_mask = t1_data_union_mask | (t1_data{i}>0);
					end
					
					% contrain my pet data within the T1 data
					masked_pet_data = pet_data{1}.* int16(t1_data_union_mask);
					
					% calculate suvr for ref region
					
					atlas_directories = roic.get('ATLAS_PATH_DICT').get('IT_LIST');
					atlas_kind = roic.get('ATLAS_KIND');
					Ref_list = roic.get('REF_REGION_LIST');
					atlas_suvr_index = roic.get('ATLAS_INDEX');
					for directory_index = 1: length(atlas_directories)
					    directory_dict = atlas_directories{directory_index};
					    directory_path = directory_dict.get('PATH');
					    atlas{directory_index} = niftiread(directory_path);
					    ref_region_masks{directory_index} = ismember(atlas{directory_index} ,Ref_list{directory_index});
					end
					ref_region_union_mask = ref_region_masks{1};
					for i = 2:length(ref_region_masks)
					    ref_region_union_mask = ref_region_union_mask | ref_region_masks{i};
					end
					ref_region_meanvalue = mean(masked_pet_data(ref_region_union_mask));
					
					% atlas_index = find(contains(atlas_kind{atlas_suvr{1}}));% here user can define refine the atlas_suvr option
					% atlas_roi = atlas{atlas_index};
					atlas_roi = atlas{atlas_suvr_index};
					% calculate normalized suvr for all unique regions
					ROI_list = unique(atlas_roi);
					ROI_list = ROI_list(ROI_list>0);% remove background which is represented by label "0"
					for roi_list_index = 1:length(ROI_list)
					    roi_index = ROI_list(roi_list_index);
					    roi_mask = atlas_roi==roi_index;
					    roi_data = masked_pet_data.*int16(roi_mask);
					    roi(roi_list_index) = mean(roi_data(roi_data>0))/ref_region_meanvalue;
					end
					
					value = roi';
					
				case 18 % SUVRConstructor.GR
					rng_settings_ = rng(); rng(roic.getPropSeed(18), 'twister')
					
					% creates empty Group
					gr_suvr = Group( ...
					    'SUB_CLASS', 'SubjectST', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
					    );
					
					gr_suvr.lock('SUB_CLASS');
					
					gr_T1 = roic.get('GR_T1');% subject from Nifti
					gr_PET = roic.get('GR_PET');% subject from Nifti
					
					
					wb = braph2waitbar(roic.get('WAITBAR'), 0, ['Calculating SUVR for subjects ...']);
					% adds subjects
					sub_dict = gr_suvr.memorize('SUB_DICT');
					for i = 1:1:gr_PET.get('SUB_DICT').get('LENGTH')
					    % braph2waitbar(wb, .15 + .85 * i / gr_sub.get('SUB_DICT').get('LENGTH'), ['Loading subject directory' num2str(i) ' of ' num2str(length(files)) ' ...'])
					    sub_id_t1 = gr_T1.get('SUB_DICT').get('IT', i).get('ID');% subject ID
					    sub_id_pet = gr_PET.get('SUB_DICT').get('IT', i).get('ID');% subject ID
					
					    if isequal(sub_id_t1, sub_id_pet)
					        t1_path = gr_T1.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST');% subject T1 data path
					        pet_path = gr_PET.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST');% subject PET data path
					        for j = 1:length(pet_path)
					            pet_data{j} = niftiread(pet_path{j}.get('PATH'));
					        end
					
					        for j = 1:length(t1_path)
					            t1_data{j} = niftiread(t1_path{j}.get('PATH'));
					        end
					        SUVR = roic.get('CALC_SUBJ_SUVR', pet_data, t1_data);
					
					        % use aal2 with 90 regions, update a list with brain regions of aal120 (stringlist)
					        ba = roic.get('BA');
					
					        % Get the number of brain regions in the atlas
					        num_regions = ba.get('BR_DICT').get('LENGTH');
					
					        % Initialize a cell array to store the names of the brain regions
					        region_names = cell(num_regions, 1);
					
					        % Iterate through each region and get its name
					        for j = 1:ba.get('BR_DICT').get('LENGTH')
					            % Get the brain region element from the BrainAtlas
					            brain_region = ba.get('BR_DICT').get('IT', j);
					
					            % Get the name of the brain region
					            region_names{j} = brain_region.get('ID');
					        end
					
					        selected_suvr_region = roic.get('SUVR_REGION_SELECTION');
					        matched_indices = [];
					        for j = 1:length(region_names)
					            match_idx = find(strcmp(selected_suvr_region, region_names{j}));
					            if ~isempty(match_idx)
					                matched_indices = [matched_indices, match_idx];
					            end
					        end
					        SUVR = SUVR(matched_indices);
					        sub = SubjectST( ...
					            'ID', sub_id_t1, ...
					            'LABEL', ['Subejct ST ' int2str(i)], ...
					            'NOTES', ['Notes on subject ST ' int2str(i)], ...
					            'BA', roic.get('BA'),...
					            'ST', SUVR);
					        sub_dict.get('ADD', sub);
					        braph2waitbar(wb, .15 + .85 * i / gr_PET.get('SUB_DICT').get('LENGTH'), ['Calculating SUVRs for subject ' num2str(i) ' of ' num2str(gr_PET.get('SUB_DICT').get('LENGTH')) ' ...'])
					    end
					end
					
					braph2waitbar(wb, 'close')
					value = gr_suvr;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(roic, prop, varargin{:});
					else
						value = calculateValue@Element(roic, prop, varargin{:});
					end
			end
			
		end
	end
end
