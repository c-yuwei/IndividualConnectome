classdef ConverterNeuroimaging2RegionalValues < ConcreteElement
	%ConverterNeuroimaging2RegionalValues converts subject-level NIfTI neuroimaging data into regional values.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% ConverterNeuroimaging2RegionalValues converts subject-level NIfTI neuroimaging data into regional values using one or more atlas NIfTI files and atlas mapping files. It can optionally restrict voxel averaging with anatomical reference images, such as GM or WM probability maps, and can optionally normalize the converted values by reference brain regions, enabling PET SUVR extraction as well as direct MRI-derived regional value extraction.
	%
	% The list of ConverterNeuroimaging2RegionalValues properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the converter of neuroimaging data to regional values.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the converter of neuroimaging data to regional values.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the converter of neuroimaging data to regional values.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the converter of neuroimaging data to regional values.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the converter of neuroimaging data to regional values.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the converter of neuroimaging data to regional values.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the converter of neuroimaging data to regional values.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>BA_LIST</strong> 	BA_LIST (data, itemlist) is the list of brain atlases used to identify the brain regions.
	%  <strong>10</strong> <strong>BA_NIFTI_FILES</strong> 	BA_NIFTI_FILES (data, stringlist) is the list of atlas NIfTI files aligned with BA_LIST.
	%  <strong>11</strong> <strong>BA_MAPPING_FILES</strong> 	BA_MAPPING_FILES (data, stringlist) is the list of atlas mapping CSV files aligned with BA_LIST.
	%  <strong>12</strong> <strong>GR_NEUROIMAGING</strong> 	GR_NEUROIMAGING (data, item) is the group of subject-level neuroimaging data to convert.
	%  <strong>13</strong> <strong>GR_LIST_ANAT_REF</strong> 	GR_LIST_ANAT_REF (data, itemlist) is the list of anatomical reference groups used to restrict voxel averaging.
	%  <strong>14</strong> <strong>THRESHOLD_ANAT_REF</strong> 	THRESHOLD_ANAT_REF (parameter, scalar) is the threshold applied to anatomical reference images.
	%  <strong>15</strong> <strong>REF_TOP_PERCENTAGE</strong> 	REF_TOP_PERCENTAGE (parameter, scalar) is the fraction of highest voxel values in the reference regions used for normalization.
	%  <strong>16</strong> <strong>ANAT_REF_COMBINE_RULE</strong> 	ANAT_REF_COMBINE_RULE (parameter, option) is the rule used to combine multiple anatomical reference masks.
	%  <strong>17</strong> <strong>REF_BR</strong> 	REF_BR (data, stringlist) is the list of reference brain-region IDs used for optional normalization.
	%  <strong>18</strong> <strong>CONVERT_BR</strong> 	CONVERT_BR (data, stringlist) is the list of brain-region IDs to convert into regional values.
	%  <strong>19</strong> <strong>BR_LABEL_IN_MAPS</strong> 	BR_LABEL_IN_MAPS (query, cell) finds the atlas index and numeric atlas label for a brain-region ID.
	%  <strong>20</strong> <strong>BA</strong> 	BA (result, item) is the brain atlas containing the converted brain regions.
	%  <strong>21</strong> <strong>GR_ST</strong> 	GR_ST (result, item) is the group of subjects with regional values.
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
	%  tostring - string with information about the converter of neuroimaging data to regional values
	%  disp - displays information about the converter of neuroimaging data to regional values
	%  tree - displays the tree of the converter of neuroimaging data to regional values
	%
	% ConverterNeuroimaging2RegionalValues methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two converter of neuroimaging data to regional values are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the converter of neuroimaging data to regional values
	%
	% ConverterNeuroimaging2RegionalValues methods (save/load, Static):
	%  save - saves BRAPH2 converter of neuroimaging data to regional values as b2 file
	%  load - loads a BRAPH2 converter of neuroimaging data to regional values from a b2 file
	%
	% ConverterNeuroimaging2RegionalValues method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the converter of neuroimaging data to regional values
	%
	% ConverterNeuroimaging2RegionalValues method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the converter of neuroimaging data to regional values
	%
	% ConverterNeuroimaging2RegionalValues methods (inspection, Static):
	%  getClass - returns the class of the converter of neuroimaging data to regional values
	%  getSubclasses - returns all subclasses of ConverterNeuroimaging2RegionalValues
	%  getProps - returns the property list of the converter of neuroimaging data to regional values
	%  getPropNumber - returns the property number of the converter of neuroimaging data to regional values
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
	% See also Group, SubjectNeuroimaging, SubjectST, BrainAtlas, BrainRegion, ImporterGroupSubjectNeuroimaging_NIfTI, ExporterGroupSubjectST_XLS, ExporterBrainAtlasXLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BA_LIST = 9; %CET: Computational Efficiency Trick
		BA_LIST_TAG = 'BA_LIST';
		BA_LIST_CATEGORY = 4;
		BA_LIST_FORMAT = 9;
		
		BA_NIFTI_FILES = 10; %CET: Computational Efficiency Trick
		BA_NIFTI_FILES_TAG = 'BA_NIFTI_FILES';
		BA_NIFTI_FILES_CATEGORY = 4;
		BA_NIFTI_FILES_FORMAT = 3;
		
		BA_MAPPING_FILES = 11; %CET: Computational Efficiency Trick
		BA_MAPPING_FILES_TAG = 'BA_MAPPING_FILES';
		BA_MAPPING_FILES_CATEGORY = 4;
		BA_MAPPING_FILES_FORMAT = 3;
		
		GR_NEUROIMAGING = 12; %CET: Computational Efficiency Trick
		GR_NEUROIMAGING_TAG = 'GR_NEUROIMAGING';
		GR_NEUROIMAGING_CATEGORY = 4;
		GR_NEUROIMAGING_FORMAT = 8;
		
		GR_LIST_ANAT_REF = 13; %CET: Computational Efficiency Trick
		GR_LIST_ANAT_REF_TAG = 'GR_LIST_ANAT_REF';
		GR_LIST_ANAT_REF_CATEGORY = 4;
		GR_LIST_ANAT_REF_FORMAT = 9;
		
		THRESHOLD_ANAT_REF = 14; %CET: Computational Efficiency Trick
		THRESHOLD_ANAT_REF_TAG = 'THRESHOLD_ANAT_REF';
		THRESHOLD_ANAT_REF_CATEGORY = 3;
		THRESHOLD_ANAT_REF_FORMAT = 11;
		
		REF_TOP_PERCENTAGE = 15; %CET: Computational Efficiency Trick
		REF_TOP_PERCENTAGE_TAG = 'REF_TOP_PERCENTAGE';
		REF_TOP_PERCENTAGE_CATEGORY = 3;
		REF_TOP_PERCENTAGE_FORMAT = 11;
		
		ANAT_REF_COMBINE_RULE = 16; %CET: Computational Efficiency Trick
		ANAT_REF_COMBINE_RULE_TAG = 'ANAT_REF_COMBINE_RULE';
		ANAT_REF_COMBINE_RULE_CATEGORY = 3;
		ANAT_REF_COMBINE_RULE_FORMAT = 5;
		
		REF_BR = 17; %CET: Computational Efficiency Trick
		REF_BR_TAG = 'REF_BR';
		REF_BR_CATEGORY = 4;
		REF_BR_FORMAT = 3;
		
		CONVERT_BR = 18; %CET: Computational Efficiency Trick
		CONVERT_BR_TAG = 'CONVERT_BR';
		CONVERT_BR_CATEGORY = 4;
		CONVERT_BR_FORMAT = 3;
		
		BR_LABEL_IN_MAPS = 19; %CET: Computational Efficiency Trick
		BR_LABEL_IN_MAPS_TAG = 'BR_LABEL_IN_MAPS';
		BR_LABEL_IN_MAPS_CATEGORY = 6;
		BR_LABEL_IN_MAPS_FORMAT = 16;
		
		BA = 20; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 5;
		BA_FORMAT = 8;
		
		GR_ST = 21; %CET: Computational Efficiency Trick
		GR_ST_TAG = 'GR_ST';
		GR_ST_CATEGORY = 5;
		GR_ST_FORMAT = 8;
		
		WAITBAR = 22; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
	end
	methods % constructor
		function cn = ConverterNeuroimaging2RegionalValues(varargin)
			%ConverterNeuroimaging2RegionalValues() creates a converter of neuroimaging data to regional values.
			%
			% ConverterNeuroimaging2RegionalValues(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConverterNeuroimaging2RegionalValues(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ConverterNeuroimaging2RegionalValues properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the converter of neuroimaging data to regional values.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the converter of neuroimaging data to regional values.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the converter of neuroimaging data to regional values.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the converter of neuroimaging data to regional values.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the converter of neuroimaging data to regional values.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the converter of neuroimaging data to regional values.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the converter of neuroimaging data to regional values.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>BA_LIST</strong> 	BA_LIST (data, itemlist) is the list of brain atlases used to identify the brain regions.
			%  <strong>10</strong> <strong>BA_NIFTI_FILES</strong> 	BA_NIFTI_FILES (data, stringlist) is the list of atlas NIfTI files aligned with BA_LIST.
			%  <strong>11</strong> <strong>BA_MAPPING_FILES</strong> 	BA_MAPPING_FILES (data, stringlist) is the list of atlas mapping CSV files aligned with BA_LIST.
			%  <strong>12</strong> <strong>GR_NEUROIMAGING</strong> 	GR_NEUROIMAGING (data, item) is the group of subject-level neuroimaging data to convert.
			%  <strong>13</strong> <strong>GR_LIST_ANAT_REF</strong> 	GR_LIST_ANAT_REF (data, itemlist) is the list of anatomical reference groups used to restrict voxel averaging.
			%  <strong>14</strong> <strong>THRESHOLD_ANAT_REF</strong> 	THRESHOLD_ANAT_REF (parameter, scalar) is the threshold applied to anatomical reference images.
			%  <strong>15</strong> <strong>REF_TOP_PERCENTAGE</strong> 	REF_TOP_PERCENTAGE (parameter, scalar) is the fraction of highest voxel values in the reference regions used for normalization.
			%  <strong>16</strong> <strong>ANAT_REF_COMBINE_RULE</strong> 	ANAT_REF_COMBINE_RULE (parameter, option) is the rule used to combine multiple anatomical reference masks.
			%  <strong>17</strong> <strong>REF_BR</strong> 	REF_BR (data, stringlist) is the list of reference brain-region IDs used for optional normalization.
			%  <strong>18</strong> <strong>CONVERT_BR</strong> 	CONVERT_BR (data, stringlist) is the list of brain-region IDs to convert into regional values.
			%  <strong>19</strong> <strong>BR_LABEL_IN_MAPS</strong> 	BR_LABEL_IN_MAPS (query, cell) finds the atlas index and numeric atlas label for a brain-region ID.
			%  <strong>20</strong> <strong>BA</strong> 	BA (result, item) is the brain atlas containing the converted brain regions.
			%  <strong>21</strong> <strong>GR_ST</strong> 	GR_ST (result, item) is the group of subjects with regional values.
			%  <strong>22</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%
			% See also Category, Format.
			
			cn = cn@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the converter of neuroimaging data to regional values.
			%
			% BUILD = ConverterNeuroimaging2RegionalValues.GETBUILD() returns the build of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Alternative forms to call this method are:
			%  BUILD = CN.GETBUILD() returns the build of the converter of neuroimaging data to regional values CN.
			%  BUILD = Element.GETBUILD(CN) returns the build of 'CN'.
			%  BUILD = Element.GETBUILD('ConverterNeuroimaging2RegionalValues') returns the build of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Note that the Element.GETBUILD(CN) and Element.GETBUILD('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			
			build = 1;
		end
		function cn_class = getClass()
			%GETCLASS returns the class of the converter of neuroimaging data to regional values.
			%
			% CLASS = ConverterNeuroimaging2RegionalValues.GETCLASS() returns the class 'ConverterNeuroimaging2RegionalValues'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CN.GETCLASS() returns the class of the converter of neuroimaging data to regional values CN.
			%  CLASS = Element.GETCLASS(CN) returns the class of 'CN'.
			%  CLASS = Element.GETCLASS('ConverterNeuroimaging2RegionalValues') returns 'ConverterNeuroimaging2RegionalValues'.
			%
			% Note that the Element.GETCLASS(CN) and Element.GETCLASS('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			
			cn_class = 'ConverterNeuroimaging2RegionalValues';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the converter of neuroimaging data to regional values.
			%
			% LIST = ConverterNeuroimaging2RegionalValues.GETSUBCLASSES() returns all subclasses of 'ConverterNeuroimaging2RegionalValues'.
			%
			% Alternative forms to call this method are:
			%  LIST = CN.GETSUBCLASSES() returns all subclasses of the converter of neuroimaging data to regional values CN.
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
			%GETPROPS returns the property list of converter of neuroimaging data to regional values.
			%
			% PROPS = ConverterNeuroimaging2RegionalValues.GETPROPS() returns the property list of converter of neuroimaging data to regional values
			%  as a row vector.
			%
			% PROPS = ConverterNeuroimaging2RegionalValues.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CN.GETPROPS([CATEGORY]) returns the property list of the converter of neuroimaging data to regional values CN.
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
					prop_list = [4 14 15 16];
				case 4 % Category.DATA
					prop_list = [5 9 10 11 12 13 17 18];
				case 5 % Category.RESULT
					prop_list = [20 21];
				case 6 % Category.QUERY
					prop_list = [8 19];
				case 9 % Category.GUI
					prop_list = 22;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of converter of neuroimaging data to regional values.
			%
			% N = ConverterNeuroimaging2RegionalValues.GETPROPNUMBER() returns the property number of converter of neuroimaging data to regional values.
			%
			% N = ConverterNeuroimaging2RegionalValues.GETPROPNUMBER(CATEGORY) returns the property number of converter of neuroimaging data to regional values
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CN.GETPROPNUMBER([CATEGORY]) returns the property number of the converter of neuroimaging data to regional values CN.
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
					prop_number = 8;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in converter of neuroimaging data to regional values/error.
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
			%EXISTSTAG checks whether tag exists in converter of neuroimaging data to regional values/error.
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
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA_LIST'  'BA_NIFTI_FILES'  'BA_MAPPING_FILES'  'GR_NEUROIMAGING'  'GR_LIST_ANAT_REF'  'THRESHOLD_ANAT_REF'  'REF_TOP_PERCENTAGE'  'ANAT_REF_COMBINE_RULE'  'REF_BR'  'CONVERT_BR'  'BR_LABEL_IN_MAPS'  'BA'  'GR_ST'  'WAITBAR' })); %CET: Computational Efficiency Trick
			
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
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA_LIST'  'BA_NIFTI_FILES'  'BA_MAPPING_FILES'  'GR_NEUROIMAGING'  'GR_LIST_ANAT_REF'  'THRESHOLD_ANAT_REF'  'REF_TOP_PERCENTAGE'  'ANAT_REF_COMBINE_RULE'  'REF_BR'  'CONVERT_BR'  'BR_LABEL_IN_MAPS'  'BA'  'GR_ST'  'WAITBAR' })); % tag = pointer %CET: Computational Efficiency Trick
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
				converterneuroimaging2regionalvalues_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA_LIST'  'BA_NIFTI_FILES'  'BA_MAPPING_FILES'  'GR_NEUROIMAGING'  'GR_LIST_ANAT_REF'  'THRESHOLD_ANAT_REF'  'REF_TOP_PERCENTAGE'  'ANAT_REF_COMBINE_RULE'  'REF_BR'  'CONVERT_BR'  'BR_LABEL_IN_MAPS'  'BA'  'GR_ST'  'WAITBAR' };
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
			converterneuroimaging2regionalvalues_category_list = { 1  1  1  3  4  2  2  6  4  4  4  4  4  3  3  3  4  4  6  5  5  9 };
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
			converterneuroimaging2regionalvalues_format_list = { 2  2  2  8  2  2  2  2  9  3  3  8  9  11  11  5  3  3  16  8  8  4 };
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
			converterneuroimaging2regionalvalues_description_list = { 'ELCLASS (constant, string) is the class of the converter of neuroimaging data to regional values.'  'NAME (constant, string) is the name of the converter of neuroimaging data to regional values.'  'DESCRIPTION (constant, string) is the description of the converter of neuroimaging data to regional values.'  'TEMPLATE (parameter, item) is the template of the converter of neuroimaging data to regional values.'  'ID (data, string) is a few-letter code for the converter of neuroimaging data to regional values.'  'LABEL (metadata, string) is an extended label of the converter of neuroimaging data to regional values.'  'NOTES (metadata, string) are some specific notes about the converter of neuroimaging data to regional values.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'BA_LIST (data, itemlist) is the list of brain atlases used to identify the brain regions.'  'BA_NIFTI_FILES (data, stringlist) is the list of atlas NIfTI files aligned with BA_LIST.'  'BA_MAPPING_FILES (data, stringlist) is the list of atlas mapping CSV files aligned with BA_LIST.'  'GR_NEUROIMAGING (data, item) is the group of subject-level neuroimaging data to convert.'  'GR_LIST_ANAT_REF (data, itemlist) is the list of anatomical reference groups used to restrict voxel averaging.'  'THRESHOLD_ANAT_REF (parameter, scalar) is the threshold applied to anatomical reference images.'  'REF_TOP_PERCENTAGE (parameter, scalar) is the fraction of highest voxel values in the reference regions used for normalization.'  'ANAT_REF_COMBINE_RULE (parameter, option) is the rule used to combine multiple anatomical reference masks.'  'REF_BR (data, stringlist) is the list of reference brain-region IDs used for optional normalization.'  'CONVERT_BR (data, stringlist) is the list of brain-region IDs to convert into regional values.'  'BR_LABEL_IN_MAPS (query, cell) finds the atlas index and numeric atlas label for a brain-region ID.'  'BA (result, item) is the brain atlas containing the converted brain regions.'  'GR_ST (result, item) is the group of subjects with regional values.'  'WAITBAR (gui, logical) determines whether to show the waitbar.' };
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
				case 9 % ConverterNeuroimaging2RegionalValues.BA_LIST
					prop_settings = Format.getFormatSettings(9);
				case 10 % ConverterNeuroimaging2RegionalValues.BA_NIFTI_FILES
					prop_settings = Format.getFormatSettings(3);
				case 11 % ConverterNeuroimaging2RegionalValues.BA_MAPPING_FILES
					prop_settings = Format.getFormatSettings(3);
				case 12 % ConverterNeuroimaging2RegionalValues.GR_NEUROIMAGING
					prop_settings = 'Group';
				case 13 % ConverterNeuroimaging2RegionalValues.GR_LIST_ANAT_REF
					prop_settings = Format.getFormatSettings(9);
				case 14 % ConverterNeuroimaging2RegionalValues.THRESHOLD_ANAT_REF
					prop_settings = Format.getFormatSettings(11);
				case 15 % ConverterNeuroimaging2RegionalValues.REF_TOP_PERCENTAGE
					prop_settings = Format.getFormatSettings(11);
				case 16 % ConverterNeuroimaging2RegionalValues.ANAT_REF_COMBINE_RULE
					prop_settings = {'or' 'and'};
				case 17 % ConverterNeuroimaging2RegionalValues.REF_BR
					prop_settings = Format.getFormatSettings(3);
				case 18 % ConverterNeuroimaging2RegionalValues.CONVERT_BR
					prop_settings = Format.getFormatSettings(3);
				case 19 % ConverterNeuroimaging2RegionalValues.BR_LABEL_IN_MAPS
					prop_settings = Format.getFormatSettings(16);
				case 20 % ConverterNeuroimaging2RegionalValues.BA
					prop_settings = 'BrainAtlas';
				case 21 % ConverterNeuroimaging2RegionalValues.GR_ST
					prop_settings = 'Group';
				case 22 % ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 4 % ConverterNeuroimaging2RegionalValues.TEMPLATE
					prop_settings = 'ConverterNeuroimaging2RegionalValues';
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
				case 9 % ConverterNeuroimaging2RegionalValues.BA_LIST
					prop_default = Format.getFormatDefault(9, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 10 % ConverterNeuroimaging2RegionalValues.BA_NIFTI_FILES
					prop_default = {''};
				case 11 % ConverterNeuroimaging2RegionalValues.BA_MAPPING_FILES
					prop_default = {''};
				case 12 % ConverterNeuroimaging2RegionalValues.GR_NEUROIMAGING
					prop_default = Group('SUB_CLASS', 'SubjectNeuroimaging', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNeuroimaging'));
				case 13 % ConverterNeuroimaging2RegionalValues.GR_LIST_ANAT_REF
					prop_default = {};
				case 14 % ConverterNeuroimaging2RegionalValues.THRESHOLD_ANAT_REF
					prop_default = 0.5;
				case 15 % ConverterNeuroimaging2RegionalValues.REF_TOP_PERCENTAGE
					prop_default = 1;
				case 16 % ConverterNeuroimaging2RegionalValues.ANAT_REF_COMBINE_RULE
					prop_default = 'or';
				case 17 % ConverterNeuroimaging2RegionalValues.REF_BR
					prop_default = {''};
				case 18 % ConverterNeuroimaging2RegionalValues.CONVERT_BR
					prop_default = {''};
				case 19 % ConverterNeuroimaging2RegionalValues.BR_LABEL_IN_MAPS
					prop_default = Format.getFormatDefault(16, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 20 % ConverterNeuroimaging2RegionalValues.BA
					prop_default = Format.getFormatDefault(8, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 21 % ConverterNeuroimaging2RegionalValues.GR_ST
					prop_default = Format.getFormatDefault(8, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 22 % ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_default = true;
				case 1 % ConverterNeuroimaging2RegionalValues.ELCLASS
					prop_default = 'ConverterNeuroimaging2RegionalValues';
				case 2 % ConverterNeuroimaging2RegionalValues.NAME
					prop_default = 'Neuroimaging-to-Regional-Values Converter';
				case 3 % ConverterNeuroimaging2RegionalValues.DESCRIPTION
					prop_default = 'ConverterNeuroimaging2RegionalValues converts subject-level NIfTI neuroimaging data into regional values using atlas-defined brain regions, optional anatomical masks, and optional reference-region normalization.';
				case 4 % ConverterNeuroimaging2RegionalValues.TEMPLATE
					prop_default = Format.getFormatDefault(8, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 5 % ConverterNeuroimaging2RegionalValues.ID
					prop_default = 'ConverterNeuroimaging2RegionalValues ID';
				case 6 % ConverterNeuroimaging2RegionalValues.LABEL
					prop_default = 'ConverterNeuroimaging2RegionalValues label';
				case 7 % ConverterNeuroimaging2RegionalValues.NOTES
					prop_default = 'ConverterNeuroimaging2RegionalValues notes';
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
				case 9 % ConverterNeuroimaging2RegionalValues.BA_LIST
					check = Format.checkFormat(9, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 10 % ConverterNeuroimaging2RegionalValues.BA_NIFTI_FILES
					check = Format.checkFormat(3, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 11 % ConverterNeuroimaging2RegionalValues.BA_MAPPING_FILES
					check = Format.checkFormat(3, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 12 % ConverterNeuroimaging2RegionalValues.GR_NEUROIMAGING
					check = Format.checkFormat(8, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 13 % ConverterNeuroimaging2RegionalValues.GR_LIST_ANAT_REF
					check = Format.checkFormat(9, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 14 % ConverterNeuroimaging2RegionalValues.THRESHOLD_ANAT_REF
					check = Format.checkFormat(11, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 15 % ConverterNeuroimaging2RegionalValues.REF_TOP_PERCENTAGE
					check = Format.checkFormat(11, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 16 % ConverterNeuroimaging2RegionalValues.ANAT_REF_COMBINE_RULE
					check = Format.checkFormat(5, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 17 % ConverterNeuroimaging2RegionalValues.REF_BR
					check = Format.checkFormat(3, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 18 % ConverterNeuroimaging2RegionalValues.CONVERT_BR
					check = Format.checkFormat(3, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 19 % ConverterNeuroimaging2RegionalValues.BR_LABEL_IN_MAPS
					check = Format.checkFormat(16, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 20 % ConverterNeuroimaging2RegionalValues.BA
					check = Format.checkFormat(8, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case 21 % ConverterNeuroimaging2RegionalValues.GR_ST
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
				case 19 % ConverterNeuroimaging2RegionalValues.BR_LABEL_IN_MAPS
					br_id = varargin{1};
					region_label_map_list = varargin{2};
					
					atlas_idx = [];
					region_label = [];
					
					for i = 1:numel(region_label_map_list)
					    region_label_map = region_label_map_list{i};
					
					    if isKey(region_label_map, br_id)
					        atlas_idx = i;
					        region_label = region_label_map(br_id);
					        value = {atlas_idx, region_label};
					        return
					    end
					end
					
				case 20 % ConverterNeuroimaging2RegionalValues.BA
					rng_settings_ = rng(); rng(cn.getPropSeed(20), 'twister')
					
					ba_list = cn.get('BA_LIST');
					convert_br = cn.get('CONVERT_BR');
					
					if isempty(ba_list)
					    value = BrainAtlas( ...
					        'ID', 'RegionalValuesAtlas', ...
					        'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion') ...
					        );
					    return
					end
					
					if isempty(convert_br)
					    ba = ba_list{1};
					    value = ba;
					    return
					end
					
					selected_br_list = {};
					
					for br_i = 1:numel(convert_br)
					    br_id = convert_br{br_i};
					    br_found = false;
					
					    for ba_i = 1:numel(ba_list)
					        ba = ba_list{ba_i};
					        br_dict = ba.get('BR_DICT');
					
					        for j = 1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', j);
					
					            if strcmp(br.get('ID'), br_id)
					                selected_br_list{end + 1} = br; %#ok<AGROW>
					                br_found = true;
					                break
					            end
					        end
					
					        if br_found
					            break
					        end
					    end
					
					    if ~br_found
					        warning('Brain region "%s" was not found in BA_LIST and will be skipped.', br_id)
					    end
					end
					
					value = BrainAtlas( ...
					    'ID', 'RegionalValuesAtlas', ...
					    'LABEL', 'Regional values atlas', ...
					    'NOTES', 'Brain atlas containing the regions converted from subject-level NIfTI data.', ...
					    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', selected_br_list) ...
					    );
					
					rng(rng_settings_)
					
				case 21 % ConverterNeuroimaging2RegionalValues.GR_ST
					rng_settings_ = rng(); rng(cn.getPropSeed(21), 'twister')
					
					ba_list = cn.get('BA_LIST');
					ba_nifti_files = cn.get('BA_NIFTI_FILES');
					ba_mapping_files = cn.get('BA_MAPPING_FILES');
					gr_neuroimaging = cn.get('GR_NEUROIMAGING');
					gr_list_anat_ref = cn.get('GR_LIST_ANAT_REF');
					threshold_anat_ref = cn.get('THRESHOLD_ANAT_REF');
					anat_ref_combine_rule = cn.get('ANAT_REF_COMBINE_RULE');
					ref_br = cn.get('REF_BR');
					convert_br = cn.get('CONVERT_BR');
					ref_top_percentage = cn.get('REF_TOP_PERCENTAGE');
					
					if gr_neuroimaging.get('SUB_DICT').get('LENGTH') == 0
					    value = Group();
					    return
					end
					
					if isempty(ba_list)
					    error('BA_LIST must not be empty.')
					end
					
					if isempty(ba_nifti_files)
					    error('BA_NIFTI_FILES must not be empty.')
					end
					
					if isempty(ba_mapping_files)
					    error('BA_MAPPING_FILES must not be empty.')
					end
					
					if numel(ba_nifti_files) ~= numel(ba_mapping_files)
					    error('BA_NIFTI_FILES and BA_MAPPING_FILES must have the same length.')
					end
					
					if numel(ba_list) ~= numel(ba_nifti_files)
					    error('BA_LIST and BA_NIFTI_FILES must have the same length.')
					end
					
					if isempty(convert_br)
					    error('CONVERT_BR must not be empty.')
					end
					
					% Load atlas NIfTI files and mapping tables.
					atlas_data_list = cell(1, numel(ba_nifti_files));
					region_label_map_list = cell(1, numel(ba_mapping_files));
					
					for atlas_i = 1:numel(ba_nifti_files)
					    atlas_file = ba_nifti_files{atlas_i};
					    mapping_file = ba_mapping_files{atlas_i};
					
					    if ~isfile(atlas_file)
					        error('Atlas NIfTI file not found: %s', atlas_file)
					    end
					
					    if ~isfile(mapping_file)
					        error('Atlas mapping file not found: %s', mapping_file)
					    end
					
					    atlas_data_list{atlas_i} = niftiread(atlas_file);
					
					    mapping_table = readtable(mapping_file, 'TextType', 'string');
					
					    if width(mapping_table) < 4
					        error('Atlas mapping file must have at least 4 columns: %s', mapping_file)
					    end
					
					    atlas_labels = mapping_table{:, 3};
					    atlas_br_ids = string(mapping_table{:, 4});
					
					    region_label_map = containers.Map();
					
					    for row_i = 1:numel(atlas_br_ids)
					        br_id = char(atlas_br_ids(row_i));
					
					        if isempty(br_id) || ismissing(string(br_id))
					            continue
					        end
					
					        region_label_map(br_id) = double(atlas_labels(row_i));
					    end
					
					    region_label_map_list{atlas_i} = region_label_map;
					end
					
					% Build output brain atlas from CONVERT_BR.
					ba_st = cn.get('BA');
					
					% Create output group.
					gr_st = Group( ...
					    'SUB_CLASS', 'SubjectST', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
					    );
					
					sub_dict = gr_st.memorize('SUB_DICT');
					sub_dict_neuroimaging = gr_neuroimaging.get('SUB_DICT');
					subject_number = sub_dict_neuroimaging.get('LENGTH');
					
					wb = braph2waitbar(cn.get('WAITBAR'), 0, 'Converting neuroimaging data to regional values ...');
					
					for sub_i = 1:subject_number
					    sub_neuroimaging = sub_dict_neuroimaging.get('IT', sub_i);
					    subject_id = sub_neuroimaging.get('ID');
					
					    neuroimaging_file = sub_neuroimaging.get('ABSOLUTE_NIFTI_PATH');
					
					    if ~isfile(neuroimaging_file)
					        error('Subject neuroimaging file not found: %s', neuroimaging_file)
					    end
					
					    neuroimaging_data = double(niftiread(neuroimaging_file));
					
					    % Build anatomical reference mask.
					    anat_mask = true(size(neuroimaging_data));
					
					    if ~isempty(gr_list_anat_ref)
					        if strcmpi(anat_ref_combine_rule, 'and')
					            anat_mask = true(size(neuroimaging_data));
					        else
					            anat_mask = false(size(neuroimaging_data));
					        end
					
					        for anat_i = 1:numel(gr_list_anat_ref)
					            gr_anat = gr_list_anat_ref{anat_i};
					            sub_anat = gr_anat.get('SUB_DICT').get('IT', sub_i);
					
					            if ~strcmp(sub_anat.get('ID'), subject_id)
					                error('Subject ID mismatch between GR_NEUROIMAGING and GR_LIST_ANAT_REF{%d}: %s versus %s.', ...
					                    anat_i, subject_id, sub_anat.get('ID'))
					            end
					
					            anat_file = sub_anat.get('ABSOLUTE_NIFTI_PATH');
					
					            if ~isfile(anat_file)
					                error('Anatomical reference file not found: %s', anat_file)
					            end
					
					            anat_data = double(niftiread(anat_file));
					            anat_mask_i = anat_data >= threshold_anat_ref;
					
					            if strcmpi(anat_ref_combine_rule, 'and')
					                anat_mask = anat_mask & anat_mask_i;
					            else
					                anat_mask = anat_mask | anat_mask_i;
					            end
					        end
					    end
					
					    % Build reference mask if needed.
					    use_reference_normalization = ~isempty(ref_br);
					    reference_mask = false(size(neuroimaging_data));
					
					    if use_reference_normalization
					        for ref_i = 1:numel(ref_br)
					            br_id = ref_br{ref_i};
					            br_label_info = cn.get('BR_LABEL_IN_MAPS', br_id, region_label_map_list);
					            atlas_idx = br_label_info{1};
					            region_label = br_label_info{2};
					
					            if isempty(atlas_idx)
					                error('Reference brain region "%s" was not found in BA_MAPPING_FILES.', br_id)
					            end
					
					            reference_mask = reference_mask | (atlas_data_list{atlas_idx} == region_label);
					        end
					
					        reference_mask = reference_mask & anat_mask;
					        reference_values = neuroimaging_data(reference_mask);
					        reference_values = reference_values(~isnan(reference_values));
					
					        if isempty(reference_values)
					            error('Reference mask is empty for subject %s.', subject_id)
					        end
					
					        % Use only the top REF_TOP_PERCENTAGE of reference-region voxel values.
					        % REF_TOP_PERCENTAGE = 1 keeps the current behaviour and uses all reference voxels.
					        reference_values = sort(reference_values, 'descend');
					
					        num_reference_values = numel(reference_values);
					        num_values_to_use = ceil(num_reference_values * ref_top_percentage);
					        num_values_to_use = max(num_values_to_use, 1);
					
					        reference_values_to_use = reference_values(1:num_values_to_use);
					        reference_mean = mean(reference_values_to_use);
					
					        if reference_mean == 0 || isnan(reference_mean)
					            error('Invalid reference mean for subject %s.', subject_id)
					        end
					    else
					        reference_mean = 1;
					    end
					
					    % Convert each target brain region.
					    regional_values = nan(1, numel(convert_br));
					
					    for br_i = 1:numel(convert_br)
					        br_id = convert_br{br_i};
					        br_label_info = cn.get('BR_LABEL_IN_MAPS', br_id, region_label_map_list);
					        atlas_idx = br_label_info{1};
					        region_label = br_label_info{2};
					        
					        if isempty(atlas_idx)
					            warning('Converted brain region "%s" was not found in BA_MAPPING_FILES. Setting value to NaN.', br_id)
					            regional_values(br_i) = NaN;
					            continue
					        end
					
					        roi_mask = (atlas_data_list{atlas_idx} == region_label);
					        final_mask = roi_mask & anat_mask;
					
					        roi_values = neuroimaging_data(final_mask);
					        roi_values = roi_values(~isnan(roi_values));
					
					        if isempty(roi_values)
					            regional_values(br_i) = NaN;
					        else
					            regional_values(br_i) = mean(roi_values) / reference_mean;
					        end
					    end
					
					    sub_st = SubjectST( ...
					        'ID', subject_id, ...
					        'LABEL', sub_neuroimaging.get('LABEL'), ...
					        'NOTES', sub_neuroimaging.get('NOTES'), ...
					        'BA', ba_st, ...
					        'ST', regional_values', ...
					        'VOI_DICT', sub_neuroimaging.get('VOI_DICT') ...
					        );
					
					    sub_dict.get('ADD', sub_st);
					
					    braph2waitbar(wb, sub_i / subject_number, ...
					        ['Converting neuroimaging data for subject ' num2str(sub_i) ' of ' num2str(subject_number) ' ...'])
					end
					
					braph2waitbar(wb, 'close')
					
					value = gr_st;
					
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
	methods (Access=protected) % check value
		function [check, msg] = checkValue(cn, prop, value)
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
			msg = ['Error while checking ' tostring(cn) ' ' cn.getPropTag(prop) '.'];
			
			switch prop
				case 15 % ConverterNeuroimaging2RegionalValues.REF_TOP_PERCENTAGE
					check = value >= 0.1 && value <= 1;
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(cn, prop, value);
					end
			end
		end
	end
end
