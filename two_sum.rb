#This function will find if two numbers in an array add up to the target sum.
def two_sum?(arr, target_sum)
    # your code here...
end

arr = [0, 1, 5, 7]
two_sum?(arr, 6) # => should be true
two_sum?(arr, 10) # => should be false

    #Possible implementations...
#Finding all possible sums and searching them is O(n^2). Space complexity is
#also O(n^2)

#Finding the largest and smallest numbers as bounds would be linear time. Using
#those to discard certain numbers would speed up the process, but worse case is
#still quadratic time. Space complexity suffers from similar difficulties.

#Sorting can happen in O(nlogn). For a given number, we can then compute exactly
#what other number must be in the array to create the sum. We can find if that
#number is in the array with a binary search, which takes O(log n) time.
#Finally, looping through the array takes O(n) time. In theory, we would have:
# nlog(n) + n * log(n) = 2nlog(n) = O(nlogn)
#Space complexity is O(n) because we need to store the sorted array.

#Is it possible to do better? If a solution in linear time exists, it cannot
#rely on sorting algorithms, nor can it use the binary search within a loop.
#Can hashing do something for us? What should we hash? Hashing every sum would
#put us at quadratic time again, so that's out. Hashing num => index
#(essentially inverting the array's structure) would take linear time. We could
#lookup if any number is present in the array in constant time! We could then
#loop over the array in linear time, and see if what we need to make the sum is
#present in constant time! This gives us a rather simple to implement O(n) time
#solution. Storing the hash would also make for linear space complexity,
#which is nice.

#A solution that involves log n time... would need a sorted array of elements
#that only needed to be searched once, if it relies on binary search. Since we
#have an unsorted array as a parameter, that's out. At this point, I don't know
#of any other algorithms that run in log(n) time. I'm unsure of how to proceed
#with being struck with great creativity.