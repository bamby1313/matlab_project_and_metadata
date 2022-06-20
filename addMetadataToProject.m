function project = addMetadataToProject(mdata, project, file, options)
arguments
    mdata                   struct {mustBeNonempty}
    project                 matlab.project.Project {mustBeNonempty}
    file                    {mustBeFile, mustBeNonempty}
    options.EnforceCategory logical = false
end

% Create a label definition from a structure
label = struct2label(mdata);

% Initialize DataType & Data if not set
if ~isfield(mdata, "SingleValued")
    mdata.SingleValued = "single-valued";
elseif isfield(mdata, "SingleValued")
    mustBeMember(mdata.SingleValued, ["single-valued", "singlevalued"]);
end

% Get the currently open project
if ~isLoaded(project)
    openProject(project);
end
 
% Get the categories, file and labels for this project
projectFile = findFile(project, file);

% Attach it to a file in the project
c = findCategory(project, label.CategoryName);
if ~isempty(c)
    addLabel(projectFile, label.CategoryName, label.Name);
elseif isempty(c) && options.EnforceCategory 
    c = createCategory(project, label.CategoryName, mdata.DataType, mdata.SingleValued);
    assert(c.Name == label.CategoryName);
    disp("Project " + project.Name + ", Category created: " + c.Name + ".")
    addLabel(projectFile, label.Name, label.Name);
else 
    warning("Category " + label.CategoryName + " no created because EnforceCategory is set to false (by default).")
    return
end

if isfield(mdata, "Data")
    newLabel        = findLabel(projectFile, label.CategoryName, label.Name);
    newLabel.Data   = mdata.Data;
end

end

