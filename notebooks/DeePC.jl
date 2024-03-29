module DeePC

export SolveDeePC

using JuMP: Model, @variable, @objective, @constraint, optimize!
using Ipopt: Ipopt
using MathOptInterface

"""
This is a modification of DeePC to predict trajectories 
Using past trajectories and the current trajectory so far (y_ini)
"""
function matchTrajectory(Y,y_ini)
    Yp = Y[1:length(y_ini),:] # Past-matching segments
    Yf = Y[length(y_ini)+1:end,:] # Future-matching segments
    g = Yp\y_ini # Least Square
    y_fut = Yf*g
    return y_fut
end
    

function SolveDeePC(Up,Uf,Yp,Yf,Q,R,y_ini,u_ini)
    model = Model(Ipopt.Optimizer)
    set_silent(model)
    @variable(model, g[1:size(Up)[2]])
    @objective(model, Min, (Yf*g)'*Q*(Yf*g) + (Uf*g)'*R*(Uf*g))
    @constraint(model, Yp*g == y_ini)
    @constraint(model, Up*g == u_ini)
    optimize!(model)
    return model
end
    
function SolveDeePC(Up,Uf,Yp,Yf,Q,R,y_ini,u_ini,lambda_y,lambda_g)
    model = Model(Ipopt.Optimizer)
    set_silent(model)
    @variable(model, g[1:size(Up)[2]])
    @variable(model, sigma_y[1:size(y_ini)[1]])
    @variable(model, norm_1_sigma_y>=0)
    @variable(model, norm_1_g>=0)
    @objective(model, Min, (Yf*g)'*Q*(Yf*g) + (Uf*g)'*R*(Uf*g) + lambda_y*norm_1_sigma_y + lambda_g*norm_1_g  )
    @constraint(model, Yp*g == y_ini + sigma_y)
    @constraint(model, Up*g == u_ini)
    @constraint(model, [norm_1_sigma_y; sigma_y] in MOI.NormOneCone(1 + length(sigma_y)))
    @constraint(model, [norm_1_g; g] in MOI.NormOneCone(1 + length(g)))
    optimize!(model)
    return model
end

end