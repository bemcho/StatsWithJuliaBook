__precompile__() 
using GeometryTypes, Plots,StatsPlots,Statistics
"""
    smooth(vals::Array{T,N}) where {T<:Real,N}

For a continuous X variable, divide the X-axis into distinct and nonoverlapping neighborhoods (slices). A common approach to dividing the X-axis is creating 10 equal-sized slices (also known as deciles), whose aggregation equals the total sample [3–5]. Each slice accounts for 10% of the sample. For a categorical X variable, slicing per se cannot be performed. The categorical labels (levels) define single-point slices. Each single-point slice accounts for a percentage of the sample dependent on the distribution of the categorical levels in the sample.

Take the average of X within each slice. The average is either the mean or median. The average of X within each slice is known as a smooth X value, or smooth X.Notation for smooth X is sm_X.
"""
function smooth(vals::Array{T,N}) where {T<:Real,N}

    result = Float64[]
    sliceSize = Int(floor(length(vals) / 10))
    rEnds = [slice*sliceSize for slice=1:10]
    rStart = 1
    for rEnd in rEnds
       #println(range(rStart,stop=rEnd))
       push!(result,median(vals[range(rStart,stop=rEnd)]))
       rStart+=sliceSize
    end

   return result
end # function

"""
   smoothScatterPlot!(xVals::Array{T,N},yVals::Array{T,N}) where {T<:Real,N}

The smoothed scatterplot is the desired visual display for revealing a rough-free relationship lying within big data. Smoothing is a method of removing the rough and retaining the predictable underlying relationship (the smooth) in data by averaging within neighborhoods of similar values. Smoothing an X–Y scatterplot involves taking the averages of both the target (dependent) variable Y and the continuous predictor (independent) variable X, within X-based neighborhoods [2]. The six-step procedure to construct a smoothed scatterplot follows:

Plot the (Xi, Yi) data points on an X–Y graph.
For a continuous X variable, divide the X-axis into distinct and nonoverlapping neighborhoods (slices). A common approach to dividing the X-axis is creating 10 equal-sized slices (also known as deciles), whose aggregation equals the total sample [3–5]. Each slice accounts for 10% of the sample. For a categorical X variable, slicing per se cannot be performed. The categorical labels (levels) define single-point slices. Each single-point slice accounts for a percentage of the sample dependent on the distribution of the categorical levels in the sample.
Take the average of X within each slice. The average is either the mean or median. The average of X within each slice is known as a smooth X value, or smooth X. Notation for smooth X is sm_X.
Take the average of Y within each slice.
For a continuous Y, the mean or median serves as the average.
For a categorical Y that assumes only two levels, the levels are reassigned typically numeric values 0 and 1. Clearly, only the mean can be calculated. This coding yields Y proportions or Y rates.
For a multinomial Y that assumes more than two levels, say k, clearly, the average cannot be calculated. (Level-specific proportions are calculable, but they do not fit into any developed procedure for the intended task.)
The appropriate procedure, which involves generating all combinations of pairwise-level scatterplots, is cumbersome and rarely used.
The procedure is that most often used because of its ease of implementation and efficiency is discussed in Section 18.5.
Notation for smooth Y is sm_Y.
Plot the smooth points (smooth Y, smooth X), constructing a smooth scatterplot.
Connect the smooth points, starting from the first left smooth point through the last right smooth point. The resultant smooth trace line reveals the underlying relationship between X and Y.
"""
function smoothScatterPlot!(xVals::Array{T,N},yVals::Array{T,N}) where {T<:Real,N}
    xSmooth = smooth(xVals)
    ySmooth = smooth(yVals)
    plot!(xSmooth,ySmooth,label="Smooth Trace Line N=$(length(xSmooth))",color=[:red])
    hline!([median(ySmooth)],label="Median line (median(ySmooth))",color=[:green])
end


function smoothScatterPlot(xVals::Array{T,N},yVals::Array{T,N}) where {T<:Real,N}
    xSmooth = smooth(xVals)
    ySmooth = smooth(yVals)
    plt =  Plots.scatter(xSmooth,ySmooth,title="Smooth Scatter plot",label="Raw x,y Correlation coeff. = $(cor(xVals,yVals))")
    smoothScatterPlot!(xVals,yVals)
    return plt
end

"""
validateGAT(xVals::Array{T,N},yVals::Array{T,N}) where {T<: Real,N}

    Validates GAT calculating TS score

TS is N − 1 − m.
where N is length in xVals or yVals
m is number of  intersections with median line
Detects intersections with median line and returns (N,TS,intersections as LineSegments)
"""
function validateGAT(xVals::Array{T,N},yVals::Array{T,N}) where {T<: Real,N}

    xSmooth = smooth(xVals)
    ySmooth = smooth(yVals)
    medianY = median(ySmooth)
    medianLine = LineSegment(Point(minimum(xSmooth),medianY),Point(maximum(xSmooth),medianY))

    n = length(xSmooth)
    intersections = [l1 for l1 in [LineSegment(Point(xSmooth[i1],ySmooth[i1]),Point(xSmooth[i1+1],ySmooth[i1+1])) for i1=1:n-1] if first(GeometryTypes.intersects(l1,medianLine))]
    return (n, n-1-length(intersections),intersections)

end

"""
   generalAssociationTest(xVals::Array{T,N},yVals::Array{T,N},title::String,xLabel::String,yLabel::String) where {T<:Real,N}

Here is the general association test:

    Plots the N smooth points in a scatterplot and draw a horizontal medial line that divides the N points into two equal-sized groups.

    Connect the N smooth points starting from the first left-hand smooth point. N − 1 line segments result. Count the number m of line segments that cross the medial line.

    Test for significance. The null hypothesis: There is no association between the two variables at hand. The alternative hypothesis: There is an association between the two variables.

```Consider the test statistic TS is N − 1 − m.

 N                                      CI 95%,TS                         CI 99%,TS
-------------------------------------------------------------------------------------------
8-9                                           6                                  -
10-11                                         7                                  8
12-13                                         9                                  10 
14-15                                         10                                 11
```
"""
function generalAssociationTest(xVals::Array{T,N},yVals::Array{T,N},title::String,xLabel::String,yLabel::String) where {T<:Real,N}

    t = "General Assesment Test, $title, Correlation coeff. = $(cor(xVals,yVals))"
    plt = Plots.scatter(xVals,yVals,label="$xLabel , $yLabel (before smoothing)",title=t,xlabel=xLabel,ylabel=yLabel,m=(0.5,[:+]),bg=:linen)
    smoothScatterPlot!(xVals,yVals)

    n,TS,intersections = validateGAT(xVals,yVals)
    annotate!([(median(xVals) ,maximum(yVals),"N is $n ,TS is $TS, Intersections = $(length(intersections)), $(TS < 7 ? :failed : :passed)")])
  
    println("N is $n, TS is $TS, Intersections - $(length(intersections)), $(TS < 7 ? :failed : :passed))")
    return (plt,n,TS,intersections)

end


