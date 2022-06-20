function pj = updateProjectWithMetadata(pj, mdata) % TO DO
arguments 
    pj matlab.project.Project {mustBeNonempty}
    mdata   struct {mustBeNonempty,mustBeAStructForProjectCategory}
end

% Default Category
default_categories = "Classification";

% New categories 
new_categories = structfun(@(x) x.Name, mdata);

% Remove old categories (except default one)
old_categories  = string({pj.Categories.Name});
catToRemove     = old_categories(~ismember(old_categories, [new_categories;default_categories]));
if ~isempty(catToRemove)
    arrayfun(@(x) removeCategory(pj, x), catToRemove);
end

% Add/Modify categories to project
structfun(@(x) addCategoryToProject(pj,x), mdata);

end

function mustBeAStructForProjectCategory(s)
structfun(@mustBeAStructCategory,s);
end


