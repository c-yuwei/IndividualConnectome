classdef NNClassifierMLP_VOIs < NNClassifierMLP
	%NNClassifierMLP_VOIs comprises a multi-layer perceptron classifier model and a given dataset with variable of interests.
	% It is a subclass of <a href="matlab:help NNClassifierMLP">NNClassifierMLP</a>.
	%
	% This is children class of NNClassifierMLP that also includes user-defined variable of interests loaded from NNDataset for classification
	%
	% NNClassifierMLP_VOIs methods (constructor):
	%  NNClassifierMLP_VOIs - constructor
	%
	% NNClassifierMLP_VOIs methods:
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
	% NNClassifierMLP_VOIs methods (display):
	%  tostring - string with information about the multi-layer perceptron classifier with vois
	%  disp - displays information about the multi-layer perceptron classifier with vois
	%  tree - displays the tree of the multi-layer perceptron classifier with vois
	%
	% NNClassifierMLP_VOIs methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multi-layer perceptron classifier with vois are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multi-layer perceptron classifier with vois
	%
	% NNClassifierMLP_VOIs methods (save/load, Static):
	%  save - saves BRAPH2 multi-layer perceptron classifier with vois as b2 file
	%  load - loads a BRAPH2 multi-layer perceptron classifier with vois from a b2 file
	%
	% NNClassifierMLP_VOIs method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multi-layer perceptron classifier with vois
	%
	% NNClassifierMLP_VOIs method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multi-layer perceptron classifier with vois
	%
	% NNClassifierMLP_VOIs methods (inspection, Static):
	%  getClass - returns the class of the multi-layer perceptron classifier with vois
	%  getSubclasses - returns all subclasses of NNClassifierMLP_VOIs
	%  getProps - returns the property list of the multi-layer perceptron classifier with vois
	%  getPropNumber - returns the property number of the multi-layer perceptron classifier with vois
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
	% NNClassifierMLP_VOIs methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_VOIs methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_VOIs methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_VOIs methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_VOIs; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_VOIs constants</a>.
	%
	%
	% See also NNDataPoint_CON_CLA, NNClassifier_Evaluator_VOIs.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		VOI_SELECTION = NNClassifierMLP.getPropNumber() + 1;
		VOI_SELECTION_TAG = 'VOI_SELECTION';
		VOI_SELECTION_CATEGORY = Category.PARAMETER;
		VOI_SELECTION_FORMAT = Format.STRINGLIST;
		
		D_VOIS = NNClassifierMLP.getPropNumber() + 2;
		D_VOIS_TAG = 'D_VOIS';
		D_VOIS_CATEGORY = Category.DATA;
		D_VOIS_FORMAT = Format.ITEM;
		
		VOI_INPUT = NNClassifierMLP.getPropNumber() + 3;
		VOI_INPUT_TAG = 'VOI_INPUT';
		VOI_INPUT_CATEGORY = Category.QUERY;
		VOI_INPUT_FORMAT = Format.CELL;
	end
	methods % constructor
		function nn = NNClassifierMLP_VOIs(varargin)
			%NNClassifierMLP_VOIs() creates a multi-layer perceptron classifier with vois.
			%
			% NNClassifierMLP_VOIs(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_VOIs(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nn = nn@NNClassifierMLP(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the multi-layer perceptron classifier with vois.
			%
			% BUILD = NNClassifierMLP_VOIs.GETBUILD() returns the build of 'NNClassifierMLP_VOIs'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NN.GETBUILD() returns the build of the multi-layer perceptron classifier with vois NN.
			%  BUILD = Element.GETBUILD(NN) returns the build of 'NN'.
			%  BUILD = Element.GETBUILD('NNClassifierMLP_VOIs') returns the build of 'NNClassifierMLP_VOIs'.
			%
			% Note that the Element.GETBUILD(NN) and Element.GETBUILD('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nn_class = getClass()
			%GETCLASS returns the class of the multi-layer perceptron classifier with vois.
			%
			% CLASS = NNClassifierMLP_VOIs.GETCLASS() returns the class 'NNClassifierMLP_VOIs'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NN.GETCLASS() returns the class of the multi-layer perceptron classifier with vois NN.
			%  CLASS = Element.GETCLASS(NN) returns the class of 'NN'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_VOIs') returns 'NNClassifierMLP_VOIs'.
			%
			% Note that the Element.GETCLASS(NN) and Element.GETCLASS('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			
			nn_class = 'NNClassifierMLP_VOIs';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multi-layer perceptron classifier with vois.
			%
			% LIST = NNClassifierMLP_VOIs.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_VOIs'.
			%
			% Alternative forms to call this method are:
			%  LIST = NN.GETSUBCLASSES() returns all subclasses of the multi-layer perceptron classifier with vois NN.
			%  LIST = Element.GETSUBCLASSES(NN) returns all subclasses of 'NN'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_VOIs') returns all subclasses of 'NNClassifierMLP_VOIs'.
			%
			% Note that the Element.GETSUBCLASSES(NN) and Element.GETSUBCLASSES('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_VOIs', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multi-layer perceptron classifier with vois.
			%
			% PROPS = NNClassifierMLP_VOIs.GETPROPS() returns the property list of multi-layer perceptron classifier with vois
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_VOIs.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NN.GETPROPS([CATEGORY]) returns the property list of the multi-layer perceptron classifier with vois NN.
			%  PROPS = Element.GETPROPS(NN[, CATEGORY]) returns the property list of 'NN'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_VOIs'[, CATEGORY]) returns the property list of 'NNClassifierMLP_VOIs'.
			%
			% Note that the Element.GETPROPS(NN) and Element.GETPROPS('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNClassifierMLP.getProps() ...
						NNClassifierMLP_VOIs.VOI_SELECTION ...
						NNClassifierMLP_VOIs.D_VOIS ...
						NNClassifierMLP_VOIs.VOI_INPUT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.PARAMETER) ...
						NNClassifierMLP_VOIs.VOI_SELECTION ...
						];
				case Category.DATA
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.DATA) ...
						NNClassifierMLP_VOIs.D_VOIS ...
						];
				case Category.RESULT
					prop_list = [
						NNClassifierMLP.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.QUERY) ...
						NNClassifierMLP_VOIs.VOI_INPUT ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNClassifierMLP.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multi-layer perceptron classifier with vois.
			%
			% N = NNClassifierMLP_VOIs.GETPROPNUMBER() returns the property number of multi-layer perceptron classifier with vois.
			%
			% N = NNClassifierMLP_VOIs.GETPROPNUMBER(CATEGORY) returns the property number of multi-layer perceptron classifier with vois
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NN.GETPROPNUMBER([CATEGORY]) returns the property number of the multi-layer perceptron classifier with vois NN.
			%  N = Element.GETPROPNUMBER(NN) returns the property number of 'NN'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_VOIs') returns the property number of 'NNClassifierMLP_VOIs'.
			%
			% Note that the Element.GETPROPNUMBER(NN) and Element.GETPROPNUMBER('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_VOIs.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multi-layer perceptron classifier with vois/error.
			%
			% CHECK = NNClassifierMLP_VOIs.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSPROP(PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NN, PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_VOIs, PROP) checks whether PROP exists for NNClassifierMLP_VOIs.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSPROP(PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%  Element.EXISTSPROP(NN, PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_VOIs, PROP) throws error if PROP does NOT exist for NNClassifierMLP_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NN) and Element.EXISTSPROP('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_VOIs.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_VOIs.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multi-layer perceptron classifier with vois/error.
			%
			% CHECK = NNClassifierMLP_VOIs.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSTAG(TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NN, TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_VOIs, TAG) checks whether TAG exists for NNClassifierMLP_VOIs.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSTAG(TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%  Element.EXISTSTAG(NN, TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_VOIs, TAG) throws error if TAG does NOT exist for NNClassifierMLP_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NN) and Element.EXISTSTAG('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_vois_tag_list = cellfun(@(x) NNClassifierMLP_VOIs.getPropTag(x), num2cell(NNClassifierMLP_VOIs.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_vois_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_VOIs.'] ...
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
			%  PROPERTY = NN.GETPROPPROP(POINTER) returns property number of POINTER of NN.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_VOIs.
			%  PROPERTY = NN.GETPROPPROP(NNClassifierMLP_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPPROP(NN) and Element.GETPROPPROP('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_vois_tag_list = cellfun(@(x) NNClassifierMLP_VOIs.getPropTag(x), num2cell(NNClassifierMLP_VOIs.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_vois_tag_list)); % tag = pointer
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
			%  TAG = NN.GETPROPTAG(POINTER) returns tag of POINTER of NN.
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_VOIs.
			%  TAG = NN.GETPROPTAG(NNClassifierMLP_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPTAG(NN) and Element.GETPROPTAG('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_VOIs.VOI_SELECTION
						tag = NNClassifierMLP_VOIs.VOI_SELECTION_TAG;
					case NNClassifierMLP_VOIs.D_VOIS
						tag = NNClassifierMLP_VOIs.D_VOIS_TAG;
					case NNClassifierMLP_VOIs.VOI_INPUT
						tag = NNClassifierMLP_VOIs.VOI_INPUT_TAG;
					otherwise
						tag = getPropTag@NNClassifierMLP(prop);
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
			%  CATEGORY = NN.GETPROPCATEGORY(POINTER) returns category of POINTER of NN.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_VOIs.
			%  CATEGORY = NN.GETPROPCATEGORY(NNClassifierMLP_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPCATEGORY(NN) and Element.GETPROPCATEGORY('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_VOIs.VOI_SELECTION
					prop_category = NNClassifierMLP_VOIs.VOI_SELECTION_CATEGORY;
				case NNClassifierMLP_VOIs.D_VOIS
					prop_category = NNClassifierMLP_VOIs.D_VOIS_CATEGORY;
				case NNClassifierMLP_VOIs.VOI_INPUT
					prop_category = NNClassifierMLP_VOIs.VOI_INPUT_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNClassifierMLP(prop);
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
			%  FORMAT = NN.GETPROPFORMAT(POINTER) returns format of POINTER of NN.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_VOIs.
			%  FORMAT = NN.GETPROPFORMAT(NNClassifierMLP_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPFORMAT(NN) and Element.GETPROPFORMAT('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_VOIs.VOI_SELECTION
					prop_format = NNClassifierMLP_VOIs.VOI_SELECTION_FORMAT;
				case NNClassifierMLP_VOIs.D_VOIS
					prop_format = NNClassifierMLP_VOIs.D_VOIS_FORMAT;
				case NNClassifierMLP_VOIs.VOI_INPUT
					prop_format = NNClassifierMLP_VOIs.VOI_INPUT_FORMAT;
				otherwise
					prop_format = getPropFormat@NNClassifierMLP(prop);
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
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_VOIs.
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(NNClassifierMLP_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPDESCRIPTION(NN) and Element.GETPROPDESCRIPTION('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_VOIs.VOI_SELECTION
					prop_description = 'VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.';
				case NNClassifierMLP_VOIs.D_VOIS
					prop_description = 'D_VOIS (data, item) is the voi dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.';
				case NNClassifierMLP_VOIs.VOI_INPUT
					prop_description = 'VOI_INPUT (query, cell) extracts VOI values based on the selection list.';
				case NNClassifierMLP_VOIs.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the neural network multi-layer perceptron classifier.';
				case NNClassifierMLP_VOIs.NAME
					prop_description = 'NAME (constant, string) is the name of the neural network multi-layer perceptron classifier.';
				case NNClassifierMLP_VOIs.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron classifier.';
				case NNClassifierMLP_VOIs.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron classifier with VOI.';
				case NNClassifierMLP_VOIs.ID
					prop_description = 'ID (data, string) is a few-letter code for the neural network multi-layer perceptron classifier.';
				case NNClassifierMLP_VOIs.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron classifier.';
				case NNClassifierMLP_VOIs.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron classifier.';
				case NNClassifierMLP_VOIs.DP_CLASSES
					prop_description = 'DP_CLASSES (parameter, classlist) is the list of compatible data points.';
				case NNClassifierMLP_VOIs.MODEL
					prop_description = 'MODEL (result, net) is a trained neural network model.';
				case NNClassifierMLP_VOIs.PREDICT
					prop_description = 'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset pair (D and D_VOIs).';
				otherwise
					prop_description = getPropDescription@NNClassifierMLP(prop);
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
			%  SETTINGS = NN.GETPROPSETTINGS(POINTER) returns settings of POINTER of NN.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_VOIs.
			%  SETTINGS = NN.GETPROPSETTINGS(NNClassifierMLP_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPSETTINGS(NN) and Element.GETPROPSETTINGS('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_VOIs.VOI_SELECTION
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_VOIs.D_VOIS
					prop_settings = 'NNDataset';
				case NNClassifierMLP_VOIs.VOI_INPUT
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierMLP_VOIs.TEMPLATE
					prop_settings = 'NNClassifierMLP_VOIs';
				otherwise
					prop_settings = getPropSettings@NNClassifierMLP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_VOIs.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_VOIs.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_VOIs.
			%  DEFAULT = NN.GETPROPDEFAULT(NNClassifierMLP_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPDEFAULT(NN) and Element.GETPROPDEFAULT('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_VOIs.VOI_SELECTION
					prop_default = {'Age', 'Sex','Education'};
				case NNClassifierMLP_VOIs.D_VOIS
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint_VOIs');
				case NNClassifierMLP_VOIs.VOI_INPUT
					prop_default = Format.getFormatDefault(Format.CELL, NNClassifierMLP_VOIs.getPropSettings(prop));
				case NNClassifierMLP_VOIs.ELCLASS
					prop_default = 'NNClassifierMLP_VOIs';
				case NNClassifierMLP_VOIs.NAME
					prop_default = 'Neural Network Multi-layer Perceptron Classifier with Variables of interests';
				case NNClassifierMLP_VOIs.DESCRIPTION
					prop_default = 'A neural network multi-layer perceptron classifier (NNClassifierMLP) comprises a multi-layer perceptron classifier model and a given dataset. NNClassifierMLP trains the multi-layer perceptron classifier with a formatted inputs ("CB", channel and batch) derived from the given dataset.';
				case NNClassifierMLP_VOIs.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_VOIs.getPropSettings(prop));
				case NNClassifierMLP_VOIs.ID
					prop_default = 'NNClassifierMLP_VOIs ID';
				case NNClassifierMLP_VOIs.LABEL
					prop_default = 'NNClassifierMLP_VOIs label';
				case NNClassifierMLP_VOIs.NOTES
					prop_default = 'NNClassifierMLP_VOIs notes';
				case NNClassifierMLP_VOIs.DP_CLASSES
					prop_default = {'NNDataPoint_CON_CLA' 'NNDataPoint_FUN_CLA' 'NNDataPoint_ST_CLA' 'NNDataPoint_Graph_CLA' 'NNDataPoint_Measure_CLA' 'NNDataPoint_VOIs'};
				otherwise
					prop_default = getPropDefault@NNClassifierMLP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_VOIs.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_VOIs.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_VOIs.
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_VOIs.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NN) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_VOIs.conditioning(prop, NNClassifierMLP_VOIs.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NN.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_VOIs.
			%  CHECK = NN.CHECKPROP(NNClassifierMLP_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_VOIs.
			% 
			% NN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_VOIs:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NN.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_VOIs:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_VOIs:€BRAPH2.WRONG_INPUT€
			%  NN.CHECKPROP(NNClassifierMLP_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_VOIs:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NN) and Element.CHECKPROP('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_VOIs.VOI_SELECTION % __NNClassifierMLP_VOIs.VOI_SELECTION__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				case NNClassifierMLP_VOIs.D_VOIS % __NNClassifierMLP_VOIs.D_VOIS__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				case NNClassifierMLP_VOIs.VOI_INPUT % __NNClassifierMLP_VOIs.VOI_INPUT__
					check = Format.checkFormat(Format.CELL, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				case NNClassifierMLP_VOIs.TEMPLATE % __NNClassifierMLP_VOIs.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				otherwise
					if prop <= NNClassifierMLP.getPropNumber()
						check = checkProp@NNClassifierMLP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_VOIs.getPropTag(prop) ' (' NNClassifierMLP_VOIs.getFormatTag(NNClassifierMLP_VOIs.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nn, prop, varargin)
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
				case NNClassifierMLP_VOIs.VOI_INPUT % __NNClassifierMLP_VOIs.VOI_INPUT__
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					dp_dict = d.get('DP_DICT');
					it_list = dp_dict.get('IT_LIST');
					num_subjects = length(it_list);
					selected_vois = nn.get('VOI_SELECTION'); % Get user-defined VOI list
					voi_data = zeros(num_subjects, length(selected_vois)); % Preallocate as a numerical matrix
					
					for subj_idx = 1:num_subjects
					    sub = it_list{subj_idx}; % Get subject data
					    voi_dict = sub.get('VOI_DICT');
					    
					    selected_values = nan(1, length(selected_vois)); % Initialize with NaNs to handle missing VOIs
					    
					    for voi_idx = 1:voi_dict.get('LENGTH')
					        voi = voi_dict.get('IT', voi_idx);
					        voi_id = voi.get('ID'); % Extract VOI ID
					        
					        % If the VOI ID is in the selected list, store its value
					        match_idx = find(strcmp(selected_vois, voi_id), 1);
					        if ~isempty(match_idx)
					            selected_values(match_idx) = voi.get('V'); % Assign value to the corresponding column
					        end
					    end
					    
					    voi_data(subj_idx, :) = selected_values; % Store extracted VOI values
					end
					
					value = {voi_data};
					
				case NNClassifierMLP_VOIs.MODEL % __NNClassifierMLP_VOIs.MODEL__
					rng_settings_ = rng(); rng(nn.getPropSeed(NNClassifierMLP_VOIs.MODEL), 'twister')
					
					inputs = cell2mat(nn.get('INPUTS', nn.get('D')));
					targets = nn.get('TARGET_CLASSES', nn.get('D'));
					voi_data = cell2mat(nn.get('VOI_INPUT',nn.get('D_VOIS')));
					
					if isempty(inputs) || isempty(targets)
					    value = network();
					else
					    number_features = size(inputs, 2);
					    number_vois = size(voi_data, 2); % Number of additional VOIs
					    number_classes = numel(categories(categorical(targets)));
					    targets = categorical(targets);
					    % Define the primary feature input
					    feature_input = featureInputLayer(number_features, 'Name', 'Feature_Input');
					    
					    % Define VOI input
					    voi_input = featureInputLayer(number_vois, 'Name', 'VOI_Input');
					    
					    % Retrieve user-defined layer settings
					    layers = nn.get('LAYERS');
					    nn_architecture = [feature_input];
					    
					    for i = 1:length(layers)
					        nn_architecture = [nn_architecture
					            fullyConnectedLayer(layers(i), 'Name', ['Dense_' num2str(i)])
					            batchNormalizationLayer('Name', ['BatchNormalization_' num2str(i)])
					            dropoutLayer(0.5, 'Name', ['Dropout_' num2str(i)])
					            reluLayer('Name', ['ReLU_' num2str(i)])
					        ];
					    end
					    
					    % Concatenation layer
					    concatenation_layer = concatenationLayer(1, 2, 'Name', 'Concat');
					    
					    % Final classification layers after concatenation
					    classification_layers = [
					        fullyConnectedLayer(number_classes, 'Name', 'Dense_output')
					        softmaxLayer('Name', 'Softmax')
					        classificationLayer('Name', 'Output')
					    ];
					    
					    % Convert to layerGraph for proper connections
					    nn_architecture = layerGraph(nn_architecture);
					    nn_architecture = addLayers(nn_architecture, voi_input);
					    nn_architecture = addLayers(nn_architecture, concatenation_layer);
					    nn_architecture = addLayers(nn_architecture, classification_layers);
					    
					    % Connect layers properly
					    nn_architecture = connectLayers(nn_architecture, ['ReLU_' num2str(length(layers))], 'Concat/in1'); % Features -> Concat
					    nn_architecture = connectLayers(nn_architecture, 'VOI_Input', 'Concat/in2'); % VOI Input -> Concat
					    nn_architecture = connectLayers(nn_architecture, 'Concat', 'Dense_output'); % Concat -> Final classification
					
					    % Specify training options
					    options = trainingOptions(nn.get('SOLVER'), ...
					        'MiniBatchSize', nn.get('BATCH'), ...
					        'MaxEpochs', nn.get('EPOCHS'), ...
					        'Shuffle', nn.get('SHUFFLE'), ...
					        'Plots', nn.get('PLOT_TRAINING'), ...
					        'Verbose', nn.get('VERBOSE'));
					
					    % Create ArrayDatastore for each input
					    dsFeatures = arrayDatastore(inputs, 'IterationDimension', 1);
					    dsVOI      = arrayDatastore(voi_data, 'IterationDimension', 1);
					    dsTargets  = arrayDatastore(targets, 'IterationDimension', 1);
					
					    % Combine the two datastores
					    combinedDS = combine(dsFeatures, dsVOI, dsTargets);
					    combinedTrainDS = transform(combinedDS, @(data) {data{1}', data{2}', data{3}});
					
					    % Train the neural network
					    value = trainNetwork(combinedTrainDS, nn_architecture, options);
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_VOIs.PREDICT % __NNClassifierMLP_VOIs.PREDICT__
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1}; % Primary dataset
					d_vois = varargin{2}; % VOI dataset
					inputs = cell2mat(nn.get('INPUTS', d));
					voi_data = cell2mat(nn.get('VOI_INPUT', d_vois));
					if isempty(inputs) || isempty(voi_data)
					    value = {};
					else
					    dsFeatures = arrayDatastore(inputs, 'IterationDimension', 1);
					    dsVOI = arrayDatastore(voi_data, 'IterationDimension', 1);
					    combinedDS = combine(dsFeatures, dsVOI);
					    combinedPredDS = transform(combinedDS, @(data) {data{1}', data{2}'});
					    net = nn.get('MODEL');
					    value = {net.predict(combinedPredDS)};
					end
					
				otherwise
					if prop <= NNClassifierMLP.getPropNumber()
						value = calculateValue@NNClassifierMLP(nn, prop, varargin{:});
					else
						value = calculateValue@Element(nn, prop, varargin{:});
					end
			end
			
		end
	end
end
