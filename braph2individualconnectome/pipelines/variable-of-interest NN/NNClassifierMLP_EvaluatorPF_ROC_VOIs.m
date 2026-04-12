classdef NNClassifierMLP_EvaluatorPF_ROC_VOIs < NNClassifierMLP_EvaluatorPF_ROC
	%NNClassifierMLP_EvaluatorPF_ROC_VOIs plots a panel of receiver operating characteristic curves for dual-input MLP classifier with VOIs.
	% It is a subclass of <a href="matlab:help NNClassifierMLP_EvaluatorPF_ROC">NNClassifierMLP_EvaluatorPF_ROC</a>.
	%
	% The receiver operating characteristic panel for an evaluator of MLP classifier with variables of interest (NNClassifierMLP_EvaluatorPF_ROC_VOIs) manages the functionalities to plot a panel of receiver operating characteristic curves for an NNClassifierMLP_VOIs classifier, using both a primary dataset (D) and a VOI dataset (D_VOIs).
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
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
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
			
			subclass_list = subclasses('NNClassifierMLP_EvaluatorPF_ROC_VOIs', [], [], true);
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
			
			if nargin == 0
				prop_list = [ ...
					NNClassifierMLP_EvaluatorPF_ROC.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNClassifierMLP_EvaluatorPF_ROC.getProps(Category.GUI) ...
						];
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
			
			prop_number = numel(NNClassifierMLP_EvaluatorPF_ROC_VOIs.getProps(varargin{:}));
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
			
			check = any(prop == NNClassifierMLP_EvaluatorPF_ROC_VOIs.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
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
			
			nnclassifiermlp_evaluatorpf_roc_vois_tag_list = cellfun(@(x) NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropTag(x), num2cell(NNClassifierMLP_EvaluatorPF_ROC_VOIs.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_evaluatorpf_roc_vois_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
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
				nnclassifiermlp_evaluatorpf_roc_vois_tag_list = cellfun(@(x) NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropTag(x), num2cell(NNClassifierMLP_EvaluatorPF_ROC_VOIs.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_evaluatorpf_roc_vois_tag_list)); % tag = pointer
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
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@NNClassifierMLP_EvaluatorPF_ROC(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  CATEGORY = PF.GETPROPCATEGORY(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns category of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@NNClassifierMLP_EvaluatorPF_ROC(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  FORMAT = PF.GETPROPFORMAT(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns format of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@NNClassifierMLP_EvaluatorPF_ROC(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns description of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ROC panel for an evaluator of MLP classifier with VOIs.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NAME
					prop_description = 'NAME (constant, string) is the name of the ROC panel for an evaluator of MLP classifier with VOIs.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ROC panel for an evaluator of MLP classifier with VOIs.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ROC panel.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.ID
					prop_description = 'ID (data, string) is a few-letter code for the ROC panel.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ROC panel.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ROC panel.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE
					prop_description = 'NNE (metadata, item) is the neural network evaluator with VOIs support.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.X_VALUES
					prop_description = 'X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves using D and D_VOIs.';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.Y_VALUES
					prop_description = 'Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves using D and D_VOIs.';
				otherwise
					prop_description = getPropDescription@NNClassifierMLP_EvaluatorPF_ROC(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%  SETTINGS = PF.GETPROPSETTINGS(NNClassifierMLP_EvaluatorPF_ROC_VOIs, POINTER) returns settings of POINTER of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE
					prop_settings = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE
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
			
			switch prop
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.ELCLASS
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NAME
					prop_default = 'ROC Panel for an Evaluator of MLP Classifier with Variables of Interest';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.DESCRIPTION
					prop_default = 'The receiver operating characteristic panel for an evaluator of MLP classifier with variables of interest (NNClassifierMLP_EvaluatorPF_ROC_VOIs) manages the functionalities to plot a panel of receiver operating characteristic curves for an NNClassifierMLP_VOIs classifier, using both a primary dataset (D) and a VOI dataset (D_VOIs).';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.ID
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs ID';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.LABEL
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs label';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NOTES
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC_VOIs notes';
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
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
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_EvaluatorPF_ROC_VOIs:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_EvaluatorPF_ROC_VOIs:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_EvaluatorPF_ROC_VOIs:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC_VOIs, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_EvaluatorPF_ROC_VOIs.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_EvaluatorPF_ROC_VOIs:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNClassifierMLP_EvaluatorPF_ROC_VOIs')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE % __NNClassifierMLP_EvaluatorPF_ROC_VOIs.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE % __NNClassifierMLP_EvaluatorPF_ROC_VOIs.NNE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_EvaluatorPF_ROC_VOIs.getPropSettings(prop));
				otherwise
					if prop <= NNClassifierMLP_EvaluatorPF_ROC.getPropNumber()
						check = checkProp@NNClassifierMLP_EvaluatorPF_ROC(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs:' BRAPH2.WRONG_INPUT '\n' ...
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
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.X_VALUES % __NNClassifierMLP_EvaluatorPF_ROC_VOIs.X_VALUES__
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
					
				case NNClassifierMLP_EvaluatorPF_ROC_VOIs.Y_VALUES % __NNClassifierMLP_EvaluatorPF_ROC_VOIs.Y_VALUES__
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
					if prop <= NNClassifierMLP_EvaluatorPF_ROC.getPropNumber()
						postprocessing@NNClassifierMLP_EvaluatorPF_ROC(pf, prop);
					end
			end
		end
	end
end
