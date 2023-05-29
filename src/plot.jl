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