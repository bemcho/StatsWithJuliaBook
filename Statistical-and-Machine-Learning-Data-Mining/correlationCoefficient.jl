cd(dirname(@__FILE__()))
using Plots,StatsPlots,Statistics,DataFrames,RDatasets
include("correlationUtils.jl")
gr()

iris = dataset("datasets","iris")

println(first(iris))
println(describe(iris))

xVals = iris[:SepalLength]
yVals = iris[:SepalWidth]

println("Correlation coeff. = $(cor(xVals,yVals))")
plt1 = @df iris scatter(:SepalLength,:SepalWidth,group=:Species,title="General Association Test, Cor=$(cor(xVals,yVals))",xlabel="SepalLength",ylabel="SepalWidth",m=(0.5,[:+ :h :star7],12),bg=RGB(0.2,0.2,0.2))

smoothScatterPlot!(xVals,yVals)
savefig(plt1,"plotting/GAT_iris.png")

solder = dataset("rpart","solder")
println(first(solder))
println(describe(solder))

xVals = solder[5]
yVals = solder[6]
plt2 = smoothScatterPlot(xVals,yVals)
savefig(plt2,"plotting/GAT_solder.png")
