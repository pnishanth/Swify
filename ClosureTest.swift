// Closure Test

import UIKit

func sumNum(_ x : Int ,_ y :Int) -> Int{
    
    return x + y
    
}

var number = sumNum(10,15)
print(number)

var closureNum : (Int,Int) -> (Int) = {
    
    x,y in
    
    return x + y
    
}

closureNum(10,15)


func getBool(number:Int,completion:@escaping(_ result:Bool)->()){
    
    if number>5{
        completion(true)
        
    }else{
        completion(false)
        
    }
    
}

getBool(number: 10) { (number) in
    print(number)
}

