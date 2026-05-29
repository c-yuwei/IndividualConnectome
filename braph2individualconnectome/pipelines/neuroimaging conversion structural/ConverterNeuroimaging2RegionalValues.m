classdef ConverterNeuroimaging2RegionalValues < ConcreteElement
	%ConverterNeuroimaging2RegionalValues calculates mean SUVR value of brain ROIs per subject.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% SUVRConstructor calculates mean value of brain ROIs. It loads brain atlases for ROI identification and calculates mean SUVR values per subject, supporting multiple atlases with region-index mappings loaded from CSV files.
	%
	% The list of ConverterNeuroimaging2RegionalValues properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject ROI constructor for NIfTI.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject ROI constructor for NIfTI.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject ROI constructor for NIfTI.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject ROI constructor for NIfTI.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject ROI constructor for NIfTI.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of subject ROI constructor for NIfTI.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about subject ROI constructor for NIfTI.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>BA</strong> 	BA (data, itemlist) is a list of brain atlases.
	%  <strong>10</strong> <strong>ATLAS_REGION_IDS</strong> 	ATLAS_REGION_IDS (data, stringlist) is the list of region IDs for multiple atlases.
	%  <strong>11</strong> <strong>ATLAS_LABELS</strong> 	ATLAS_LABELS (data, cell) is the list of string labels for multiple atlases.
	%  <strong>12</strong> <strong>MAPPING_PATH_DICT</strong> 	MAPPING_PATH_DICT (data, idict) is the dictionary of paths to CSV files for region-index mappings.
	%  <strong>13</strong> <strong>REF_REGION_LIST</strong> 	REF_REGION_LIST (data, cell) is the list containing the indices of reference regions for each atlas.
	%  <strong>14</strong> <strong>REF_BR_DICT</strong> 	REF_BR_DICT (data, idict) contains the effective brain regions of the simulated network.
	%  <strong>15</strong> <strong>ATLAS_INDEX</strong> 	ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.
	%  <strong>16</strong> <strong>ATLAS_PATH_DICT</strong> 	ATLAS_PATH_DICT (parameter, idict) is the dictionary containing the paths to atlas NIfTI files.
	%  <strong>17</strong> <strong>GR_PET</strong> 	GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
	%  <strong>18</strong> <strong>GR_T1</strong> 	GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
	%  <strong>19</strong> <strong>SUVR_REGION_SELECTION</strong> 	SUVR_REGION_SELECTION (parameter, idict) is the list of selected brain regions.
	%  <strong>20</strong> <strong>CALC_SUBJ_SUVR</strong> 	CALC_SUBJ_SUVR (query, cell) generates SUVR vectors per subject using subject PET and T1 data.
	%  <strong>21</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with SUVR analysis data.
	%  <strong>22</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%
	% ConverterNeuroimaging2RegionalValues methods (constructor):
	%  ConverterNeuroimaging2RegionalValues - constructor
	%
	% ConverterNeuroimaging2RegionalValues methods:
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
	% ConverterNeuroimaging2RegionalValues methods (display):
	%  tostring - string with information about the converter of neuroimaging subject
	%  disp - displays information about the converter of neuroimaging subject
	%  tree - displays the tree of the converter of neuroimaging subject
	%
	% ConverterNeuroimaging2RegionalValues methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two converter of neuroimaging subject are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the converter of neuroimaging subject
	%
	% ConverterNeuroimaging2RegionalValues methods (save/load, Static):
	%  save - saves BRAPH2 converter of neuroimaging subject as b2 file
	%  load - loads a BRAPH2 converter of neuroimaging subject from a b2 file
	%
	% ConverterNeuroimaging2RegionalValues method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the converter of neuroimaging subject
	%
	% ConverterNeuroimaging2RegionalValues method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the converter of neuroimaging subject
	%
	% ConverterNeuroimaging2RegionalValues methods (inspection, Static):
	%  getClass - returns the class of the converter of neuroimaging subject
	%  getSubclasses - returns all subclasses of ConverterNeuroimaging2RegionalValues
	%  getProps - returns the property list of the converter of neuroimaging subject
	%  getPropNumber - returns the property number of the converter of neuroimaging subject
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
	% ConverterNeuroimaging2RegionalValues methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConverterNeuroimaging2RegionalValues methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConverterNeuroimaging2RegionalValues methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConverterNeuroimaging2RegionalValues methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConverterNeuroimaging2RegionalValues; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConverterNeuroimaging2RegionalValues constants</a>.
	%
	%
	% See also Group, SubjectNIfTI, ExporterGroupSubjectCON_XLS, SubjectST, NNDatasetSplit.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BA = 9; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 4;
		BA_FORMAT = 9;
		
		ATLAS_REGION_IDS = 10; %CET: Computational Efficiency Trick
		ATLAS_REGION_IDS_TAG = 'ATLAS_REGION_IDS';
		ATLAS_REGION_IDS_CATEGORY = 4;
		ATLAS_REGION_IDS_FORMAT = 3;
		
		ATLAS_LABELS = 11; %CET: Computational Efficiency Trick
		ATLAS_LABELS_TAG = 'ATLAS_LABELS';
		ATLAS_LABELS_CATEGORY = 4;
		ATLAS_LABELS_FORMAT = 16;
		
		MAPPING_PATH_DICT = 12; %CET: Computational Efficiency Trick
		MAPPING_PATH_DICT_TAG = 'MAPPING_PATH_DICT';
		MAPPING_PATH_DICT_CATEGORY = 4;
		MAPPING_PATH_DICT_FORMAT = 10;
		
		REF_REGION_LIST = 13; %CET: Computational Efficiency Trick
		REF_REGION_LIST_TAG = 'REF_REGION_LIST';
		REF_REGION_LIST_CATEGORY = 4;
		REF_REGION_LIST_FORMAT = 16;
		
		REF_BR_DICT = 14; %CET: Computational Efficiency Trick
		REF_BR_DICT_TAG = 'REF_BR_DICT';
		REF_BR_DICT_CATEGORY = 4;
		REF_BR_DICT_FORMAT = 10;
		
		ATLAS_INDEX = 15; %CET: Computational Efficiency Trick
		ATLAS_INDEX_TAG = 'ATLAS_INDEX';
		ATLAS_INDEX_CATEGORY = 3;
		ATLAS_INDEX_FORMAT = 11;
		
		ATLAS_PATH_DICT = 16; %CET: Computational Efficiency Trick
		ATLAS_PATH_DICT_TAG = 'ATLAS_PATH_DICT';
		ATLAS_PATH_DICT_CATEGORY = 3;
		ATLAS_PATH_DICT_FORMAT = 10;
		
		GR_PET = 17; %CET: Computational Efficiency Trick
		GR_PET_TAG = 'GR_PET';
		GR_PET_CATEGORY = 4;
		GR_PET_FORMAT = 8;
		
		GR_T1 = 18; %CET: Computational Efficiency Trick
		GR_T1_TAG = 'GR_T1';
		GR_T1_CATEGORY = 4;
		GR_T1_FORMAT = 8;
		
		SUVR_REGION_SELECTION = 19; %CET: Computational Efficiency Trick
		SUVR_REGION_SELECTION_TAG = 'SUVR_REGION_SELECTION';
		SUVR_REGION_SELECTION_CATEGORY = 3;
		SUVR_REGION_SELECTION_FORMAT = 10;
		
		CALC_SUBJ_SUVR = 20; %CET: Computational Efficiency Trick
		CALC_SUBJ_SUVR_TAG = 'CALC_SUBJ_SUVR';
		CALC_SUBJ_SUVR_CATEGORY = 6;
		CALC_SUBJ_SUVR_FORMAT = 16;
		
		GR = 21; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 5;
		GR_FORMAT = 8;
		
		WAITBAR = 22; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
	end
	methods % constructor
		function cn = ConverterNeuroimaging2RegionalValues(varargin)
			%ConverterNeuroimaging2RegionalValues() creates a converter of neuroimaging subject.
			%
			% ConverterNeuroimaging2RegionalValues(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConverterNeuroimaging2RegionalValues(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ConverterNeuroimaging2RegionalValues properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject ROI constructor for NIfTI.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject ROI constructor for NIfTI.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject ROI constructor for NIfTI.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject ROI constructor for NIfTI.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject ROI constructor for NIfTI.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of subject ROI constructor for NIfTI.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about subject ROI constructor for NIfTI.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>BA</strong> 	BA (data, itemlist) is a list of brain atlases.
			%  <strong>10</strong> <strong>ATLAS_REGION_IDS</strong> 	ATLAS_REGION_IDS (data, stringlist) is the list of region IDs for multiple atlases.
			%  <strong>11</strong> <strong>ATLAS_LABELS</strong> 	ATLAS_LABELS (data, cell) is the list of string labels for multiple atlases.
			%  <strong>12</strong> <strong>MAPPING_PATH_DICT</strong> 	MAPPING_PATH_DICT (data, idict) is the dictionary of paths to CSV files for region-index mappings.
			%  <strong>13</strong> <strong>REF_REGION_LIST</strong> 	REF_REGION_LIST (data, cell) is the list containing the indices of reference regions for each atlas.
			%  <strong>14</strong> <strong>REF_BR_DICT</strong> 	REF_BR_DICT (data, idict) contains the effective brain regions of the simulated network.
			%  <strong>15</strong> <strong>ATLAS_INDEX</strong> 	ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.
			%  <strong>16</strong> <strong>ATLAS_PATH_DICT</strong> 	ATLAS_PATH_DICT (parameter, idict) is the dictionary containing the paths to atlas NIfTI files.
			%  <strong>17</strong> <strong>GR_PET</strong> 	GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
			%  <strong>18</strong> <strong>GR_T1</strong> 	GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
			%  <strong>19</strong> <strong>SUVR_REGION_SELECTION</strong> 	SUVR_REGION_SELECTION (parameter, idict) is the list of selected brain regions.
			%  <strong>20</strong> <strong>CALC_SUBJ_SUVR</strong> 	CALC_SUBJ_SUVR (query, cell) generates SUVR vectors per subject using subject PET and T1 data.
			%  <strong>21</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with SUVR analysis data.
			%  <strong>22</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%
			% See also Category, Format.
			
			cn = cn@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the converter of neuroimaging subject.
			%
			% BUILD = ConverterNeuroimaging2RegionalValues.GETBUILD() returns the build of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Alternative forms to call this method are:
			%  BUILD = CN.GETBUILD() returns the build of the converter of neuroimaging subject CN.
			%  BUILD = Element.GETBUILD(CN) returns the build of 'CN'.
			%  BUILD = Element.GETBUILD('ConverterNeuroimaging2RegionalValues') returns the build of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Note that the Element.GETBUILD(CN) and Element.GETBUILD('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			
			build = 1;
		end
		function cn_class = getClass()
			%GETCLASS returns the class of the converter of neuroimaging subject.
			%
			% CLASS = ConverterNeuroimaging2RegionalValues.GETCLASS() returns the class 'ConverterNeuroimaging2RegionalValues'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CN.GETCLASS() returns the class of the converter of neuroimaging subject CN.
			%  CLASS = Element.GETCLASS(CN) returns the class of 'CN'.
			%  CLASS = Element.GETCLASS('ConverterNeuroimaging2RegionalValues') returns 'ConverterNeuroimaging2RegionalValues'.
			%
			% Note that the Element.GETCLASS(CN) and Element.GETCLASS('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			
			cn_class = 'ConverterNeuroimaging2RegionalValues';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the converter of neuroimaging subject.
			%
			% LIST = ConverterNeuroimaging2RegionalValues.GETSUBCLASSES() returns all subclasses of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Alternative forms to call this method are:
			%  LIST = CN.GETSUBCLASSES() returns all subclasses of the converter of neuroimaging subject CN.
			%  LIST = Element.GETSUBCLASSES(CN) returns all subclasses of 'CN'.
			%  LIST = Element.GETSUBCLASSES('ConverterNeuroimaging2RegionalValues') returns all subclasses of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Note that the Element.GETSUBCLASSES(CN) and Element.GETSUBCLASSES('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ConverterNeuroimaging2RegionalValues' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of converter of neuroimaging subject.
			%
			% PROPS = ConverterNeuroimaging2RegionalValues.GETPROPS() returns the property list of converter of neuroimaging subject
			%  as a row vector.
			%
			% PROPS = ConverterNeuroimaging2RegionalValues.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CN.GETPROPS([CATEGORY]) returns the property list of the converter of neuroimaging subject CN.
			%  PROPS = Element.GETPROPS(CN[, CATEGORY]) returns the property list of 'CN'.
			%  PROPS = Element.GETPROPS('ConverterNeuroimaging2RegionalValues'[, CATEGORY]) returns the property list of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Note that the Element.GETPROPS(CN) and Element.GETPROPS('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 15 16 19];
				case 4 % Category.DATA
					prop_list = [5 9 10 11 12 13 14 17 18];
				case 5 % Category.RESULT
					prop_list = 21;
				case 6 % Category.QUERY
					prop_list = [8 20];
				case 9 % Category.GUI
					prop_list = 22;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of converter of neuroimaging subject.
			%
			% N = ConverterNeuroimaging2RegionalValues.GETPROPNUMBER() returns the property number of converter of neuroimaging subject.
			%
			% N = ConverterNeuroimaging2RegionalValues.GETPROPNUMBER(CATEGORY) returns the property number of converter of neuroimaging subject
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CN.GETPROPNUMBER([CATEGORY]) returns the property number of the converter of neuroimaging subject CN.
			%  N = Element.GETPROPNUMBER(CN) returns the property number of 'CN'.
			%  N = Element.GETPROPNUMBER('ConverterNeuroimaging2RegionalValues') returns the property number of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Note that the Element.GETPROPNUMBER(CN) and Element.GETPROPNUMBER('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 22;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 4;
				case 4 % Category.DATA
					prop_number = 9;
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
			%EXISTSPROP checks whether property exists in converter of neuroimaging subject/error.
			%
			% CHECK = ConverterNeuroimaging2RegionalValues.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CN.EXISTSPROP(PROP) checks whether PROP exists for CN.
			%  CHECK = Element.EXISTSPROP(CN, PROP) checks whether PROP exists for CN.
			%  CHECK = Element.EXISTSPROP(ConverterNeuroimaging2RegionalValues, PROP) checks whether PROP exists for ConverterNeuroimaging2RegionalValues.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CN.EXISTSPROP(PROP) throws error if PROP does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%  Element.EXISTSPROP(CN, PROP) throws error if PROP does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%  Element.EXISTSPROP(ConverterNeuroimaging2RegionalValues, PROP) throws error if PROP does NOT exist for ConverterNeuroimaging2RegionalValues.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CN) and Element.EXISTSPROP('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 22 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterNeuroimaging2RegionalValues:' 'WrongInput'], ...
					['BRAPH2' ':ConverterNeuroimaging2RegionalValues:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConverterNeuroimaging2RegionalValues.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in converter of neuroimaging subject/error.
			%
			% CHECK = ConverterNeuroimaging2RegionalValues.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CN.EXISTSTAG(TAG) checks whether TAG exists for CN.
			%  CHECK = Element.EXISTSTAG(CN, TAG) checks whether TAG exists for CN.
			%  CHECK = Element.EXISTSTAG(ConverterNeuroimaging2RegionalValues, TAG) checks whether TAG exists for ConverterNeuroimaging2RegionalValues.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CN.EXISTSTAG(TAG) throws error if TAG does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%  Element.EXISTSTAG(CN, TAG) throws error if TAG does NOT exist for CN.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%  Element.EXISTSTAG(ConverterNeuroimaging2RegionalValues, TAG) throws error if TAG does NOT exist for ConverterNeuroimaging2RegionalValues.
			%   Error id: [BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CN) and Element.EXISTSTAG('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'ATLAS_REGION_IDS'  'ATLAS_LABELS'  'MAPPING_PATH_DICT'  'REF_REGION_LIST'  'REF_BR_DICT'  'ATLAS_INDEX'  'ATLAS_PATH_DICT'  'GR_PET'  'GR_T1'  'SUVR_REGION_SELECTION'  'CALC_SUBJ_SUVR'  'GR'  'WAITBAR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterNeuroimaging2RegionalValues:' 'WrongInput'], ...
					['BRAPH2' ':ConverterNeuroimaging2RegionalValues:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ConverterNeuroimaging2RegionalValues.'] ...
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
			%  PROPERTY = CN.GETPROPPROP(POINTER) returns property number of POINTER of CN.
			%  PROPERTY = Element.GETPROPPROP(ConverterNeuroimaging2RegionalValues, POINTER) returns property number of POINTER of ConverterNeuroimaging2RegionalValues.
			%  PROPERTY = CN.GETPROPPROP(ConverterNeuroimaging2RegionalValues, POINTER) returns property number of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPPROP(CN) and Element.GETPROPPROP('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'ATLAS_REGION_IDS'  'ATLAS_LABELS'  'MAPPING_PATH_DICT'  'REF_REGION_LIST'  'REF_BR_DICT'  'ATLAS_INDEX'  'ATLAS_PATH_DICT'  'GR_PET'  'GR_T1'  'SUVR_REGION_SELECTION'  'CALC_SUBJ_SUVR'  'GR'  'WAITBAR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = CN.GETPROPTAG(POINTER) returns tag of POINTER of CN.
			%  TAG = Element.GETPROPTAG(ConverterNeuroimaging2RegionalValues, POINTER) returns tag of POINTER of ConverterNeuroimaging2RegionalValues.
			%  TAG = CN.GETPROPTAG(ConverterNeuroimaging2RegionalValues, POINTER) returns tag of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPTAG(CN) and Element.GETPROPTAG('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				converterneuroimaging2regionalvalues_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'ATLAS_REGION_IDS'  'ATLAS_LABELS'  'MAPPING_PATH_DICT'  'REF_REGION_LIST'  'REF_BR_DICT'  'ATLAS_INDEX'  'ATLAS_PATH_DICT'  'GR_PET'  'GR_T1'  'SUVR_REGION_SELECTION'  'CALC_SUBJ_SUVR'  'GR'  'WAITBAR' };
				tag = converterneuroimaging2regionalvalues_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = CN.GETPROPCATEGORY(POINTER) returns category of POINTER of CN.
			%  CATEGORY = Element.GETPROPCATEGORY(ConverterNeuroimaging2RegionalValues, POINTER) returns category of POINTER of ConverterNeuroimaging2RegionalValues.
			%  CATEGORY = CN.GETPROPCATEGORY(ConverterNeuroimaging2RegionalValues, POINTER) returns category of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPCATEGORY(CN) and Element.GETPROPCATEGORY('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterneuroimaging2regionalvalues_category_list = { 1  1  1  3  4  2  2  6  4  4  4  4  4  4  3  3  4  4  3  6  5  9 };
			prop_category = converterneuroimaging2regionalvalues_category_list{prop};
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
			%  FORMAT = CN.GETPROPFORMAT(POINTER) returns format of POINTER of CN.
			%  FORMAT = Element.GETPROPFORMAT(ConverterNeuroimaging2RegionalValues, POINTER) returns format of POINTER of ConverterNeuroimaging2RegionalValues.
			%  FORMAT = CN.GETPROPFORMAT(ConverterNeuroimaging2RegionalValues, POINTER) returns format of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPFORMAT(CN) and Element.GETPROPFORMAT('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterneuroimaging2regionalvalues_format_list = { 2  2  2  8  2  2  2  2  9  3  16  10  16  10  11  10  8  8  10  16  8  4 };
			prop_format = converterneuroimaging2regionalvalues_format_list{prop};
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
			%  DESCRIPTION = CN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConverterNeuroimaging2RegionalValues, POINTER) returns description of POINTER of ConverterNeuroimaging2RegionalValues.
			%  DESCRIPTION = CN.GETPROPDESCRIPTION(ConverterNeuroimaging2RegionalValues, POINTER) returns description of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPDESCRIPTION(CN) and Element.GETPROPDESCRIPTION('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			converterneuroimaging2regionalvalues_description_list = { 'ELCLASS (constant, string) is the class of the subject ROI constructor for NIfTI.'  'NAME (constant, string) is the name of the subject ROI constructor for NIfTI.'  'DESCRIPTION (constant, string) is the description of the subject ROI constructor for NIfTI.'  'TEMPLATE (parameter, item) is the template of the subject ROI constructor for NIfTI.'  'ID (data, string) is a few-letter code for the subject ROI constructor for NIfTI.'  'LABEL (metadata, string) is an extended label of subject ROI constructor for NIfTI.'  'NOTES (metadata, string) are some specific notes about subject ROI constructor for NIfTI.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'BA (data, itemlist) is a list of brain atlases.'  'ATLAS_REGION_IDS (data, stringlist) is the list of region IDs for multiple atlases.'  'ATLAS_LABELS (data, cell) is the list of string labels for multiple atlases.'  'MAPPING_PATH_DICT (data, idict) is the dictionary of paths to CSV files for region-index mappings.'  'REF_REGION_LIST (data, cell) is the list containing the indices of reference regions for each atlas.'  'REF_BR_DICT (data, idict) contains the effective brain regions of the simulated network.'  'ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.'  'ATLAS_PATH_DICT (parameter, idict) is the dictionary containing the paths to atlas NIfTI files.'  'GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.'  'GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.'  'SUVR_REGION_SELECTION (parameter, idict) is the list of selected brain regions.'  'CALC_SUBJ_SUVR (query, cell) generates SUVR vectors per subject using subject PET and T1 data.'  'GR (result, item) is a group of subjects with SUVR analysis data.'  'WAITBAR (gui, logical) determines whether to show the waitbar.' };
			prop_description = converterneuroimaging2regionalvalues_description_list{prop};
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
			%  SETTINGS = CN.GETPROPSETTINGS(POINTER) returns settings of POINTER of CN.
			%  SETTINGS = Element.GETPROPSETTINGS(ConverterNeuroimaging2RegionalValues, POINTER) returns settings of POINTER of ConverterNeuroimaging2RegionalValues.
			%  SETTINGS = CN.GETPROPSETTINGS(ConverterNeuroimaging2RegionalValues, POINTER) returns settings of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPSETTINGS(CN) and Element.GETPROPSETTINGS('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConverterNeuroimaging2RegionalValues.BA
					prop_settings = 'BrainAtlas';
				case 10 % ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					prop_settings = Format.getFormatSettings(3);
				case 11 % ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					prop_settings = Format.getFormatSettings(16);
				case 12 % ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					prop_settings = 'FILE_PATH';
				case 13 % ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					prop_settings = Format.getFormatSettings(16);
				case 14 % ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					prop_settings = 'BrainRegion';
				case 15 % ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					prop_settings = Format.getFormatSettings(11);
				case 16 % ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					prop_settings = 'FILE_PATH';
				case 17 % ConverterNeuroimaging2RegionalValues.GR_PET
					prop_settings = Format.getFormatSettings(8);
				case 18 % ConverterNeuroimaging2RegionalValues.GR_T1
					prop_settings = Format.getFormatSettings(8);
				case 19 % ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					prop_settings = 'BrainRegion';
				case 20 % ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					prop_settings = Format.getFormatSettings(16);
				case 21 % ConverterNeuroimaging2RegionalValues.GR
					prop_settings = Format.getFormatSettings(8);
				case 22 % ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 4 % ConverterNeuroimaging2RegionalValues.TEMPLATE
					prop_settings = 'SUVRConstructor';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValues.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValues.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CN.
			%  DEFAULT = Element.GETPROPDEFAULT(ConverterNeuroimaging2RegionalValues, POINTER) returns the default value of POINTER of ConverterNeuroimaging2RegionalValues.
			%  DEFAULT = CN.GETPROPDEFAULT(ConverterNeuroimaging2RegionalValues, POINTER) returns the default value of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPDEFAULT(CN) and Element.GETPROPDEFAULT('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ConverterNeuroimaging2RegionalValues.BA
					prop_default = Format.getFormatDefault(9, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 10 % ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					prop_default = {} % Default to an empty cell array;
				case 11 % ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					prop_default = {} % Default to an empty cell array;
				case 12 % ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'FILE_PATH');
				case 13 % ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					prop_default = {};
				case 14 % ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					prop_default = Format.getFormatDefault(10, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 15 % ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					prop_default = 1;;
				case 16 % ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'FILE_PATH');
				case 17 % ConverterNeuroimaging2RegionalValues.GR_PET
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI');
				case 18 % ConverterNeuroimaging2RegionalValues.GR_T1
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI');
				case 19 % ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					prop_default = Format.getFormatDefault(10, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 20 % ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					prop_default = Format.getFormatDefault(16, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 21 % ConverterNeuroimaging2RegionalValues.GR
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case 22 % ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_default = true;
				case 1 % ConverterNeuroimaging2RegionalValues.ELCLASS
					prop_default = 'ConverterNeuroimaging2RegionalValues';
				case 2 % ConverterNeuroimaging2RegionalValues.NAME
					prop_default = 'SUVR Constructor';
				case 3 % ConverterNeuroimaging2RegionalValues.DESCRIPTION
					prop_default = 'SUVRConstructor calculates a group of subjects mean value of ROI from imaging data from a series of NIfTI files.';
				case 4 % ConverterNeuroimaging2RegionalValues.TEMPLATE
					prop_default = Format.getFormatDefault(8, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 5 % ConverterNeuroimaging2RegionalValues.ID
					prop_default = 'SUVRConstructor ID';
				case 6 % ConverterNeuroimaging2RegionalValues.LABEL
					prop_default = 'SUVRConstructor label';
				case 7 % ConverterNeuroimaging2RegionalValues.NOTES
					prop_default = 'SUVRConstructor notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValues.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConverterNeuroimaging2RegionalValues.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConverterNeuroimaging2RegionalValues, POINTER) returns the conditioned default value of POINTER of ConverterNeuroimaging2RegionalValues.
			%  DEFAULT = CN.GETPROPDEFAULTCONDITIONED(ConverterNeuroimaging2RegionalValues, POINTER) returns the conditioned default value of POINTER of ConverterNeuroimaging2RegionalValues.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CN) and Element.GETPROPDEFAULTCONDITIONED('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			prop_default = ConverterNeuroimaging2RegionalValues.conditioning(prop, ConverterNeuroimaging2RegionalValues.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CN.
			%  CHECK = Element.CHECKPROP(ConverterNeuroimaging2RegionalValues, PROP, VALUE) checks VALUE format for PROP of ConverterNeuroimaging2RegionalValues.
			%  CHECK = CN.CHECKPROP(ConverterNeuroimaging2RegionalValues, PROP, VALUE) checks VALUE format for PROP of ConverterNeuroimaging2RegionalValues.
			% 
			% CN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CN.
			%   Error id: BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput
			%  Element.CHECKPROP(ConverterNeuroimaging2RegionalValues, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterNeuroimaging2RegionalValues.
			%   Error id: BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput
			%  CN.CHECKPROP(ConverterNeuroimaging2RegionalValues, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterNeuroimaging2RegionalValues.
			%   Error id: BRAPH2:ConverterNeuroimaging2RegionalValues:WrongInput]
			% 
			% Note that the Element.CHECKPROP(CN) and Element.CHECKPROP('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			switch prop
				case 9 % ConverterNeuroimaging2RegionalValues.BA
					check = Format.checkFormat(9, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 10 % ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					check = Format.checkFormat(3, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 11 % ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					check = Format.checkFormat(16, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 12 % ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					check = Format.checkFormat(10, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 13 % ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					check = Format.checkFormat(16, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 14 % ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					check = Format.checkFormat(10, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 15 % ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					check = Format.checkFormat(11, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 16 % ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					check = Format.checkFormat(10, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 17 % ConverterNeuroimaging2RegionalValues.GR_PET
					check = Format.checkFormat(8, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 18 % ConverterNeuroimaging2RegionalValues.GR_T1
					check = Format.checkFormat(8, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 19 % ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					check = Format.checkFormat(10, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 20 % ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					check = Format.checkFormat(16, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 21 % ConverterNeuroimaging2RegionalValues.GR
					check = Format.checkFormat(8, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 22 % ConverterNeuroimaging2RegionalValues.WAITBAR
					check = Format.checkFormat(4, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 4 % ConverterNeuroimaging2RegionalValues.TEMPLATE
					check = Format.checkFormat(8, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConverterNeuroimaging2RegionalValues:' 'WrongInput'], ...
					['BRAPH2' ':ConverterNeuroimaging2RegionalValues:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConverterNeuroimaging2RegionalValues.getPropTag(prop) ' (' ConverterNeuroimaging2RegionalValues.getFormatTag(ConverterNeuroimaging2RegionalValues.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(cn, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 12 % ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					if roic.get('MAPPING_PATH_DICT').get('LENGTH') > 0
					    mapping_files = roic.get('MAPPING_PATH_DICT').get('IT_LIST');
					    atlas_region_ids = cell(1, length(mapping_files));
					    atlas_labels = cell(1, length(mapping_files));
					    for atlas_idx = 1:length(mapping_files)
					        file_path = mapping_files{atlas_idx}.get('PATH');
					        if ~isfile(file_path)
					            warning('File not found: %s. Skipping atlas %d.', file_path, atlas_idx);
					            atlas_region_ids{atlas_idx} = {};
					            atlas_labels{atlas_idx} = {};
					            continue;
					        end
					        atlas_data = readtable(file_path, 'FileType', 'text');
					        if size(atlas_data, 2) < 2
					            warning('CSV file %s lacks 2 columns. Skipping atlas %d.', file_path, atlas_idx);
					            atlas_region_ids{atlas_idx} = {};
					            atlas_labels{atlas_idx} = {};
					            continue;
					        end
					        % Split data into numeric IDs and string labels
					        region_ids = atlas_data{:, 2}; % Numeric indices
					        labels = atlas_data{:, 1};          % String labels
					        atlas_region_ids{atlas_idx} = region_ids; % Cell array of numeric IDs
					        atlas_labels{atlas_idx} = labels;                    % String array of labels
					    end
					    % Assuming atlas_region_ids is a cell array of column vectors
					    atlas_region_ids_list = cell(1, length(atlas_region_ids)); % Preallocate a cell array
					    for i = 1:length(atlas_region_ids)
					        atlas_region_ids_list{i} = atlas_region_ids{i}'; % Transpose each column vector to a row vector
					    end
					    all_region_ids = [atlas_region_ids_list{:}]; % Concatenate all row vectors horizontally
					
					    all_atlas_labels_list = cell(1, length(atlas_labels)); % Preallocate a cell array
					    for i = 1:length(atlas_labels)
					        all_atlas_labels_list{i} = atlas_labels{i}'; % Transpose each column vector to a row vector
					    end
					    all_atlas_labels = [all_atlas_labels_list{:}];
					    all_atlas_labels = num2cell(all_atlas_labels);
					    roic.set('ATLAS_REGION_IDS', all_region_ids);
					    roic.set('ATLAS_LABELS', all_atlas_labels);
					end
					
				case 13 % ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					if ~isempty(roic.get('REF_REGION_LIST'))
					    ba_list = roic.get('BA');
					    ref_region_list = roic.get('REF_REGION_LIST');
					    region_ids = roic.get('ATLAS_REGION_IDS');
					    labels = roic.get('ATLAS_LABELS');
					    ref_br_list = cell(0); % Initialize an empty cell array for reference brain regions
					    % Iterate over each atlas in ref_region_list
					    for atlas_idx = 1:length(ref_region_list)
					        ba = ba_list{atlas_idx}; % Get the BrainAtlas for this atlas index
					        br_dict = ba.get('BR_DICT');       % Get the brain region dictionary for this atlas
					        indices = ref_region_list{atlas_idx}; % Numeric indices for this atlas
					        % Iterate over each index in the current atlas's reference list
					        for idx = 1:length(indices)
					            % Find the position of the numeric index in region_ids
					            pos = find(cellfun(@(x) x == indices(idx), labels));
					            if ~isempty(pos)
					                % Get the corresponding label using the position
					                label = labels{pos}; % Access as cell element since labels is a cell array
					                region_id = region_ids{pos};
					                if ~isempty(region_id)
					                    br = br_dict.get('IT', region_id); % Retrieve the brain region
					                    ref_br_list{end+1} = br; % Add to the list
					                end
					            end
					        end
					    end
					    if isempty(roic.get('REF_BR_DICT').get('IT_LIST'))
					        % Set the REF_BR_DICT with the list of reference brain regions
					        roic.set('REF_BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', ref_br_list));
					    end
					% else
					%     % If REF_REGION_LIST is empty, ensure it’s a 0×0 empty cell array
					%     roic.set('REF_REGION_LIST', {});
					end
					
				case 14 % ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					Ref_region_list = roic.get('REF_REGION_LIST');
					selected_br = roic.get('REF_BR_DICT').get('IT_LIST'); % List of selected BrainRegion objects
					ba_list = roic.get('BA');
					region_ids = roic.get('ATLAS_REGION_IDS');
					labels = roic.get('ATLAS_LABELS');
					ref_region_list = cell(length(ba_list)); % One cell per atlas
					for atlas_idx = 1:length(ba_list)
					    ba = ba_list{atlas_idx};
					    br_dict = ba.get('BR_DICT');
					    atlas_br_ids = cellfun(@(br) br.get('ID'), br_dict.get('IT_LIST'), 'UniformOutput', false);
					    selected_br_ids = cellfun(@(br) br.get('ID'), selected_br, 'UniformOutput', false);
					    [~, loc] = ismember(selected_br_ids, atlas_br_ids); % Find matches
					    idx = find(loc > 0); % Indices of matches
					    selected_br_ids = selected_br_ids(idx);
					    if ~isempty(idx)
					        [~, loc] = ismember(selected_br_ids, region_ids);
					        ref_region = labels(loc);
					        ref_region_list{atlas_idx} =  [ref_region{:}];
					    end
					end
					if isempty(Ref_region_list) && ~isempty(ref_region_list)
					    roic.set('REF_REGION_LIST', ref_region_list);
					end
					
				case 15 % ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					ba_list = roic.get('BA'); % Ensure brain atlas is obtained correctly
					if isempty(ba_list)
					    br = BrainRegion('ID', 'SingleRegion');
					    ba = BrainAtlas('ID', 'Atlas', 'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {br}));
					    ba_list = {ba};
					end
					atlas_index = roic.get('ATLAS_INDEX');
					ba = ba_list{atlas_index};
					if isempty(roic.get('SUVR_REGION_SELECTION').get('IT_LIST')) && ~isempty(ba.get('BR_DICT').get('IT_LIST'))
					    roic.set('SUVR_REGION_SELECTION', ba.get('BR_DICT'));
					end
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(cn, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(cn, prop, varargin)
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
				case 20 % ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
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
					
					% Constrain PET data within the T1 data
					masked_pet_data = pet_data{1} .* int16(t1_data_union_mask);
					
					% Calculate SUVR for reference regions
					atlas_directories = roic.get('ATLAS_PATH_DICT').get('IT_LIST'); % in hangs case, there are 2 atlases
					% atlas_kind = roic.get('ATLAS_KIND');
					ref_list = roic.get('REF_REGION_LIST'); % 2001 from atlas 1, 1XXX from atlas 2
					atlas_suvr_index = roic.get('ATLAS_INDEX');
					for directory_index = 1:length(atlas_directories)
					    directory_dict = atlas_directories{directory_index};
					    directory_path = directory_dict.get('PATH');
					    atlas{directory_index} = niftiread(directory_path);
					    ref_region_masks{directory_index} = ismember(atlas{directory_index}, ref_list{directory_index}); % one mask per one atlase, hang's case is 2 atlases, so 2 masks
					end
					ref_region_union_mask = ref_region_masks{1};
					for i = 2:length(ref_region_masks)
					    ref_region_union_mask = ref_region_union_mask | ref_region_masks{i}; % merge into one union atlas mask for reference regions
					end
					% ref_region_meanvalue = mean(masked_pet_data(ref_region_union_mask));
					% % Sort the values in descending order
					sorted_values = sort(masked_pet_data(ref_region_union_mask), 'descend');
					
					% Calculate the number of values that constitute the top 50%
					num_values = length(sorted_values);
					top_50_percent_count = ceil(num_values / 2); % according to ADNI's instruction
					
					% Select the top 50% of the values
					top_50_percent_values = sorted_values(1:top_50_percent_count);
					
					% Calculate the mean of the top 50% values
					ref_region_meanvalue = mean(top_50_percent_values);
					% Calculate normalized SUVR for all unique regions
					atlas_roi = atlas{atlas_suvr_index};
					ROI_list = unique(atlas_roi);
					ROI_list = ROI_list(ROI_list>0); % Remove background (label "0")
					for roi_list_index = 1:length(ROI_list)
					    roi_index = ROI_list(roi_list_index);
					    roi_mask = atlas_roi == roi_index;
					    roi_data = masked_pet_data .* int16(roi_mask);
					    roi(roi_list_index) = mean(roi_data(roi_data>0)) / ref_region_meanvalue;
					end
					
					value = roi';
					
				case 21 % ConverterNeuroimaging2RegionalValues.GR
					rng_settings_ = rng(); rng(cn.getPropSeed(21), 'twister')
					
					% Create empty Group
					gr_suvr = Group( ...
					    'SUB_CLASS', 'SubjectST', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
					);
					
					gr_suvr.lock('SUB_CLASS');
					
					gr_T1 = roic.get('GR_T1'); % Subject from NIfTI
					gr_PET = roic.get('GR_PET'); % Subject from NIfTI
					
					wb = braph2waitbar(roic.get('WAITBAR'), 0, ['Calculating SUVR for subjects ...']);
					% Add subjects
					sub_dict = gr_suvr.memorize('SUB_DICT');
					for i = 1:1:gr_PET.get('SUB_DICT').get('LENGTH')
					    sub_id_t1 = gr_T1.get('SUB_DICT').get('IT', i).get('ID'); % Subject ID
					    sub_id_pet = gr_PET.get('SUB_DICT').get('IT', i).get('ID'); % Subject ID
					
					    if isequal(sub_id_t1, sub_id_pet)
					        t1_path = gr_T1.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST'); % Subject T1 data path
					        pet_path = gr_PET.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST'); % Subject PET data path
					        for j = 1:length(pet_path)
					            pet_data{j} = niftiread(pet_path{j}.get('PATH'));
					        end
					
					        for j = 1:length(t1_path)
					            t1_data{j} = niftiread(t1_path{j}.get('PATH'));
					        end
					        SUVR = roic.get('CALC_SUBJ_SUVR', pet_data, t1_data);
					
					        % Use atlas with regions, update a list with brain regions
					        ba_list = roic.get('BA'); % it imports a list of BA (several), in hang's case it is 2
					        atlas_suvr_index = roic.get('ATLAS_INDEX'); % index for specifying which atlas we use to have the regions for SUVR
					        ba = ba_list{atlas_suvr_index};
					        
					        num_regions = ba.get('BR_DICT').get('LENGTH');
					        region_names = cell(num_regions, 1);
					        for j = 1:ba.get('BR_DICT').get('LENGTH')
					            brain_region = ba.get('BR_DICT').get('IT', j);
					            region_names{j} = brain_region.get('ID');
					        end
					
					        selected_suvr_region = cellfun(@(x) x.get('ID'), roic.get('SUVR_REGION_SELECTION').get('IT_LIST'),'UniformOutput',false);
					        matched_indices = [];
					        for j = 1:length(region_names)
					            match_idx = find(strcmp(selected_suvr_region, region_names{j}));
					            if ~isempty(match_idx)
					                matched_indices = [matched_indices, match_idx];
					            end
					        end
					        
					        SUVR = SUVR(matched_indices);
					        % Create a new BrainAtlas with only selected regions
					        selected_br_list = cellfun(@(idx) ba.get('BR_DICT').get('IT', idx), num2cell(matched_indices), 'UniformOutput', false);
					        br_dict_filtered = IndexedDictionary( ...
					            'IT_CLASS', 'BrainRegion', ...
					            'IT_LIST', selected_br_list ...
					            );
					        ba_filtered = BrainAtlas( ...
					            'ID', [ba.get('ID') '_filtered'], ...
					            'LABEL', ba.get('LABEL'), ...
					            'NOTES', [ba.get('NOTES') ' - Filtered to selected regions'], ...
					            'BR_DICT', br_dict_filtered ...
					            );
					
					        % Create subject with filtered atlas
					        sub = SubjectST( ...
					            'ID', sub_id_t1, ...
					            'LABEL', ['Subject ST ' int2str(i)], ...
					            'NOTES', ['Notes on subject ST ' int2str(i)], ...
					            'BA', ba_filtered, ... % Use filtered atlas
					            'ST', SUVR, ...
					            'VOI_DICT', gr_PET.get('SUB_DICT').get('IT', i).get('VOI_DICT'));
					        % sub = SubjectST( ...
					        %     'ID', sub_id_t1, ...
					        %     'LABEL', ['Subject ST ' int2str(i)], ...
					        %     'NOTES', ['Notes on subject ST ' int2str(i)], ...
					        %     'BA', ba, ...
					        %     'ST', SUVR);
					        sub_dict.get('ADD', sub);
					        braph2waitbar(wb, .15 + .85 * i / gr_PET.get('SUB_DICT').get('LENGTH'), ['Calculating SUVRs for subject ' num2str(i) ' of ' num2str(gr_PET.get('SUB_DICT').get('LENGTH')) ' ...'])
					    end
					end
					
					braph2waitbar(wb, 'close')
					value = gr_suvr;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(cn, prop, varargin{:});
					else
						value = calculateValue@Element(cn, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(cn, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 14 % ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					pr = SUVRConstructorPP_BR_DICT('EL', roic, 'PROP', SUVRConstructor.REF_BR_DICT, ...
					    'WAITBAR', roic.getCallback('WAITBAR'), ...
					    varargin{:});
					
					% %% ¡prop!
					% ATLAS_KIND (parameter, stringlist) is the list of atlas types needed for ROI analysis.
					% %% ¡default!
					% {'aal90', 'TD'}
					
				case 19 % ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					pr = SUVRConstructorPP_BR_DICT('EL', roic, 'PROP', SUVRConstructor.SUVR_REGION_SELECTION, ...
					    'WAITBAR', roic.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(cn, prop, varargin{:});
					
			end
		end
	end
end
