using Plots, JLD2, FileIO

####
#Heatmaps of states
@load "data/states.jld2" state10_T1_0 state10_T2_26 state10_T4_0 state80_T1_0 state80_T2_26 state80_T4_0

heatmap(state10_T1_0, title ="L=10, T=1", legend= false)
heatmap(state10_T2_26, title ="L=10, T=2.26", legend = false)
heatmap(state10_T4_0, title ="L=10, T=4", legend = false)

heatmap(state80_T1_0, title ="L=80, T=1", legend= false)
heatmap(state80_T2_26, title ="L=80, T=2.26", legend = false)
heatmap(state80_T4_0, title ="L=80, T=4", legend = false)
####
#Ploting trajectories
@load "data/trajectories_T1_0.jld2" trajectories_L10_T1_0 trajectories_L20_T1_0 trajectories_L40_T1_0 trajectories_L80_T1_0

plot(trajectories_L10_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=10, T=1")
plot(trajectories_L20_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=20, T=1")
plot(trajectories_L40_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=40, T=1")
plot(trajectories_L80_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=80, T=1")
####
#Magnetizataion for temperatures from 0.5 to 3.5. Average by time.
@load "data/magnetization_time.jld2" magnetization_time_L10 magnetization_time_L20 magnetization_time_L40 magnetization_time_L80
t = LinRange(0.5,3.5,60)
plot(t, magnetization_time_L10, label="L10", marker=(:circle,4), title="Average by time K0 = 90 000 MCS, K= 100 000 MCS", xlabel = "T*", ylabel="<m>")
plot!(t, magnetization_time_L20, label="L20", marker=(:diamond,4))
plot!(t, magnetization_time_L40, label="L40", marker=(:hexagon,4))
plot!(t, magnetization_time_L80, label = "L80", marker=(:dtriangle,4))
####
