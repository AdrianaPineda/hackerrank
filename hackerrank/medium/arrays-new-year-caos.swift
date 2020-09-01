//
// Problem: https://www.hackerrank.com/challenges/new-year-chaos/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
// Big O:
// Time complexity:
// Space complexity:

// Complete the minimumBribes function below.
func minimumBribes(q: [Int]) -> Void {
    var newQ = q
    var bribes = 0
    var bribesDict = [Int: Int]()
    var bribesInQueue = true
    var passes = 0
    var caotic = false

    while(!caotic && bribesInQueue) {

        var iterationWithBribes = false
        for i in 0..<(q.count - 1) {

            let shouldSwitch = shouldSwitchCurrentAndNextPositions(q: newQ, i: i, passes: passes)
            if shouldSwitch {
                let currentVal = newQ[i]
                let currentBribes = bribesDict[currentVal] ?? 0
                if currentBribes >= 2 { // Maximum number of bribes per person reached
                    caotic = true
                    break
                }

                // Switch positions
                newQ[i] = newQ[i + 1]
                newQ[i + 1] = currentVal
                bribes += 1
                bribesDict[currentVal] = currentBribes + 1
            }

            if isCurrentOrNextValueInWrongOrder(q: newQ, pos: i) {
                iterationWithBribes = true
            }
        }

        // If last iteration didn't have any bribes, we can finish the while loop
        if !iterationWithBribes {
            bribesInQueue = false
        }

        passes += 1
    }

    if caotic {
        print("Too chaotic")
    } else {
        print(bribes)
    }

}

func shouldSwitchCurrentAndNextPositions(q: [Int], i: Int, passes: Int) -> Bool {
    let currentVal = q[i]
    let nextVal = q[i + 1]

    let currentValInWrongPos = currentVal > (i + 1)
    let nextValInWrongPos = nextVal < (i + 2)
    // The first pass we switch positions only if both current and next values are wrong.
    // The subsequent passes we only care about next value.
    let shouldSwitch = (currentValInWrongPos && nextValInWrongPos) || (passes > 0 && nextValInWrongPos)
    return shouldSwitch
}

func isCurrentOrNextValueInWrongOrder(q: [Int], pos: Int) -> Bool {
    let updatedCurrentValInWrongPos = q[pos] > (pos + 1)
    let updatedNextValInWrongPos = q[pos + 1] < (pos + 2)
    return updatedCurrentValInWrongPos || updatedNextValInWrongPos
}


minimumBribes(q: [2, 1, 5, 3, 4])
minimumBribes(q: [2, 5, 1, 3, 4])
minimumBribes(q: [1, 2, 5, 3, 4, 7, 8, 6])
minimumBribes(q: [5, 1, 2, 3, 7, 8, 6, 4])
minimumBribes(q: [1, 2, 5, 3, 7, 8, 6, 4])
