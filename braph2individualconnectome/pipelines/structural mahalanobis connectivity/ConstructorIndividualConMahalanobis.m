classdef ConstructorIndividualConMahalanobis < ConstructorIndividualConBase
	%ConstructorIndividualConMahalanobis imports a group of subjects with regional SUVR data from a series of XLS/XLSX file.
	% It is a subclass of <a href="matlab:help ConstructorIndividualConBase">ConstructorIndividualConBase</a>.
	%
	% IndividualDistanceConConstructor imports a group of subjects with mean SUVR  
	%  (standarize uptake value ratio) data from a series of nifti files 
	%  contained in a folder named "group_data". All these files must be in the same 
	%  folder; also, no other files should be in the folder. Each file contains a 
	%  matrix of values corresponding to the intensity distribution of brain regions.
	%  The connectivity matrix constructed based on Mahanlanobis Distance is returned
	% The variables of interest are from another Nifti file named "SUVR_GROUP_MAT.vois.xlsx" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% ConstructorIndividualConMahalanobis methods (constructor):
	%  ConstructorIndividualConMahalanobis - constructor
	%
	% ConstructorIndividualConMahalanobis methods:
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
	% ConstructorIndividualConMahalanobis methods (display):
	%  tostring - string with information about the distance-based subject individual brain connectome Constructor
	%  disp - displays information about the distance-based subject individual brain connectome Constructor
	%  tree - displays the tree of the distance-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConMahalanobis methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two distance-based subject individual brain connectome Constructor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the distance-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConMahalanobis methods (save/load, Static):
	%  save - saves BRAPH2 distance-based subject individual brain connectome Constructor as b2 file
	%  load - loads a BRAPH2 distance-based subject individual brain connectome Constructor from a b2 file
	%
	% ConstructorIndividualConMahalanobis method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the distance-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConMahalanobis method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the distance-based subject individual brain connectome Constructor
	%
	% ConstructorIndividualConMahalanobis methods (inspection, Static):
	%  getClass - returns the class of the distance-based subject individual brain connectome Constructor
	%  getSubclasses - returns all subclasses of ConstructorIndividualConMahalanobis
	%  getProps - returns the property list of the distance-based subject individual brain connectome Constructor
	%  getPropNumber - returns the property number of the distance-based subject individual brain connectome Constructor
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
	% ConstructorIndividualConMahalanobis methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConstructorIndividualConMahalanobis methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConstructorIndividualConMahalanobis methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConstructorIndividualConMahalanobis methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConstructorIndividualConMahalanobis; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConstructorIndividualConMahalanobis constants</a>.
	%
	%
	% See also Group, SubjectCON, ExporterGroupSubjectCON_XLS.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	methods % constructor
		function icd = ConstructorIndividualConMahalanobis(varargin)
			%ConstructorIndividualConMahalanobis() creates a distance-based subject individual brain connectome Constructor.
			%
			% ConstructorIndividualConMahalanobis(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConstructorIndividualConMahalanobis(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			icd = icd@ConstructorIndividualConBase(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the distance-based subject individual brain connectome Constructor.
			%
			% BUILD = ConstructorIndividualConMahalanobis.GETBUILD() returns the build of 'ConstructorIndividualConMahalanobis'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ICD.GETBUILD() returns the build of the distance-based subject individual brain connectome Constructor ICD.
			%  BUILD = Element.GETBUILD(ICD) returns the build of 'ICD'.
			%  BUILD = Element.GETBUILD('ConstructorIndividualConMahalanobis') returns the build of 'ConstructorIndividualConMahalanobis'.
			%
			% Note that the Element.GETBUILD(ICD) and Element.GETBUILD('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			
			build = 1;
		end
		function icd_class = getClass()
			%GETCLASS returns the class of the distance-based subject individual brain connectome Constructor.
			%
			% CLASS = ConstructorIndividualConMahalanobis.GETCLASS() returns the class 'ConstructorIndividualConMahalanobis'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ICD.GETCLASS() returns the class of the distance-based subject individual brain connectome Constructor ICD.
			%  CLASS = Element.GETCLASS(ICD) returns the class of 'ICD'.
			%  CLASS = Element.GETCLASS('ConstructorIndividualConMahalanobis') returns 'ConstructorIndividualConMahalanobis'.
			%
			% Note that the Element.GETCLASS(ICD) and Element.GETCLASS('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			
			icd_class = 'ConstructorIndividualConMahalanobis';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the distance-based subject individual brain connectome Constructor.
			%
			% LIST = ConstructorIndividualConMahalanobis.GETSUBCLASSES() returns all subclasses of 'ConstructorIndividualConMahalanobis'.
			%
			% Alternative forms to call this method are:
			%  LIST = ICD.GETSUBCLASSES() returns all subclasses of the distance-based subject individual brain connectome Constructor ICD.
			%  LIST = Element.GETSUBCLASSES(ICD) returns all subclasses of 'ICD'.
			%  LIST = Element.GETSUBCLASSES('ConstructorIndividualConMahalanobis') returns all subclasses of 'ConstructorIndividualConMahalanobis'.
			%
			% Note that the Element.GETSUBCLASSES(ICD) and Element.GETSUBCLASSES('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ConstructorIndividualConMahalanobis', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of distance-based subject individual brain connectome Constructor.
			%
			% PROPS = ConstructorIndividualConMahalanobis.GETPROPS() returns the property list of distance-based subject individual brain connectome Constructor
			%  as a row vector.
			%
			% PROPS = ConstructorIndividualConMahalanobis.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ICD.GETPROPS([CATEGORY]) returns the property list of the distance-based subject individual brain connectome Constructor ICD.
			%  PROPS = Element.GETPROPS(ICD[, CATEGORY]) returns the property list of 'ICD'.
			%  PROPS = Element.GETPROPS('ConstructorIndividualConMahalanobis'[, CATEGORY]) returns the property list of 'ConstructorIndividualConMahalanobis'.
			%
			% Note that the Element.GETPROPS(ICD) and Element.GETPROPS('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConstructorIndividualConBase.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ConstructorIndividualConBase.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConstructorIndividualConBase.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of distance-based subject individual brain connectome Constructor.
			%
			% N = ConstructorIndividualConMahalanobis.GETPROPNUMBER() returns the property number of distance-based subject individual brain connectome Constructor.
			%
			% N = ConstructorIndividualConMahalanobis.GETPROPNUMBER(CATEGORY) returns the property number of distance-based subject individual brain connectome Constructor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ICD.GETPROPNUMBER([CATEGORY]) returns the property number of the distance-based subject individual brain connectome Constructor ICD.
			%  N = Element.GETPROPNUMBER(ICD) returns the property number of 'ICD'.
			%  N = Element.GETPROPNUMBER('ConstructorIndividualConMahalanobis') returns the property number of 'ConstructorIndividualConMahalanobis'.
			%
			% Note that the Element.GETPROPNUMBER(ICD) and Element.GETPROPNUMBER('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ConstructorIndividualConMahalanobis.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in distance-based subject individual brain connectome Constructor/error.
			%
			% CHECK = ConstructorIndividualConMahalanobis.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ICD.EXISTSPROP(PROP) checks whether PROP exists for ICD.
			%  CHECK = Element.EXISTSPROP(ICD, PROP) checks whether PROP exists for ICD.
			%  CHECK = Element.EXISTSPROP(ConstructorIndividualConMahalanobis, PROP) checks whether PROP exists for ConstructorIndividualConMahalanobis.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ICD.EXISTSPROP(PROP) throws error if PROP does NOT exist for ICD.
			%   Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%  Element.EXISTSPROP(ICD, PROP) throws error if PROP does NOT exist for ICD.
			%   Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%  Element.EXISTSPROP(ConstructorIndividualConMahalanobis, PROP) throws error if PROP does NOT exist for ConstructorIndividualConMahalanobis.
			%   Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ICD) and Element.EXISTSPROP('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ConstructorIndividualConMahalanobis.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConMahalanobis:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConMahalanobis:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConstructorIndividualConMahalanobis.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in distance-based subject individual brain connectome Constructor/error.
			%
			% CHECK = ConstructorIndividualConMahalanobis.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ICD.EXISTSTAG(TAG) checks whether TAG exists for ICD.
			%  CHECK = Element.EXISTSTAG(ICD, TAG) checks whether TAG exists for ICD.
			%  CHECK = Element.EXISTSTAG(ConstructorIndividualConMahalanobis, TAG) checks whether TAG exists for ConstructorIndividualConMahalanobis.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ICD.EXISTSTAG(TAG) throws error if TAG does NOT exist for ICD.
			%   Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%  Element.EXISTSTAG(ICD, TAG) throws error if TAG does NOT exist for ICD.
			%   Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%  Element.EXISTSTAG(ConstructorIndividualConMahalanobis, TAG) throws error if TAG does NOT exist for ConstructorIndividualConMahalanobis.
			%   Error id: [BRAPH2:ConstructorIndividualConMahalanobis:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ICD) and Element.EXISTSTAG('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			constructorindividualconmahalanobis_tag_list = cellfun(@(x) ConstructorIndividualConMahalanobis.getPropTag(x), num2cell(ConstructorIndividualConMahalanobis.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, constructorindividualconmahalanobis_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConMahalanobis:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConMahalanobis:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ConstructorIndividualConMahalanobis.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ConstructorIndividualConMahalanobis, POINTER) returns property number of POINTER of ConstructorIndividualConMahalanobis.
			%  PROPERTY = ICD.GETPROPPROP(ConstructorIndividualConMahalanobis, POINTER) returns property number of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPPROP(ICD) and Element.GETPROPPROP('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				constructorindividualconmahalanobis_tag_list = cellfun(@(x) ConstructorIndividualConMahalanobis.getPropTag(x), num2cell(ConstructorIndividualConMahalanobis.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, constructorindividualconmahalanobis_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ConstructorIndividualConMahalanobis, POINTER) returns tag of POINTER of ConstructorIndividualConMahalanobis.
			%  TAG = ICD.GETPROPTAG(ConstructorIndividualConMahalanobis, POINTER) returns tag of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPTAG(ICD) and Element.GETPROPTAG('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@ConstructorIndividualConBase(prop);
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
			%  CATEGORY = ICD.GETPROPCATEGORY(POINTER) returns category of POINTER of ICD.
			%  CATEGORY = Element.GETPROPCATEGORY(ConstructorIndividualConMahalanobis, POINTER) returns category of POINTER of ConstructorIndividualConMahalanobis.
			%  CATEGORY = ICD.GETPROPCATEGORY(ConstructorIndividualConMahalanobis, POINTER) returns category of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPCATEGORY(ICD) and Element.GETPROPCATEGORY('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConMahalanobis.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@ConstructorIndividualConBase(prop);
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
			%  FORMAT = ICD.GETPROPFORMAT(POINTER) returns format of POINTER of ICD.
			%  FORMAT = Element.GETPROPFORMAT(ConstructorIndividualConMahalanobis, POINTER) returns format of POINTER of ConstructorIndividualConMahalanobis.
			%  FORMAT = ICD.GETPROPFORMAT(ConstructorIndividualConMahalanobis, POINTER) returns format of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPFORMAT(ICD) and Element.GETPROPFORMAT('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConMahalanobis.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@ConstructorIndividualConBase(prop);
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
			%  DESCRIPTION = ICD.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ICD.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConstructorIndividualConMahalanobis, POINTER) returns description of POINTER of ConstructorIndividualConMahalanobis.
			%  DESCRIPTION = ICD.GETPROPDESCRIPTION(ConstructorIndividualConMahalanobis, POINTER) returns description of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPDESCRIPTION(ICD) and Element.GETPROPDESCRIPTION('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConMahalanobis.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConMahalanobis.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject individual distance based connectivity constructor.';
				case ConstructorIndividualConMahalanobis.NAME
					prop_description = 'NAME (constant, string) is the name of the subject individual distance based connectivity constructor.';
				case ConstructorIndividualConMahalanobis.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject individual distance based connectivity constructor.';
				case ConstructorIndividualConMahalanobis.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject individual distance based connectivity constructor.';
				case ConstructorIndividualConMahalanobis.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject individual distance based connectivity constructor.';
				case ConstructorIndividualConMahalanobis.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject individual distance based connectivity constructor.';
				case ConstructorIndividualConMahalanobis.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the subject individual distance based connectivity constructor.';
				case ConstructorIndividualConMahalanobis.CONNECTOME_CONSTRUCT_METHOD
					prop_description = 'CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for Mahalanobis distance individual connectome construction.';
				otherwise
					prop_description = getPropDescription@ConstructorIndividualConBase(prop);
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
			%  SETTINGS = ICD.GETPROPSETTINGS(POINTER) returns settings of POINTER of ICD.
			%  SETTINGS = Element.GETPROPSETTINGS(ConstructorIndividualConMahalanobis, POINTER) returns settings of POINTER of ConstructorIndividualConMahalanobis.
			%  SETTINGS = ICD.GETPROPSETTINGS(ConstructorIndividualConMahalanobis, POINTER) returns settings of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPSETTINGS(ICD) and Element.GETPROPSETTINGS('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConstructorIndividualConMahalanobis.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConMahalanobis.TEMPLATE
					prop_settings = 'IndividualDistanceConConstructor';
				otherwise
					prop_settings = getPropSettings@ConstructorIndividualConBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConstructorIndividualConMahalanobis.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConstructorIndividualConMahalanobis.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ICD.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ICD.
			%  DEFAULT = Element.GETPROPDEFAULT(ConstructorIndividualConMahalanobis, POINTER) returns the default value of POINTER of ConstructorIndividualConMahalanobis.
			%  DEFAULT = ICD.GETPROPDEFAULT(ConstructorIndividualConMahalanobis, POINTER) returns the default value of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPDEFAULT(ICD) and Element.GETPROPDEFAULT('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConstructorIndividualConMahalanobis.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConMahalanobis.ELCLASS
					prop_default = 'ConstructorIndividualConMahalanobis';
				case ConstructorIndividualConMahalanobis.NAME
					prop_default = 'Distance based connectivity constructor';
				case ConstructorIndividualConMahalanobis.DESCRIPTION
					prop_default = 'IndividualDistanceConConstructor construct distance based connectome for a group of subjects with nifti file.';
				case ConstructorIndividualConMahalanobis.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ConstructorIndividualConMahalanobis.getPropSettings(prop));
				case ConstructorIndividualConMahalanobis.ID
					prop_default = 'IndividualDistanceConConstructor ID';
				case ConstructorIndividualConMahalanobis.LABEL
					prop_default = 'IndividualDistanceConConstructor label';
				case ConstructorIndividualConMahalanobis.NOTES
					prop_default = 'IndividualDistanceConConstructor notes';
				otherwise
					prop_default = getPropDefault@ConstructorIndividualConBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConstructorIndividualConMahalanobis.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConstructorIndividualConMahalanobis.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ICD.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ICD.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConstructorIndividualConMahalanobis, POINTER) returns the conditioned default value of POINTER of ConstructorIndividualConMahalanobis.
			%  DEFAULT = ICD.GETPROPDEFAULTCONDITIONED(ConstructorIndividualConMahalanobis, POINTER) returns the conditioned default value of POINTER of ConstructorIndividualConMahalanobis.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ICD) and Element.GETPROPDEFAULTCONDITIONED('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConstructorIndividualConMahalanobis.getPropProp(pointer);
			
			prop_default = ConstructorIndividualConMahalanobis.conditioning(prop, ConstructorIndividualConMahalanobis.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ConstructorIndividualConMahalanobis, PROP, VALUE) checks VALUE format for PROP of ConstructorIndividualConMahalanobis.
			%  CHECK = ICD.CHECKPROP(ConstructorIndividualConMahalanobis, PROP, VALUE) checks VALUE format for PROP of ConstructorIndividualConMahalanobis.
			% 
			% ICD.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ConstructorIndividualConMahalanobis:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ICD.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ICD.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConMahalanobis:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ConstructorIndividualConMahalanobis, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConMahalanobis.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConMahalanobis:€BRAPH2.WRONG_INPUT€
			%  ICD.CHECKPROP(ConstructorIndividualConMahalanobis, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConstructorIndividualConMahalanobis.
			%   Error id: €BRAPH2.STR€:ConstructorIndividualConMahalanobis:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ICD) and Element.CHECKPROP('ConstructorIndividualConMahalanobis')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConstructorIndividualConMahalanobis.getPropProp(pointer);
			
			switch prop
				case ConstructorIndividualConMahalanobis.TEMPLATE % __ConstructorIndividualConMahalanobis.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ConstructorIndividualConMahalanobis.getPropSettings(prop));
				otherwise
					if prop <= ConstructorIndividualConBase.getPropNumber()
						check = checkProp@ConstructorIndividualConBase(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConstructorIndividualConMahalanobis:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConstructorIndividualConMahalanobis:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConstructorIndividualConMahalanobis.getPropTag(prop) ' (' ConstructorIndividualConMahalanobis.getFormatTag(ConstructorIndividualConMahalanobis.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(icd, prop, varargin)
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
				case ConstructorIndividualConMahalanobis.CONNECTOME_CONSTRUCT_METHOD % __ConstructorIndividualConMahalanobis.CONNECTOME_CONSTRUCT_METHOD__
					if isempty(varargin) && isempty(icd.get('GR_SUVR').get('SUB_DICT').get('IT_LIST'))
					    value = {};
					    return
					end
					gr_suvr = icd.get('GR_SUVR');
					gr_suvr_ref = icd.get('GR_SUVR_REF');
					for i = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
					    subj_suvrs{i} = gr_suvr.get('SUB_DICT').get('IT',i).get('ST');
					end
					for i = 1:1:gr_suvr_ref.get('SUB_DICT').get('LENGTH')
					    subj_suvrs_ref{i} = gr_suvr_ref.get('SUB_DICT').get('IT',i).get('ST');
					end
					subj_suvrs_ref = cell2mat(subj_suvrs_ref);
					subj_suvrs_ref_regional_mean = mean(subj_suvrs_ref,2);
					maxMahalDistAcrossSubjects = 0;
					mahalDistances_cross_subjects = {};
					for i = 1:1:length(subj_suvrs)
					    subj_suvr = subj_suvrs{i};
					    uniqueROIs = size(subj_suvr,1);
					    % Subtract the global mean from each SUVR value to center the data
					    centeredSUVRMatrix = subj_suvr - subj_suvrs_ref_regional_mean;
					    % Calculate the covariance matrix of the centered SUVR data
					    covMatrix = cov(subj_suvrs_ref');
					    % invCovMatrix = inv(covMatrix); % Inverse of the covariance matrix
					    mahalDistances = zeros(uniqueROIs, uniqueROIs); % To store Mahalanobis distances for each ROI
					    for roi1 = 1:uniqueROIs-1
					        for roi2 = roi1+1:uniqueROIs
					            % 2D residual vector r = [x_i - μ_i; x_j - μ_j]
					            centeredSUVRMatrix_ij  = [centeredSUVRMatrix(roi1); centeredSUVRMatrix(roi2)];  % 2×1
					
					            % 2×2 covariance submatrix for {roi1, roi2}
					            cov_ij  = covMatrix([roi1 roi2], [roi1 roi2]);                  % 2×2
					
					
					            y = cov_ij \ centeredSUVRMatrix_ij;
					            d = sqrt(centeredSUVRMatrix_ij' * y);                 % = sqrt(r' * inv(S) * r)
					
					
					            % bidirectional-collapsed (symmetric) edge
					            mahalDistances(roi1, roi2) = d;
					            mahalDistances(roi2, roi1) = d;
					        end
					    end
					    mahalDistances_cross_subjects{i} = mahalDistances;
					end
					value = mahalDistances_cross_subjects;
					
				otherwise
					if prop <= ConstructorIndividualConBase.getPropNumber()
						value = calculateValue@ConstructorIndividualConBase(icd, prop, varargin{:});
					else
						value = calculateValue@Element(icd, prop, varargin{:});
					end
			end
			
		end
	end
end
