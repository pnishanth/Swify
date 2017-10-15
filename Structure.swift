//
//
//  Strucure - MARK
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import SomeExternalFramework

class FooViewController : UIViewController, FoobarDelegate {
    
    let foo: Foo
    
    private let fooStringConstant = "FooConstant"
    private let floatConstant = 1234.5
    
    // MARK: Lifecycle
    
    // Custom initializers go here
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ...
    }
    
    // MARK: Layout
    
    private func makeViewConstraints() {
        // ...
    }
    
    // MARK: User Interaction
    
    func foobarButtonTapped() {
        // ...
    }
    
    // MARK: FoobarDelegate
    
    func foobar(foobar: Foobar, didSomethingWithFoo foo: Foo) {
        // ...
    }
    
    // MARK: Additional Helpers
    
    private func displayNameForFoo(foo: Foo) {
        // ...
    }
    
}
