import UIKit

// MARK: - Topic 2
// Class vs Struct

/*

class Car {
    var year:Int
    var make: String
    var color: String

    init(year: Int, make: String, color: String) {
        self.year = year
        self.make = make
        self.color = color
    }
}

var myCar = Car(year: 2022, make: "Porsche", color: "Grey")
var stolenCar = myCar
stolenCar.color = "Yellow"
print (myCar.color)

 */

struct Car {
    var year: Int
    var make: String
    var color: String
}
    
var myCar = Car(year:2022, make: "Porsche", color: "Grey")
var stolenCar = myCar
stolenCar.color = "Red"
print(stolenCar.color)



// MARK: - Topic 3
// Generics

func determineHigherValue<T: Comparable>(valueOne: T, valueTwo: T) {
    let higherValue = valueOne > valueTwo ? valueOne : valueTwo
    print("\(higherValue) is the higher value")
}

determineHigherValue(valueOne: 3, valueTwo: 5)
determineHigherValue(valueOne: "Sean", valueTwo: "Swift")

//Example of an Array
var numbersArray = Array(repeating: 3, count: 10)
var stringArray = Array(repeating:"Sean", count: 5)
numbersArray.append(4)
stringArray.append("Swift")



// MARK: - Topic 4
// Closures

struct Student {
    let name: String
    var testScore: Int
}

let students = [Student (name: "Luke", testScore: 88),
                Student (name: "Han", testScore: 73),
                Student (name: "Leia", testScore: 95),
                Student (name: "Chewy", testScore: 78),
                Student (name: "Obi-Wan", testScore: 65),
                Student (name: "Ahsoka", testScore: 86),
                Student (name: "Yoda", testScore: 68)]

var topStudentFilter: (Student) -> Bool = { student in
    return student.testScore > 80
}

func topStudentFilterF(student: Student) -> Bool {
    return student.testScore > 70
}

let topStudents = students.filter(topStudentFilter)

for topStudent in topStudents {
    print (topStudent.name)
}
