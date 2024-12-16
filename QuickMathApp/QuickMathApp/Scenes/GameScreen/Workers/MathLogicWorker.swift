
import Foundation

class MathLogicWorker {
    
    enum Operation: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "*"
        case division = "/"
    }
    
    func generateRandomNumber100() -> Int {
        return Int.random(in: 0...100)
    }

    func generateRandomNumber10() -> Int {
        return Int.random(in: 1...10)
    }

    func generateRandomOperation() -> Operation {
        let operations: [Operation] = [.addition, .subtraction, .multiplication, .division]
        return operations.randomElement() ?? .addition
    }

    func generateMathematicalOperation() -> MathExample {
        
        let num1 = generateRandomNumber100()
        let num2 = generateRandomNumber100()
        let num3 = generateRandomNumber10()
        let operation = generateRandomOperation()
        
        var example: String
        var answer: Int
        
        switch operation {
        case .addition:
            example = "\(num1) + \(num2) = ?"
            answer = num1 + num2
        case .subtraction:
            example = "\(num1) - \(num2) = ?"
            answer = num1 - num2
        case .multiplication:
            example = "\(num1) * \(num3) = ?"
            answer = num1 * num3
        case .division:
            let validNum2 = num2 == 0 ? 1 : num2
            let validNum1 = validNum2 * (generateRandomNumber100() % 10 + 1)
            example = "\(validNum1) / \(validNum2) = ?"
            answer = validNum1 / validNum2
        }
        
        return MathExample(question: example, answer: answer)
    }
}
