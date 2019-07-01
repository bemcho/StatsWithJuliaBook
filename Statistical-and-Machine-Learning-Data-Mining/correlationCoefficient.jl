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

plt1 = generalAssesmentTest(xVals,yVals, "Iris dataset","SepalLength","SepalWidth")

#smoothScatterPlot!(xVals,yVals)
savefig(plt1,"plotting/GAT_iris.png")

solder = dataset("rpart","solder")
println(first(solder))
println(describe(solder))

xVals = solder[5]
yVals = solder[6]
plt2 = generalAssesmentTest(xVals,yVals, "Solder dataset","Panel","Skips")
savefig(plt2,"plotting/GAT_solder.png")

xVals = rand(10000)
yVals = rand(10000)
plt2 = generalAssesmentTest(xVals,yVals, "Random","Rand x","Rand y")
savefig(plt2,"plotting/GAT_random.png")
