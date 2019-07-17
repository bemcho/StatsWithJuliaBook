__precompile__()
cd(dirname(@__FILE__()))
using DataFrames,RDatasets
include("correlationUtils.jl")
gr()

iris = dataset("datasets", "iris")
println(first(iris))
println(describe(iris))

xVals = iris[:SepalLength]
yVals = iris[:SepalWidth]

plt1, _ = generalAssociationTest(xVals, yVals, "Iris dataset", "SepalLength", "SepalWidth")
Plots.savefig(plt1, "plotting/GAT_iris.png")

solder = dataset("rpart", "solder")
println(first(solder))
println(describe(solder))

xVals = solder[5]
yVals = solder[6]
plt2, _ = generalAssociationTest(xVals, yVals, "Solder dataset", "Panel", "Skips")
Plots.savefig(plt2, "plotting/GAT_solder.png")

xVals = rand(1:1000, 1000)
yVals = rand(1:1000, 1000)
plt3, _ = generalAssociationTest(xVals, yVals, "Random", "Rand X", "Rand Y")
Plots.savefig(plt3, "plotting/GAT_random.png")




sleep = dataset("datasets", "sleep")
println(first(sleep))
println(describe(sleep))

plt4, _ = generalAssociationTest([parse(Float64, g) for g in sleep[:Group]], sleep[:Extra], "Students sleep dataset", "Group", "Extra")
Plots.savefig(plt4, "plotting/GAT_students_sleep.png")


co2 = dataset("datasets", "CO2")
println(first(co2))
println(describe(co2))

plt5, _ = generalAssociationTest(co2[:Uptake], 0.0 .+ co2[:Conc], "CO2 dataset", "Uptake", "Conc")
Plots.savefig(plt5, "plotting/GAT_co2.png")


# women = dataset("datasets","women")
# println(first(women))
# println(describe(women))

# plt5,_ = generalAssociationTest(women[:Height], women[:Weight], "Women dataset","Height","Weight")
# Plots.savefig(plt5,"plotting/GAT_women.png")
