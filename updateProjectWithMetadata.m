function pj = updateProjectWithMetadata(pj, mdata) % TO DO
arguments 
    pj matlab.project.Project {mustBeNonempty}
    mdata   struct {mustBeNonempty,mustBeAStructForProjectCategory}
end

% Default Category
default_categories = "Classification";

% Add category name to the structure
new_categories = string(fieldnames(mdata));
for i = 1 : numel(new_categories)
    mdata.(new_categories(i)).Name = new_categories(i);
end

% Remove old categories
old_categories  = string({pj.Categories.Name});
catToRemove     = old_categories(~ismember(old_categories, new_categories));
    % Except default category
    catToRemove(ismember(catToRemove, default_categories)) = [];
arrayfun(@(x) removeCategory(pj, x), catToRemove);

% Add/Modify categories to project
arrayfun(@(x) addCategoryToProject(pj, mdata.(x)), new_categories);

end






function mustBeAStructForProjectCategory(s)
import utils.project.*
categories  = string(fieldnames(s));
for i = 1 : numel(categories)
    s.(categories(i)).Name = categories(i);
end
structfun(@mustBeAStructCategory,s);
end


