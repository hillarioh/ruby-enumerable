
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

    def my_inject(val=1)

        result = 0

        if val!=1
            self.unshift(val)
        end
       
        for i in 0...self.size-1
            if block_given?
                self[i+1]=yield(self[i],self[i+1])
               
            end
            if i == self.size-2
                result = self[i+1]
            end
        end

        return result
        
    end
          
end

def multiply_els(my_array)

        return my_array.my_inject {|product, number| product * number}

end

# Test for my_each

puts ">>>Test for my_each"
["janet","junior","shem"].my_each{ |elem| puts elem}
puts ""

puts ">>>Test for my_each_with_index"
fruits = ["apple", "banana", "strawberry", "pineapple"]
fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }
puts ""

puts ">>>Test for select"
friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
print friends.my_select { |friend| friend != 'Brian'  }
puts ""

puts ">>>Test for all?"
ages = [ 19, 59, 70, 23, 140 ]
valid = ages.my_all? { | age | age > 0 && age <= 222 } 
puts valid
puts ""

puts ">>>Test for any?"
pet_names = ['pluto', 'scooby', 'nyan']
find_scooby = pet_names.my_any? { | pet | pet == 'scoobyy' }
puts find_scooby
puts ""

puts ">>>Test for none?"
animals = ["ant","bear","cat"]
wrd_len = animals.my_none? { |word| word.length == 5 } 
puts wrd_len


wrd_len2 = animals.my_none? { |word| word.length >= 4 } 
puts wrd_len2
puts ""

puts ">>>Test for count"
nomb = [1,2,3,2,2,3,2,3]
puts nomb.count
puts nomb.my_count(2)
puts nomb.my_count{ |x| x%2==0 }
puts ""

puts ">>>Test for map"
salaries = [1200, 1500, 1100, 1800]
puts salaries.my_map { |salary| salary - 700 }
puts ""

puts ">>>Test for inject"
puts [3, 6, 37, 45, 10].my_inject(2) {|sum, number| sum + number}
puts [3, 6, 37, 45, 10].my_inject{|sum, number| sum + number}
puts ""

puts ">>>Test for multuply_els"
puts multiply_els([3, 6, 37, 45, 10])


