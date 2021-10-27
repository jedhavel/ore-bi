#! julia

# run from ore-bi top dir
using PlotlyJS, CSV, DataFrames, Glob

datafiles = CSV.File.(glob("data/ore-token-burn-*.csv")) #Get all the token burn data files
dfs = DataFrame.(datafiles) # Convert to DataFrames

function _append!(dataframes::Vector{})
    for i = 1:size(dataframes)[1] - 1 # size returns tuple, we want the 1st value
        append!(dataframes[1], dataframes[i+1])
    end
end

if size(dfs)[1] > 1
    _append!(dfs)
end

p_instantburn = plot(dfs[1], x=:DateTime, y=:Quantity, Layout(title="Instant Burn"))

p_cumulativeburn = plot(dfs[1], x=:DateTime, y=:CumulativeQuantity, Layout(title="Cumulative Burn"))
