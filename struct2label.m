function label = struct2label(s)
arguments
    s struct {mustBeAStructLabel}
end
label = matlab.project.LabelDefinition(s.CategoryName, s.Name);
end

