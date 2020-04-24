
# Create a script file to house your methods and run it in IRB to test them later.
# Add your new methods onto the existing Enumerable module. Ruby makes this easy for you because any class or module can be added to without trouble ... just do something like:
#   module Enumerable
#     def my_each
#       # your code here
#     end
#   end
# Create #my_each, a method that is identical to #each but (obviously) does not use #each. You'll need to remember the yield statement. Make sure it returns the same thing as #each as well.
# Create #my_each_with_index in the same way.
# Create #my_select in the same way, though you may use #my_each in your definition (but not #each).
# Create #my_all? (continue as above)
# Create #my_any?
# Create #my_none?
# Create #my_count
# Create #my_map
# Create #my_inject
# Test your #my_inject by creating a method called #multiply_els which multiplies all the elements of the 
# array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40
# Modify your #my_map method to take a proc instead.
# Modify your #my_map method to take either a proc or a block. It won't be 
# necessary to apply both a proc and a block in the same #my_map call since you 
# could get the same effect by chaining together one #my_map call with the block and one with the proc. 
# This approach is also clearer,
# since the user doesn't have to remember whether the proc or block will be run first. 
# So if both a proc and a block are given, only execute the proc.


module Enumerable

    def my_each

        for i in self
         block_given? ? yield(i) : break
            
        end
      
    end

    def my_each_with_index

        for i in 0...self.size
            block_given? ? yield(self[i],i) : break
        end
        

    end

    def my_select
        
        arrayed = []

        my_each {|i| arrayed << i if yield(i) == true}

       return arrayed

    end

    def my_all?

         arrayed=[]

         my_each {|i| yield(i) == true ? arrayed << true : arrayed << false}

         state=true

         for j in arrayed
            if j==true
                next
            else
                state = false
                break
            end

            
         end  
         
         
         return state
      

    end

    def my_any?

         arrayed=[]

         my_each {|i| yield(i) == true ? arrayed << true : arrayed << false}

         state=false

         for j in arrayed
            if j==true
                state=true
                break
           
            end
         end  
         
         return state

    end

    def my_none?

        arrayed=[]

         my_each {|i| yield(i) == true ? arrayed << true : arrayed << false}

         state=true

         for j in arrayed
            if j==true
                state=false
                break
           
            end
         end  
         
         return state

    end

    def my_count(val=1)

        num = 0

        if val==1 && block_given?

            arrayed = []
            my_each {|i| arrayed << i if yield(i) == true}

            num = arrayed.size

       
             
        elsif val==1
            track = 0

            for i in self
                track +=1
            end

            num = track
            puts num
 
        else
            
            arrayed = self.my_select { |ent| ent == val} 

            num = arrayed.size
        end
        
        return num

    end

    def my_map

        arrayed = []

        for i in self
            if block_given?
                arrayed << yield(i)
                
            end
        end

        return arrayed

    end

    def my_inject

    end

    def multiply_els

    end
       
end

# Test for my_each

# ["janet","junior","shem"].my_each{ |elem| puts elem}


# Test for my_each_with_index

# fruits = ["apple", "banana", "strawberry", "pineapple"]

# fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }


# Test for select

# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

# friends.my_select { |friend| friend != 'Brian'  }


# # Test for all?
# ages = [ 19, 59, 70, 23, 140 ]

# valid = ages.my_all? { | age | age > 0 && age <= 222 } 

# Test for any?

# pet_names = ['pluto', 'scooby', 'nyan']

# find_scooby = pet_names.my_any? { | pet | pet == 'scoobyy' }

# puts find_scooby

# Test for none?

# animals = ["ant","bear","cat"]
# wrd_len = animals.my_none? { |word| word.length == 5 } #=> true

# puts wrd_len

# animal = ["ant","bear","cat"]
# wrd_len2 = animals.my_none? { |word| word.length >= 4 } #=> false
# puts wrd_len2

# Test for count

# ary.count               #=> 4
# ary.count(2)            #=> 2
# ary.count{ |x| x%2==0 } #=> 3

# print [1,2,3,2,2,3,2,3].my_count(2)

# Test for map

salaries = [1200, 1500, 1100, 1800]

puts salaries.my_map { |salary| salary - 700 }
#=> [500, 800, 400, 1100]



