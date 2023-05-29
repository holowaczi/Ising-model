using Random, Plots, ProgressBars, Statistics, StatsBase, JLD2, FileIO

include("functions.jl")

####
#Generating trajectories for T=1, length 100 MCS

trajectories_L10_T1_0 = Vector(undef,10)
trajectories_L20_T1_0 = Vector(undef,10)
trajectories_L40_T1_0 = Vector(undef,10)
trajectories_L80_T1_0 = Vector(undef,10)

for i in 1:10
    trajectories_L10_T1_0[i] = trajectory_random(10,1,100)
    trajectories_L20_T1_0[i] = trajectory_random(20,1,100)
    trajectories_L40_T1_0[i] = trajectory_random(40,1,100)
    trajectories_L80_T1_0[i] = trajectory_random(80,1,100)
end

@save "data/trajectories_T1_0.jld2" trajectories_L10_T1_0 trajectories_L20_T1_0 trajectories_L40_T1_0 trajectories_L80_T1_0
