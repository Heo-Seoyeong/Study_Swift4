/* 클래스, 구조체/열거형 비교 */

//MARK:- Class vs Struct/Enum
struct ValueType {
    var property = 1
}

class ReferenceType {
    var property = 1
}

// 값타입은 복사!
// 값이 수정되도 다른값이 바뀌지 않는다.
let firstStructInstance = ValueType()
var secondStructInstance = firstStructInstance
secondStructInstance.property = 2

print("first struct instance property : \(firstStructInstance.property)")    // 1
print("second struct instance property : \(secondStructInstance.property)")  // 2

// 참조타입은 메모리 위치를 전달
// 수정하면 같이 바뀐다.
let firstClassReference = ReferenceType()
var secondClassReference = firstClassReference
secondClassReference.property = 2

print("first class reference property : \(firstClassReference.property)")    // 2
print("second class reference property : \(secondClassReference.property)")  // 2

/* 클로저 */

//코드의 블럭
//일급 시민(first-citizen)
//변수, 상수 등으로 저장, 전달인자로 전달이 가능
//함수 : 이름이 있는 클로저

//MARK: - 정의
//{ (<#매개변수 목록#>) -> <#반환타입#> in
//    <#실행 코드#>
//}

// 함수를 사용한다면
func sumFunction(a: Int, b: Int) -> Int {
    return a + b
}

var sumResult: Int = sumFunction(a: 1, b: 2)

print(sumResult) // 3
// 클로저의 사용
var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
}

sumResult = sum(1, 2)
print(sumResult) // 3

// 함수는 클로저의 일종이므로
// sum 변수에는 당연히 함수도 할당할 수 있다.
// 파라미터를 바로 이어 붙인다.
sum = sumFunction(a:b:)

sumResult = sum(1, 2)
print(sumResult) // 3


//MARK: - 함수의 전달인자로서의 클로저
let add: (Int, Int) -> Int
add = { (a: Int, b: Int) -> Int in
    return a + b
}

let substract: (Int, Int) -> Int
substract = { (a: Int, b: Int) -> Int in
    return a - b
}

let divide: (Int, Int) -> Int
divide = { (a: Int, b: Int) -> Int in
    return a / b
}

func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}

var calculated: Int

// 아규먼트로 함수를 적는 것을 대신해 클로저를 이용해 클린코드를 완성한다.
calculated = calculate(a: 50, b: 10, method: add)

print(calculated) // 60
calculated = calculate(a: 50, b: 10, method: substract)

print(calculated) // 40
calculated = calculate(a: 50, b: 10, method: divide)

print(calculated) // 5
calculated = calculate(a: 50, b: 10, method: { (left: Int, right: Int) -> Int in
    return left * right
})

print(calculated) // 500


/* 클로저 고급 */

var result: Int

//MARK: - 후행 클로저
// 클로저가 함수의 마지막 전달인자라면
// 마지막 매개변수 이름을 생략한 후
// 함수 소괄호 외부에 클로저를 구현할 수 있다.
// { (파라미터: 아규먼트} in return 결과 } 로 표현
result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
    return left + right
}

print(result) // 20

//MARK: - 반환타입 생략
// calculate 함수의 method 매개변수는
// Int 타입을 반환할 것이라는 사실을 컴파일러도 알기 때문에
// 굳이 클로저에서 반환타입을 명시해 주지 않아도 된다.
// 대신 in 키워드는 생략할 수 없다.
result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) in
    return left + right
})

print(result) // 20
// 후행클로저와 함께 사용할 수도 있다
result = calculate(a: 10, b: 10) { (left: Int, right: Int) in
    return left + right
}

//MARK: - 단축 인자이름
// 클로저의 매개변수 이름이 굳이 불필요하다면 단축 인자이름을 활용할 수 있다.
// 단축 인자이름은 클로저의 매개변수의 순서대로 $0, $1... 처럼 표현한다.
result = calculate(a: 10, b: 10, method: {
    return $0 + $1
})

print(result) // 20
// 당연히 후행 클로저와 함께 사용할 수 있다.
result = calculate(a: 10, b: 10) {
    return $0 + $1
}

print(result) // 20

//MARK: - 암시적 반환 표현
// 클로저가 반환하는 값이 있다면
// 클로저의 마지막 줄의 결과값은 암시적으로 반환값으로 취급한다.
result = calculate(a: 10, b: 10) {
    $0 + $1
}

print(result) // 20
// 간결하게 한 줄로 표현해 줄 수도 있다.
result = calculate(a: 10, b: 10) { $0 + $1 }

print(result) // 20
// 축약하지 않은 클로저 문법과 축약 후의 문법 비교
result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) -> Int in
    return left + right
})

result = calculate(a: 10, b: 10) { $0 + $1 }

print(result) // 20

// 너무 줄이면 협업시에 어려움이 생길수도 있다.
