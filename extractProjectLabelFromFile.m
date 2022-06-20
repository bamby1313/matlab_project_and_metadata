function label = extractProjectLabelFromFile(pj, file, options)
arguments
    pj               matlab.project.Project     {mustBeNonempty}
    file             {mustBeAFileOrProjectFile}
    options.category {mustBeA(options.category, ["matlab.project.Category", "string"])} = ""   
end

% Message if the label is not filled for the file
msgIfLabelNotFiled = "";

% Check that file is in the MATLAB Project
if isa(file, "matlab.project.ProjectFile")
    fpath = file.Path;
else
    fpath = which(file);
end
file = findFile(pj, fpath);
assert(~isempty(file), "File is not in the MATLAB Project " + pj.Name + ".");

% Pass category to string
if isa(options.category, "matlab.project.Category")
    options.category = string(matlab.project.Category);
elseif options.category == ""
    options.category = [pj.Categories.Name];
end

% All filled labels for the ProjectFile
labels = file.Labels;
% Initialize label (output)
label = matlab.project.Label.empty();

    for i = 1 : numel(options.category)
        c = findCategory(pj, options.category(i));
        if ~isempty(c)
            idx = find([labels.CategoryName] == c.Name);
            if ~isempty(idx)
                label = [label, labels(idx)]; %#ok<AGROW> 
            else
                label = [label, ...
                         createEmptyLabel(options.category(i),...
                         msgIfLabelNotFiled, file)]; %#ok<AGROW> 
            end
        end
    end
end

function mustBeAFileOrProjectFile(file)
if isempty(file) || (~isa(file, "matlab.project.ProjectFile") && (~isfile(file) && ~isfile(which(file))))
    eidType = 'App:notAValidFile';
    msgType = 'Input must be a valid file or MATLAB Project file.';
    throwAsCaller(MException(eidType,msgType));
end
end

function label = createEmptyLabel(cat, emptyName, file)
    label = matlab.project.Label(cat, emptyName, [], file);
end
