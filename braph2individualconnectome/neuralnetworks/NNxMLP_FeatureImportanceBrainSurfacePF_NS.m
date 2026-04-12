classdef NNxMLP_FeatureImportanceBrainSurfacePF_NS < NNxMLP_FeatureImportanceBrainSurfacePF
	%NNxMLP_FeatureImportanceBrainSurfacePF_NS is a plot of a feature importance brain.
	% It is a subclass of <a href="matlab:help NNxMLP_FeatureImportanceBrainSurfacePF">NNxMLP_FeatureImportanceBrainSurfacePF</a>.
	%
	% A panel figure for the neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF_NS) manages the plot
	%  of the feature importance ploted over the brain with the nodal-superglobal graph measures.  
	% NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate 
	%  the feature importance values into the brain regions.
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (constructor):
	%  NNxMLP_FeatureImportanceBrainSurfacePF_NS - constructor
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods:
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
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (display):
	%  tostring - string with information about the panel figure for feature importance brain
	%  disp - displays information about the panel figure for feature importance brain
	%  tree - displays the tree of the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for feature importance brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for feature importance brain as b2 file
	%  load - loads a BRAPH2 panel figure for feature importance brain from a b2 file
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for feature importance brain
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (inspection, Static):
	%  getClass - returns the class of the panel figure for feature importance brain
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceBrainSurfacePF_NS
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
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceBrainSurfacePF_NS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceBrainSurfacePF_NS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceBrainSurfacePF_NS constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportanceBrainSurface, NNxMLP_FeatureImportanceBrainSurfacePF.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		LAYER = NNxMLP_FeatureImportanceBrainSurfacePF.getPropNumber() + 1;
		LAYER_TAG = 'LAYER';
		LAYER_CATEGORY = Category.FIGURE;
		LAYER_FORMAT = Format.SCALAR;
		
		SIZE_DIFF = NNxMLP_FeatureImportanceBrainSurfacePF.getPropNumber() + 2;
		SIZE_DIFF_TAG = 'SIZE_DIFF';
		SIZE_DIFF_CATEGORY = Category.FIGURE;
		SIZE_DIFF_FORMAT = Format.OPTION;
		
		SIZE_SCALE = NNxMLP_FeatureImportanceBrainSurfacePF.getPropNumber() + 3;
		SIZE_SCALE_TAG = 'SIZE_SCALE';
		SIZE_SCALE_CATEGORY = Category.FIGURE;
		SIZE_SCALE_FORMAT = Format.SCALAR;
		
		COLOR_DIFF = NNxMLP_FeatureImportanceBrainSurfacePF.getPropNumber() + 4;
		COLOR_DIFF_TAG = 'COLOR_DIFF';
		COLOR_DIFF_CATEGORY = Category.FIGURE;
		COLOR_DIFF_FORMAT = Format.OPTION;
	end
	methods % constructor
		function pf = NNxMLP_FeatureImportanceBrainSurfacePF_NS(varargin)
			%NNxMLP_FeatureImportanceBrainSurfacePF_NS() creates a panel figure for feature importance brain.
			%
			% NNxMLP_FeatureImportanceBrainSurfacePF_NS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceBrainSurfacePF_NS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@NNxMLP_FeatureImportanceBrainSurfacePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel figure for feature importance brain.
			%
			% BUILD = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel figure for feature importance brain PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurfacePF_NS') returns the build of 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for feature importance brain.
			%
			% CLASS = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETCLASS() returns the class 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for feature importance brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurfacePF_NS') returns 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			
			pf_class = 'NNxMLP_FeatureImportanceBrainSurfacePF_NS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for feature importance brain.
			%
			% LIST = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for feature importance brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurfacePF_NS') returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_FeatureImportanceBrainSurfacePF_NS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for feature importance brain.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPS() returns the property list of panel figure for feature importance brain
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for feature importance brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurfacePF_NS'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNxMLP_FeatureImportanceBrainSurfacePF.getProps() ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.FIGURE) ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE ...
						NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF ...
						];
				case Category.GUI
					prop_list = [ ...
						NNxMLP_FeatureImportanceBrainSurfacePF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for feature importance brain.
			%
			% N = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPNUMBER() returns the property number of panel figure for feature importance brain.
			%
			% N = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for feature importance brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for feature importance brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurfacePF_NS') returns the property number of 'NNxMLP_FeatureImportanceBrainSurfacePF_NS'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_FeatureImportanceBrainSurfacePF_NS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for feature importance brain/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurfacePF_NS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_FeatureImportanceBrainSurfacePF_NS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceBrainSurfacePF_NS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for feature importance brain/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurfacePF_NS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurfacePF_NS, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurfacePF_NS, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePF_NS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_featureimportancebrainsurfacepf_ns_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropTag(x), num2cell(NNxMLP_FeatureImportanceBrainSurfacePF_NS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_featureimportancebrainsurfacepf_ns_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceBrainSurfacePF_NS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  PROPERTY = PF.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_featureimportancebrainsurfacepf_ns_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropTag(x), num2cell(NNxMLP_FeatureImportanceBrainSurfacePF_NS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_featureimportancebrainsurfacepf_ns_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  TAG = PF.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER
						tag = NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER_TAG;
					case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF
						tag = NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF_TAG;
					case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE
						tag = NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE_TAG;
					case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF
						tag = NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF_TAG;
					otherwise
						tag = getPropTag@NNxMLP_FeatureImportanceBrainSurfacePF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  CATEGORY = PF.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER
					prop_category = NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER_CATEGORY;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF
					prop_category = NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF_CATEGORY;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE
					prop_category = NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE_CATEGORY;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF
					prop_category = NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNxMLP_FeatureImportanceBrainSurfacePF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  FORMAT = PF.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER
					prop_format = NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER_FORMAT;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF
					prop_format = NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF_FORMAT;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE
					prop_format = NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE_FORMAT;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF
					prop_format = NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF_FORMAT;
				otherwise
					prop_format = getPropFormat@NNxMLP_FeatureImportanceBrainSurfacePF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER
					prop_description = 'LAYER (figure, scalar) is the layer number of the nodal measure.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF
					prop_description = 'SIZE_DIFF (figure, option) determines whether the difference is shown with size effect.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE
					prop_description = 'SIZE_SCALE (figure, scalar) determines the scale of size effect.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF
					prop_description = 'COLOR_DIFF (figure, option) determines whether the difference is shown with color effect.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for the neural networks feature importance on brain surface.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SETUP
					prop_description = 'SETUP (query, empty) calculates the diff value and stores it to be implemented in the subelements.';
				otherwise
					prop_description = getPropDescription@NNxMLP_FeatureImportanceBrainSurfacePF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  SETTINGS = PF.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurfacePF_NS';
				otherwise
					prop_settings = getPropSettings@NNxMLP_FeatureImportanceBrainSurfacePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  DEFAULT = PF.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER
					prop_default = 1;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF
					prop_default = 'on';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE
					prop_default = 10;
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF
					prop_default = 'on';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.ELCLASS
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF_NS';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.NAME
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF_NS';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.DESCRIPTION
					prop_default = 'A panel figure for the neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF_NS) manages the plot of the feature importance ploted over the brain with the nodal-superglobal graph measures. NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate the feature importance values into the brain regions.';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.ID
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF_NS ID';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LABEL
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF_NS label';
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.NOTES
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePF_NS notes';
				otherwise
					prop_default = getPropDefault@NNxMLP_FeatureImportanceBrainSurfacePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePF_NS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurfacePF_NS, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceBrainSurfacePF_NS.conditioning(prop, NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%  CHECK = PF.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF_NS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF_NS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF_NS:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePF_NS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurfacePF_NS.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurfacePF_NS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNxMLP_FeatureImportanceBrainSurfacePF_NS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF__
					check = Format.checkFormat(Format.OPTION, value, NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF__
					check = Format.checkFormat(Format.OPTION, value, NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.TEMPLATE % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropSettings(prop));
				otherwise
					if prop <= NNxMLP_FeatureImportanceBrainSurfacePF.getPropNumber()
						check = checkProp@NNxMLP_FeatureImportanceBrainSurfacePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropTag(prop) ' (' NNxMLP_FeatureImportanceBrainSurfacePF_NS.getFormatTag(NNxMLP_FeatureImportanceBrainSurfacePF_NS.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
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
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER__
					pf.get('SETUP');
					
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_DIFF__
					pf.get('SETUP');
					
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.SIZE_SCALE__
					pf.get('SETUP');
					
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.COLOR_DIFF__
					pf.get('SETUP');
					
				otherwise
					if prop <= NNxMLP_FeatureImportanceBrainSurfacePF.getPropNumber()
						postset@NNxMLP_FeatureImportanceBrainSurfacePF(pf, prop);
					end
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
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.SETUP % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.SETUP__
					% get brain region related list
					sph_list = pf.get('SPH_DICT').get('IT_LIST');
					sym_list = pf.get('SYM_DICT').get('IT_LIST');
					id_list = pf.get('ID_DICT').get('IT_LIST');
					lab_list = pf.get('LAB_DICT').get('IT_LIST');
					
					% get the value to show on the surface
					layer = pf.get('LAYER');
					fis = pf.get('FI');
					if isempty(fis)
					    value = {};
					    return
					end
					fi = fis{layer};
					if isempty(fi)
					    value = {};
					    return
					end
					
					% apply mask to mask out those nodes with value of 0
					mask = zeros(size(fi));
					mask(fi ~= 0) = 1;
					mask = logical(mask);
					for i = 1:1:length(sph_list)
					    set(sph_list{i}, 'VISIBLE', mask(i));
					end
					for i = 1:1:length(sym_list)
					    set(sym_list{i}, 'VISIBLE', mask(i));
					end
					for i = 1:1:length(id_list)
					    set(id_list{i}, 'VISIBLE', mask(i));
					end
					for i = 1:1:length(lab_list)
					    set(lab_list{i}, 'VISIBLE', mask(i));
					end
					
					size_diff = pf.get('SIZE_DIFF');
					switch size_diff
					    case 'on'
					        % transfrom diff value to appropriate size
					        % value ranching from 0.01 to 1
					        fi(isnan(fi)) = 0.1;
					        fi(isinf(fi)) = 0.1;
					        size_value = abs(fi);
					        min_bound = 0.01;
					        max_bound = 1.0;
					        min_size_value = min(size_value);
					        if min_size_value == 0 % change the min value to the second min as 0 indicates masked out
					            min_size_value = min(size_value(size_value > 0));
					            size_value(size_value == 0) = min_size_value;
					        end
					        max_size_value = max(size_value);
					        if max_size_value == min_size_value
					            normalized_size_value = ones(size(size_value)) * max_bound;
					        else
					            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
					        end
					        size_scale = pf.get('SIZE_SCALE');
					        scaled_size_value = normalized_size_value * size_scale;
					
					        % set size to sphs
					        for i = 1:1:length(sph_list)
					            set(sph_list{i}, 'SPHERESIZE', scaled_size_value(i));
					        end
					    case 'off'
					        if pf.get('SPHS')
					            for i = 1:1:length(sph_list)
					                set(sph_list{i}, 'SPHERESIZE', SettingsSphere.getPropDefault('SPHERESIZE'));
					            end
					        end
					    case 'disable'
					end
					
					color_diff = pf.get('COLOR_DIFF');
					switch color_diff
					    case 'on'
					        % transfrom m value to appropriate color
					        % RGB code ranching from 0 to 1
					        fi(isnan(fi)) = 0;
					        size_value = abs(fi);
					        min_bound = 0.0;
					        max_bound = 1.0;
					        min_size_value = min(size_value);
					        if min_size_value == 0 % change the min value to the second min as 0 indicates masked out
					            min_size_value = min(size_value(size_value > 0));
					            size_value(size_value == 0) = min_size_value;
					        end
					        max_size_value = max(size_value);
					        if max_size_value == min_size_value
					            normalized_size_value = ones(size(size_value)) * max_bound;
					        else
					            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
					        end
					
					        % Map the normalized values to colors in the Jet colormap
					        cmap = jet(256);
					        color_indices = ceil(normalized_size_value * (size(cmap, 1) - 1)) + 1;
					
					        % Clip color_indices to valid range
					        color_indices = max(1, min(color_indices, size(cmap, 1)));
					
					        % Get the RGB colors for the indices
					        rgb_colors = cmap(color_indices, :);
					
					        % set color to sphs
					        for i = 1:1:length(sph_list)
					            set(sph_list{i}, 'FACECOLOR', rgb_colors(i, :));
					        end
					    case 'off'
					        if pf.get('SPHS')
					            for i = 1:1:length(sph_list)
					                set(sph_list{i}, 'FACECOLOR', SettingsSphere.getPropDefault('FACECOLOR'));
					            end
					        end
					    case 'disable'
					end
					
					value = {};
					
				otherwise
					if prop <= NNxMLP_FeatureImportanceBrainSurfacePF.getPropNumber()
						value = calculateValue@NNxMLP_FeatureImportanceBrainSurfacePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
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
				case NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER % __NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER__
					pr = NNxMLP_FeatureImportanceBSPF_xSPP_Layer('EL', pf, 'PROP', NNxMLP_FeatureImportanceBrainSurfacePF_NS.LAYER);
					
				otherwise
					pr = getPanelProp@NNxMLP_FeatureImportanceBrainSurfacePF(pf, prop, varargin{:});
					
			end
		end
	end
end
