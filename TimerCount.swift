var count = 0
Timer.every(1.seconds, fireImmediately: true) { (timer: Timer) in // fireImmediately is an optional parameter, defaults to false
    print("Will print every second")
    if count == 3 {
        timer.invalidate()
    }
    count++
}

//Schedule timer after a certain delay:

Timer.after(2.seconds) {
    print("Prints this 2 seconds later in main queue")
}

//Manual scheduling a timer:

let timer = Timer.new(every: 2.seconds) {
    print("Prints this 2 seconds later in main queue")
}
timer.start(onRunLoop: RunLoop.current, modes: RunLoopMode.defaultRunLoopMode)

//Manual scheduling a timer with a delay:

let timer = Timer.new(after: 2.seconds) {
    print("Prints this 2 seconds later in main queue")
}
timer.start(onRunLoop: RunLoop.current, modes: RunLoopMode.defaultRunLoopMode)


//Execution time for a function

let methodStart = Date()

/* ... Do whatever you need to do ... */

let methodFinish = Date()
let executionTime = methodFinish.timeIntervalSince(methodStart)
print("Execution time: \(executionTime)")
