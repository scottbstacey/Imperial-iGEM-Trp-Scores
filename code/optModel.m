function sol = optModel(model,pos,c,base_sol)
  % optModel
  %   Wrapper for optimizeCbModel with added functionality for irreversible models.
  %
  %   model       (struct) metabolic model (in irreversible format)
  %   pos         (int) the position of the reaction to optimize
  %   c           (int) either -1 (for minimizing) or +1 (for maximizing)
  %   base_sol    (struct, opt) a previous COBRA solution (for fixing values)
  %
  %   sol         (struct) COBRA solution from running the optimization
  %
  %   Usage: sol = optModel(model,pos,c,base_sol)
  %

% Make sure that the opposite reaction is blocked:
if length(pos) == 1
    rxn_code = model.rxns{pos};
    if strcmp(rxn_code(end-3:end),'_REV')
        rev_pos = strcmp(model.rxns,rxn_code(1:end-4));
    else
        rev_pos = strcmp(model.rxns,[rxn_code '_REV']);
    end
    model.lb(rev_pos) = 0;
    model.ub(rev_pos) = 0;
end

% Optimize:
model.c      = zeros(size(model.rxns));
model.c(pos) = c;
sol          = optimizeCbModel(model);

% If optimization didn't work, fix opposite reaction at a basal solution:
if isempty(sol.x) && length(pos) == 1
    model.lb(rev_pos) = base_sol.x(rev_pos);
    model.ub(rev_pos) = base_sol.x(rev_pos);
    sol               = optimizeCbModel(model);
end

end