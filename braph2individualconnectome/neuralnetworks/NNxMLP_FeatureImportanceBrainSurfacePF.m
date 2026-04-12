classdef NNxMLP_FeatureImportanceBrainSurfacePF < BrainAtlasPF
	%NNxMLP_FeatureImportanceBrainSurfacePF is a plot of a feature importance brain.
	% It is a subclass of <a href="matlab:help BrainAtlasPF">BrainAtlasPF</a>.
	%
	% A panel figure for the neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF) manages the plot
	%  of the feature importance ploted over the brain.  
	% NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate 
	%  the feature importance values into the brain regions.
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (constructor):
	%  NNxMLP_FeatureImportanceBrainSurfacePF - constructor
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods:
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
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (display):
	%  tostring - string with information about the panel figure for feature importance brain
	%  disp - displays information about the panel figure for feature importance brain
	%  tree - displays the tree of the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for feature importance brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for feature importance brain as b2 file
	%  load - loads a BRAPH2 panel figure for feature importance brain from a b2 file
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for feature importance brain
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceBrainSurfacePF
	%  getProps - returns the property list of the panel figure for feature importance brain
	%  getPropNumber - returns the property number of the panel figure for feature importance brain
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
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceBrainSurfacePF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceBrainSurfacePF constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportanceBrainSurface.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		FI = BrainAtlasPF.getPropNumber() + 1;
		FI_TAG = 'FI';
		FI_CATEGORY = Category.METADATA;
		FI_FORMAT = Format.CELL;
		
		D = BrainAtlasPF.getPropNumber() + 2;
		D_TAG = 'D';
		D_CATEGORY = Category.METADATA;
		D_FORMAT = Format.ITEM;
		
		SETUP = BrainAtlasPF.getPropNumber() + 3;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pf = NNxMLP_FeatureImportanceBrainSurfacePF(varargin)
			%NNxMLP_FeatureImportanceBrainSurfacePF() creates a panel figure for feature importance brain.
			%
			% NNxMLP_FeatureImportanceBrainSurfacePF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceBrainSurfacePF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@BrainAtlasPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel figure for feature importance brain.
			%
			% BUILD = NNxMLP_FeatureImportanceBrainSurfacePF.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel figure for feature importance brain PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurfacePF') returns the build of 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for feature importance brain.
			%
			% CLASS = NNxMLP_FeatureImportanceBrainSurfacePF.GETCLASS() returns the class 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for feature importance brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurfacePF') returns 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			
			pf_class = 'NNxMLP_FeatureImportanceBrainSurfacePF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for feature importance brain.
			%
			% LIST = NNxMLP_FeatureImportanceBrainSurfacePF.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for feature importance brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurfacePF') returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_FeatureImportanceBrainSurfacePF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for feature importance brain.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPS() returns the property list of panel figure for feature importance brain
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for feature importance brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurfacePF'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					BrainAtlasPF.getProps() ...
						NNxMLP_FeatureImportanceBrainSurfacePF.FI ...
						NNxMLP_FeatureImportanceBrainSurfacePF.D ...
						NNxMLP_FeatureImportanceBrainSurfacePF.SETUP ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.METADATA) ...
						NNxMLP_FeatureImportanceBrainSurfacePF.FI ...
						NNxMLP_FeatureImportanceBrainSurfacePF.D ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						BrainAtlasPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.QUERY) ...
						NNxMLP_FeatureImportanceBrainSurfacePF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						BrainAtlasPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for feature importance brain.
			%
			% N = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPNUMBER() returns the property number of panel figure for feature importance brain.
			%
			% N = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for feature importance brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for feature importance brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurfacePF') returns the property number of 'NNxMLP_FeatureImportanceBrainSurfacePF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_FeatureImportanceBrainSurfacePF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for feature importance brain/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurfacePF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurfacePF, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurfacePF, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceBrainSurfacePF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_FeatureImportanceBrainSurfacePF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceBrainSurfacePF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for feature importance brain/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurfacePF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurfacePF, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurfacePF, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceBrainSurfacePF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_featureimportancebrainsurfacepf_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceBrainSurfacePF.getPropTag(x), num2cell(NNxMLP_FeatureImportanceBrainSurfacePF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_featureimportancebrainsurfacepf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceBrainSurfacePF.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  PROPERTY = PF.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_featureimportancebrainsurfacepf_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceBrainSurfacePF.getPropTag(x), num2cell(NNxMLP_FeatureImportanceBrainSurfacePF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_featureimportancebrainsurfacepf_tag_list)); % tag = pointer
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  TAG = PF.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNxMLP_FeatureImportanceBrainSurfacePF.FI
						tag = NNxMLP_FeatureImportanceBrainSurfacePF.FI_TAG;
					case NNxMLP_FeatureImportanceBrainSurfacePF.D
						tag = NNxMLP_FeatureImportanceBrainSurfacePF.D_TAG;
					case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP
						tag = NNxMLP_FeatureImportanceBrainSurfacePF.SETUP_TAG;
					otherwise
						tag = getPropTag@BrainAtlasPF(prop);
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  CATEGORY = PF.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF.FI
					prop_category = NNxMLP_FeatureImportanceBrainSurfacePF.FI_CATEGORY;
				case NNxMLP_FeatureImportanceBrainSurfacePF.D
					prop_category = NNxMLP_FeatureImportanceBrainSurfacePF.D_CATEGORY;
				case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP
					prop_category = NNxMLP_FeatureImportanceBrainSurfacePF.SETUP_CATEGORY;
				otherwise
					prop_category = getPropCategory@BrainAtlasPF(prop);
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  FORMAT = PF.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF.FI
					prop_format = NNxMLP_FeatureImportanceBrainSurfacePF.FI_FORMAT;
				case NNxMLP_FeatureImportanceBrainSurfacePF.D
					prop_format = NNxMLP_FeatureImportanceBrainSurfacePF.D_FORMAT;
				case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP
					prop_format = NNxMLP_FeatureImportanceBrainSurfacePF.SETUP_FORMAT;
				otherwise
					prop_format = getPropFormat@BrainAtlasPF(prop);
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF.FI
					prop_description = 'FI (metadata, cell) is the feature importance value.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.D
					prop_description = 'D (metadata, item) is the NN dataset.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure brain atlas.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.';
				otherwise
					prop_description = getPropDescription@BrainAtlasPF(prop);
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  SETTINGS = PF.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF.FI
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportanceBrainSurfacePF.D
					prop_settings = 'NNDataset';
				case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportanceBrainSurfacePF.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurfacePF';
				otherwise
					prop_settings = getPropSettings@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  DEFAULT = PF.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF.FI
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF.D
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF.ELCLASS
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF';
				case NNxMLP_FeatureImportanceBrainSurfacePF.NAME
					prop_default = 'Panel Figure for Neural Networks Feature Impoortance on Brain Surface';
				case NNxMLP_FeatureImportanceBrainSurfacePF.DESCRIPTION
					prop_default = 'A panel figure for neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF) manages the plot of the feature importance ploted over the brain. NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate the feature importance values into the brain regions.';
				case NNxMLP_FeatureImportanceBrainSurfacePF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF.ID
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF ID';
				case NNxMLP_FeatureImportanceBrainSurfacePF.LABEL
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF label';
				case NNxMLP_FeatureImportanceBrainSurfacePF.NOTES
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF notes';
				otherwise
					prop_default = getPropDefault@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurfacePF, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceBrainSurfacePF.conditioning(prop, NNxMLP_FeatureImportanceBrainSurfacePF.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF.
			%  CHECK = PF.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNxMLP_FeatureImportanceBrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF.FI % __NNxMLP_FeatureImportanceBrainSurfacePF.FI__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF.D % __NNxMLP_FeatureImportanceBrainSurfacePF.D__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP % __NNxMLP_FeatureImportanceBrainSurfacePF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF.TEMPLATE % __NNxMLP_FeatureImportanceBrainSurfacePF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceBrainSurfacePF.getPropSettings(prop));
				otherwise
					if prop <= BrainAtlasPF.getPropNumber()
						check = checkProp@BrainAtlasPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceBrainSurfacePF.getPropTag(prop) ' (' NNxMLP_FeatureImportanceBrainSurfacePF.getFormatTag(NNxMLP_FeatureImportanceBrainSurfacePF.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case NNxMLP_FeatureImportanceBrainSurfacePF.SETUP % __NNxMLP_FeatureImportanceBrainSurfacePF.SETUP__
					value = [];
					
				case NNxMLP_FeatureImportanceBrainSurfacePF.DRAW % __NNxMLP_FeatureImportanceBrainSurfacePF.DRAW__
					value = calculateValue@BrainAtlasPF(pf, NNxMLP_FeatureImportanceBrainSurfacePF.DRAW, varargin{:}); % also warning
					if value    
					    % trigger setup
					    pf.get('SETUP');
					end
					
				case NNxMLP_FeatureImportanceBrainSurfacePF.DELETE % __NNxMLP_FeatureImportanceBrainSurfacePF.DELETE__
					value = calculateValue@BrainAtlasPF(pf, NNxMLP_FeatureImportanceBrainSurfacePF.DELETE, varargin{:}); % also warning
					if value
					    % do nothing
					end
					
				otherwise
					if prop <= BrainAtlasPF.getPropNumber()
						value = calculateValue@BrainAtlasPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
