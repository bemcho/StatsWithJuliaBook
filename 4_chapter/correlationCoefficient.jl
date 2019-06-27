using Plots,StatsPlots,Statistics,DataFrames,RDatasets
include("correlationUtils.jl")
gr()

iris = dataset("datasets","iris")

println(first(iris))
println(showcols(iris))
println(describe(iris))

xVals = iris[:SepalLength]
yVals = iris[:SepalWidth]

println("Correlation coeff. = $(cor(xVals,yVals))")
@df iris scatter(:SepalLength,:SepalWidth,group=:Species,title="General Association Test, Cor=$(cor(xVals,yVals))",xlabel="SepalLength",ylabel="SepalWidth",m=(0.5,[:+ :h :star7],12),bg=RGB(0.2,0.2,0.2))

smoothScatterPlot(xVals,yVals)


