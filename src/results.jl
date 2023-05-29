using Random, Plots, ProgressBars, Statistics, StatsBase, JLD2, FileIO

include("functions.jl")

####
#Generating states after 100 MCS, sizes L=10 and L=80 for T=1, T=2.26, T=4

state10_T1_0 = state(10,1,100)
state10_T2_26 = state(10,2.26,100)
state10_T4_0 = state(10,4,100)

state80_T1_0 = state(80,1,100)
state80_T2_26 = state(80,2.26,100)
state80_T4_0 = state(80,4,100)

@save "data/states.jld2" state10_T1_0 state10_T2_26 state10_T4_0 state80_T1_0 state80_T2_26 state80_T4_0
####
#Generating trajectories for T=1, length 1000 MCS

trajectories_L10_T1_0 = Vector(undef,10)
trajectories_L20_T1_0 = Vector(undef,10)
trajectories_L40_T1_0 = Vector(undef,10)
trajectories_L80_T1_0 = Vector(undef,10)

for i in 1:10
    trajectories_L10_T1_0[i] = trajectory_random(10,1,1000)
    trajectories_L20_T1_0[i] = trajectory_random(20,1,1000)
    trajectories_L40_T1_0[i] = trajectory_random(40,1,1000)
    trajectories_L80_T1_0[i] = trajectory_random(80,1,1000)
end

@save "data/trajectories_T1_0.jld2" trajectories_L10_T1_0 trajectories_L20_T1_0 trajectories_L40_T1_0 trajectories_L80_T1_0
####

