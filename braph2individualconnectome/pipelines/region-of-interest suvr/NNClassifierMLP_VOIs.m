classdef NNClassifierMLP_VOIs < NNClassifierMLP
	%NNClassifierMLP_VOIs comprises a multi-layer perceptron classifier model and a given dataset with variable of interests.
	% It is a subclass of <a href="matlab:help NNClassifierMLP">NNClassifierMLP</a>.
	%
	% This is children class of NNClassifierMLP that also includes user-defined variable of interests loaded from NNDataset for classification
	%
	% The list of NNClassifierMLP_VOIs properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network multi-layer perceptron classifier.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network multi-layer perceptron classifier.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron classifier.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron classifier.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network multi-layer perceptron classifier.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron classifier.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron classifier.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
	%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
	%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model.
	%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
	%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the targets in the CB (channel-batch) format with one-hot vectors.
	%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
	%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
	%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset pair (D and D_VOIs).
	%  <strong>22</strong> <strong>TARGET_CLASSES</strong> 	TARGET_CLASSES (query, stringlist) constructs the target classes which represent the class of each data point.
	%  <strong>23</strong> <strong>LAYERS</strong> 	LAYERS (data, rvector) defines the number of layers and their neurons.
	%  <strong>24</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>25</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
	%  <strong>26</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.
	%  <strong>27</strong> <strong>VOI_SELECTION</strong> 	VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.
	%  <strong>28</strong> <strong>D_VOIS</strong> 	D_VOIs (data, item) is the voi dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
	%  <strong>29</strong> <strong>VOI_INPUT</strong> 	VOI_INPUT (query, cell) extracts VOI values based on the selection list.
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
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		VOI_SELECTION = 27; %CET: Computational Efficiency Trick
		VOI_SELECTION_TAG = 'VOI_SELECTION';
		VOI_SELECTION_CATEGORY = 3;
		VOI_SELECTION_FORMAT = 3;
		
		D_VOIS = 28; %CET: Computational Efficiency Trick
		D_VOIS_TAG = 'D_VOIS';
		D_VOIS_CATEGORY = 4;
		D_VOIS_FORMAT = 8;
		
		VOI_INPUT = 29; %CET: Computational Efficiency Trick
		VOI_INPUT_TAG = 'VOI_INPUT';
		VOI_INPUT_CATEGORY = 6;
		VOI_INPUT_FORMAT = 16;
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
			% The list of NNClassifierMLP_VOIs properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network multi-layer perceptron classifier.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network multi-layer perceptron classifier.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron classifier.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron classifier.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network multi-layer perceptron classifier.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron classifier.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron classifier.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
			%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
			%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model.
			%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
			%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the targets in the CB (channel-batch) format with one-hot vectors.
			%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
			%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
			%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset pair (D and D_VOIs).
			%  <strong>22</strong> <strong>TARGET_CLASSES</strong> 	TARGET_CLASSES (query, stringlist) constructs the target classes which represent the class of each data point.
			%  <strong>23</strong> <strong>LAYERS</strong> 	LAYERS (data, rvector) defines the number of layers and their neurons.
			%  <strong>24</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>25</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
			%  <strong>26</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.
			%  <strong>27</strong> <strong>VOI_SELECTION</strong> 	VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.
			%  <strong>28</strong> <strong>D_VOIS</strong> 	D_VOIs (data, item) is the voi dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
			%  <strong>29</strong> <strong>VOI_INPUT</strong> 	VOI_INPUT (query, cell) extracts VOI values based on the selection list.
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
			
			subclass_list = { 'NNClassifierMLP_VOIs' }; %CET: Computational Efficiency Trick
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
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 20];
				case 3 % Category.PARAMETER
					prop_list = [4 10 11 12 13 14 27];
				case 4 % Category.DATA
					prop_list = [5 9 23 28];
				case 5 % Category.RESULT
					prop_list = 15;
				case 6 % Category.QUERY
					prop_list = [8 16 17 18 21 22 26 29];
				case 9 % Category.GUI
					prop_list = [19 24 25];
				otherwise
					prop_list = [];
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
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 29;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 7;
				case 4 % Category.DATA
					prop_number = 4;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 9 % Category.GUI
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
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
			
			check = prop >= 1 && prop <= 29 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_VOIs:' 'WrongInput' '\n' ...
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
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'TARGET_CLASSES'  'LAYERS'  'WAITBAR'  'INTERRUPTIBLE'  'FEATURE_IMPORTANCE'  'VOI_SELECTION'  'D_VOIS'  'VOI_INPUT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_VOIs:' 'WrongInput' '\n' ...
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
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'TARGET_CLASSES'  'LAYERS'  'WAITBAR'  'INTERRUPTIBLE'  'FEATURE_IMPORTANCE'  'VOI_SELECTION'  'D_VOIS'  'VOI_INPUT' })); % tag = pointer %CET: Computational Efficiency Trick
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
				%CET: Computational Efficiency Trick
				nnclassifiermlp_vois_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'TARGET_CLASSES'  'LAYERS'  'WAITBAR'  'INTERRUPTIBLE'  'FEATURE_IMPORTANCE'  'VOI_SELECTION'  'D_VOIS'  'VOI_INPUT' };
				tag = nnclassifiermlp_vois_tag_list{pointer}; % prop = pointer
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
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_vois_category_list = { 1  1  1  3  4  2  2  6  4  3  3  3  3  3  5  6  6  6  9  2  6  6  4  9  9  6  3  4  6 };
			prop_category = nnclassifiermlp_vois_category_list{prop};
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
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_vois_format_list = { 2  2  2  8  2  2  2  2  8  7  11  11  5  5  17  16  16  1  4  5  16  3  12  4  11  16  3  8  16 };
			prop_format = nnclassifiermlp_vois_format_list{prop};
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
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_vois_description_list = { 'ELCLASS (constant, string) is the class of the neural network multi-layer perceptron classifier.'  'NAME (constant, string) is the name of the neural network multi-layer perceptron classifier.'  'DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron classifier.'  'TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron classifier.'  'ID (data, string) is a few-letter code for the neural network multi-layer perceptron classifier.'  'LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron classifier.'  'NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron classifier.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.'  'DP_CLASSES (parameter, classlist) is the list of compatible data points.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'MODEL (result, net) is a trained neural network model.'  'INPUTS (query, cell) constructs the data in the CB (channel-batch) format.'  'TARGETS (query, cell) constructs the targets in the CB (channel-batch) format with one-hot vectors.'  'TRAIN (query, empty) trains the neural network model with the given dataset.'  'VERBOSE (gui, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset pair (D and D_VOIs).'  'TARGET_CLASSES (query, stringlist) constructs the target classes which represent the class of each data point.'  'LAYERS (data, rvector) defines the number of layers and their neurons.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.'  'FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.'  'VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.'  'D_VOIs (data, item) is the voi dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.'  'VOI_INPUT (query, cell) extracts VOI values based on the selection list.' };
			prop_description = nnclassifiermlp_vois_description_list{prop};
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
			
			switch prop %CET: Computational Efficiency Trick
				case 27 % NNClassifierMLP_VOIs.VOI_SELECTION
					prop_settings = Format.getFormatSettings(3);
				case 28 % NNClassifierMLP_VOIs.D_VOIS
					prop_settings = 'NNDataset';
				case 29 % NNClassifierMLP_VOIs.VOI_INPUT
					prop_settings = Format.getFormatSettings(16);
				case 4 % NNClassifierMLP_VOIs.TEMPLATE
					prop_settings = 'NNClassifierMLP_VOIs';
				case 9 % NNClassifierMLP_VOIs.D
					prop_settings = 'NNDataset';
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
			
			switch prop %CET: Computational Efficiency Trick
				case 27 % NNClassifierMLP_VOIs.VOI_SELECTION
					prop_default = {'Age', 'Sex','Education'}; % Example: Default selected VOIs;
				case 28 % NNClassifierMLP_VOIs.D_VOIS
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_VOIs.getPropSettings(prop));
				case 29 % NNClassifierMLP_VOIs.VOI_INPUT
					prop_default = Format.getFormatDefault(16, NNClassifierMLP_VOIs.getPropSettings(prop));
				case 1 % NNClassifierMLP_VOIs.ELCLASS
					prop_default = 'NNClassifierMLP_VOIs';
				case 2 % NNClassifierMLP_VOIs.NAME
					prop_default = 'Neural Network Multi-layer Perceptron Classifier with Variables of interests';
				case 3 % NNClassifierMLP_VOIs.DESCRIPTION
					prop_default = 'A neural network multi-layer perceptron classifier (NNClassifierMLP) comprises a multi-layer perceptron classifier model and a given dataset. NNClassifierMLP trains the multi-layer perceptron classifier with a formatted inputs ("CB", channel and batch) derived from the given dataset.';
				case 4 % NNClassifierMLP_VOIs.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_VOIs.getPropSettings(prop));
				case 5 % NNClassifierMLP_VOIs.ID
					prop_default = 'NNClassifierMLP_VOIs ID';
				case 6 % NNClassifierMLP_VOIs.LABEL
					prop_default = 'NNClassifierMLP_VOIs label';
				case 7 % NNClassifierMLP_VOIs.NOTES
					prop_default = 'NNClassifierMLP_VOIs notes';
				case 9 % NNClassifierMLP_VOIs.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint_CON_CLA');
				case 10 % NNClassifierMLP_VOIs.DP_CLASSES
					prop_default = {'NNDataPoint_CON_CLA' 'NNDataPoint_CON_FUN_MP_CLA' 'NNDataPoint_FUN_CLA' 'NNDataPoint_ST_CLA' 'NNDataPoint_ST_MM_CLA' 'NNDataPoint_Graph_CLA' 'NNDataPoint_Measure_CLA' 'NNDataPoint_VOIs'};
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
			%  Error id: BRAPH2:NNClassifierMLP_VOIs:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NN.
			%   Error id: BRAPH2:NNClassifierMLP_VOIs:WrongInput
			%  Element.CHECKPROP(NNClassifierMLP_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_VOIs.
			%   Error id: BRAPH2:NNClassifierMLP_VOIs:WrongInput
			%  NN.CHECKPROP(NNClassifierMLP_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_VOIs.
			%   Error id: BRAPH2:NNClassifierMLP_VOIs:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NN) and Element.CHECKPROP('NNClassifierMLP_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_VOIs.getPropProp(pointer);
			
			switch prop
				case 27 % NNClassifierMLP_VOIs.VOI_SELECTION
					check = Format.checkFormat(3, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				case 28 % NNClassifierMLP_VOIs.D_VOIS
					check = Format.checkFormat(8, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				case 29 % NNClassifierMLP_VOIs.VOI_INPUT
					check = Format.checkFormat(16, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				case 4 % NNClassifierMLP_VOIs.TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				case 9 % NNClassifierMLP_VOIs.D
					check = Format.checkFormat(8, value, NNClassifierMLP_VOIs.getPropSettings(prop));
				otherwise
					if prop <= 26
						check = checkProp@NNClassifierMLP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_VOIs:' 'WrongInput' '\n' ...
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
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 29 % NNClassifierMLP_VOIs.VOI_INPUT
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
					
				case 15 % NNClassifierMLP_VOIs.MODEL
					rng_settings_ = rng(); rng(nn.getPropSeed(15), 'twister')
					
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
					
				case 21 % NNClassifierMLP_VOIs.PREDICT
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
					if prop <= 26
						value = calculateValue@NNClassifierMLP(nn, prop, varargin{:});
					else
						value = calculateValue@Element(nn, prop, varargin{:});
					end
			end
			
		end
	end
end
