function catOut = addCategoryToProject(pj, catIn)
arguments
    pj      matlab.project.Project {mustBeNonempty}
    catIn   {mustBeA(catIn, ["matlab.project.Category", "struct"]), mustBeNonempty}   
end

% Extract labels names
if isa(catIn, "matlab.project.Category")
    labels = string({catIn.LabelDefinitions.Name});
elseif isstruct(catIn)
    labels = catIn.LabelDefinitions;
    if ~isfield(catIn, "DataType")
        catIn.DataType = "none";
    end
    if ~isfield(catIn, "SingleValued")
        catIn.SingleValued = "single-valued";
    end
end

% Create category if not existing in the project
catOut = findCategory(pj, catIn.Name);
if isempty(catOut)
    isSingleValued = any(ismember(catIn.SingleValued, ["single-valued", "singlevalued"]));
    if isSingleValued
        catOut = createCategory(pj, catIn.Name, catIn.DataType, "single-valued");
    else
        catOut = createCategory(pj, catIn.Name, catIn.DataType);
    end
end
% Create labels if not existing in the project
for i = 1 : numel(labels)
    label = findLabel(catOut, labels(i));
    if isempty(label)
        createLabel(catOut, labels(i));
    end
end
end




