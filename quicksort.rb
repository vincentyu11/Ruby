class Quicksort
    def quicksort(input, p ,r)
        if (p < r)
            j = partition(input, p, r)
            quicksort(input, p, j-1)
            quicksort(input, j+1, r)
        end
    end

    def partition(input, p ,r)
        pivot = input[r]
        while p < r
            while input[p] < pivot
                p+=1
            end
            while input[r] > pivot
                r-=1
            end
            if input[p] == input[r]
                p+=1
            elsif p < r
                tmp = input[p]
                input[p] = input[r]
                input[r] = tmp
            end
        end
        return r
    end
end


input = [500, 700, 800, 100, 300, 200, 900, 400, 1000, 600]
puts "Unsorted array:"
print input
print "\n"
Quicksort.new.quicksort(input,0,9)
puts "Sorted array:"
print input