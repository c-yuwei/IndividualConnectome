classdef SUVRConstructorPP_BR_DICT < PanelProp
	%SUVRConstructorPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% SUVRConstructorPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.
	% It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.
	%
	% The list of SUVRConstructorPP_BR_DICT properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph and measure panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph and measure panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph and measure panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph and measure panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph and measure panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph and measure panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
	%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
	%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
	%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
	%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
	%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
	%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
	%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
	%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
	%  <strong>36</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
	%  <strong>37</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
	%  <strong>38</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
	%  <strong>39</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
	%
	% SUVRConstructorPP_BR_DICT methods (constructor):
	%  SUVRConstructorPP_BR_DICT - constructor
	%
	% SUVRConstructorPP_BR_DICT methods:
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
	% SUVRConstructorPP_BR_DICT methods (display):
	%  tostring - string with information about the graph and measure plot
	%  disp - displays information about the graph and measure plot
	%  tree - displays the tree of the graph and measure plot
	%
	% SUVRConstructorPP_BR_DICT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph and measure plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph and measure plot
	%
	% SUVRConstructorPP_BR_DICT methods (save/load, Static):
	%  save - saves BRAPH2 graph and measure plot as b2 file
	%  load - loads a BRAPH2 graph and measure plot from a b2 file
	%
	% SUVRConstructorPP_BR_DICT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% SUVRConstructorPP_BR_DICT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% SUVRConstructorPP_BR_DICT methods (inspection, Static):
	%  getClass - returns the class of the graph and measure plot
	%  getSubclasses - returns all subclasses of SUVRConstructorPP_BR_DICT
	%  getProps - returns the property list of the graph and measure plot
	%  getPropNumber - returns the property number of the graph and measure plot
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
	% SUVRConstructorPP_BR_DICT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SUVRConstructorPP_BR_DICT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SUVRConstructorPP_BR_DICT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SUVRConstructorPP_BR_DICT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SUVRConstructorPP_BR_DICT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SUVRConstructorPP_BR_DICT constants</a>.
	%
	%
	% See also uitable, AnalyzeEnsemble, Graph, Measure.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		TABLE_HEIGHT = 36; %CET: Computational Efficiency Trick
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = 9;
		TABLE_HEIGHT_FORMAT = 22;
		
		SELECTED = 37; %CET: Computational Efficiency Trick
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = 9;
		SELECTED_FORMAT = 13;
		
		TABLE = 38; %CET: Computational Efficiency Trick
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = 7;
		TABLE_FORMAT = 18;
		
		CONTEXTMENU = 39; %CET: Computational Efficiency Trick
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = 7;
		CONTEXTMENU_FORMAT = 18;
	end
	methods % constructor
		function pr = SUVRConstructorPP_BR_DICT(varargin)
			%SUVRConstructorPP_BR_DICT() creates a graph and measure plot.
			%
			% SUVRConstructorPP_BR_DICT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SUVRConstructorPP_BR_DICT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SUVRConstructorPP_BR_DICT properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph and measure panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph and measure panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph and measure panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph and measure panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph and measure panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph and measure panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
			%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
			%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
			%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
			%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
			%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
			%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
			%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
			%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
			%  <strong>36</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
			%  <strong>37</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
			%  <strong>38</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
			%  <strong>39</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph and measure plot.
			%
			% BUILD = SUVRConstructorPP_BR_DICT.GETBUILD() returns the build of 'SUVRConstructorPP_BR_DICT'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the graph and measure plot PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SUVRConstructorPP_BR_DICT') returns the build of 'SUVRConstructorPP_BR_DICT'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the graph and measure plot.
			%
			% CLASS = SUVRConstructorPP_BR_DICT.GETCLASS() returns the class 'SUVRConstructorPP_BR_DICT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the graph and measure plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SUVRConstructorPP_BR_DICT') returns 'SUVRConstructorPP_BR_DICT'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			
			pr_class = 'SUVRConstructorPP_BR_DICT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph and measure plot.
			%
			% LIST = SUVRConstructorPP_BR_DICT.GETSUBCLASSES() returns all subclasses of 'SUVRConstructorPP_BR_DICT'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the graph and measure plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SUVRConstructorPP_BR_DICT') returns all subclasses of 'SUVRConstructorPP_BR_DICT'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SUVRConstructorPP_BR_DICT' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph and measure plot.
			%
			% PROPS = SUVRConstructorPP_BR_DICT.GETPROPS() returns the property list of graph and measure plot
			%  as a row vector.
			%
			% PROPS = SUVRConstructorPP_BR_DICT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the graph and measure plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SUVRConstructorPP_BR_DICT'[, CATEGORY]) returns the property list of 'SUVRConstructorPP_BR_DICT'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SUVRConstructorPP_BR_DICT')
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
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 38 39];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 37];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph and measure plot.
			%
			% N = SUVRConstructorPP_BR_DICT.GETPROPNUMBER() returns the property number of graph and measure plot.
			%
			% N = SUVRConstructorPP_BR_DICT.GETPROPNUMBER(CATEGORY) returns the property number of graph and measure plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the graph and measure plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SUVRConstructorPP_BR_DICT') returns the property number of 'SUVRConstructorPP_BR_DICT'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SUVRConstructorPP_BR_DICT')
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
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 12;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 6;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph and measure plot/error.
			%
			% CHECK = SUVRConstructorPP_BR_DICT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SUVRConstructorPP_BR_DICT, PROP) checks whether PROP exists for SUVRConstructorPP_BR_DICT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%  Element.EXISTSPROP(SUVRConstructorPP_BR_DICT, PROP) throws error if PROP does NOT exist for SUVRConstructorPP_BR_DICT.
			%   Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SUVRConstructorPP_BR_DICT:' 'WrongInput'], ...
					['BRAPH2' ':SUVRConstructorPP_BR_DICT:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SUVRConstructorPP_BR_DICT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph and measure plot/error.
			%
			% CHECK = SUVRConstructorPP_BR_DICT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SUVRConstructorPP_BR_DICT, TAG) checks whether TAG exists for SUVRConstructorPP_BR_DICT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%  Element.EXISTSTAG(SUVRConstructorPP_BR_DICT, TAG) throws error if TAG does NOT exist for SUVRConstructorPP_BR_DICT.
			%   Error id: [BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SUVRConstructorPP_BR_DICT:' 'WrongInput'], ...
					['BRAPH2' ':SUVRConstructorPP_BR_DICT:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SUVRConstructorPP_BR_DICT.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(SUVRConstructorPP_BR_DICT, POINTER) returns property number of POINTER of SUVRConstructorPP_BR_DICT.
			%  PROPERTY = PR.GETPROPPROP(SUVRConstructorPP_BR_DICT, POINTER) returns property number of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(SUVRConstructorPP_BR_DICT, POINTER) returns tag of POINTER of SUVRConstructorPP_BR_DICT.
			%  TAG = PR.GETPROPTAG(SUVRConstructorPP_BR_DICT, POINTER) returns tag of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				suvrconstructorpp_br_dict_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU' };
				tag = suvrconstructorpp_br_dict_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(SUVRConstructorPP_BR_DICT, POINTER) returns category of POINTER of SUVRConstructorPP_BR_DICT.
			%  CATEGORY = PR.GETPROPCATEGORY(SUVRConstructorPP_BR_DICT, POINTER) returns category of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			suvrconstructorpp_br_dict_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  7  7 };
			prop_category = suvrconstructorpp_br_dict_category_list{prop};
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(SUVRConstructorPP_BR_DICT, POINTER) returns format of POINTER of SUVRConstructorPP_BR_DICT.
			%  FORMAT = PR.GETPROPFORMAT(SUVRConstructorPP_BR_DICT, POINTER) returns format of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			suvrconstructorpp_br_dict_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  22  13  18  18 };
			prop_format = suvrconstructorpp_br_dict_format_list{prop};
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SUVRConstructorPP_BR_DICT, POINTER) returns description of POINTER of SUVRConstructorPP_BR_DICT.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SUVRConstructorPP_BR_DICT, POINTER) returns description of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			suvrconstructorpp_br_dict_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the graph and measure panel.'  'DESCRIPTION (constant, string) is the description of the graph and measure panel.'  'TEMPLATE (parameter, item) is the template of the graph and measure panel.'  'ID (data, string) is a few-letter code for the graph and measure panel.'  'LABEL (metadata, string) is an extended label of the graph and measure panel.'  'NOTES (metadata, string) are some specific notes about the graph and measure panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.'  'SELECTED (gui, cvector) is the list of selected items.'  'TABLE (evanescent, handle) is the table.'  'CONTEXTMENU (evanescent, handle) is the context menu.' };
			prop_description = suvrconstructorpp_br_dict_description_list{prop};
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(SUVRConstructorPP_BR_DICT, POINTER) returns settings of POINTER of SUVRConstructorPP_BR_DICT.
			%  SETTINGS = PR.GETPROPSETTINGS(SUVRConstructorPP_BR_DICT, POINTER) returns settings of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case SUVRConstructorPP_BR_DICT.TABLE_HEIGHT % __SUVRConstructorPP_BR_DICT.TABLE_HEIGHT__
					prop_settings = Format.getFormatSettings(22);
				case SUVRConstructorPP_BR_DICT.SELECTED % __SUVRConstructorPP_BR_DICT.SELECTED__
					prop_settings = Format.getFormatSettings(13);
				case SUVRConstructorPP_BR_DICT.TABLE % __SUVRConstructorPP_BR_DICT.TABLE__
					prop_settings = Format.getFormatSettings(18);
				case SUVRConstructorPP_BR_DICT.CONTEXTMENU % __SUVRConstructorPP_BR_DICT.CONTEXTMENU__
					prop_settings = Format.getFormatSettings(18);
				case SUVRConstructorPP_BR_DICT.TEMPLATE % __SUVRConstructorPP_BR_DICT.TEMPLATE__
					prop_settings = 'SUVRConstructorPP_BR_DICT';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SUVRConstructorPP_BR_DICT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SUVRConstructorPP_BR_DICT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SUVRConstructorPP_BR_DICT, POINTER) returns the default value of POINTER of SUVRConstructorPP_BR_DICT.
			%  DEFAULT = PR.GETPROPDEFAULT(SUVRConstructorPP_BR_DICT, POINTER) returns the default value of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case SUVRConstructorPP_BR_DICT.TABLE_HEIGHT % __SUVRConstructorPP_BR_DICT.TABLE_HEIGHT__
					prop_default = 360;
				case SUVRConstructorPP_BR_DICT.SELECTED % __SUVRConstructorPP_BR_DICT.SELECTED__
					prop_default = Format.getFormatDefault(13, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.TABLE % __SUVRConstructorPP_BR_DICT.TABLE__
					prop_default = Format.getFormatDefault(18, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.CONTEXTMENU % __SUVRConstructorPP_BR_DICT.CONTEXTMENU__
					prop_default = Format.getFormatDefault(18, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.ELCLASS % __SUVRConstructorPP_BR_DICT.ELCLASS__
					prop_default = 'SUVRConstructorPP_BR_DICT';
				case SUVRConstructorPP_BR_DICT.NAME % __SUVRConstructorPP_BR_DICT.NAME__
					prop_default = 'SUVRConstructorPP_BR_DICT';
				case SUVRConstructorPP_BR_DICT.DESCRIPTION % __SUVRConstructorPP_BR_DICT.DESCRIPTION__
					prop_default = 'SUVRConstructorPP_BR_DICT plots the panel to manage the graph and measures of an ensemble analysis.';
				case SUVRConstructorPP_BR_DICT.TEMPLATE % __SUVRConstructorPP_BR_DICT.TEMPLATE__
					prop_default = Format.getFormatDefault(8, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.ID % __SUVRConstructorPP_BR_DICT.ID__
					prop_default = 'SUVRConstructorPP_BR_DICT';
				case SUVRConstructorPP_BR_DICT.LABEL % __SUVRConstructorPP_BR_DICT.LABEL__
					prop_default = 'SUVRConstructorPP_BR_DICT label';
				case SUVRConstructorPP_BR_DICT.NOTES % __SUVRConstructorPP_BR_DICT.NOTES__
					prop_default = 'SUVRConstructorPP_BR_DICT';
				case SUVRConstructorPP_BR_DICT.EL % __SUVRConstructorPP_BR_DICT.EL__
					prop_default = SUVRConstructor();
				case SUVRConstructorPP_BR_DICT.PROP % __SUVRConstructorPP_BR_DICT.PROP__
					prop_default = 10;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SUVRConstructorPP_BR_DICT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SUVRConstructorPP_BR_DICT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SUVRConstructorPP_BR_DICT, POINTER) returns the conditioned default value of POINTER of SUVRConstructorPP_BR_DICT.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SUVRConstructorPP_BR_DICT, POINTER) returns the conditioned default value of POINTER of SUVRConstructorPP_BR_DICT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			prop_default = SUVRConstructorPP_BR_DICT.conditioning(prop, SUVRConstructorPP_BR_DICT.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of 2,
			%  3, 4, 8 and 9.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case SUVRConstructorPP_BR_DICT.SELECTED % __SUVRConstructorPP_BR_DICT.SELECTED__
					if isrow(value)
					    value = value';
					end
					
				otherwise
					if prop <= 35
						value = conditioning@PanelProp(pointer, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(SUVRConstructorPP_BR_DICT, PROP, VALUE) checks VALUE format for PROP of SUVRConstructorPP_BR_DICT.
			%  CHECK = PR.CHECKPROP(SUVRConstructorPP_BR_DICT, PROP, VALUE) checks VALUE format for PROP of SUVRConstructorPP_BR_DICT.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput
			%  Element.CHECKPROP(SUVRConstructorPP_BR_DICT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SUVRConstructorPP_BR_DICT.
			%   Error id: BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput
			%  PR.CHECKPROP(SUVRConstructorPP_BR_DICT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SUVRConstructorPP_BR_DICT.
			%   Error id: BRAPH2:SUVRConstructorPP_BR_DICT:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SUVRConstructorPP_BR_DICT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SUVRConstructorPP_BR_DICT.getPropProp(pointer);
			
			switch prop
				case SUVRConstructorPP_BR_DICT.TABLE_HEIGHT % __SUVRConstructorPP_BR_DICT.TABLE_HEIGHT__
					check = Format.checkFormat(22, value, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.SELECTED % __SUVRConstructorPP_BR_DICT.SELECTED__
					check = Format.checkFormat(13, value, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.TABLE % __SUVRConstructorPP_BR_DICT.TABLE__
					check = Format.checkFormat(18, value, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.CONTEXTMENU % __SUVRConstructorPP_BR_DICT.CONTEXTMENU__
					check = Format.checkFormat(18, value, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				case SUVRConstructorPP_BR_DICT.TEMPLATE % __SUVRConstructorPP_BR_DICT.TEMPLATE__
					check = Format.checkFormat(8, value, SUVRConstructorPP_BR_DICT.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SUVRConstructorPP_BR_DICT:' 'WrongInput'], ...
					['BRAPH2' ':SUVRConstructorPP_BR_DICT:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SUVRConstructorPP_BR_DICT.getPropTag(prop) ' (' SUVRConstructorPP_BR_DICT.getFormatTag(SUVRConstructorPP_BR_DICT.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case SUVRConstructorPP_BR_DICT.TABLE % __SUVRConstructorPP_BR_DICT.TABLE__
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', 12, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Brain Region', 'ID', 'Label', 'Notes', 'Description'}, ...
					    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false false false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case SUVRConstructorPP_BR_DICT.CONTEXTMENU % __SUVRConstructorPP_BR_DICT.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Measures', ...
					    'MenuSelectedFcn', {@cb_select_all} ...
					    );
					menu_clear_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_CLEAR_SELECTION', ...
					    'Text', 'Clear Selection', ...
					    'MenuSelectedFcn', {@cb_clear_selection} ...
					    );
					menu_invert_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_INVERT_SELECTION', ...
					    'Text', 'Invert Selection', ...
					    'MenuSelectedFcn', {@cb_invert_selection} ...
					    );
					menu_set = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_CALCULATE', ...
					    'Text', 'Set Selected Brain Regions', ...
						'MenuSelectedFcn', {@cb_set} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case SUVRConstructorPP_BR_DICT.X_DRAW % __SUVRConstructorPP_BR_DICT.X_DRAW__
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case SUVRConstructorPP_BR_DICT.UPDATE % __SUVRConstructorPP_BR_DICT.UPDATE__
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
						el = pr.get('EL');
					    prop = pr.get('PROP');
					    set_table()
					    pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
					    set(pr.get('TABLE'), 'Visible', 'on')
					end
					
				case SUVRConstructorPP_BR_DICT.REDRAW % __SUVRConstructorPP_BR_DICT.REDRAW__
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [4 4 w_p-8 max(1, pr.get('HEIGHT')-27)])
					end
					
				case SUVRConstructorPP_BR_DICT.SHOW % __SUVRConstructorPP_BR_DICT.SHOW__
					value = calculateValue@PanelProp(pr, 16, varargin{:}); % also warning
					
				case SUVRConstructorPP_BR_DICT.HIDE % __SUVRConstructorPP_BR_DICT.HIDE__
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					
				case SUVRConstructorPP_BR_DICT.DELETE % __SUVRConstructorPP_BR_DICT.DELETE__
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case SUVRConstructorPP_BR_DICT.CLOSE % __SUVRConstructorPP_BR_DICT.CLOSE__
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_table(~, event) % (src, event)
			    % only needs to update the selector
			
			        i = event.Indices(1);
			        
			        selected = pr.get('SELECTED');
			        if event.NewData == 1
			            pr.set('SELECTED', sort(unique([selected; i])));
			        else
			            pr.set('SELECTED', selected(selected ~= i));
			        end
			        
			        pr.get('UPDATE')    
			end
			function cb_select_all(~, ~)
			    roic = pr.get('EL');
			    br_list = cellfun(@(x) x.get('ID'), roic.get('BA').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
			    
			    pr.set('SELECTED', [1:1:length(m_list)])
			    
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~)
			    pr.set('SELECTED', [])
			    
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~)
			    roic = pr.get('EL');
			    br_list = cellfun(@(x) x.get('ID'), roic.get('BA').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
			    
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			    
			    pr.get('UPDATE')
			end
			function cb_set(~, ~)
			    roic = pr.get('EL');
			    prop = pr.get('PROP');
			    eff_br_dict = roic.get(prop);
			    
			    br_it_list = roic.get('BA').get('BR_DICT').get('IT_LIST');
			    br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
			    selected = pr.get('SELECTED');
			
			    roic.set('EFF_NODES', selected);
			    
			    added_keys_length = eff_br_dict.get('LENGTH');
			    eff_br_dict.get('REMOVE_ALL', 1:1:added_keys_length);
			    
			    for s = 1:1:length(selected)
			        br = br_list{selected(s)};
			        eff_br_dict.get('ADD', br_it_list{selected(s)});
			    end
			    roic.set(prop, eff_br_dict);
			    pr.get('UPDATE');
			end
			function set_table()
			    roic = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    br_it_list = roic.get('BA').get('BR_DICT').get('IT_LIST');
			    br_list = cellfun(@(x) x.get('ID'), br_it_list, 'UniformOutput', false);
			    
			    if isa(roic.getr(prop), 'NoValue')
			        eff_br_list = {};
			    else
			        eff_br_list = cellfun(@(x) x.get('ID'), roic.get(prop).get('IT_LIST'), 'UniformOutput', false);
			    end
			    
			    rowname = cell(length(br_list), 1);
			    data = cell(length(br_list), 5);
			    for bri = 1:1:length(br_list)
			        if any(ismember(eff_br_list, br_list{bri})) && ~isa(roic.get(prop).get('IT', br_list{bri}).getr('X'), 'NoValue')
			            rowname{bri} = 'S';
			        else
			            rowname{bri} = '';
			        end
			    
			        if any(pr.get('SELECTED') == bri)
			            data{bri, 1} = true;
			        else
			            data{bri, 1} = false;
			        end
			    
			        data{bri, 2} = br_it_list{bri}.get('ID');
			        data{bri, 3} = br_it_list{bri}.get('LABEL');
			        data{bri, 4} = br_it_list{bri}.get('NOTES');
			        data{bri, 5} = br_it_list{bri}.get('DESCRIPTION');
			    
			        set(pr.get('TABLE'), ...
			            'RowName', rowname, ...
			            'Data', data ...
			            )
			    
			        % style SELECTED
			        styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			        if ~isempty(styles_row)
			            removeStyle(pr.get('TABLE'), styles_row)
			        end
			        if ~isempty(pr.get('SELECTED'))
			            addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			        end
			    end
			end
		end
	end
end
