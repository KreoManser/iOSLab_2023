let arrayString = ["fdjgnjfdgjfdkj","gdf","gfdf","fguwhfuwbewbfwebfibwei"]
let arrayInt = [1,2,3,4,5,6,7,8,9,10,11,12]


func filterArrayString (array : [String]) -> [String]{
    let filteredArray = array.filter{ i in i.count > 5}
    return filteredArray
}

func filterArrayInt (array : [Int]) -> [Int]{
    let filteredArray = array.filter{ i in i % 2 == 0}
    return filteredArray
}



print(filterArrayString(array : arrayString))
print(filterArrayInt(array: arrayInt))
