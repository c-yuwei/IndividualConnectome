classdef NNClassifierMLP_EvaluatorPF_ROC_VOIs < NNClassifierMLP_EvaluatorPF_ROC
	%NNClassifierMLP_EvaluatorPF_ROC_VOIs plots a panel of receiver operating characteristic curves for dual-input MLP classifier with VOIs.
	% It is a subclass of <a href="matlab:help NNClassifierMLP_EvaluatorPF_ROC">NNClassifierMLP_EvaluatorPF_ROC</a>.
	%
	% The receiver operating characteristic panel for an evaluator of MLP classifier with variables of interest (NNClassifierMLP_EvaluatorPF_ROC_VOIs) manages the functionalities to plot a panel of receiver operating characteristic curves for an NNClassifierMLP_VOIs classifier, using both a primary dataset (D) and a VOI dataset (D_VOIs).
	%
	% The list of NNClassifierMLP_EvaluatorPF_ROC_VOIs properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ROC panel for an evaluator of MLP classifier with VOIs.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ROC panel for an evaluator of MLP classifier with VOIs.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ROC panel for an evaluator of MLP classifier with VOIs.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ROC panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ROC panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ROC panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ROC panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the receiver operating characteristic figure.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
	%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
	%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
	%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
	%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
	%  <strong>26</strong> <strong>NNE</strong> 	NNE (metadata, item) is the neural network evaluator with VOIs support.
	%  <strong>27</strong> <strong>CLASSNAMES</strong> 	CLASSNAMES (metadata, stringlist) is the class names.
	%  <strong>28</strong> <strong>X_VALUES</strong> 	X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves using D and D_VOIs.
	%  <strong>29</strong> <strong>Y_VALUES</strong> 	Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves using D and D_VOIs.
	%  <strong>30</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the the receiver operating characteristic values and initializes the receiver operating characteristic figure.
	%  <strong>31</strong> <strong>H_ROC</strong> 	H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.
	%  <strong>32</strong> <strong>ROC</strong> 	ROC (figure, logical) determines whether the ROC plots are shown.
	%  <strong>33</strong> <strong>ROC_DICT</strong> 	ROC_DICT (figure, idict) contains the ROC plot for each class.
	%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
	%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
	%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
	%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
	%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
	%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (constructor):
	%  NNClassifierMLP_EvaluatorPF_ROC_VOIs - constructor
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods:
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
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (display):
	%  tostring - string with information about the panel receiver operating characteristic figure for VOIs
	%  disp - displays information about the panel receiver operating characteristic figure for VOIs
	%  tree - displays the tree of the panel receiver operating characteristic figure for VOIs
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel receiver operating characteristic figure for VOIs are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel receiver operating characteristic figure for VOIs
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (save/load, Static):
	%  save - saves BRAPH2 panel receiver operating characteristic figure for VOIs as b2 file
	%  load - loads a BRAPH2 panel receiver operating characteristic figure for VOIs from a b2 file
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel receiver operating characteristic figure for VOIs
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel receiver operating characteristic figure for VOIs
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (inspection, Static):
	%  getClass - returns the class of the panel receiver operating characteristic figure for VOIs
	%  getSubclasses - returns all subclasses of NNClassifierMLP_EvaluatorPF_ROC_VOIs
	%  getProps - returns the property list of the panel receiver operating characteristic figure for VOIs
	%  getPropNumber - returns the property number of the panel receiver operating characteristic figure for VOIs
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
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_EvaluatorPF_ROC_VOIs methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_EvaluatorPF_ROC_VOIs; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_EvaluatorPF_ROC_VOIs constants</a>.
	%
	%
	% See also NNClassifierMLP_Evaluator_VOIs, NNClassifierMLP_VOIs.
	%
	% BUILD BRAPH2 7 class_name 1
	
	methods % constructor
		function pf = NNClassifierMLP_EvaluatorPF_ROC_VOIs(varargin)
			%NNClassifierMLP_EvaluatorPF_ROC_VOIs() creates a panel receiver operating characteristic figure for VOIs.
			%
			% NNClassifierMLP_EvaluatorPF_ROC_VOIs(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_EvaluatorPF_ROC_VOIs(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierMLP_EvaluatorPF_ROC_VOIs properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ROC panel for an evaluator of MLP classifier with VOIs.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ROC panel for an evaluator of MLP classifier with VOIs.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ROC panel for an evaluator of MLP classifier with VOIs.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ROC panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ROC panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ROC panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ROC panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the receiver operating characteristic figure.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
			%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
			%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
			%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
			%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
			%  <strong>26</strong> <strong>NNE</strong> 	NNE (metadata, item) is the neural network evaluator with VOIs support.
			%  <strong>27</strong> <strong>CLASSNAMES</strong> 	CLASSNAMES (metadata, stringlist) is the class names.
			%  <strong>28</strong> <strong>X_VALUES</strong> 	X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves using D and D_VOIs.
			%  <strong>29</strong> <strong>Y_VALUES</strong> 	Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves using D and D_VOIs.
			%  <strong>30</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the the receiver operating characteristic values and initializes the receiver operating characteristic figure.
			%  <strong>31</strong> <strong>H_ROC</strong> 	H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.
			%  <strong>32</strong> <strong>ROC</strong> 	ROC (figure, logical) determines whether the ROC plots are shown.
			%  <strong>33</strong> <strong>ROC_DICT</strong> 	ROC_DICT (figure, idict) contains the ROC plot for each class.
			%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
			%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
			%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
			%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
			%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
			%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
			%
			% See also Category, Format.
			
			pf = pf@NNClassifierMLP_EvaluatorPF_ROC(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel receiver operating characteristic figure for VOIs.
			%
			% BUILD = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETBUILD() returns the build of 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel receiver operating characteristic figure for VOIs PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('NNClassifierMLP_EvaluatorPF_ROC_VOIs') returns the build of 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel receiver operating characteristic figure for VOIs.
			%
			% CLASS = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETCLASS() returns the class 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel receiver operating characteristic figure for VOIs PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_EvaluatorPF_ROC_VOIs') returns 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			
			pf_class = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel receiver operating characteristic figure for VOIs.
			%
			% LIST = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel receiver operating characteristic figure for VOIs PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_EvaluatorPF_ROC_VOIs') returns all subclasses of 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNClassifierMLP_EvaluatorPF_ROC_VOIs' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel receiver operating characteristic figure for VOIs.
			%
			% PROPS = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPS() returns the property list of panel receiver operating characteristic figure for VOIs
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel receiver operating characteristic figure for VOIs PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_EvaluatorPF_ROC_VOIs'[, CATEGORY]) returns the property list of 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 26 27 28 29];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 30];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 25 31 34 36 38];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 32 33 35 37 39];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel receiver operating characteristic figure for VOIs.
			%
			% N = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPNUMBER() returns the property number of panel receiver operating characteristic figure for VOIs.
			%
			% N = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPNUMBER(CATEGORY) returns the property number of panel receiver operating characteristic figure for VOIs
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel receiver operating characteristic figure for VOIs PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_EvaluatorPF_ROC_VOIs') returns the property number of 'NNClassifierMLP_EvaluatorPF_ROC_VOIs'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 39;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 6;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 10;
				case 8 % Category.FIGURE
					prop_number = 8;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel receiver operating characteristic figure for VOIs/error.
			%
			% CHECK = NNClassifierMLP_EvaluatorPF_ROC_VOIs.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP) checks whether PROP exists for NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP) throws error if PROP does NOT exist for NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_EvaluatorPF_ROC_VOIs.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel receiver operating characteristic figure for VOIs/error.
			%
			% CHECK = NNClassifierMLP_EvaluatorPF_ROC_VOIs.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_EvaluatorPF_ROC_VOIs, TAG) checks whether TAG exists for NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_EvaluatorPF_ROC_VOIs, TAG) throws error if TAG does NOT exist for NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'CLASSNAMES'  'X_VALUES'  'Y_VALUES'  'SETUP'  'H_ROC'  'ROC'  'ROC_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_EvaluatorPF_ROC_VOIs.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  PROPERTY = PF.GETPROPPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns property number of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'CLASSNAMES'  'X_VALUES'  'Y_VALUES'  'SETUP'  'H_ROC'  'ROC'  'ROC_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  TAG = PF.GETPROPTAG(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns tag of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnclassifiermlp_evaluatorpf_roc_vois_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'CLASSNAMES'  'X_VALUES'  'Y_VALUES'  'SETUP'  'H_ROC'  'ROC'  'ROC_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' };
				tag = nnclassifiermlp_evaluatorpf_roc_vois_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  CATEGORY = PF.GETPROPCATEGORY(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluatorpf_roc_vois_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  2  2  2  6  7  8  8  7  8  7  8  7  8 };
			prop_category = nnclassifiermlp_evaluatorpf_roc_vois_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  FORMAT = PF.GETPROPFORMAT(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluatorpf_roc_vois_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  3  14  14  1  19  4  10  18  8  18  8  18  8 };
			prop_format = nnclassifiermlp_evaluatorpf_roc_vois_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluatorpf_roc_vois_description_list = { 'ELCLASS (constant, string) is the class of the ROC panel for an evaluator of MLP classifier with VOIs.'  'NAME (constant, string) is the name of the ROC panel for an evaluator of MLP classifier with VOIs.'  'DESCRIPTION (constant, string) is the description of the ROC panel for an evaluator of MLP classifier with VOIs.'  'TEMPLATE (parameter, item) is the template of the ROC panel.'  'ID (data, string) is a few-letter code for the ROC panel.'  'LABEL (metadata, string) is an extended label of the ROC panel.'  'NOTES (metadata, string) are some specific notes about the ROC panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the receiver operating characteristic figure.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'NNE (metadata, item) is the neural network evaluator with VOIs support.'  'CLASSNAMES (metadata, stringlist) is the class names.'  'X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves using D and D_VOIs.'  'Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves using D and D_VOIs.'  'SETUP (query, empty) calculates the the receiver operating characteristic values and initializes the receiver operating characteristic figure.'  'H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.'  'ROC (figure, logical) determines whether the ROC plots are shown.'  'ROC_DICT (figure, idict) contains the ROC plot for each class.'  'H_TITLE (evanescent, handle) is the axis title.'  'ST_TITLE (figure, item) determines the title settings.'  'H_XLABEL (evanescent, handle) is the axis x-label.'  'ST_XLABEL (figure, item) determines the x-label settings.'  'H_YLABEL (evanescent, handle) is the axis y-label.'  'ST_YLABEL (figure, item) determines the y-label settings.' };
			prop_description = nnclassifiermlp_evaluatorpf_roc_vois_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  SETTINGS = PF.GETPROPSETTINGS(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE
					prop_settings = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs';
				case 26 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE
					prop_settings = 'NNClassifierMLP_Evaluator_VOIs';
				otherwise
					prop_settings = getPropSettings@NNClassifierMLP_EvaluatorPF_ROC(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  DEFAULT = PF.GETPROPDEFAULT(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns the default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.ELCLASS
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs';
				case 2 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.NAME
					prop_default = 'ROC Panel for an Evaluator of MLP Classifier with Variables of Interest';
				case 3 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.DESCRIPTION
					prop_default = 'The receiver operating characteristic panel for an evaluator of MLP classifier with variables of interest (NNClassifierMLP_EvaluatorPF_ROC_VOIs) manages the functionalities to plot a panel of receiver operating characteristic curves for an NNClassifierMLP_VOIs classifier, using both a primary dataset (D) and a VOI dataset (D_VOIs).';
				case 4 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
				case 5 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.ID
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs ID';
				case 6 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.LABEL
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs label';
				case 7 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.NOTES
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs notes';
				case 26 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNClassifierMLP_EvaluatorPF_ROC(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC_VOIs.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_EvaluatorPF_ROC_VOIs.conditioning(prop, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  CHECK = PF.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput
			%  Element.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%   Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput
			%  PF.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%   Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC_VOIs:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop
				case 4 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
				case 26 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
				otherwise
					if prop <= 39
						check = checkProp@NNClassifierMLP_EvaluatorPF_ROC(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropTag(prop) ' (' NNClassifierMLP_EvaluatorPF_ROC_VOIs.getFormatTag(NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(pf, prop)
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
				case 28 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.X_VALUES
					if isa(pf.getr('X_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
					    class_names = pf.get('CLASSNAMES');
					    d = pf.get('NNE').get('D');
					    d_vois = pf.get('NNE').get('D_VOIS');
					    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', d, d_vois));
					    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    for i = 1:length(class_names)
					        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
					        values(i, :) = rocNet.Metrics(idx_class, :).FalsePositiveRate;
					    end
					    pf.set('X_VALUES', values);
					end
					
				case 29 % NNClassifierMLP_EvaluatorPF_ROC_VOIs.Y_VALUES
					if isa(pf.getr('Y_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
					    class_names = pf.get('CLASSNAMES');
					    d = pf.get('NNE').get('D');
					    d_vois = pf.get('NNE').get('D_VOIS');
					    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', d, d_vois));
					    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    for i = 1:length(class_names)
					        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
					        values(i, :) = rocNet.Metrics(idx_class, :).TruePositiveRate;
					    end
					    pf.set('Y_VALUES', values);
					end
					
				otherwise
					if prop <= 39
						postprocessing@NNClassifierMLP_EvaluatorPF_ROC(pf, prop);
					end
			end
		end
	end
end
