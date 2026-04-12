classdef NNClassifierMLP_Evaluator_VOIs < NNClassifierMLP_Evaluator
	%NNClassifierMLP_Evaluator_VOIs evaluates the performance of a multi-layer perceptron classifier with dual datasets.
	% It is a subclass of <a href="matlab:help NNClassifierMLP_Evaluator">NNClassifierMLP_Evaluator</a>.
	%
	% A neural network evaluator for a multi-layer perceptron classifier with variables of interest (NNClassifierMLP_Evaluator_VOIs) evaluates the performance of an NNClassifierMLP_VOIs classifier using a primary dataset (D) and a VOI dataset (D_VOIs). It computes classification metrics (e.g., confusion matrix, AUC) based on dual-input predictions.
	%
	% NNClassifierMLP_Evaluator_VOIs methods (constructor):
	%  NNClassifierMLP_Evaluator_VOIs - constructor
	%
	% NNClassifierMLP_Evaluator_VOIs methods:
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
	% NNClassifierMLP_Evaluator_VOIs methods (display):
	%  tostring - string with information about the neural network evaluator for multi-layer perceptron classifier with VOIs
	%  disp - displays information about the neural network evaluator for multi-layer perceptron classifier with VOIs
	%  tree - displays the tree of the neural network evaluator for multi-layer perceptron classifier with VOIs
	%
	% NNClassifierMLP_Evaluator_VOIs methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator for multi-layer perceptron classifier with VOIs are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator for multi-layer perceptron classifier with VOIs
	%
	% NNClassifierMLP_Evaluator_VOIs methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator for multi-layer perceptron classifier with VOIs as b2 file
	%  load - loads a BRAPH2 neural network evaluator for multi-layer perceptron classifier with VOIs from a b2 file
	%
	% NNClassifierMLP_Evaluator_VOIs method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator for multi-layer perceptron classifier with VOIs
	%
	% NNClassifierMLP_Evaluator_VOIs method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator for multi-layer perceptron classifier with VOIs
	%
	% NNClassifierMLP_Evaluator_VOIs methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator for multi-layer perceptron classifier with VOIs
	%  getSubclasses - returns all subclasses of NNClassifierMLP_Evaluator_VOIs
	%  getProps - returns the property list of the neural network evaluator for multi-layer perceptron classifier with VOIs
	%  getPropNumber - returns the property number of the neural network evaluator for multi-layer perceptron classifier with VOIs
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
	% NNClassifierMLP_Evaluator_VOIs methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_Evaluator_VOIs methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_Evaluator_VOIs methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_Evaluator_VOIs methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_Evaluator_VOIs; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_Evaluator_VOIs constants</a>.
	%
	%
	% See also NNDataPoint_CON_CLA, NNDataPoint_VOIs, NNClassifierMLP_VOIs.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		D_VOIS = NNClassifierMLP_Evaluator.getPropNumber() + 1;
		D_VOIS_TAG = 'D_VOIS';
		D_VOIS_CATEGORY = Category.DATA;
		D_VOIS_FORMAT = Format.ITEM;
	end
	methods % constructor
		function nne = NNClassifierMLP_Evaluator_VOIs(varargin)
			%NNClassifierMLP_Evaluator_VOIs() creates a neural network evaluator for multi-layer perceptron classifier with VOIs.
			%
			% NNClassifierMLP_Evaluator_VOIs(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_Evaluator_VOIs(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nne = nne@NNClassifierMLP_Evaluator(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network evaluator for multi-layer perceptron classifier with VOIs.
			%
			% BUILD = NNClassifierMLP_Evaluator_VOIs.GETBUILD() returns the build of 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNE.GETBUILD() returns the build of the neural network evaluator for multi-layer perceptron classifier with VOIs NNE.
			%  BUILD = Element.GETBUILD(NNE) returns the build of 'NNE'.
			%  BUILD = Element.GETBUILD('NNClassifierMLP_Evaluator_VOIs') returns the build of 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Note that the Element.GETBUILD(NNE) and Element.GETBUILD('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nne_class = getClass()
			%GETCLASS returns the class of the neural network evaluator for multi-layer perceptron classifier with VOIs.
			%
			% CLASS = NNClassifierMLP_Evaluator_VOIs.GETCLASS() returns the class 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator for multi-layer perceptron classifier with VOIs NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_Evaluator_VOIs') returns 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			
			nne_class = 'NNClassifierMLP_Evaluator_VOIs';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator for multi-layer perceptron classifier with VOIs.
			%
			% LIST = NNClassifierMLP_Evaluator_VOIs.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator for multi-layer perceptron classifier with VOIs NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_Evaluator_VOIs') returns all subclasses of 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_Evaluator_VOIs', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator for multi-layer perceptron classifier with VOIs.
			%
			% PROPS = NNClassifierMLP_Evaluator_VOIs.GETPROPS() returns the property list of neural network evaluator for multi-layer perceptron classifier with VOIs
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_Evaluator_VOIs.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator for multi-layer perceptron classifier with VOIs NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_Evaluator_VOIs'[, CATEGORY]) returns the property list of 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNClassifierMLP_Evaluator.getProps() ...
						NNClassifierMLP_Evaluator_VOIs.D_VOIS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.DATA) ...
						NNClassifierMLP_Evaluator_VOIs.D_VOIS ...
						];
				case Category.RESULT
					prop_list = [
						NNClassifierMLP_Evaluator.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNClassifierMLP_Evaluator.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator for multi-layer perceptron classifier with VOIs.
			%
			% N = NNClassifierMLP_Evaluator_VOIs.GETPROPNUMBER() returns the property number of neural network evaluator for multi-layer perceptron classifier with VOIs.
			%
			% N = NNClassifierMLP_Evaluator_VOIs.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator for multi-layer perceptron classifier with VOIs
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator for multi-layer perceptron classifier with VOIs NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_Evaluator_VOIs') returns the property number of 'NNClassifierMLP_Evaluator_VOIs'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_Evaluator_VOIs.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator for multi-layer perceptron classifier with VOIs/error.
			%
			% CHECK = NNClassifierMLP_Evaluator_VOIs.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_Evaluator_VOIs, PROP) checks whether PROP exists for NNClassifierMLP_Evaluator_VOIs.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_Evaluator_VOIs, PROP) throws error if PROP does NOT exist for NNClassifierMLP_Evaluator_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_Evaluator_VOIs.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_Evaluator_VOIs.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator for multi-layer perceptron classifier with VOIs/error.
			%
			% CHECK = NNClassifierMLP_Evaluator_VOIs.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_Evaluator_VOIs, TAG) checks whether TAG exists for NNClassifierMLP_Evaluator_VOIs.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_Evaluator_VOIs, TAG) throws error if TAG does NOT exist for NNClassifierMLP_Evaluator_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_evaluator_vois_tag_list = cellfun(@(x) NNClassifierMLP_Evaluator_VOIs.getPropTag(x), num2cell(NNClassifierMLP_Evaluator_VOIs.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_evaluator_vois_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_Evaluator_VOIs.'] ...
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
			%  PROPERTY = NNE.GETPROPPROP(POINTER) returns property number of POINTER of NNE.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_Evaluator_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  PROPERTY = NNE.GETPROPPROP(NNClassifierMLP_Evaluator_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_evaluator_vois_tag_list = cellfun(@(x) NNClassifierMLP_Evaluator_VOIs.getPropTag(x), num2cell(NNClassifierMLP_Evaluator_VOIs.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_evaluator_vois_tag_list)); % tag = pointer
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
			%  TAG = NNE.GETPROPTAG(POINTER) returns tag of POINTER of NNE.
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_Evaluator_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  TAG = NNE.GETPROPTAG(NNClassifierMLP_Evaluator_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_Evaluator_VOIs.D_VOIS
						tag = NNClassifierMLP_Evaluator_VOIs.D_VOIS_TAG;
					otherwise
						tag = getPropTag@NNClassifierMLP_Evaluator(prop);
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
			%  CATEGORY = NNE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_Evaluator_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNClassifierMLP_Evaluator_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator_VOIs.D_VOIS
					prop_category = NNClassifierMLP_Evaluator_VOIs.D_VOIS_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNClassifierMLP_Evaluator(prop);
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
			%  FORMAT = NNE.GETPROPFORMAT(POINTER) returns format of POINTER of NNE.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_Evaluator_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  FORMAT = NNE.GETPROPFORMAT(NNClassifierMLP_Evaluator_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator_VOIs.D_VOIS
					prop_format = NNClassifierMLP_Evaluator_VOIs.D_VOIS_FORMAT;
				otherwise
					prop_format = getPropFormat@NNClassifierMLP_Evaluator(prop);
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
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator_VOIs.D_VOIS
					prop_description = 'D_VOIS (data, item) is the voi dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.';
				case NNClassifierMLP_Evaluator_VOIs.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the neural network evaluator for a multi-layer perceptron classifier with VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.NAME
					prop_description = 'NAME (constant, string) is the name of the neural network evaluator for a multi-layer perceptron classifier with VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the neural network evaluator for a multi-layer perceptron classifier with VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the neural network evaluator for a multi-layer perceptron classifier with VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.ID
					prop_description = 'ID (data, string) is a few-letter code for the neural network evaluator.';
				case NNClassifierMLP_Evaluator_VOIs.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network evaluator.';
				case NNClassifierMLP_Evaluator_VOIs.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network evaluator.';
				case NNClassifierMLP_Evaluator_VOIs.NN
					prop_description = 'NN (data, item) contains a trained neural network multi-layer perceptron classifier with VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.C_MATRIX
					prop_description = 'C_MATRIX (result, matrix) provides the confusion matrix for dual-input predictions from D and D_VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.AUC
					prop_description = 'AUC (result, rvector) provides the AUC for dual-input predictions from D and D_VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.MACRO_AUC
					prop_description = 'MACRO_AUC (result, scalar) provides the average AUC across classes for multi-layer perceptron classifier with VOIs.';
				case NNClassifierMLP_Evaluator_VOIs.PFROC
					prop_description = 'PFROC (gui, item) contains the panel figure of the ROC plot for classification model.';
				otherwise
					prop_description = getPropDescription@NNClassifierMLP_Evaluator(prop);
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
			%  SETTINGS = NNE.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNE.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_Evaluator_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNClassifierMLP_Evaluator_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator_VOIs.D_VOIS
					prop_settings = 'NNDataset';
				case NNClassifierMLP_Evaluator_VOIs.TEMPLATE
					prop_settings = 'NNClassifierMLP_Evaluator_VOIs';
				case NNClassifierMLP_Evaluator_VOIs.NN
					prop_settings = 'NNClassifierMLP_VOIs';
				case NNClassifierMLP_Evaluator_VOIs.PFROC
					prop_settings = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs';
				otherwise
					prop_settings = getPropSettings@NNClassifierMLP_Evaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator_VOIs.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator_VOIs.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_Evaluator_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNClassifierMLP_Evaluator_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_Evaluator_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator_VOIs.D_VOIS
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint_CON_CLA');
				case NNClassifierMLP_Evaluator_VOIs.ELCLASS
					prop_default = 'NNClassifierMLP_Evaluator_VOIs';
				case NNClassifierMLP_Evaluator_VOIs.NAME
					prop_default = 'Neural Network Evaluator for a Multi-layer Perceptron Classifier with Variables of Interest';
				case NNClassifierMLP_Evaluator_VOIs.DESCRIPTION
					prop_default = 'A neural network evaluator for a multi-layer perceptron classifier with variables of interest (NNClassifierMLP_Evaluator_VOIs) evaluates the performance of an NNClassifierMLP_VOIs classifier using a primary dataset (D) and a VOI dataset (D_VOIs). It computes classification metrics (e.g., confusion matrix, AUC) based on dual-input predictions.';
				case NNClassifierMLP_Evaluator_VOIs.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_Evaluator_VOIs.getPropSettings(prop));
				case NNClassifierMLP_Evaluator_VOIs.ID
					prop_default = 'NNClassifierMLP_Evaluator_VOIs ID';
				case NNClassifierMLP_Evaluator_VOIs.LABEL
					prop_default = 'NNClassifierMLP_Evaluator_VOIs label';
				case NNClassifierMLP_Evaluator_VOIs.NOTES
					prop_default = 'NNClassifierMLP_Evaluator_VOIs notes';
				case NNClassifierMLP_Evaluator_VOIs.NN
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_Evaluator_VOIs.getPropSettings(prop));
				case NNClassifierMLP_Evaluator_VOIs.PFROC
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_Evaluator_VOIs.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNClassifierMLP_Evaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator_VOIs.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator_VOIs.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator_VOIs.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_Evaluator_VOIs.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_Evaluator_VOIs.conditioning(prop, NNClassifierMLP_Evaluator_VOIs.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNE.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_Evaluator_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator_VOIs.
			%  CHECK = NNE.CHECKPROP(NNClassifierMLP_Evaluator_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator_VOIs.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator_VOIs:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator_VOIs:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_Evaluator_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator_VOIs:€BRAPH2.WRONG_INPUT€
			%  NNE.CHECKPROP(NNClassifierMLP_Evaluator_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator_VOIs:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNClassifierMLP_Evaluator_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_Evaluator_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator_VOIs.D_VOIS % __NNClassifierMLP_Evaluator_VOIs.D_VOIS__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_Evaluator_VOIs.getPropSettings(prop));
				case NNClassifierMLP_Evaluator_VOIs.TEMPLATE % __NNClassifierMLP_Evaluator_VOIs.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_Evaluator_VOIs.getPropSettings(prop));
				case NNClassifierMLP_Evaluator_VOIs.NN % __NNClassifierMLP_Evaluator_VOIs.NN__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_Evaluator_VOIs.getPropSettings(prop));
				case NNClassifierMLP_Evaluator_VOIs.PFROC % __NNClassifierMLP_Evaluator_VOIs.PFROC__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_Evaluator_VOIs.getPropSettings(prop));
				otherwise
					if prop <= NNClassifierMLP_Evaluator.getPropNumber()
						check = checkProp@NNClassifierMLP_Evaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_Evaluator_VOIs.getPropTag(prop) ' (' NNClassifierMLP_Evaluator_VOIs.getFormatTag(NNClassifierMLP_Evaluator_VOIs.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(nne, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case NNClassifierMLP_Evaluator_VOIs.PFROC % __NNClassifierMLP_Evaluator_VOIs.PFROC__
					if isa(nne.getr('PFROC'), 'NoValue')
					    nne.set('PFROC', NNClassifierMLP_EvaluatorPF_ROC_VOIs('NNE', nne));
					end
					
				otherwise
					if prop <= NNClassifierMLP_Evaluator.getPropNumber()
						postprocessing@NNClassifierMLP_Evaluator(nne, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nne, prop, varargin)
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
				case NNClassifierMLP_Evaluator_VOIs.C_MATRIX % __NNClassifierMLP_Evaluator_VOIs.C_MATRIX__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator_VOIs.C_MATRIX), 'twister')
					
					d = nne.get('D');
					d_vois = nne.get('D_VOIS');
					nn = nne.get('NN');
					predictions = cell2mat(nn.get('PREDICT', d, d_vois));
					if isempty(predictions)
					    value = [];
					else
					    [~, maxIndices] = max(predictions, [], 2);
					    predictions = logical(full(sparse(1:numel(maxIndices), maxIndices, 1, size(predictions, 1), size(predictions, 2))));
					
					    classNames = nn.get('MODEL').Layers(end).Classes;
					    for i = 1:length(predictions)
					        classified(i) = classNames(predictions(i, :));
					    end
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    value = confusionmat(classified, ground_truth);
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_Evaluator_VOIs.AUC % __NNClassifierMLP_Evaluator_VOIs.AUC__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator_VOIs.AUC), 'twister')
					
					d = nne.get('D');
					d_vois = nne.get('D_VOIS');
					nn = nne.get('NN');
					predictions = cell2mat(nne.get('NN').get('PREDICT', d, d_vois));
					if isempty(predictions)
					    value = [];
					else
					    class_names = nn.get('MODEL').Layers(end).Classes;
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    value = rocNet.AUC;
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_Evaluator_VOIs.MACRO_AUC % __NNClassifierMLP_Evaluator_VOIs.MACRO_AUC__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator_VOIs.MACRO_AUC), 'twister')
					
					auc = nne.get('AUC');
					if isempty(auc)
					    value = 0;
					else
					    value = double(mean(auc));
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= NNClassifierMLP_Evaluator.getPropNumber()
						value = calculateValue@NNClassifierMLP_Evaluator(nne, prop, varargin{:});
					else
						value = calculateValue@Element(nne, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nne, prop, varargin)
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
				case NNClassifierMLP_Evaluator_VOIs.PFROC % __NNClassifierMLP_Evaluator_VOIs.PFROC__
					pr = PanelPropItem('EL', nne, 'PROP', NNClassifierMLP_EvaluatorPF_ROC_VOIs.PFROC, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['ROC Plot'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNClassifierMLP_Evaluator(nne, prop, varargin{:});
					
			end
		end
	end
end
