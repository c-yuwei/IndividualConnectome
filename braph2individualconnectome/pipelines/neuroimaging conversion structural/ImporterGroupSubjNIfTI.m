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
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		DIRECTORY = Importer.getPropNumber() + 1;
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = Category.DATA;
		DIRECTORY_FORMAT = Format.STRING;
		
		NIFTI_TYPE = Importer.getPropNumber() + 2;
		NIFTI_TYPE_TAG = 'NIFTI_TYPE';
		NIFTI_TYPE_CATEGORY = Category.DATA;
		NIFTI_TYPE_FORMAT = Format.STRINGLIST;
		
		GET_DIR = Importer.getPropNumber() + 3;
		GET_DIR_TAG = 'GET_DIR';
		GET_DIR_CATEGORY = Category.QUERY;
		GET_DIR_FORMAT = Format.ITEM;
		
		GR = Importer.getPropNumber() + 4;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
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
			
			subclass_list = subclasses('ImporterGroupSubjNIfTI', [], [], true);
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
			
			if nargin == 0
				prop_list = [ ...
					Importer.getProps() ...
						ImporterGroupSubjNIfTI.DIRECTORY ...
						ImporterGroupSubjNIfTI.NIFTI_TYPE ...
						ImporterGroupSubjNIfTI.GET_DIR ...
						ImporterGroupSubjNIfTI.GR ...
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
						ImporterGroupSubjNIfTI.DIRECTORY ...
						ImporterGroupSubjNIfTI.NIFTI_TYPE ...
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT) ...
						ImporterGroupSubjNIfTI.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						Importer.getProps(Category.QUERY) ...
						ImporterGroupSubjNIfTI.GET_DIR ...
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
			
			prop_number = numel(ImporterGroupSubjNIfTI.getProps(varargin{:}));
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
			
			check = any(prop == ImporterGroupSubjNIfTI.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjNIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjNIfTI:' BRAPH2.WRONG_INPUT '\n' ...
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
			
			importergroupsubjnifti_tag_list = cellfun(@(x) ImporterGroupSubjNIfTI.getPropTag(x), num2cell(ImporterGroupSubjNIfTI.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importergroupsubjnifti_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjNIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjNIfTI:' BRAPH2.WRONG_INPUT '\n' ...
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
				importergroupsubjnifti_tag_list = cellfun(@(x) ImporterGroupSubjNIfTI.getPropTag(x), num2cell(ImporterGroupSubjNIfTI.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importergroupsubjnifti_tag_list)); % tag = pointer
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
				prop = pointer;
				
				switch prop
					case ImporterGroupSubjNIfTI.DIRECTORY
						tag = ImporterGroupSubjNIfTI.DIRECTORY_TAG;
					case ImporterGroupSubjNIfTI.NIFTI_TYPE
						tag = ImporterGroupSubjNIfTI.NIFTI_TYPE_TAG;
					case ImporterGroupSubjNIfTI.GET_DIR
						tag = ImporterGroupSubjNIfTI.GET_DIR_TAG;
					case ImporterGroupSubjNIfTI.GR
						tag = ImporterGroupSubjNIfTI.GR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjNIfTI, POINTER) returns category of POINTER of ImporterGroupSubjNIfTI.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjNIfTI, POINTER) returns category of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjNIfTI.DIRECTORY
					prop_category = ImporterGroupSubjNIfTI.DIRECTORY_CATEGORY;
				case ImporterGroupSubjNIfTI.NIFTI_TYPE
					prop_category = ImporterGroupSubjNIfTI.NIFTI_TYPE_CATEGORY;
				case ImporterGroupSubjNIfTI.GET_DIR
					prop_category = ImporterGroupSubjNIfTI.GET_DIR_CATEGORY;
				case ImporterGroupSubjNIfTI.GR
					prop_category = ImporterGroupSubjNIfTI.GR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjNIfTI, POINTER) returns format of POINTER of ImporterGroupSubjNIfTI.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjNIfTI, POINTER) returns format of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjNIfTI.DIRECTORY
					prop_format = ImporterGroupSubjNIfTI.DIRECTORY_FORMAT;
				case ImporterGroupSubjNIfTI.NIFTI_TYPE
					prop_format = ImporterGroupSubjNIfTI.NIFTI_TYPE_FORMAT;
				case ImporterGroupSubjNIfTI.GET_DIR
					prop_format = ImporterGroupSubjNIfTI.GET_DIR_FORMAT;
				case ImporterGroupSubjNIfTI.GR
					prop_format = ImporterGroupSubjNIfTI.GR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjNIfTI, POINTER) returns description of POINTER of ImporterGroupSubjNIfTI.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjNIfTI, POINTER) returns description of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjNIfTI.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory containing the Nifti subject group files from which to load the subject group.';
				case ImporterGroupSubjNIfTI.NIFTI_TYPE
					prop_description = 'NIFTI_TYPE (data, stringlist) describes the including modality types of each Nifti file for single subject.';
				case ImporterGroupSubjNIfTI.GET_DIR
					prop_description = 'GET_DIR (query, item) opens a dialog box to set the directory from where to load the Nifti files of the subject group.';
				case ImporterGroupSubjNIfTI.GR
					prop_description = 'GR (result, item) is a group of subjects with Nifti image data.';
				case ImporterGroupSubjNIfTI.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject image group importer for Nifti.';
				case ImporterGroupSubjNIfTI.NAME
					prop_description = 'NAME (constant, string) is the name of the subject image group importer for Nifti.';
				case ImporterGroupSubjNIfTI.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject image importer for Nifti.';
				case ImporterGroupSubjNIfTI.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject image importer for Nifti.';
				case ImporterGroupSubjNIfTI.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject image importer for Nifti.';
				case ImporterGroupSubjNIfTI.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of subject image importer for Nifti.';
				case ImporterGroupSubjNIfTI.NOTES
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjNIfTI, POINTER) returns settings of POINTER of ImporterGroupSubjNIfTI.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjNIfTI, POINTER) returns settings of POINTER of ImporterGroupSubjNIfTI.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjNIfTI.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjNIfTI.NIFTI_TYPE
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case ImporterGroupSubjNIfTI.GET_DIR
					prop_settings = 'ImporterGroupSubjNIfTI';
				case ImporterGroupSubjNIfTI.GR
					prop_settings = 'Group';
				case ImporterGroupSubjNIfTI.TEMPLATE
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
			
			switch prop
				case ImporterGroupSubjNIfTI.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case ImporterGroupSubjNIfTI.NIFTI_TYPE
					prop_default = {'GM', 'WM', 'PET'};
				case ImporterGroupSubjNIfTI.GET_DIR
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case ImporterGroupSubjNIfTI.GR
					prop_default = Group('SUB_CLASS', 'SubjectNIfTI', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectNIfTI'));
				case ImporterGroupSubjNIfTI.ELCLASS
					prop_default = 'ImporterGroupSubjNIfTI';
				case ImporterGroupSubjNIfTI.NAME
					prop_default = 'Subject Nifti Image Importer';
				case ImporterGroupSubjNIfTI.DESCRIPTION
					prop_default = 'ImporterGroupSubjNIfTI imports a group of subjects with image data from a series of Nifti file.';
				case ImporterGroupSubjNIfTI.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case ImporterGroupSubjNIfTI.ID
					prop_default = 'ImporterGroupSubjNIfTI ID';
				case ImporterGroupSubjNIfTI.LABEL
					prop_default = 'ImporterGroupSubjNIfTI label';
				case ImporterGroupSubjNIfTI.NOTES
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
			%  Error id: €BRAPH2.STR€:ImporterGroupSubjNIfTI:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjNIfTI:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ImporterGroupSubjNIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjNIfTI.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjNIfTI:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(ImporterGroupSubjNIfTI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjNIfTI.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjNIfTI:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjNIfTI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjNIfTI.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjNIfTI.DIRECTORY % __ImporterGroupSubjNIfTI.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case ImporterGroupSubjNIfTI.NIFTI_TYPE % __ImporterGroupSubjNIfTI.NIFTI_TYPE__
					check = Format.checkFormat(Format.STRINGLIST, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case ImporterGroupSubjNIfTI.GET_DIR % __ImporterGroupSubjNIfTI.GET_DIR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case ImporterGroupSubjNIfTI.GR % __ImporterGroupSubjNIfTI.GR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				case ImporterGroupSubjNIfTI.TEMPLATE % __ImporterGroupSubjNIfTI.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjNIfTI.getPropSettings(prop));
				otherwise
					if prop <= Importer.getPropNumber()
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjNIfTI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjNIfTI:' BRAPH2.WRONG_INPUT '\n' ...
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
				case ImporterGroupSubjNIfTI.GET_DIR % __ImporterGroupSubjNIfTI.GET_DIR__
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    im.set('DIRECTORY', directory);
					end
					value = im;
					
				case ImporterGroupSubjNIfTI.GR % __ImporterGroupSubjNIfTI.GR__
					rng_settings_ = rng(); rng(im.getPropSeed(ImporterGroupSubjNIfTI.GR), 'twister')
					
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
				case ImporterGroupSubjNIfTI.GR % __ImporterGroupSubjNIfTI.GR__
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectNIfTI', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					if prop <= Importer.getPropNumber()
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
