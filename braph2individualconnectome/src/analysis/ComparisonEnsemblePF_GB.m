classdef ComparisonEnsemblePF_GB < ComparisonEnsemblePF
	%ComparisonEnsemblePF_GB is the base element to plot a global bilayer group comparison figure.
	% It is a subclass of <a href="matlab:help ComparisonEnsemblePF">ComparisonEnsemblePF</a>.
	%
	% ComparisonEnsemblePF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.
	%
	% The list of ComparisonEnsemblePF_GB properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure global bilayer group comparison figure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure global bilayer group comparison figure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure global bilayer group comparison figure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure global bilayer group comparison figure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure global bilayer group comparison figure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure global bilayer group comparison figure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure comparison figure.
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
	%  <strong>26</strong> <strong>CP</strong> 	CP (metadata, item) is the ensemble-based comparison.
	%  <strong>27</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the group comparison figure value and stores it.
	%  <strong>28</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.
	%  <strong>29</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the area settings.
	%  <strong>30</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
	%  <strong>31</strong> <strong>H_LINE_DIFF</strong> 	H_LINE_DIFF (evanescent, handle) is the handle for the ensemble-based comparison line.
	%  <strong>32</strong> <strong>ST_LINE_DIFF</strong> 	ST_LINE_DIFF (figure, item) determines the line settings.
	%  <strong>33</strong> <strong>LISTENER_ST_LINE_DIFF</strong> 	LISTENER_ST_LINE_DIFF (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
	%  <strong>34</strong> <strong>H_LINE_CIL</strong> 	H_LINE_CIL (evanescent, handle) is the handle for the lower confidence interval of the ensemble-based comparison line.
	%  <strong>35</strong> <strong>ST_LINE_CIL</strong> 	ST_LINE_CIL (figure, item) determines the line settings.
	%  <strong>36</strong> <strong>LISTENER_ST_LINE_CIL</strong> 	LISTENER_ST_LINE_CIL (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
	%  <strong>37</strong> <strong>H_LINE_CIU</strong> 	H_LINE_CIU (evanescent, handle) is the handle for the upper confidence interval of the ensemble-based comparison line.
	%  <strong>38</strong> <strong>ST_LINE_CIU</strong> 	ST_LINE_CIU (figure, item) determines the line settings.
	%  <strong>39</strong> <strong>LISTENER_ST_LINE_CIU</strong> 	LISTENER_ST_LINE_CIU (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
	%  <strong>40</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
	%  <strong>41</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
	%  <strong>42</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
	%  <strong>43</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
	%  <strong>44</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
	%  <strong>45</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
	%
	% ComparisonEnsemblePF_GB methods (constructor):
	%  ComparisonEnsemblePF_GB - constructor
	%
	% ComparisonEnsemblePF_GB methods:
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
	% ComparisonEnsemblePF_GB methods (display):
	%  tostring - string with information about the panel global bilayer group comparison figure
	%  disp - displays information about the panel global bilayer group comparison figure
	%  tree - displays the tree of the panel global bilayer group comparison figure
	%
	% ComparisonEnsemblePF_GB methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel global bilayer group comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel global bilayer group comparison figure
	%
	% ComparisonEnsemblePF_GB methods (save/load, Static):
	%  save - saves BRAPH2 panel global bilayer group comparison figure as b2 file
	%  load - loads a BRAPH2 panel global bilayer group comparison figure from a b2 file
	%
	% ComparisonEnsemblePF_GB method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel global bilayer group comparison figure
	%
	% ComparisonEnsemblePF_GB method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel global bilayer group comparison figure
	%
	% ComparisonEnsemblePF_GB methods (inspection, Static):
	%  getClass - returns the class of the panel global bilayer group comparison figure
	%  getSubclasses - returns all subclasses of ComparisonEnsemblePF_GB
	%  getProps - returns the property list of the panel global bilayer group comparison figure
	%  getPropNumber - returns the property number of the panel global bilayer group comparison figure
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
	% ComparisonEnsemblePF_GB methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsemblePF_GB methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsemblePF_GB methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsemblePF_GB methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsemblePF_GB; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsemblePF_GB constants</a>.
	%
	%
	% See also ComparisonEnsemble.
	%
	% BUILD BRAPH2 7 class_name 1
	
	methods % constructor
		function pf = ComparisonEnsemblePF_GB(varargin)
			%ComparisonEnsemblePF_GB() creates a panel global bilayer group comparison figure.
			%
			% ComparisonEnsemblePF_GB(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsemblePF_GB(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ComparisonEnsemblePF_GB properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure global bilayer group comparison figure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure global bilayer group comparison figure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure global bilayer group comparison figure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure global bilayer group comparison figure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure global bilayer group comparison figure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure global bilayer group comparison figure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure comparison figure.
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
			%  <strong>26</strong> <strong>CP</strong> 	CP (metadata, item) is the ensemble-based comparison.
			%  <strong>27</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the group comparison figure value and stores it.
			%  <strong>28</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.
			%  <strong>29</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the area settings.
			%  <strong>30</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
			%  <strong>31</strong> <strong>H_LINE_DIFF</strong> 	H_LINE_DIFF (evanescent, handle) is the handle for the ensemble-based comparison line.
			%  <strong>32</strong> <strong>ST_LINE_DIFF</strong> 	ST_LINE_DIFF (figure, item) determines the line settings.
			%  <strong>33</strong> <strong>LISTENER_ST_LINE_DIFF</strong> 	LISTENER_ST_LINE_DIFF (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
			%  <strong>34</strong> <strong>H_LINE_CIL</strong> 	H_LINE_CIL (evanescent, handle) is the handle for the lower confidence interval of the ensemble-based comparison line.
			%  <strong>35</strong> <strong>ST_LINE_CIL</strong> 	ST_LINE_CIL (figure, item) determines the line settings.
			%  <strong>36</strong> <strong>LISTENER_ST_LINE_CIL</strong> 	LISTENER_ST_LINE_CIL (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
			%  <strong>37</strong> <strong>H_LINE_CIU</strong> 	H_LINE_CIU (evanescent, handle) is the handle for the upper confidence interval of the ensemble-based comparison line.
			%  <strong>38</strong> <strong>ST_LINE_CIU</strong> 	ST_LINE_CIU (figure, item) determines the line settings.
			%  <strong>39</strong> <strong>LISTENER_ST_LINE_CIU</strong> 	LISTENER_ST_LINE_CIU (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
			%  <strong>40</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
			%  <strong>41</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
			%  <strong>42</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
			%  <strong>43</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
			%  <strong>44</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
			%  <strong>45</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
			%
			% See also Category, Format.
			
			pf = pf@ComparisonEnsemblePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel global bilayer group comparison figure.
			%
			% BUILD = ComparisonEnsemblePF_GB.GETBUILD() returns the build of 'ComparisonEnsemblePF_GB'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel global bilayer group comparison figure PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('ComparisonEnsemblePF_GB') returns the build of 'ComparisonEnsemblePF_GB'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel global bilayer group comparison figure.
			%
			% CLASS = ComparisonEnsemblePF_GB.GETCLASS() returns the class 'ComparisonEnsemblePF_GB'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel global bilayer group comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonEnsemblePF_GB') returns 'ComparisonEnsemblePF_GB'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonEnsemblePF_GB';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel global bilayer group comparison figure.
			%
			% LIST = ComparisonEnsemblePF_GB.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsemblePF_GB'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel global bilayer group comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsemblePF_GB') returns all subclasses of 'ComparisonEnsemblePF_GB'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ComparisonEnsemblePF_GB' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel global bilayer group comparison figure.
			%
			% PROPS = ComparisonEnsemblePF_GB.GETPROPS() returns the property list of panel global bilayer group comparison figure
			%  as a row vector.
			%
			% PROPS = ComparisonEnsemblePF_GB.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel global bilayer group comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonEnsemblePF_GB'[, CATEGORY]) returns the property list of 'ComparisonEnsemblePF_GB'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 26];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 27];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 25 28 30 31 33 34 36 37 39 40 42 44];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 29 32 35 38 41 43 45];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel global bilayer group comparison figure.
			%
			% N = ComparisonEnsemblePF_GB.GETPROPNUMBER() returns the property number of panel global bilayer group comparison figure.
			%
			% N = ComparisonEnsemblePF_GB.GETPROPNUMBER(CATEGORY) returns the property number of panel global bilayer group comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel global bilayer group comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsemblePF_GB') returns the property number of 'ComparisonEnsemblePF_GB'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 45;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 17;
				case 8 % Category.FIGURE
					prop_number = 10;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel global bilayer group comparison figure/error.
			%
			% CHECK = ComparisonEnsemblePF_GB.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsemblePF_GB, PROP) checks whether PROP exists for ComparisonEnsemblePF_GB.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsemblePF_GB, PROP) throws error if PROP does NOT exist for ComparisonEnsemblePF_GB.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 45 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsemblePF_GB:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsemblePF_GB:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsemblePF_GB.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel global bilayer group comparison figure/error.
			%
			% CHECK = ComparisonEnsemblePF_GB.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsemblePF_GB, TAG) checks whether TAG exists for ComparisonEnsemblePF_GB.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsemblePF_GB, TAG) throws error if TAG does NOT exist for ComparisonEnsemblePF_GB.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'CP'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE_DIFF'  'ST_LINE_DIFF'  'LISTENER_ST_LINE_DIFF'  'H_LINE_CIL'  'ST_LINE_CIL'  'LISTENER_ST_LINE_CIL'  'H_LINE_CIU'  'ST_LINE_CIU'  'LISTENER_ST_LINE_CIU'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsemblePF_GB:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsemblePF_GB:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsemblePF_GB.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsemblePF_GB, POINTER) returns property number of POINTER of ComparisonEnsemblePF_GB.
			%  PROPERTY = PF.GETPROPPROP(ComparisonEnsemblePF_GB, POINTER) returns property number of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'CP'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE_DIFF'  'ST_LINE_DIFF'  'LISTENER_ST_LINE_DIFF'  'H_LINE_CIL'  'ST_LINE_CIL'  'LISTENER_ST_LINE_CIL'  'H_LINE_CIU'  'ST_LINE_CIU'  'LISTENER_ST_LINE_CIU'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsemblePF_GB, POINTER) returns tag of POINTER of ComparisonEnsemblePF_GB.
			%  TAG = PF.GETPROPTAG(ComparisonEnsemblePF_GB, POINTER) returns tag of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				comparisonensemblepf_gb_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'CP'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE_DIFF'  'ST_LINE_DIFF'  'LISTENER_ST_LINE_DIFF'  'H_LINE_CIL'  'ST_LINE_CIL'  'LISTENER_ST_LINE_CIL'  'H_LINE_CIU'  'ST_LINE_CIU'  'LISTENER_ST_LINE_CIU'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' };
				tag = comparisonensemblepf_gb_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsemblePF_GB, POINTER) returns category of POINTER of ComparisonEnsemblePF_GB.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonEnsemblePF_GB, POINTER) returns category of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_GB.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemblepf_gb_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  6  7  8  7  7  8  7  7  8  7  7  8  7  7  8  7  8  7  8 };
			prop_category = comparisonensemblepf_gb_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsemblePF_GB, POINTER) returns format of POINTER of ComparisonEnsemblePF_GB.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonEnsemblePF_GB, POINTER) returns format of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_GB.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemblepf_gb_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  1  18  8  18  18  8  18  18  8  18  18  8  18  18  8  18  8  18  8 };
			prop_format = comparisonensemblepf_gb_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsemblePF_GB, POINTER) returns description of POINTER of ComparisonEnsemblePF_GB.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonEnsemblePF_GB, POINTER) returns description of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_GB.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemblepf_gb_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the panel figure global bilayer group comparison figure.'  'DESCRIPTION (constant, string) is the description of the panel figure global bilayer group comparison figure.'  'TEMPLATE (parameter, item) is the template of the panel figure global bilayer group comparison figure.'  'ID (data, string) is a few-letter code for the panel figure global bilayer group comparison figure.'  'LABEL (metadata, string) is an extended label of the panel figure global bilayer group comparison figure.'  'NOTES (metadata, string) are some specific notes about the panel figure global bilayer group comparison figure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure comparison figure.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'CP (metadata, item) is the ensemble-based comparison.'  'SETUP (query, empty) calculates the group comparison figure value and stores it.'  'H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.'  'ST_AREA (figure, item) determines the area settings.'  'LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.'  'H_LINE_DIFF (evanescent, handle) is the handle for the ensemble-based comparison line.'  'ST_LINE_DIFF (figure, item) determines the line settings.'  'LISTENER_ST_LINE_DIFF (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.'  'H_LINE_CIL (evanescent, handle) is the handle for the lower confidence interval of the ensemble-based comparison line.'  'ST_LINE_CIL (figure, item) determines the line settings.'  'LISTENER_ST_LINE_CIL (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.'  'H_LINE_CIU (evanescent, handle) is the handle for the upper confidence interval of the ensemble-based comparison line.'  'ST_LINE_CIU (figure, item) determines the line settings.'  'LISTENER_ST_LINE_CIU (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.'  'H_TITLE (evanescent, handle) is the axis title.'  'ST_TITLE (figure, item) determines the title settings.'  'H_XLABEL (evanescent, handle) is the axis x-label.'  'ST_XLABEL (figure, item) determines the x-label settings.'  'H_YLABEL (evanescent, handle) is the axis y-label.'  'ST_YLABEL (figure, item) determines the y-label settings.' };
			prop_description = comparisonensemblepf_gb_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsemblePF_GB, POINTER) returns settings of POINTER of ComparisonEnsemblePF_GB.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonEnsemblePF_GB, POINTER) returns settings of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_GB.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % ComparisonEnsemblePF_GB.TEMPLATE
					prop_settings = 'ComparisonEnsemblePF_GB';
				otherwise
					prop_settings = getPropSettings@ComparisonEnsemblePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF_GB.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF_GB.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsemblePF_GB, POINTER) returns the default value of POINTER of ComparisonEnsemblePF_GB.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonEnsemblePF_GB, POINTER) returns the default value of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsemblePF_GB.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % ComparisonEnsemblePF_GB.ELCLASS
					prop_default = 'ComparisonEnsemblePF_GB';
				case 2 % ComparisonEnsemblePF_GB.NAME
					prop_default = 'ComparisonEnsemblePF_GB';
				case 3 % ComparisonEnsemblePF_GB.DESCRIPTION
					prop_default = 'ComparisonEnsemblePF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.';
				case 4 % ComparisonEnsemblePF_GB.TEMPLATE
					prop_default = Format.getFormatDefault(8, ComparisonEnsemblePF_GB.getPropSettings(prop));
				case 5 % ComparisonEnsemblePF_GB.ID
					prop_default = 'ComparisonEnsemblePF_GB ID';
				case 6 % ComparisonEnsemblePF_GB.LABEL
					prop_default = 'ComparisonEnsemblePF_GB label';
				case 7 % ComparisonEnsemblePF_GB.NOTES
					prop_default = 'ComparisonEnsemblePF_GB notes';
				otherwise
					prop_default = getPropDefault@ComparisonEnsemblePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF_GB.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF_GB.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF_GB, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF_GB.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF_GB, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF_GB.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsemblePF_GB.getPropProp(pointer);
			
			prop_default = ComparisonEnsemblePF_GB.conditioning(prop, ComparisonEnsemblePF_GB.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsemblePF_GB, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF_GB.
			%  CHECK = PF.CHECKPROP(ComparisonEnsemblePF_GB, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF_GB.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ComparisonEnsemblePF_GB:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:ComparisonEnsemblePF_GB:WrongInput
			%  Element.CHECKPROP(ComparisonEnsemblePF_GB, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF_GB.
			%   Error id: BRAPH2:ComparisonEnsemblePF_GB:WrongInput
			%  PF.CHECKPROP(ComparisonEnsemblePF_GB, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF_GB.
			%   Error id: BRAPH2:ComparisonEnsemblePF_GB:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonEnsemblePF_GB')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsemblePF_GB.getPropProp(pointer);
			
			switch prop
				case 4 % ComparisonEnsemblePF_GB.TEMPLATE
					check = Format.checkFormat(8, value, ComparisonEnsemblePF_GB.getPropSettings(prop));
				otherwise
					if prop <= 45
						check = checkProp@ComparisonEnsemblePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsemblePF_GB:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsemblePF_GB:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsemblePF_GB.getPropTag(prop) ' (' ComparisonEnsemblePF_GB.getFormatTag(ComparisonEnsemblePF_GB.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case 27 % ComparisonEnsemblePF_GB.SETUP
					warning([BRAPH2.STR ':ComparisonEnsemblePF_GB'], [BRAPH2.STR ':ComparisonEnsemblePF_GB \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					value = [];
					
				otherwise
					if prop <= 45
						value = calculateValue@ComparisonEnsemblePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
