cd(dirname(@__FILE__()))
using DataFrames, CSV

purchaseData = CSV.read("../data/purchaseData.csv");
