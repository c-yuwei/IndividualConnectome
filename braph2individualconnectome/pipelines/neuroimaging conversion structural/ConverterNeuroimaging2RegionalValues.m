classdef ConverterNeuroimaging2RegionalValues < ConcreteElement
	%ConverterNeuroimaging2RegionalValues calculates mean SUVR value of brain ROIs per subject.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% SUVRConstructor calculates mean value of brain ROIs. It loads brain atlases for ROI identification and calculates mean SUVR values per subject, supporting multiple atlases with region-index mappings loaded from CSV files.
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
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		BA = ConcreteElement.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEMLIST;
		
		ATLAS_REGION_IDS = ConcreteElement.getPropNumber() + 2;
		ATLAS_REGION_IDS_TAG = 'ATLAS_REGION_IDS';
		ATLAS_REGION_IDS_CATEGORY = Category.DATA;
		ATLAS_REGION_IDS_FORMAT = Format.STRINGLIST;
		
		ATLAS_LABELS = ConcreteElement.getPropNumber() + 3;
		ATLAS_LABELS_TAG = 'ATLAS_LABELS';
		ATLAS_LABELS_CATEGORY = Category.DATA;
		ATLAS_LABELS_FORMAT = Format.CELL;
		
		MAPPING_PATH_DICT = ConcreteElement.getPropNumber() + 4;
		MAPPING_PATH_DICT_TAG = 'MAPPING_PATH_DICT';
		MAPPING_PATH_DICT_CATEGORY = Category.DATA;
		MAPPING_PATH_DICT_FORMAT = Format.IDICT;
		
		REF_REGION_LIST = ConcreteElement.getPropNumber() + 5;
		REF_REGION_LIST_TAG = 'REF_REGION_LIST';
		REF_REGION_LIST_CATEGORY = Category.DATA;
		REF_REGION_LIST_FORMAT = Format.CELL;
		
		REF_BR_DICT = ConcreteElement.getPropNumber() + 6;
		REF_BR_DICT_TAG = 'REF_BR_DICT';
		REF_BR_DICT_CATEGORY = Category.DATA;
		REF_BR_DICT_FORMAT = Format.IDICT;
		
		ATLAS_INDEX = ConcreteElement.getPropNumber() + 7;
		ATLAS_INDEX_TAG = 'ATLAS_INDEX';
		ATLAS_INDEX_CATEGORY = Category.PARAMETER;
		ATLAS_INDEX_FORMAT = Format.SCALAR;
		
		ATLAS_PATH_DICT = ConcreteElement.getPropNumber() + 8;
		ATLAS_PATH_DICT_TAG = 'ATLAS_PATH_DICT';
		ATLAS_PATH_DICT_CATEGORY = Category.PARAMETER;
		ATLAS_PATH_DICT_FORMAT = Format.IDICT;
		
		GR_PET = ConcreteElement.getPropNumber() + 9;
		GR_PET_TAG = 'GR_PET';
		GR_PET_CATEGORY = Category.DATA;
		GR_PET_FORMAT = Format.ITEM;
		
		GR_T1 = ConcreteElement.getPropNumber() + 10;
		GR_T1_TAG = 'GR_T1';
		GR_T1_CATEGORY = Category.DATA;
		GR_T1_FORMAT = Format.ITEM;
		
		SUVR_REGION_SELECTION = ConcreteElement.getPropNumber() + 11;
		SUVR_REGION_SELECTION_TAG = 'SUVR_REGION_SELECTION';
		SUVR_REGION_SELECTION_CATEGORY = Category.PARAMETER;
		SUVR_REGION_SELECTION_FORMAT = Format.IDICT;
		
		CALC_SUBJ_SUVR = ConcreteElement.getPropNumber() + 12;
		CALC_SUBJ_SUVR_TAG = 'CALC_SUBJ_SUVR';
		CALC_SUBJ_SUVR_CATEGORY = Category.QUERY;
		CALC_SUBJ_SUVR_FORMAT = Format.CELL;
		
		GR = ConcreteElement.getPropNumber() + 13;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
		
		WAITBAR = ConcreteElement.getPropNumber() + 14;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
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
			
			subclass_list = subclasses('ConverterNeuroimaging2RegionalValues', [], [], true);
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
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						ConverterNeuroimaging2RegionalValues.BA ...
						ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS ...
						ConverterNeuroimaging2RegionalValues.ATLAS_LABELS ...
						ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT ...
						ConverterNeuroimaging2RegionalValues.REF_REGION_LIST ...
						ConverterNeuroimaging2RegionalValues.REF_BR_DICT ...
						ConverterNeuroimaging2RegionalValues.ATLAS_INDEX ...
						ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT ...
						ConverterNeuroimaging2RegionalValues.GR_PET ...
						ConverterNeuroimaging2RegionalValues.GR_T1 ...
						ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION ...
						ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR ...
						ConverterNeuroimaging2RegionalValues.GR ...
						ConverterNeuroimaging2RegionalValues.WAITBAR ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						ConverterNeuroimaging2RegionalValues.ATLAS_INDEX ...
						ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT ...
						ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						ConverterNeuroimaging2RegionalValues.BA ...
						ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS ...
						ConverterNeuroimaging2RegionalValues.ATLAS_LABELS ...
						ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT ...
						ConverterNeuroimaging2RegionalValues.REF_REGION_LIST ...
						ConverterNeuroimaging2RegionalValues.REF_BR_DICT ...
						ConverterNeuroimaging2RegionalValues.GR_PET ...
						ConverterNeuroimaging2RegionalValues.GR_T1 ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						ConverterNeuroimaging2RegionalValues.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						ConverterNeuroimaging2RegionalValues.WAITBAR ...
						];
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
			
			prop_number = numel(ConverterNeuroimaging2RegionalValues.getProps(varargin{:}));
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
			
			check = any(prop == ConverterNeuroimaging2RegionalValues.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValues:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValues:' BRAPH2.WRONG_INPUT '\n' ...
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
			
			converterneuroimaging2regionalvalues_tag_list = cellfun(@(x) ConverterNeuroimaging2RegionalValues.getPropTag(x), num2cell(ConverterNeuroimaging2RegionalValues.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, converterneuroimaging2regionalvalues_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValues:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValues:' BRAPH2.WRONG_INPUT '\n' ...
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
				converterneuroimaging2regionalvalues_tag_list = cellfun(@(x) ConverterNeuroimaging2RegionalValues.getPropTag(x), num2cell(ConverterNeuroimaging2RegionalValues.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, converterneuroimaging2regionalvalues_tag_list)); % tag = pointer
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
				prop = pointer;
				
				switch prop
					case ConverterNeuroimaging2RegionalValues.BA
						tag = ConverterNeuroimaging2RegionalValues.BA_TAG;
					case ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
						tag = ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS_TAG;
					case ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
						tag = ConverterNeuroimaging2RegionalValues.ATLAS_LABELS_TAG;
					case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
						tag = ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT_TAG;
					case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
						tag = ConverterNeuroimaging2RegionalValues.REF_REGION_LIST_TAG;
					case ConverterNeuroimaging2RegionalValues.REF_BR_DICT
						tag = ConverterNeuroimaging2RegionalValues.REF_BR_DICT_TAG;
					case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
						tag = ConverterNeuroimaging2RegionalValues.ATLAS_INDEX_TAG;
					case ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
						tag = ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT_TAG;
					case ConverterNeuroimaging2RegionalValues.GR_PET
						tag = ConverterNeuroimaging2RegionalValues.GR_PET_TAG;
					case ConverterNeuroimaging2RegionalValues.GR_T1
						tag = ConverterNeuroimaging2RegionalValues.GR_T1_TAG;
					case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
						tag = ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION_TAG;
					case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
						tag = ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR_TAG;
					case ConverterNeuroimaging2RegionalValues.GR
						tag = ConverterNeuroimaging2RegionalValues.GR_TAG;
					case ConverterNeuroimaging2RegionalValues.WAITBAR
						tag = ConverterNeuroimaging2RegionalValues.WAITBAR_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			
			switch prop
				case ConverterNeuroimaging2RegionalValues.BA
					prop_category = ConverterNeuroimaging2RegionalValues.BA_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					prop_category = ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					prop_category = ConverterNeuroimaging2RegionalValues.ATLAS_LABELS_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					prop_category = ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					prop_category = ConverterNeuroimaging2RegionalValues.REF_REGION_LIST_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					prop_category = ConverterNeuroimaging2RegionalValues.REF_BR_DICT_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					prop_category = ConverterNeuroimaging2RegionalValues.ATLAS_INDEX_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					prop_category = ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.GR_PET
					prop_category = ConverterNeuroimaging2RegionalValues.GR_PET_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.GR_T1
					prop_category = ConverterNeuroimaging2RegionalValues.GR_T1_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					prop_category = ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					prop_category = ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.GR
					prop_category = ConverterNeuroimaging2RegionalValues.GR_CATEGORY;
				case ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_category = ConverterNeuroimaging2RegionalValues.WAITBAR_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			
			switch prop
				case ConverterNeuroimaging2RegionalValues.BA
					prop_format = ConverterNeuroimaging2RegionalValues.BA_FORMAT;
				case ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					prop_format = ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS_FORMAT;
				case ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					prop_format = ConverterNeuroimaging2RegionalValues.ATLAS_LABELS_FORMAT;
				case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					prop_format = ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT_FORMAT;
				case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					prop_format = ConverterNeuroimaging2RegionalValues.REF_REGION_LIST_FORMAT;
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					prop_format = ConverterNeuroimaging2RegionalValues.REF_BR_DICT_FORMAT;
				case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					prop_format = ConverterNeuroimaging2RegionalValues.ATLAS_INDEX_FORMAT;
				case ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					prop_format = ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT_FORMAT;
				case ConverterNeuroimaging2RegionalValues.GR_PET
					prop_format = ConverterNeuroimaging2RegionalValues.GR_PET_FORMAT;
				case ConverterNeuroimaging2RegionalValues.GR_T1
					prop_format = ConverterNeuroimaging2RegionalValues.GR_T1_FORMAT;
				case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					prop_format = ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION_FORMAT;
				case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					prop_format = ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR_FORMAT;
				case ConverterNeuroimaging2RegionalValues.GR
					prop_format = ConverterNeuroimaging2RegionalValues.GR_FORMAT;
				case ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_format = ConverterNeuroimaging2RegionalValues.WAITBAR_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			
			switch prop
				case ConverterNeuroimaging2RegionalValues.BA
					prop_description = 'BA (data, itemlist) is a list of brain atlases.';
				case ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					prop_description = 'ATLAS_REGION_IDS (data, stringlist) is the list of region IDs for multiple atlases.';
				case ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					prop_description = 'ATLAS_LABELS (data, cell) is the list of string labels for multiple atlases.';
				case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					prop_description = 'MAPPING_PATH_DICT (data, idict) is the dictionary of paths to CSV files for region-index mappings.';
				case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					prop_description = 'REF_REGION_LIST (data, cell) is the list containing the indices of reference regions for each atlas.';
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					prop_description = 'REF_BR_DICT (data, idict) contains the effective brain regions of the simulated network.';
				case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					prop_description = 'ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.';
				case ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					prop_description = 'ATLAS_PATH_DICT (parameter, idict) is the dictionary containing the paths to atlas NIfTI files.';
				case ConverterNeuroimaging2RegionalValues.GR_PET
					prop_description = 'GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.';
				case ConverterNeuroimaging2RegionalValues.GR_T1
					prop_description = 'GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.';
				case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					prop_description = 'SUVR_REGION_SELECTION (parameter, idict) is the list of selected brain regions.';
				case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					prop_description = 'CALC_SUBJ_SUVR (query, cell) generates SUVR vectors per subject using subject PET and T1 data.';
				case ConverterNeuroimaging2RegionalValues.GR
					prop_description = 'GR (result, item) is a group of subjects with SUVR analysis data.';
				case ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_description = 'WAITBAR (gui, logical) determines whether to show the waitbar.';
				case ConverterNeuroimaging2RegionalValues.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject ROI constructor for NIfTI.';
				case ConverterNeuroimaging2RegionalValues.NAME
					prop_description = 'NAME (constant, string) is the name of the subject ROI constructor for NIfTI.';
				case ConverterNeuroimaging2RegionalValues.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject ROI constructor for NIfTI.';
				case ConverterNeuroimaging2RegionalValues.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject ROI constructor for NIfTI.';
				case ConverterNeuroimaging2RegionalValues.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject ROI constructor for NIfTI.';
				case ConverterNeuroimaging2RegionalValues.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of subject ROI constructor for NIfTI.';
				case ConverterNeuroimaging2RegionalValues.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about subject ROI constructor for NIfTI.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			
			switch prop
				case ConverterNeuroimaging2RegionalValues.BA
					prop_settings = 'BrainAtlas';
				case ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					prop_settings = 'FILE_PATH';
				case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					prop_settings = 'BrainRegion';
				case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					prop_settings = 'FILE_PATH';
				case ConverterNeuroimaging2RegionalValues.GR_PET
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ConverterNeuroimaging2RegionalValues.GR_T1
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					prop_settings = 'BrainRegion';
				case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ConverterNeuroimaging2RegionalValues.GR
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ConverterNeuroimaging2RegionalValues.TEMPLATE
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
			
			switch prop
				case ConverterNeuroimaging2RegionalValues.BA
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS
					prop_default = {} % Default to an empty cell array;
				case ConverterNeuroimaging2RegionalValues.ATLAS_LABELS
					prop_default = {} % Default to an empty cell array;
				case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'FILE_PATH');
				case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST
					prop_default = {};
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX
					prop_default = 1;;
				case ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'FILE_PATH');
				case ConverterNeuroimaging2RegionalValues.GR_PET
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI');
				case ConverterNeuroimaging2RegionalValues.GR_T1
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI');
				case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION
					prop_default = Format.getFormatDefault(Format.IDICT, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR
					prop_default = Format.getFormatDefault(Format.CELL, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.GR
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case ConverterNeuroimaging2RegionalValues.WAITBAR
					prop_default = true;
				case ConverterNeuroimaging2RegionalValues.ELCLASS
					prop_default = 'ConverterNeuroimaging2RegionalValues';
				case ConverterNeuroimaging2RegionalValues.NAME
					prop_default = 'SUVR Constructor';
				case ConverterNeuroimaging2RegionalValues.DESCRIPTION
					prop_default = 'SUVRConstructor calculates a group of subjects mean value of ROI from imaging data from a series of NIfTI files.';
				case ConverterNeuroimaging2RegionalValues.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.ID
					prop_default = 'SUVRConstructor ID';
				case ConverterNeuroimaging2RegionalValues.LABEL
					prop_default = 'SUVRConstructor label';
				case ConverterNeuroimaging2RegionalValues.NOTES
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
			%  Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValues:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CN.
			%   Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValues:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ConverterNeuroimaging2RegionalValues, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterNeuroimaging2RegionalValues.
			%   Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValues:€BRAPH2.WRONG_INPUT€
			%  CN.CHECKPROP(ConverterNeuroimaging2RegionalValues, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConverterNeuroimaging2RegionalValues.
			%   Error id: €BRAPH2.STR€:ConverterNeuroimaging2RegionalValues:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(CN) and Element.CHECKPROP('ConverterNeuroimaging2RegionalValues')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConverterNeuroimaging2RegionalValues.getPropProp(pointer);
			
			switch prop
				case ConverterNeuroimaging2RegionalValues.BA % __ConverterNeuroimaging2RegionalValues.BA__
					check = Format.checkFormat(Format.ITEMLIST, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS % __ConverterNeuroimaging2RegionalValues.ATLAS_REGION_IDS__
					check = Format.checkFormat(Format.STRINGLIST, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.ATLAS_LABELS % __ConverterNeuroimaging2RegionalValues.ATLAS_LABELS__
					check = Format.checkFormat(Format.CELL, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT % __ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT__
					check = Format.checkFormat(Format.IDICT, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST % __ConverterNeuroimaging2RegionalValues.REF_REGION_LIST__
					check = Format.checkFormat(Format.CELL, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT % __ConverterNeuroimaging2RegionalValues.REF_BR_DICT__
					check = Format.checkFormat(Format.IDICT, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX % __ConverterNeuroimaging2RegionalValues.ATLAS_INDEX__
					check = Format.checkFormat(Format.SCALAR, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT % __ConverterNeuroimaging2RegionalValues.ATLAS_PATH_DICT__
					check = Format.checkFormat(Format.IDICT, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.GR_PET % __ConverterNeuroimaging2RegionalValues.GR_PET__
					check = Format.checkFormat(Format.ITEM, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.GR_T1 % __ConverterNeuroimaging2RegionalValues.GR_T1__
					check = Format.checkFormat(Format.ITEM, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION % __ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION__
					check = Format.checkFormat(Format.IDICT, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR % __ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR__
					check = Format.checkFormat(Format.CELL, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.GR % __ConverterNeuroimaging2RegionalValues.GR__
					check = Format.checkFormat(Format.ITEM, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.WAITBAR % __ConverterNeuroimaging2RegionalValues.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				case ConverterNeuroimaging2RegionalValues.TEMPLATE % __ConverterNeuroimaging2RegionalValues.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ConverterNeuroimaging2RegionalValues.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValues:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConverterNeuroimaging2RegionalValues:' BRAPH2.WRONG_INPUT '\n' ...
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
				case ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT % __ConverterNeuroimaging2RegionalValues.MAPPING_PATH_DICT__
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
					
				case ConverterNeuroimaging2RegionalValues.REF_REGION_LIST % __ConverterNeuroimaging2RegionalValues.REF_REGION_LIST__
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
					
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT % __ConverterNeuroimaging2RegionalValues.REF_BR_DICT__
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
					
				case ConverterNeuroimaging2RegionalValues.ATLAS_INDEX % __ConverterNeuroimaging2RegionalValues.ATLAS_INDEX__
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
					if prop <= ConcreteElement.getPropNumber()
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
				case ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR % __ConverterNeuroimaging2RegionalValues.CALC_SUBJ_SUVR__
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
					
				case ConverterNeuroimaging2RegionalValues.GR % __ConverterNeuroimaging2RegionalValues.GR__
					rng_settings_ = rng(); rng(cn.getPropSeed(ConverterNeuroimaging2RegionalValues.GR), 'twister')
					
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
					if prop <= ConcreteElement.getPropNumber()
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
				case ConverterNeuroimaging2RegionalValues.REF_BR_DICT % __ConverterNeuroimaging2RegionalValues.REF_BR_DICT__
					pr = SUVRConstructorPP_BR_DICT('EL', roic, 'PROP', SUVRConstructor.REF_BR_DICT, ...
					    'WAITBAR', roic.getCallback('WAITBAR'), ...
					    varargin{:});
					
					% %% ¡prop!
					% ATLAS_KIND (parameter, stringlist) is the list of atlas types needed for ROI analysis.
					% %% ¡default!
					% {'aal90', 'TD'}
					
				case ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION % __ConverterNeuroimaging2RegionalValues.SUVR_REGION_SELECTION__
					pr = SUVRConstructorPP_BR_DICT('EL', roic, 'PROP', SUVRConstructor.SUVR_REGION_SELECTION, ...
					    'WAITBAR', roic.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(cn, prop, varargin{:});
					
			end
		end
	end
end
