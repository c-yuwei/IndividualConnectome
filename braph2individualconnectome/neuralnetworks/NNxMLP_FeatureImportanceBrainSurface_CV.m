classdef NNxMLP_FeatureImportanceBrainSurface_CV < NNxMLP_FeatureImportance_CV
	%NNxMLP_FeatureImportanceBrainSurface_CV manages the visuazation of the feature importance on the brain surface within neural network evaluators.
	% It is a subclass of <a href="matlab:help NNxMLP_FeatureImportance_CV">NNxMLP_FeatureImportance_CV</a>.
	%
	% A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) 
	%  manages the visualization of feature importance within neural network evaluators, particularly on the brain surface.
	% It handles different types of neural network inputs, including graph data 
	%  (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures),
	%  and the subject data (connectivity data or structural data).
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (constructor):
	%  NNxMLP_FeatureImportanceBrainSurface_CV - constructor
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods:
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
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceBrainSurface_CV
	%  getProps - returns the property list of the neural network feature importace for multi-layer perceptron
	%  getPropNumber - returns the property number of the neural network feature importace for multi-layer perceptron
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
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceBrainSurface_CV; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceBrainSurface_CV constants</a>.
	%
	%
	% See also NNEvaluator, NNDataPoint_Graph_CLA, NNDataPoint_Measure_REG, NNDataPoint_CON_CLA, NNDataPoint_ST_CLA.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		BA = NNxMLP_FeatureImportance_CV.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.PARAMETER;
		BA_FORMAT = Format.ITEM;
	end
	methods % constructor
		function nnficv = NNxMLP_FeatureImportanceBrainSurface_CV(varargin)
			%NNxMLP_FeatureImportanceBrainSurface_CV() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportanceBrainSurface_CV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceBrainSurface_CV(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nnficv = nnficv@NNxMLP_FeatureImportance_CV(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network feature importace for multi-layer perceptron.
			%
			% BUILD = NNxMLP_FeatureImportanceBrainSurface_CV.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNFICV.GETBUILD() returns the build of the neural network feature importace for multi-layer perceptron NNFICV.
			%  BUILD = Element.GETBUILD(NNFICV) returns the build of 'NNFICV'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurface_CV') returns the build of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETBUILD(NNFICV) and Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnficv_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportanceBrainSurface_CV.GETCLASS() returns the class 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFICV.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFICV.
			%  CLASS = Element.GETCLASS(NNFICV) returns the class of 'NNFICV'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurface_CV') returns 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETCLASS(NNFICV) and Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			
			nnficv_class = 'NNxMLP_FeatureImportanceBrainSurface_CV';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportanceBrainSurface_CV.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFICV.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFICV.
			%  LIST = Element.GETSUBCLASSES(NNFICV) returns all subclasses of 'NNFICV'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurface_CV') returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETSUBCLASSES(NNFICV) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_FeatureImportanceBrainSurface_CV', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFICV.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFICV.
			%  PROPS = Element.GETPROPS(NNFICV[, CATEGORY]) returns the property list of 'NNFICV'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurface_CV'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETPROPS(NNFICV) and Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNxMLP_FeatureImportance_CV.getProps() ...
						NNxMLP_FeatureImportanceBrainSurface_CV.BA ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.PARAMETER) ...
						NNxMLP_FeatureImportanceBrainSurface_CV.BA ...
						];
				case Category.DATA
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNxMLP_FeatureImportance_CV.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFICV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFICV.
			%  N = Element.GETPROPNUMBER(NNFICV) returns the property number of 'NNFICV'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurface_CV') returns the property number of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETPROPNUMBER(NNFICV) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_FeatureImportanceBrainSurface_CV.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurface_CV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSPROP(PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNFICV, PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSPROP(NNFICV, PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFICV) and Element.EXISTSPROP('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_FeatureImportanceBrainSurface_CV.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurface_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurface_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceBrainSurface_CV.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurface_CV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSTAG(TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNFICV, TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurface_CV, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSTAG(NNFICV, TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurface_CV, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFICV) and Element.EXISTSTAG('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_featureimportancebrainsurface_cv_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceBrainSurface_CV.getPropTag(x), num2cell(NNxMLP_FeatureImportanceBrainSurface_CV.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_featureimportancebrainsurface_cv_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurface_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurface_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceBrainSurface_CV.'] ...
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
			%  PROPERTY = NNFICV.GETPROPPROP(POINTER) returns property number of POINTER of NNFICV.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  PROPERTY = NNFICV.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPPROP(NNFICV) and Element.GETPROPPROP('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_featureimportancebrainsurface_cv_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceBrainSurface_CV.getPropTag(x), num2cell(NNxMLP_FeatureImportanceBrainSurface_CV.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_featureimportancebrainsurface_cv_tag_list)); % tag = pointer
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
			%  TAG = NNFICV.GETPROPTAG(POINTER) returns tag of POINTER of NNFICV.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  TAG = NNFICV.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPTAG(NNFICV) and Element.GETPROPTAG('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNxMLP_FeatureImportanceBrainSurface_CV.BA
						tag = NNxMLP_FeatureImportanceBrainSurface_CV.BA_TAG;
					otherwise
						tag = getPropTag@NNxMLP_FeatureImportance_CV(prop);
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
			%  CATEGORY = NNFICV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFICV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  CATEGORY = NNFICV.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPCATEGORY(NNFICV) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurface_CV.BA
					prop_category = NNxMLP_FeatureImportanceBrainSurface_CV.BA_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNxMLP_FeatureImportance_CV(prop);
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
			%  FORMAT = NNFICV.GETPROPFORMAT(POINTER) returns format of POINTER of NNFICV.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  FORMAT = NNFICV.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPFORMAT(NNFICV) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurface_CV.BA
					prop_format = NNxMLP_FeatureImportanceBrainSurface_CV.BA_FORMAT;
				otherwise
					prop_format = getPropFormat@NNxMLP_FeatureImportance_CV(prop);
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
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFICV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFICV) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurface_CV.BA
					prop_description = 'BA (parameter, item) is the brain atlas.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.NAME
					prop_description = 'NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.ID
					prop_description = 'ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE
					prop_description = 'FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.';
				case NNxMLP_FeatureImportanceBrainSurface_CV.AV_FEATURE_IMPORTANCE
					prop_description = 'AV_FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.';
				otherwise
					prop_description = getPropDescription@NNxMLP_FeatureImportance_CV(prop);
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
			%  SETTINGS = NNFICV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFICV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  SETTINGS = NNFICV.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPSETTINGS(NNFICV) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurface_CV.BA
					prop_settings = 'BrainAtlas';
				case NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurface_CV';
				case NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurface';
				otherwise
					prop_settings = getPropSettings@NNxMLP_FeatureImportance_CV(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPDEFAULT(NNFICV) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurface_CV.BA
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurface_CV.ELCLASS
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV';
				case NNxMLP_FeatureImportanceBrainSurface_CV.NAME
					prop_default = 'Feature Importace for Multi-layer Perceptron';
				case NNxMLP_FeatureImportanceBrainSurface_CV.DESCRIPTION
					prop_default = 'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).';
				case NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurface_CV.ID
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV ID';
				case NNxMLP_FeatureImportanceBrainSurface_CV.LABEL
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV label';
				case NNxMLP_FeatureImportanceBrainSurface_CV.NOTES
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV notes';
				case NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNxMLP_FeatureImportance_CV(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFICV) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceBrainSurface_CV.conditioning(prop, NNxMLP_FeatureImportanceBrainSurface_CV.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFICV.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  CHECK = NNFICV.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			% 
			% NNFICV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurface_CV:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFICV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFICV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurface_CV:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurface_CV:€BRAPH2.WRONG_INPUT€
			%  NNFICV.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceBrainSurface_CV:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNFICV) and Element.CHECKPROP('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceBrainSurface_CV.BA % __NNxMLP_FeatureImportanceBrainSurface_CV.BA__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE % __NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE % __NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				otherwise
					if prop <= NNxMLP_FeatureImportance_CV.getPropNumber()
						check = checkProp@NNxMLP_FeatureImportance_CV(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurface_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurface_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceBrainSurface_CV.getPropTag(prop) ' (' NNxMLP_FeatureImportanceBrainSurface_CV.getFormatTag(NNxMLP_FeatureImportanceBrainSurface_CV.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(nnficv, prop, varargin)
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
				case NNxMLP_FeatureImportanceBrainSurface_CV.AV_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportanceBrainSurface_CV.AV_FEATURE_IMPORTANCE__
					if isempty(nnficv.get('NNCV').get('D_LIST'))
					    input_dataset = NNDataset();
					else
					    input_dataset = nnficv.get('NNCV').get('D_LIST_IT', 1);
					end
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('ELCLASS'), NNDataPoint_Graph_REG().get('ELCLASS')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('ELCLASS'), NNDataPoint_Measure_REG().get('ELCLASS')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Graph('EL', nnficv, 'BA', nnficv.get('BA'), 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface_CV.AV_FEATURE_IMPORTANCE, 'RESHAPED_PROP', NNxMLP_FeatureImportanceBrainSurface_CV.RESHAPED_AV_FEATURE_IMPORTANCE, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Measure('EL', nnficv, 'BA', nnficv.get('BA'), 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface_CV.AV_FEATURE_IMPORTANCE, 'RESHAPED_PROP', NNxMLP_FeatureImportanceBrainSurface_CV.RESHAPED_AV_FEATURE_IMPORTANCE, varargin{:});
					else % DATA input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Data('EL', nnficv, 'BA', nnficv.get('BA'), 'D', input_dataset, 'PROP', NNxMLP_FeatureImportanceBrainSurface_CV.AV_FEATURE_IMPORTANCE, 'RESHAPED_PROP', NNxMLP_FeatureImportanceBrainSurface_CV.RESHAPED_AV_FEATURE_IMPORTANCE, varargin{:});
					end
					
				otherwise
					pr = getPanelProp@NNxMLP_FeatureImportance_CV(nnficv, prop, varargin{:});
					
			end
		end
	end
end
