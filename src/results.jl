using Random, Plots, ProgressBars, Statistics, StatsBase, JLD2, FileIO

include("functions.jl")

####
#Generating states after 100 MCS, sizes L=10 and L=80 for T=1, T=2.26, T=4

state10_T1_0 = state(10,1,100)
state10_T2_27 = state(10,2.27,100)
state10_T4_0 = state(10,4,100)

state80_T1_0 = state(80,1,100)
state80_T2_27 = state(80,2.27,100)
state80_T4_0 = state(80,4,100)

@save "data/states.jld2" state10_T1_0 state10_T2_27 state10_T4_0 state80_T1_0 state80_T2_27 state80_T4_0
####
#Generating trajectories for T=1, length 1000 MCS

trajectories_L10_T1_0 = Vector(undef,10)
trajectories_L20_T1_0 = Vector(undef,10)
trajectories_L40_T1_0 = Vector(undef,10)
trajectories_L80_T1_0 = Vector(undef,10)

for i in ProgressBar(1:10)
    trajectories_L10_T1_0[i] = trajectory_random(10,1,1000)
    trajectories_L20_T1_0[i] = trajectory_random(20,1,1000)
    trajectories_L40_T1_0[i] = trajectory_random(40,1,1000)
    trajectories_L80_T1_0[i] = trajectory_random(80,1,1000)
end

@save "data/trajectories_T1_0.jld2" trajectories_L10_T1_0 trajectories_L20_T1_0 trajectories_L40_T1_0 trajectories_L80_T1_0
####
trajectories_L10_T2_0 = Vector(undef,10)
trajectories_L20_T2_0 = Vector(undef,10)
trajectories_L40_T2_0 = Vector(undef,10)
trajectories_L80_T2_0 = Vector(undef,10)

for i in 1:10
    trajectories_L10_T2_0[i] = trajectory_random(10,2,1000)
    trajectories_L20_T2_0[i] = trajectory_random(20,2,1000)
    trajectories_L40_T2_0[i] = trajectory_random(40,2,1000)
    trajectories_L80_T2_0[i] = trajectory_random(80,2,1000)
end

@save "data/trajectories_T2_0.jld2" trajectories_L10_T2_0 trajectories_L20_T2_0 trajectories_L40_T2_0 trajectories_L80_T2_0
####
trajectories_L10_T2_27 = Vector(undef,10)
trajectories_L20_T2_27 = Vector(undef,10)
trajectories_L40_T2_27 = Vector(undef,10)
trajectories_L80_T2_27 = Vector(undef,10)

for i in 1:10
    trajectories_L10_T2_27[i] = trajectory_random(10,2.27,1000)
    trajectories_L20_T2_27[i] = trajectory_random(20,2.27,1000)
    trajectories_L40_T2_27[i] = trajectory_random(40,2.27,1000)
    trajectories_L80_T2_27[i] = trajectory_random(80,2.27,1000)
end

@save "data/trajectories_T2_27.jld2" trajectories_L10_T2_27 trajectories_L20_T2_27 trajectories_L40_T2_27 trajectories_L80_T2_27
####
trajectories_L10_T3_0 = Vector(undef,10)
trajectories_L20_T3_0 = Vector(undef,10)
trajectories_L40_T3_0 = Vector(undef,10)
trajectories_L80_T3_0 = Vector(undef,10)

for i in 1:10
    trajectories_L10_T3_0[i] = trajectory_random(10,3,1000)
    trajectories_L20_T3_0[i] = trajectory_random(20,3,1000)
    trajectories_L40_T3_0[i] = trajectory_random(40,3,1000)
    trajectories_L80_T3_0[i] = trajectory_random(80,3,1000)
end

@save "data/trajectories_T3_0.jld2" trajectories_L10_T3_0 trajectories_L20_T3_0 trajectories_L40_T3_0 trajectories_L80_T3_0
####
trajectories_L10_LONG = trajectory_random(10,1.8,10^6)

@save "data/trajectories_LONG.jld2" trajectories_L10_LONG
####
#Magnetization for temperatures. Averege by time 9*10^4:10^5 MCS
temperatures = LinRange(0.5,3.5,60)

