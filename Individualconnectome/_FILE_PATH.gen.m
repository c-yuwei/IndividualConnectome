%% ¡header!
FILE_PATH < ConcreteElement (FP, path of interest) is the base element for the variables of interest.

%%% ¡description!
A FILE_PATH is the base element for storing path of subject data files.
 Instances of this class should not be created. 
 Use one of its subclasses instead.

%%% ¡seealso!
VOINumeric, VOICategoric

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the variable of interest.
%%%% ¡default!
'FILE_PATH'

%%% ¡prop!
NAME (constant, string) is the name of the variable of interest.
%%%% ¡default!
'FILE PATH'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of element for savfile path for subjects.
%%%% ¡default!
'A path Of Interest  is the base element for a variable of interest. Instances of this class should not be created. Use one of its subclasses instead.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the variable of interest.
%%%% ¡settings!
'FILE_PATH'

%%% ¡prop!
ID (data, string) is a few-letter code for the variable of interest.
%%%% ¡default!
'FILE PATH ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the variable of interest.
%%%% ¡default!
'FILE PATH label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the variable of interest.
%%%% ¡default!
'FILE PATH notes'

%% ¡props!

%%% ¡prop!
PATH (data, string) is the value of the variable of interest.
