classdef NNClassifierMLP_CrossValidation_VOIs < NNClassifierMLP_CrossValidation
	%NNClassifierMLP_CrossValidation_VOIs is a process for evaluating multi-layer perceptron classifiers with variables of interest using cross-validation.
	% It is a subclass of <a href="matlab:help NNClassifierMLP_CrossValidation">NNClassifierMLP_CrossValidation</a>.
	%
	% A cross-validation for multi-layer perceptron classifiers with variables of interest (NNClassifierMLP_CrossValidation_VOIs) extends the standard MLP cross-validation to incorporate additional variables of interest (VOIs), such as demographic or clinical data. It splits both the primary dataset and the VOI dataset into folds, trains the model on training folds, and validates on the held-out fold, repeating for all fold combinations.
	% 
	% To train all neural networks for all folds, use: nncv.get('TRAIN')
	%
	% NNClassifierMLP_CrossValidation_VOIs methods (constructor):
	%  NNClassifierMLP_CrossValidation_VOIs - constructor
	%
	% NNClassifierMLP_CrossValidation_VOIs methods:
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
	% NNClassifierMLP_CrossValidation_VOIs methods (display):
	%  tostring - string with information about the neural network cross-validation for MLP classifiers with VOIs
	%  disp - displays information about the neural network cross-validation for MLP classifiers with VOIs
	%  tree - displays the tree of the neural network cross-validation for MLP classifiers with VOIs
	%
	% NNClassifierMLP_CrossValidation_VOIs methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network cross-validation for MLP classifiers with VOIs are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network cross-validation for MLP classifiers with VOIs
	%
	% NNClassifierMLP_CrossValidation_VOIs methods (save/load, Static):
	%  save - saves BRAPH2 neural network cross-validation for MLP classifiers with VOIs as b2 file
	%  load - loads a BRAPH2 neural network cross-validation for MLP classifiers with VOIs from a b2 file
	%
	% NNClassifierMLP_CrossValidation_VOIs method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network cross-validation for MLP classifiers with VOIs
	%
	% NNClassifierMLP_CrossValidation_VOIs method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network cross-validation for MLP classifiers with VOIs
	%
	% NNClassifierMLP_CrossValidation_VOIs methods (inspection, Static):
	%  getClass - returns the class of the neural network cross-validation for MLP classifiers with VOIs
	%  getSubclasses - returns all subclasses of NNClassifierMLP_CrossValidation_VOIs
	%  getProps - returns the property list of the neural network cross-validation for MLP classifiers with VOIs
	%  getPropNumber - returns the property number of the neural network cross-validation for MLP classifiers with VOIs
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
	% NNClassifierMLP_CrossValidation_VOIs methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_CrossValidation_VOIs methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_CrossValidation_VOIs methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_CrossValidation_VOIs methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_CrossValidation_VOIs; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_CrossValidation_VOIs constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNEvaluator, NNClassifierMLP_VOIs, NNClassifierMLP_Evaluator_VOIs.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		D_VOIS = NNClassifierMLP_CrossValidation.getPropNumber() + 1;
		D_VOIS_TAG = 'D_VOIS';
		D_VOIS_CATEGORY = Category.DATA;
		D_VOIS_FORMAT = Format.ITEMLIST;
		
		DSP_VOIS = NNClassifierMLP_CrossValidation.getPropNumber() + 2;
		DSP_VOIS_TAG = 'DSP_VOIS';
		DSP_VOIS_CATEGORY = Category.RESULT;
		DSP_VOIS_FORMAT = Format.ITEMLIST;
		
		DCO_VOIS = NNClassifierMLP_CrossValidation.getPropNumber() + 3;
		DCO_VOIS_TAG = 'DCO_VOIS';
		DCO_VOIS_CATEGORY = Category.RESULT;
		DCO_VOIS_FORMAT = Format.ITEMLIST;
		
		D_VOIS_LIST = NNClassifierMLP_CrossValidation.getPropNumber() + 4;
		D_VOIS_LIST_TAG = 'D_VOIS_LIST';
		D_VOIS_LIST_CATEGORY = Category.RESULT;
		D_VOIS_LIST_FORMAT = Format.ITEMLIST;
	end
	methods % constructor
		function nncv = NNClassifierMLP_CrossValidation_VOIs(varargin)
			%NNClassifierMLP_CrossValidation_VOIs() creates a neural network cross-validation for MLP classifiers with VOIs.
			%
			% NNClassifierMLP_CrossValidation_VOIs(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_CrossValidation_VOIs(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nncv = nncv@NNClassifierMLP_CrossValidation(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network cross-validation for MLP classifiers with VOIs.
			%
			% BUILD = NNClassifierMLP_CrossValidation_VOIs.GETBUILD() returns the build of 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNCV.GETBUILD() returns the build of the neural network cross-validation for MLP classifiers with VOIs NNCV.
			%  BUILD = Element.GETBUILD(NNCV) returns the build of 'NNCV'.
			%  BUILD = Element.GETBUILD('NNClassifierMLP_CrossValidation_VOIs') returns the build of 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Note that the Element.GETBUILD(NNCV) and Element.GETBUILD('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nncv_class = getClass()
			%GETCLASS returns the class of the neural network cross-validation for MLP classifiers with VOIs.
			%
			% CLASS = NNClassifierMLP_CrossValidation_VOIs.GETCLASS() returns the class 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the neural network cross-validation for MLP classifiers with VOIs NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_CrossValidation_VOIs') returns 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Note that the Element.GETCLASS(NNCV) and Element.GETCLASS('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			
			nncv_class = 'NNClassifierMLP_CrossValidation_VOIs';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network cross-validation for MLP classifiers with VOIs.
			%
			% LIST = NNClassifierMLP_CrossValidation_VOIs.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNCV.GETSUBCLASSES() returns all subclasses of the neural network cross-validation for MLP classifiers with VOIs NNCV.
			%  LIST = Element.GETSUBCLASSES(NNCV) returns all subclasses of 'NNCV'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_CrossValidation_VOIs') returns all subclasses of 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Note that the Element.GETSUBCLASSES(NNCV) and Element.GETSUBCLASSES('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_CrossValidation_VOIs', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network cross-validation for MLP classifiers with VOIs.
			%
			% PROPS = NNClassifierMLP_CrossValidation_VOIs.GETPROPS() returns the property list of neural network cross-validation for MLP classifiers with VOIs
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_CrossValidation_VOIs.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the neural network cross-validation for MLP classifiers with VOIs NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_CrossValidation_VOIs'[, CATEGORY]) returns the property list of 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Note that the Element.GETPROPS(NNCV) and Element.GETPROPS('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNClassifierMLP_CrossValidation.getProps() ...
						NNClassifierMLP_CrossValidation_VOIs.D_VOIS ...
						NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS ...
						NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS ...
						NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.DATA) ...
						NNClassifierMLP_CrossValidation_VOIs.D_VOIS ...
						];
				case Category.RESULT
					prop_list = [
						NNClassifierMLP_CrossValidation.getProps(Category.RESULT) ...
						NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS ...
						NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS ...
						NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNClassifierMLP_CrossValidation.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network cross-validation for MLP classifiers with VOIs.
			%
			% N = NNClassifierMLP_CrossValidation_VOIs.GETPROPNUMBER() returns the property number of neural network cross-validation for MLP classifiers with VOIs.
			%
			% N = NNClassifierMLP_CrossValidation_VOIs.GETPROPNUMBER(CATEGORY) returns the property number of neural network cross-validation for MLP classifiers with VOIs
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network cross-validation for MLP classifiers with VOIs NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_CrossValidation_VOIs') returns the property number of 'NNClassifierMLP_CrossValidation_VOIs'.
			%
			% Note that the Element.GETPROPNUMBER(NNCV) and Element.GETPROPNUMBER('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_CrossValidation_VOIs.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network cross-validation for MLP classifiers with VOIs/error.
			%
			% CHECK = NNClassifierMLP_CrossValidation_VOIs.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_CrossValidation_VOIs, PROP) checks whether PROP exists for NNClassifierMLP_CrossValidation_VOIs.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_CrossValidation_VOIs, PROP) throws error if PROP does NOT exist for NNClassifierMLP_CrossValidation_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNCV) and Element.EXISTSPROP('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_CrossValidation_VOIs.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_CrossValidation_VOIs.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network cross-validation for MLP classifiers with VOIs/error.
			%
			% CHECK = NNClassifierMLP_CrossValidation_VOIs.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_CrossValidation_VOIs, TAG) checks whether TAG exists for NNClassifierMLP_CrossValidation_VOIs.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_CrossValidation_VOIs, TAG) throws error if TAG does NOT exist for NNClassifierMLP_CrossValidation_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNCV) and Element.EXISTSTAG('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_crossvalidation_vois_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidation_VOIs.getPropTag(x), num2cell(NNClassifierMLP_CrossValidation_VOIs.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_crossvalidation_vois_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_CrossValidation_VOIs.'] ...
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
			%  PROPERTY = NNCV.GETPROPPROP(POINTER) returns property number of POINTER of NNCV.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  PROPERTY = NNCV.GETPROPPROP(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPPROP(NNCV) and Element.GETPROPPROP('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_crossvalidation_vois_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidation_VOIs.getPropTag(x), num2cell(NNClassifierMLP_CrossValidation_VOIs.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_crossvalidation_vois_tag_list)); % tag = pointer
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
			%  TAG = NNCV.GETPROPTAG(POINTER) returns tag of POINTER of NNCV.
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  TAG = NNCV.GETPROPTAG(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPTAG(NNCV) and Element.GETPROPTAG('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_CrossValidation_VOIs.D_VOIS
						tag = NNClassifierMLP_CrossValidation_VOIs.D_VOIS_TAG;
					case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS
						tag = NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS_TAG;
					case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS
						tag = NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS_TAG;
					case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST
						tag = NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST_TAG;
					otherwise
						tag = getPropTag@NNClassifierMLP_CrossValidation(prop);
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
			%  CATEGORY = NNCV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNCV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPCATEGORY(NNCV) and Element.GETPROPCATEGORY('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS
					prop_category = NNClassifierMLP_CrossValidation_VOIs.D_VOIS_CATEGORY;
				case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS
					prop_category = NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS_CATEGORY;
				case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS
					prop_category = NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS_CATEGORY;
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST
					prop_category = NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNClassifierMLP_CrossValidation(prop);
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
			%  FORMAT = NNCV.GETPROPFORMAT(POINTER) returns format of POINTER of NNCV.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  FORMAT = NNCV.GETPROPFORMAT(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPFORMAT(NNCV) and Element.GETPROPFORMAT('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS
					prop_format = NNClassifierMLP_CrossValidation_VOIs.D_VOIS_FORMAT;
				case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS
					prop_format = NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS_FORMAT;
				case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS
					prop_format = NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS_FORMAT;
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST
					prop_format = NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST_FORMAT;
				otherwise
					prop_format = getPropFormat@NNClassifierMLP_CrossValidation(prop);
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
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNCV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNCV) and Element.GETPROPDESCRIPTION('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS
					prop_description = 'D_VOIS (data, itemlist) is the VOI datasets from groups to be cross-validated.';
				case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS
					prop_description = 'DSP_VOIS (result, itemlist) is a list of dataset splitters for the VOI datasets.';
				case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS
					prop_description = 'DCO_VOIS (result, itemlist) is a list of dataset combiners for the VOI datasets per fold.';
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST
					prop_description = 'D_VOIS_LIST (result, itemlist) contains the split VOI datasets corresponding to the k folds.';
				case NNClassifierMLP_CrossValidation_VOIs.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the cross-validation.';
				case NNClassifierMLP_CrossValidation_VOIs.NAME
					prop_description = 'NAME (constant, string) is the name of the cross-validation.';
				case NNClassifierMLP_CrossValidation_VOIs.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cross-validation.';
				case NNClassifierMLP_CrossValidation_VOIs.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the cross-validation.';
				case NNClassifierMLP_CrossValidation_VOIs.NN_TEMPLATE
					prop_description = 'NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.';
				case NNClassifierMLP_CrossValidation_VOIs.NNEVALUATOR_TEMPLATE
					prop_description = 'NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evaluator parameters.';
				case NNClassifierMLP_CrossValidation_VOIs.NN_LIST
					prop_description = 'NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.';
				case NNClassifierMLP_CrossValidation_VOIs.EVALUATOR_LIST
					prop_description = 'EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.';
				otherwise
					prop_description = getPropDescription@NNClassifierMLP_CrossValidation(prop);
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
			%  SETTINGS = NNCV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNCV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPSETTINGS(NNCV) and Element.GETPROPSETTINGS('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS
					prop_settings = 'NNDataset';
				case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS
					prop_settings = 'NNDatasetSplit';
				case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS
					prop_settings = 'NNDatasetCombine';
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case NNClassifierMLP_CrossValidation_VOIs.TEMPLATE
					prop_settings = 'NNClassifierMLP_CrossValidation_VOIs';
				case NNClassifierMLP_CrossValidation_VOIs.NN_TEMPLATE
					prop_settings = 'NNClassifierMLP_VOIs';
				case NNClassifierMLP_CrossValidation_VOIs.NNEVALUATOR_TEMPLATE
					prop_settings = 'NNClassifierMLP_Evaluator_VOIs';
				otherwise
					prop_settings = getPropSettings@NNClassifierMLP_CrossValidation(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation_VOIs.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation_VOIs.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPDEFAULT(NNCV) and Element.GETPROPDEFAULT('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_CrossValidation_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.ELCLASS
					prop_default = 'NNClassifierMLP_CrossValidation_VOIs';
				case NNClassifierMLP_CrossValidation_VOIs.NAME
					prop_default = 'Neural Network Cross-Validation for Multi-layer Perceptron Classifiers with Variables of Interest';
				case NNClassifierMLP_CrossValidation_VOIs.DESCRIPTION
					prop_default = 'A cross validation for multi-layer perceptron classifiers with variables of interest (NNClassifierMLP_CrossValidation_VOIs) extends the standard MLP cross-validation to incorporate additional variables of interest (VOIs) such as demographic or clinical data. It splits both the primary dataset and the VOI dataset into folds, trains the model on training folds, and validates on the held-out fold, repeating for all fold combinations.';
				case NNClassifierMLP_CrossValidation_VOIs.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.NN_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.NNEVALUATOR_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNClassifierMLP_CrossValidation(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation_VOIs.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation_VOIs.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidation_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidation_VOIs.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNCV) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_CrossValidation_VOIs.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_CrossValidation_VOIs.conditioning(prop, NNClassifierMLP_CrossValidation_VOIs.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNCV.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_CrossValidation_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidation_VOIs.
			%  CHECK = NNCV.CHECKPROP(NNClassifierMLP_CrossValidation_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidation_VOIs.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation_VOIs:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation_VOIs:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_CrossValidation_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidation_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation_VOIs:€BRAPH2.WRONG_INPUT€
			%  NNCV.CHECKPROP(NNClassifierMLP_CrossValidation_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidation_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation_VOIs:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNCV) and Element.CHECKPROP('NNClassifierMLP_CrossValidation_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_CrossValidation_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS % __NNClassifierMLP_CrossValidation_VOIs.D_VOIS__
					check = Format.checkFormat(Format.ITEMLIST, value, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS % __NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS__
					check = Format.checkFormat(Format.ITEMLIST, value, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS % __NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS__
					check = Format.checkFormat(Format.ITEMLIST, value, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST % __NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.TEMPLATE % __NNClassifierMLP_CrossValidation_VOIs.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.NN_TEMPLATE % __NNClassifierMLP_CrossValidation_VOIs.NN_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation_VOIs.NNEVALUATOR_TEMPLATE % __NNClassifierMLP_CrossValidation_VOIs.NNEVALUATOR_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidation_VOIs.getPropSettings(prop));
				otherwise
					if prop <= NNClassifierMLP_CrossValidation.getPropNumber()
						check = checkProp@NNClassifierMLP_CrossValidation(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_CrossValidation_VOIs.getPropTag(prop) ' (' NNClassifierMLP_CrossValidation_VOIs.getFormatTag(NNClassifierMLP_CrossValidation_VOIs.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nncv, prop, varargin)
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
				case NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS % __NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation_VOIs.DSP_VOIS), 'twister')
					
					d_vois_list = nncv.get('D_VOIS');
					split = nncv.get('SPLIT');
					if isempty(split)
					    split_per_dataset = {};
					else
					    for i = 1:length(d_vois_list)
					        split_per_dataset{i} = split(i, :);
					    end
					end
					value = cellfun(@(d_vois, s) NNDatasetSplit('D', d_vois, 'SPLIT', s), d_vois_list, split_per_dataset, 'UniformOutput', false);
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS % __NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation_VOIs.DCO_VOIS), 'twister')
					
					dsp_vois_list = nncv.get('DSP_VOIS');
					if length(dsp_vois_list) == 0
					    value = {};
					else
					    kfolds = nncv.get('KFOLDS');
					    for i = 1:1:kfolds
					        d_vois_splitted_list = cellfun(@(dsp) dsp.get('D_LIST_IT', i), dsp_vois_list, 'UniformOutput', false);
					        value{i} = NNDatasetCombine('D_LIST', d_vois_splitted_list);
					    end
					    value = value';
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST % __NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation_VOIs.D_VOIS_LIST), 'twister')
					
					dco_vois_list = nncv.get('DCO_VOIS');
					if length(dco_vois_list) == 0
					    value = {};
					else
					    value = cellfun(@(dco) dco.get('D'), dco_vois_list, 'UniformOutput', false);
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation_VOIs.NN_LIST % __NNClassifierMLP_CrossValidation_VOIs.NN_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation_VOIs.NN_LIST), 'twister')
					
					d_list = nncv.get('D_LIST');
					d_vois_list = nncv.get('D_VOIS_LIST');
					if isempty(d_list) || isempty(d_vois_list)
					    value = {};
					else
					    kfolds = nncv.get('KFOLDS');
					    for i = 1:kfolds
					        % Combine training folds for D and D_VOIS
					        d_training_set = d_list;
					        d_training_set(i) = [];  % Exclude the i-th fold
					        d_training_set = NNDatasetCombine('D_LIST', d_training_set).get('D');
					        
					        d_vois_training_set = d_vois_list;
					        d_vois_training_set(i) = [];  % Exclude the i-th fold
					        d_vois_training_set = NNDatasetCombine('D_LIST', d_vois_training_set).get('D');
					        
					        if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
					            nn_template = nncv.get('NN_TEMPLATE');
					        else
					            nn_template = NNClassifierMLP_VOIs( ...
					                'EPOCHS', nncv.get('EPOCHS'), ...
					                'BATCH', nncv.get('BATCH'), ...
					                'SHUFFLE', nncv.get('SHUFFLE'), ...
					                'SOLVER', nncv.get('SOLVER'), ...
					                'VERBOSE', nncv.get('VERBOSE'), ...
					                'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
					        end
					        
					        value{i} = NNClassifierMLP_VOIs( ...
					            'TEMPLATE', nn_template, ...
					            'D', d_training_set, ...
					            'D_VOIS', d_vois_training_set, ...
					            'VERBOSE', nncv.get('VERBOSE'), ...
					            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
					    end
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation_VOIs.EVALUATOR_LIST % __NNClassifierMLP_CrossValidation_VOIs.EVALUATOR_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation_VOIs.EVALUATOR_LIST), 'twister')
					
					d_list = nncv.get('D_LIST');
					d_vois_list = nncv.get('D_VOIS_LIST');
					nn_list = nncv.get('NN_LIST');
					if isempty(d_list) || isempty(d_vois_list) || isempty(nn_list)
					    value = {};
					else
					    if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
					        nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
					    else
					        nne_template = NNClassifierMLP_Evaluator_VOIs();
					    end
					    
					    value = cell(length(d_list), 1);
					    for i = 1:length(d_list)
					        value{i} = NNClassifierMLP_Evaluator_VOIs( ...
					            'TEMPLATE', nne_template, ...
					            'D', d_list{i}, ...
					            'D_VOIS', d_vois_list{i}, ...
					            'NN', nn_list{i});
					    end
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= NNClassifierMLP_CrossValidation.getPropNumber()
						value = calculateValue@NNClassifierMLP_CrossValidation(nncv, prop, varargin{:});
					else
						value = calculateValue@Element(nncv, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(nncv, prop, value)
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
			msg = ['Error while checking ' tostring(nncv) ' ' nncv.getPropTag(prop) '.'];
			
			switch prop
				case NNClassifierMLP_CrossValidation_VOIs.D_VOIS % __NNClassifierMLP_CrossValidation_VOIs.D_VOIS__
					d_list = nncv.get('D');
					d_vois_list = nncv.get('D_VOIS');
					if length(d_list) ~= length(d_vois_list)
					    check = 'The number of primary datasets (D) and VOI datasets (D_VOIS) must be equal.';
					elseif ~isempty(d_list) && ~isempty(d_vois_list)
					    for i = 1:length(d_list)
					        if d_list{i}.get('DP_DICT').get('LENGTH') ~= d_vois_list{i}.get('DP_DICT').get('LENGTH')
					            check = 'The number of data points in each primary dataset (D) and corresponding VOI dataset (D_VOIS) must be equal.';
					            return
					        end
					    end
					end
					check = true;
					
				otherwise
					if prop <= NNClassifierMLP_CrossValidation.getPropNumber()
						[check, msg] = checkValue@NNClassifierMLP_CrossValidation(nncv, prop, value);
					end
			end
		end
	end
end
