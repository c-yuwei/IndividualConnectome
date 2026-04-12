classdef ImporterGroupSubjectNeuroimaging_NIfTI < Importer
	%ImporterGroupSubjectNeuroimaging_NIfTI imports a group of subjects with image data from a series of Nifti files.
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
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (constructor):
	%  ImporterGroupSubjectNeuroimaging_NIfTI - constructor
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI methods:
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
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (display):
	%  tostring - string with information about the importer of neuroimaging subject group from NIfTI
	%  disp - displays information about the importer of neuroimaging subject group from NIfTI
	%  tree - displays the tree of the importer of neuroimaging subject group from NIfTI
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of neuroimaging subject group from NIfTI are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of neuroimaging subject group from NIfTI
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (save/load, Static):
	%  save - saves BRAPH2 importer of neuroimaging subject group from NIfTI as b2 file
	%  load - loads a BRAPH2 importer of neuroimaging subject group from NIfTI from a b2 file
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of neuroimaging subject group from NIfTI
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of neuroimaging subject group from NIfTI
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (inspection, Static):
	%  getClass - returns the class of the importer of neuroimaging subject group from NIfTI
	%  getSubclasses - returns all subclasses of ImporterGroupSubjectNeuroimaging_NIfTI
	%  getProps - returns the property list of the importer of neuroimaging subject group from NIfTI
	%  getPropNumber - returns the property number of the importer of neuroimaging subject group from NIfTI
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
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectNeuroimaging_NIfTI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjectNeuroimaging_NIfTI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjectNeuroimaging_NIfTI constants</a>.
	%
	%
	% See also Group, SubjectCON, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		DIRECTORY = Importer.getPropNumber() + 1;
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = Category.DATA;
		DIRECTORY_FORMAT = Format.STRING;
		
		GET_DIR = Importer.getPropNumber() + 2;
		GET_DIR_TAG = 'GET_DIR';
		GET_DIR_CATEGORY = Category.QUERY;
		GET_DIR_FORMAT = Format.ITEM;
		
		GR = Importer.getPropNumber() + 3;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
	end
	methods % constructor
		function im = ImporterGroupSubjectNeuroimaging_NIfTI(varargin)
			%ImporterGroupSubjectNeuroimaging_NIfTI() creates a importer of neuroimaging subject group from NIfTI.
			%
			% ImporterGroupSubjectNeuroimaging_NIfTI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectNeuroimaging_NIfTI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the importer of neuroimaging subject group from NIfTI.
			%
			% BUILD = ImporterGroupSubjectNeuroimaging_NIfTI.GETBUILD() returns the build of 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the importer of neuroimaging subject group from NIfTI IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('ImporterGroupSubjectNeuroimaging_NIfTI') returns the build of 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the importer of neuroimaging subject group from NIfTI.
			%
			% CLASS = ImporterGroupSubjectNeuroimaging_NIfTI.GETCLASS() returns the class 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of neuroimaging subject group from NIfTI IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectNeuroimaging_NIfTI') returns 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjectNeuroimaging_NIfTI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of neuroimaging subject group from NIfTI.
			%
			% LIST = ImporterGroupSubjectNeuroimaging_NIfTI.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of neuroimaging subject group from NIfTI IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjectNeuroimaging_NIfTI') returns all subclasses of 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ImporterGroupSubjectNeuroimaging_NIfTI', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of neuroimaging subject group from NIfTI.
			%
			% PROPS = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPS() returns the property list of importer of neuroimaging subject group from NIfTI
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of neuroimaging subject group from NIfTI IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectNeuroimaging_NIfTI'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Importer.getProps() ...
						ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY ...
						ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR ...
						ImporterGroupSubjectNeuroimaging_NIfTI.GR ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Importer.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Importer.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Importer.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Importer.getProps(Category.DATA) ...
						ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY ...
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT) ...
						ImporterGroupSubjectNeuroimaging_NIfTI.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						Importer.getProps(Category.QUERY) ...
						ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Importer.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Importer.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Importer.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of importer of neuroimaging subject group from NIfTI.
			%
			% N = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPNUMBER() returns the property number of importer of neuroimaging subject group from NIfTI.
			%
			% N = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPNUMBER(CATEGORY) returns the property number of importer of neuroimaging subject group from NIfTI
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of neuroimaging subject group from NIfTI IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectNeuroimaging_NIfTI') returns the property number of 'ImporterGroupSubjectNeuroimaging_NIfTI'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ImporterGroupSubjectNeuroimaging_NIfTI.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of neuroimaging subject group from NIfTI/error.
			%
			% CHECK = ImporterGroupSubjectNeuroimaging_NIfTI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectNeuroimaging_NIfTI, PROP) checks whether PROP exists for ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectNeuroimaging_NIfTI, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectNeuroimaging_NIfTI.
			%   Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ImporterGroupSubjectNeuroimaging_NIfTI.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectNeuroimaging_NIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectNeuroimaging_NIfTI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectNeuroimaging_NIfTI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of neuroimaging subject group from NIfTI/error.
			%
			% CHECK = ImporterGroupSubjectNeuroimaging_NIfTI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectNeuroimaging_NIfTI, TAG) checks whether TAG exists for ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectNeuroimaging_NIfTI, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectNeuroimaging_NIfTI.
			%   Error id: [BRAPH2:ImporterGroupSubjectNeuroimaging_NIfTI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			importergroupsubjectneuroimaging_nifti_tag_list = cellfun(@(x) ImporterGroupSubjectNeuroimaging_NIfTI.getPropTag(x), num2cell(ImporterGroupSubjectNeuroimaging_NIfTI.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importergroupsubjectneuroimaging_nifti_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectNeuroimaging_NIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectNeuroimaging_NIfTI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectNeuroimaging_NIfTI.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns property number of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns property number of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				importergroupsubjectneuroimaging_nifti_tag_list = cellfun(@(x) ImporterGroupSubjectNeuroimaging_NIfTI.getPropTag(x), num2cell(ImporterGroupSubjectNeuroimaging_NIfTI.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importergroupsubjectneuroimaging_nifti_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns tag of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns tag of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY
						tag = ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY_TAG;
					case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR
						tag = ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR_TAG;
					case ImporterGroupSubjectNeuroimaging_NIfTI.GR
						tag = ImporterGroupSubjectNeuroimaging_NIfTI.GR_TAG;
					otherwise
						tag = getPropTag@Importer(prop);
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
			%  CATEGORY = IM.GETPROPCATEGORY(POINTER) returns category of POINTER of IM.
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns category of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns category of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectNeuroimaging_NIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY
					prop_category = ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY_CATEGORY;
				case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR
					prop_category = ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR_CATEGORY;
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR
					prop_category = ImporterGroupSubjectNeuroimaging_NIfTI.GR_CATEGORY;
				otherwise
					prop_category = getPropCategory@Importer(prop);
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
			%  FORMAT = IM.GETPROPFORMAT(POINTER) returns format of POINTER of IM.
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns format of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns format of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectNeuroimaging_NIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY
					prop_format = ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY_FORMAT;
				case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR
					prop_format = ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR_FORMAT;
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR
					prop_format = ImporterGroupSubjectNeuroimaging_NIfTI.GR_FORMAT;
				otherwise
					prop_format = getPropFormat@Importer(prop);
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
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns description of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns description of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectNeuroimaging_NIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory containing the Nifti subject group files from which to load the subject group.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR
					prop_description = 'GET_DIR (query, item) opens a dialog box to set the directory from where to load the Nifti files of the subject group.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR
					prop_description = 'GR (result, item) is a group of subjects with Nifti image data.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject image group importer for Nifti.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.NAME
					prop_description = 'NAME (constant, string) is the name of the subject image group importer for Nifti.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject image importer for Nifti.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject image importer for Nifti.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject image importer for Nifti.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of subject image importer for Nifti.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about subject image importer for Nifti.';
				otherwise
					prop_description = getPropDescription@Importer(prop);
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
			%  SETTINGS = IM.GETPROPSETTINGS(POINTER) returns settings of POINTER of IM.
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns settings of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns settings of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectNeuroimaging_NIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR
					prop_settings = 'ImporterGroupSubjNIfTI';
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR
					prop_settings = 'Group';
				case ImporterGroupSubjectNeuroimaging_NIfTI.TEMPLATE
					prop_settings = 'ImporterGroupSubjNIfTI';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns the default value of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns the default value of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectNeuroimaging_NIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectNeuroimaging_NIfTI.getPropSettings(prop));
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNIfTI'));
				case ImporterGroupSubjectNeuroimaging_NIfTI.ELCLASS
					prop_default = 'ImporterGroupSubjectNeuroimaging_NIfTI';
				case ImporterGroupSubjectNeuroimaging_NIfTI.NAME
					prop_default = 'Subject Nifti Image Importer';
				case ImporterGroupSubjectNeuroimaging_NIfTI.DESCRIPTION
					prop_default = 'ImporterGroupSubjNIfTI imports a group of subjects with image data from a series of Nifti file.';
				case ImporterGroupSubjectNeuroimaging_NIfTI.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectNeuroimaging_NIfTI.getPropSettings(prop));
				case ImporterGroupSubjectNeuroimaging_NIfTI.ID
					prop_default = 'ImporterGroupSubjNIfTI ID';
				case ImporterGroupSubjectNeuroimaging_NIfTI.LABEL
					prop_default = 'ImporterGroupSubjNIfTI label';
				case ImporterGroupSubjectNeuroimaging_NIfTI.NOTES
					prop_default = 'ImporterGroupSubjNIfTI notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectNeuroimaging_NIfTI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectNeuroimaging_NIfTI, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectNeuroimaging_NIfTI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjectNeuroimaging_NIfTI.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectNeuroimaging_NIfTI.conditioning(prop, ImporterGroupSubjectNeuroimaging_NIfTI.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectNeuroimaging_NIfTI, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectNeuroimaging_NIfTI.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectNeuroimaging_NIfTI, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectNeuroimaging_NIfTI.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ImporterGroupSubjectNeuroimaging_NIfTI:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectNeuroimaging_NIfTI:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ImporterGroupSubjectNeuroimaging_NIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectNeuroimaging_NIfTI.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectNeuroimaging_NIfTI:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(ImporterGroupSubjectNeuroimaging_NIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectNeuroimaging_NIfTI.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectNeuroimaging_NIfTI:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjectNeuroimaging_NIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjectNeuroimaging_NIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY % __ImporterGroupSubjectNeuroimaging_NIfTI.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectNeuroimaging_NIfTI.getPropSettings(prop));
				case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR % __ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectNeuroimaging_NIfTI.getPropSettings(prop));
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR % __ImporterGroupSubjectNeuroimaging_NIfTI.GR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectNeuroimaging_NIfTI.getPropSettings(prop));
				case ImporterGroupSubjectNeuroimaging_NIfTI.TEMPLATE % __ImporterGroupSubjectNeuroimaging_NIfTI.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectNeuroimaging_NIfTI.getPropSettings(prop));
				otherwise
					if prop <= Importer.getPropNumber()
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectNeuroimaging_NIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectNeuroimaging_NIfTI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectNeuroimaging_NIfTI.getPropTag(prop) ' (' ImporterGroupSubjectNeuroimaging_NIfTI.getFormatTag(ImporterGroupSubjectNeuroimaging_NIfTI.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop, varargin)
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
				case ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR % __ImporterGroupSubjectNeuroimaging_NIfTI.GET_DIR__
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    im.set('DIRECTORY', directory);
					end
					value = im;
					
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR % __ImporterGroupSubjectNeuroimaging_NIfTI.GR__
					rng_settings_ = rng(); rng(im.getPropSeed(ImporterGroupSubjectNeuroimaging_NIfTI.GR), 'twister')
					
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
					    error([BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.ERR_IO], ...
					        [BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.ERR_IO '\n' ...
					        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
					        );
					end
					
					value = gr;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Importer.getPropNumber()
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
				case ImporterGroupSubjectNeuroimaging_NIfTI.GR % __ImporterGroupSubjectNeuroimaging_NIfTI.GR__
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectNIfTI', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					if prop <= Importer.getPropNumber()
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