magnetization_time_L10 = Vector(undef,60)
magnetization_time_L20 = Vector(undef,60)
magnetization_time_L40 = Vector(undef,60)
magnetization_time_L80 = Vector(undef,60)

Threads.@threads for i in ProgressBar(1:60)
    T = temperatures[i]
    magnetization_time_L10[i] = mean(abs.(trajectory_order(10,T,10^5)[5*10^4:10^5]))
    magnetization_time_L20[i] = mean(abs.(trajectory_order(20,T,10^5)[5*10^4:10^5]))
    magnetization_time_L40[i] = mean(abs.(trajectory_order(40,T,10^5)[5*10^4:10^5]))
    magnetization_time_L80[i] = mean(abs.(trajectory_order(80,T,10^5)[5*10^4:10^5]))
end

@save "data/magnetization_time.jld2" magnetization_time_L10 magnetization_time_L20 magnetization_time_L40 magnetization_time_L80
####
#Magnetization for temperatures. Ensemble average. Ensemble size = 50.
temperatures = LinRange(0.5,3.5,60)

#L=10
magnetization_ensemble_L10 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,50)
    Threads.@threads for j in 1:50
        mag[j] = abs(trajectory_order(10,T,10^4)[10^4])
    end
    magnetization_ensemble_L10[i] = mean(mag)
end

#L=20
magnetization_ensemble_L20 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,50)
    Threads.@threads for j in 1:50
        mag[j] = abs(trajectory_order(20,T,10^4)[10^4])
    end
    magnetization_ensemble_L20[i] = mean(mag)
end

#L=40
magnetization_ensemble_L40 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,50)
    Threads.@threads for j in 1:50
        mag[j] = abs(trajectory_order(40,T,10^4)[10^4])
    end
    magnetization_ensemble_L40[i] = mean(mag)
end

#L=80
magnetization_ensemble_L80 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,50)
    Threads.@threads for j in 1:50
        mag[j] = abs(trajectory_order(80,T,10^4)[10^4])
    end
    magnetization_ensemble_L80[i] = mean(mag)
end

@save "data/magnetization_ensemble.jld2" magnetization_ensemble_L10 magnetization_ensemble_L20 magnetization_ensemble_L40 magnetization_ensemble_L80
####
#Magnetization for temperatures. Ensemble average. Ensemble size = 150.
temperatures = LinRange(0.5,3.5,60)

#L=10
magnetization_ensemble_L10_150 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,150)
    Threads.@threads for j in 1:150
        mag[j] = abs(trajectory_order(10,T,10^4)[10^4])
    end
    magnetization_ensemble_L10_150[i] = mean(mag)
end

#L=20
magnetization_ensemble_L20_150 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,150)
    Threads.@threads for j in 1:150
        mag[j] = abs(trajectory_order(20,T,10^4)[10^4])
    end
    magnetization_ensemble_L20_150[i] = mean(mag)
end

#L=40
magnetization_ensemble_L40_150 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,150)
    Threads.@threads for j in 1:150
        mag[j] = abs(trajectory_order(40,T,10^4)[10^4])
    end
    magnetization_ensemble_L40_150[i] = mean(mag)
end

#L=80
magnetization_ensemble_L80_150 = Vector(undef,60)

for i in ProgressBar(1:60)
    T = temperatures[i]
    mag = Vector{Float64}(undef,150)
    Threads.@threads for j in 1:150
        mag[j] = abs(trajectory_order(80,T,10^4)[10^4])
    end
    magnetization_ensemble_L80_150[i] = mean(mag)
end

@save "data/magnetization_ensemble2.jld2" magnetization_ensemble_L10_150 magnetization_ensemble_L20_150 magnetization_ensemble_L40_150 magnetization_ensemble_L80_150
####
#Magnetization for temperatures. Averege by time 100 000 : 250 000 MCS

temperatures = LinRange(0.5,3.5,50)
magnetization_time_L10_250k = Vector(undef,50)
magnetization_time_L50 = Vector(undef,50)
magnetization_time_L100 = Vector(undef,50)
magnetization_time_L200 = Vector(undef,50)
magnetization_time_L500 = Vector(undef,50)
MCS = 250000
K0=100000
Threads.@threads for i in ProgressBar(1:50)
    T = temperatures[i]
    magnetization_time_L50[i] = mean(abs.(trajectory_order(50,T,MCS)[K0:MCS]))
