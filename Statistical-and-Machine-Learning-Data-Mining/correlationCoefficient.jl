cd(dirname(@__FILE__()))
using DataFrames,RDatasets
include("correlationUtils.jl")
gr()

iris = dataset("datasets","iris")
println(first(iris))
println(describe(iris))

xVals = iris[:SepalLength]
yVals = iris[:SepalWidth]

plt1,_ = generalAssociationTest(xVals,yVals, "Iris dataset","SepalLength","SepalWidth")
#smoothScatterPlot!(xVals,yVals)
Plots.savefig(plt1,"plotting/GAT_iris.png")

solder = dataset("rpart","solder")
println(first(solder))
println(describe(solder))

xVals = solder[6]
yVals = solder[5]
plt2,_ = generalAssociationTest(xVals,yVals, "Solder dataset","Panel","Skips")
Plots.savefig(plt2,"plotting/GAT_solder.png")

xVals = rand(1:10000,10000)
yVals = rand(1:10000,10000)
plt3,_ = generalAssociationTest(xVals,yVals, "Random","Rand X","Rand Y")
Plots.savefig(plt3,"plotting/GAT_random.png")



women = dataset("datasets","women")
println(first(women))
println(describe(women))

xVals = women[:Height]
yVals = women[:Weight]

plt4,_ = generalAssociationTest(xVals,yVals, "Women dataset","Height","Weight")
Plots.savefig(plt4,"plotting/GAT_women.png")
