function mustBeAStructLabel(s)
    fnames  = fieldnames(s);
    props   = ["Name", "CategoryName"];
    if ~all(ismember(props, fnames))
        eidType = "App:notAValidMetadataStructure";
        msgType = "Input must be a valid metadata structure, with fieldnames from this list: " + join(props, ", ") + ".";
        throwAsCaller(MException(eidType,msgType));
    end
end


