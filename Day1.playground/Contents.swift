import Cocoa

// Puzzle input will be a list of strings
// We have to obtain the first and last digits of each string
// If there is only one digit, it is both the first and last digit
// The calibration value of each line is the combination of the first and last digits
// Example:
// pr3stu8vwx - 38
// treb7uchet - 7
// ab2h23jck5 - 25

func readByLine(from fileUrl: URL) -> [String] {
    let content = try! String(contentsOf: fileUrl)
    return content.components(separatedBy: "\n").filter { $0.count > 1 }
}


func calibrationValue(of line: String) -> Int {
        let elements = line.map { $0.wholeNumberValue }.filter { $0 != nil }
        guard elements.count >= 1 else { return 0 }
        let (first, last) = (elements.first!, elements.last!)
        return Int("\(first!)\(last!)")!
    }

func computeTotalCalibration(from fileUrl: URL) -> Int {
    let lines = readByLine(from: fileUrl)
    let calibrationValues = lines.map { calibrationValue(of: $0) }
    return calibrationValues.reduce(0, +)
}


// Read input.txt

// MARK: - Part 1

//let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt")!
//computeTotalCalibration(from: fileUrl)

// MARK: - Part 2

// Now, we have to check if the string contains spelled-out numbers
// That number will count towards the calibration value

enum Numbers {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    static var allCases: [Numbers] {
        return [.zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine]
    }
    
    var stringValue: String {
        switch self {
        case .zero: return "zero"
        case .one: return "one"
        case .two: return "two"
        case .three: return "three"
        case .four: return "four"
        case .five: return "five"
        case .six: return "six"
        case .seven: return "seven"
        case .eight: return "eight"
        case .nine: return "nine"
        }
    }
    
    var intValue: String {
        switch self {
        case .zero: return "z0o"
        case .one: return "o1e"
        case .two: return "t2o"
        case .three: return "t3e"
        case .four: return "f4r"
        case .five: return "f5e"
        case .six: return "s6x"
        case .seven: return "s7n"
        case .eight: return "e8t"
        case .nine: return "n9e"
        }
    }
}

func replaceSpelledOutNumbers(in line: String) -> String {
    var newLine = line
    //add the last ch
    for number in Numbers.allCases {
        newLine = newLine.replacingOccurrences(of: number.stringValue, with: "\(number.intValue)")
    }
    return newLine
}

func computeTotalCalibrationWithSpelledOutNumbers(from fileUrl: URL) -> Int {
    let lines = readByLine(from: fileUrl).map { replaceSpelledOutNumbers(in: $0)}
    print(lines)
        let calibrationValues = lines.map { calibrationValue(of: $0) }
    return calibrationValues.reduce(0, +)
}

computeTotalCalibrationWithSpelledOutNumbers(from: Bundle.main.url(forResource: "input2", withExtension: "txt")!)

