using Plots, JLD2, FileIO

####
#Heatmaps of states
@load "data/states.jld2" state10_T1_0 state10_T2_27 state10_T4_0 state80_T1_0 state80_T2_27 state80_T4_0

heatmap(state10_T1_0, title ="L=10, T=1", legend= false)
heatmap(state10_T2_27, title ="L=10, T=2.27", legend = false)
heatmap(state10_T4_0, title ="L=10, T=4", legend = false)

heatmap(state80_T1_0, title ="L=80, T=1", legend= false)
heatmap(state80_T2_27, title ="L=80, T=2.27", legend = false)
heatmap(state80_T4_0, title ="L=80, T=4", legend = false)
####
#Ploting trajectories
@load "data/trajectories_T1_0.jld2" trajectories_L10_T1_0 trajectories_L20_T1_0 trajectories_L40_T1_0 trajectories_L80_T1_0

plot(trajectories_L10_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=10, T=1")
plot(trajectories_L20_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=20, T=1")
plot(trajectories_L40_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=40, T=1")
plot(trajectories_L80_T1_0, legend=false, xlabel = "MCS", ylabel="m", title="L=80, T=1")
####
#Ploting trajectories
@load "data/trajectories_T2_0.jld2" trajectories_L10_T2_0 trajectories_L20_T2_0 trajectories_L40_T2_0 trajectories_L80_T2_0

plot(trajectories_L10_T2_0, legend=false, xlabel = "MCS", ylabel="m", title="L=10, T=2")
plot(trajectories_L20_T2_0, legend=false, xlabel = "MCS", ylabel="m", title="L=20, T=2")
plot(trajectories_L40_T2_0, legend=false, xlabel = "MCS", ylabel="m", title="L=40, T=2")
plot(trajectories_L80_T2_0, legend=false, xlabel = "MCS", ylabel="m", title="L=80, T=2")
####
#Magnetizataion for temperatures from 0.5 to 3.5. Average by time.
@load "data/magnetization_time.jld2" magnetization_time_L10 magnetization_time_L20 magnetization_time_L40 magnetization_time_L80
t = LinRange(0.5,3.5,60)
plot(t, magnetization_time_L10, label="L10", marker=(:circle,4), title="Average by time K0 = 90 000 MCS, K= 100 000 MCS", xlabel = "T*", ylabel="<m>")
plot!(t, magnetization_time_L20, label="L20", marker=(:diamond,4))
plot!(t, magnetization_time_L40, label="L40", marker=(:hexagon,4))
plot!(t, magnetization_time_L80, label = "L80", marker=(:dtriangle,4))
####
#Magnetizataion for temperatures from 0.5 to 3.5. Ensemble average. Ensemble size = 50.
@load "data/magnetization_ensemble.jld2" magnetization_ensemble_L10 magnetization_ensemble_L20 magnetization_ensemble_L40 magnetization_ensemble_L80
t = LinRange(0.5,3.5,60)
plot(t, magnetization_ensemble_L10, label="L10", marker=(:circle,4), title="Ensemble average", xlabel = "T*", ylabel="<m>")
plot!(t, magnetization_ensemble_L20, label="L20", marker=(:diamond,4))
plot!(t, magnetization_ensemble_L40, label="L40", marker=(:hexagon,4))
plot!(t, magnetization_ensemble_L80, label = "L80", marker=(:dtriangle,4))
####
@load "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100 magnetization_time_L200 magnetization_time_L10_250k magnetization_time_L500

t = LinRange(0.5,3.5,50)

plot(t, magnetization_time_L10_250k, label = "L10", marker=(:dtriangle,4), title="Average by time K0=100 000 MCS, K=250 000 MCS", xlabel = "T*", ylabel="<m>")
plot!(t, magnetization_time_L50, label="L50", marker=(:circle,4))
plot!(t, magnetization_time_L100, label="L100", marker=(:diamond,4))
plot!(t, magnetization_time_L200, label="L200", marker=(:hexagon,4))
plot!(t, magnetization_time_L500, label = "L500", marker=(:star4,4))
####
@load "data/histeresis.jld2" m_T15 h_T15 m_T18 h_T18 m_T2 h_T2 m_T226 h_T226 

scatter(h_T15[1:10:2*10^4], m_T15[1:10:2*10^4],markersize=3,markerstrokewidth=0, label="T=1.5", title="L40",legend = :outerbottom, xlabel="h", ylabel="m")
scatter!(h_T18[1:10:2*10^4], m_T18[1:10:2*10^4],markersize=3,markerstrokewidth=0, label="T=1.8")
scatter!(h_T2[1:10:2*10^4], m_T2[1:10:2*10^4],markersize=3,markerstrokewidth=0, label="T=2")
scatter!(h_T226[1:10:2*10^4], m_T226[1:10:2*10^4],markersize=3,markerstrokewidth=0, label="T=2.26")
####
#Ising 3D
@load "data/magnetization_time_3D.jld2"  magnetization_time_L5_3D magnetization_time_L10_3D magnetization_time_L25_3D magnetization_time_L50_3D

t = LinRange(0.5,6.5,60)

plot(t, magnetization_time_L5_3D, label="L5", marker=(:circle,4), title="Ising 3D K0 = 10 000 MCS, K= 50 000 MCS", xlabel = "T*", ylabel="<m>")
plot!(t, magnetization_time_L10_3D, label="L10", marker=(:hexagon,4))
plot!(t, magnetization_time_L25_3D, label="L25", marker=(:diamond,4))
plot!(t, magnetization_time_L50_3D, label="L50", marker=(:dtriangle,4))
####

