using Random, Plots, ProgressBars, Statistics, StatsBase

function metropolis!(S, T, L)
    for _ in 1:L^2
        i = rand(1:L)
        j = rand(1:L)
        ΔE = 2*S[i,j]*(S[i,mod1(j+1,L)] + S[i,mod1(j-1,L)]+S[mod1(i+1,L),j]+S[mod1(i-1,L),j])
        if ΔE<=0
            S[i,j] = - S[i,j]
        elseif randexp()>ΔE/T
            S[i,j] = - S[i,j]
        end
    end
end

function metropolis_with_field!(S, T, h, L)
    for _ in 1:L^2
        i = rand(1:L)
        j = rand(1:L)
        ΔE = 2*S[i,j]*(S[i,mod1(j+1,L)] + S[i,mod1(j-1,L)]+S[mod1(i+1,L),j]+S[mod1(i-1,L),j]) + 2*h*S[i,j]
        if ΔE<=0
            S[i,j] = - S[i,j]
        elseif randexp()>ΔE/T
            S[i,j] = - S[i,j]
        end
    end
end

function trajectory_random(L,T,MCS)
    m = Vector{Float64}(undef,MCS)
    S = rand((-1,1),L,L)
    for step in 1:MCS
        metropolis!(S,T,L)
        m[step] = mean(S)
    end
    m
end

function trajectory_order(L,T,MCS)
    m = Vector{Float64}(undef,MCS)
    S = ones(L,L)
    for step in 1:MCS
        metropolis!(S,T,L)
        m[step] = mean(S)
    end
    m
end

function state(L,T,MCS)
    S = rand((-1,1),L,L)
    for _ in 1:MCS
        metropolis!(S,T,L)
    end
    S
end

function animate_ising(L,T,MCS, path::String, FPS::Int64)
    m = Vector{Float64}(undef,MCS)
    S = rand((-1,1),L,L)
    an = @animate for step in ProgressBar(1:MCS)
        metropolis!(S, T, L)
        m[step] = mean(S)
        p1 = heatmap(S, legend=false)
        p2 = plot(1:step,m[1:step], legend=false)
        plot(p1,p2, layout= grid(2, 1, heights=[0.8 ,0.2]))
    end
    plot!(size=(700,1000))
    gif(an, path, fps = FPS)
end
