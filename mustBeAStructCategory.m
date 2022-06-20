function mustBeAStructCategory(s)
    fnames  = string(fieldnames(s));
    propReq = "Name";
    propOpt = ["SingleValued", "DataType", "LabelDefinitions"];
    if ~ismember(propReq, fnames) || any(~ismember(fnames, [propReq, propOpt]))
        eidType = "App+:notAValidMetadataStructure";
        msgType = "Input must be a valid metadata structure, with fieldnames from this list: " + join([propReq,propOpt], ", ") + ".";
        throwAsCaller(MException(eidType,msgType));
    end
end