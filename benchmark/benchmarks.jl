using Benchmark
using PersistentDataStructures

const rands = rand(1:1000000, 100000)

function appending(::Type{PersistentVector})
    function ()
        v = PersistentVector{Int}()
        for i=1:250000
            v = append(v, i)
        end
    end
end
function appending(::Type{Array})
    function ()
        a = Int[]
        for i=1:250000
            a = push!(a, i)
        end
    end
end

println("Appending")
println(compare([appending(PersistentVector), appending(Array)], 20))

vec(r::Range1) = PersistentVector([r])

function iterating(::Type{PersistentVector})
    pv = vec(1:500000)
    function ()
        sum = 0
        for el in pv
            sum += el
        end
    end
end
function iterating(::Type{Array})
    arr = [1:500000]
    function ()
        sum = 0
        for el in arr
            sum += el
        end
    end
end

println("Iterating")
println(compare([iterating(PersistentVector), iterating(Array)], 20))

function indexing{T}(v::PersistentVector{T})
    function ()
        for idx in rands
            v[idx]
        end
    end
end
function indexing{T}(a::Array{T})
    function ()
        for idx in rands
            a[idx]
        end
    end
end

println("Indexing")
println(compare([indexing(vec(1:1000000)), indexing(Array(Int, 1000000))], 20))

function popping(::Type{PersistentVector})
    v = vec(1:100000)
    function ()
        v2 = v
        for _ in 1:length(v2)
            v2 = pop(v2)
        end
    end
end
function popping(::Type{Array})
    function ()
        a = Array(Int, 100000)
        for _ in 1:length(a)
            pop!(a)
        end
    end
end

println("Popping")
println(compare([popping(PersistentVector), popping(Array)], 20))

function updating(v::PersistentVector{Int})
    function ()
        for idx in rands
            update(v, idx, 1)
        end
    end
end
function updating(a::Array{Int})
    function ()
        for idx in rands
            a[idx] = 1
        end
    end
end

println("Updating")
println(compare([updating(vec(1:1000000)), updating(Array(Int, 1000000))], 20))