end

@save "data/magnetization_time_large.jld2" magnetization_time_L50

Threads.@threads for i in ProgressBar(1:50)
    T = temperatures[i]
    magnetization_time_L100[i] = mean(abs.(trajectory_order(100,T,MCS)[K0:MCS]))
end

@load "data/magnetization_time_large.jld2" magnetization_time_L50
@save "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100

Threads.@threads for i in ProgressBar(1:50)
    T = temperatures[i]
    magnetization_time_L200[i] = mean(abs.(trajectory_order(200,T,MCS)[K0:MCS]))
end

@load "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100
@save "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100 magnetization_time_L200

Threads.@threads for i in ProgressBar(1:50)
    T = temperatures[i]
    magnetization_time_L500[i] = mean(abs.(trajectory_order(500,T,MCS)[K0:MCS]))
end

@load "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100 magnetization_time_L200 magnetization_time_L10_250k
@save "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100 magnetization_time_L200 magnetization_time_L10_250k magnetization_time_L500

Threads.@threads for i in ProgressBar(1:50)
    T = temperatures[i]
    magnetization_time_L10_250k[i] = mean(abs.(trajectory_order(10,T,MCS)[K0:MCS]))
end

@load "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100 magnetization_time_L200
@save "data/magnetization_time_large.jld2" magnetization_time_L50 magnetization_time_L100 magnetization_time_L200 magnetization_time_L10_250k
####
#Histeresis
m1_T15, h1_T15 = with_field_plus(40,1.5,10^4,200)
m2_T15, h2_T15 = with_field_minus(40,1.5,10^4,200)

m_T15 = vcat(m1_T15,m2_T15)
h_T15 = vcat(h1_T15,h2_T15)

m1_T18, h1_T18 = with_field_plus(40,1.8,10^4,200)
m2_T18, h2_T18 = with_field_minus(40,1.8,10^4,200)

m_T18 = vcat(m1_T18,m2_T18)
h_T18 = vcat(h1_T18,h2_T18)

m1_T2, h1_T2 = with_field_plus(40,2,10^4,200)
m2_T2, h2_T2 = with_field_minus(40,2,10^4,200)

m_T2 = vcat(m1_T2,m2_T2)
h_T2 = vcat(h1_T2,h2_T2)

m1_T227, h1_T227 = with_field_plus(40,2.27,10^4,200)
m2_T227, h2_T227 = with_field_minus(40,2.27,10^4,200)

m_T227 = vcat(m1_T227,m2_T227)
h_T227 = vcat(h1_T227,h2_T227)

@save "data/histeresis.jld2" m_T15 h_T15 m_T18 h_T18 m_T2 h_T2 m_T227 h_T227 
####
#Ising 3D
temperatures = LinRange(0.5,6.5,60)

magnetization_time_L5_3D = Vector(undef,60)

Threads.@threads for i in ProgressBar(1:60)
    T = temperatures[i]
    magnetization_time_L5_3D[i] = mean(abs.(trajectory_order3D(5,T,5*10^4)[10^4:5*10^4]))
end

magnetization_time_L10_3D = Vector(undef,60)

Threads.@threads for i in ProgressBar(1:60)
    T = temperatures[i]
    magnetization_time_L10_3D[i] = mean(abs.(trajectory_order3D(10,T,5*10^4)[10^4:5*10^4]))
end

magnetization_time_L25_3D = Vector(undef,60)

Threads.@threads for i in ProgressBar(1:60)
    T = temperatures[i]
    magnetization_time_L25_3D[i] = mean(abs.(trajectory_order3D(25,T,5*10^4)[10^4:5*10^4]))
end


magnetization_time_L50_3D = Vector(undef,60)

Threads.@threads for i in ProgressBar(1:60)
    T = temperatures[i]
    magnetization_time_L50_3D[i] = mean(abs.(trajectory_order3D(50,T,5*10^4)[10^4:5*10^4]))
end

@save "data/magnetization_time_3D.jld2"   magnetization_time_L5_3D magnetization_time_L10_3D magnetization_time_L25_3D magnetization_time_L50_3D
