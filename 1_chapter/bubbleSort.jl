function simdBubbleSort!(a)
    n = length(a)
 @simd for i in 1:n-1
    @simd    for j in 1:n-i
            if a[j] > a[j+1]
                a[j], a[j+1] = a[j+1], a[j]
            end
        end
    end
    return a
end

function bubbleSort!(a)
    n = length(a)
 @simd for i in 1:n-1
    @simd    for j in 1:n-i
            if a[j] > a[j+1]
                a[j], a[j+1] = a[j+1], a[j]
            end
        end
    end
    return a
end


data = [65, 51, 32, 12, 23, 84, 68, 1]
const randCount = 10^7
@time bubbleSort!(rand(randCount))
@time simdBubbleSort!(rand(randCount))
@time sort(rand(randCount))
@time sort!(rand(randCount))
