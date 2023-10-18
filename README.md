# Instrument
# We are going to use Zombie to verify the crash issue

 1)Once an Objective-C or Swift object no longer has any strong references to it, the object is deallocated. Attempting to further send messages to the object as if it were still a valid object is a “use after free” issue, with the deallocated object still receiving messages called a zombie object.
 
 2)Determine whether a crash report has signs of a zombiein page link
The Objective-C runtime can’t message objects deallocated from memory, so crashes often occur in the objc_msgSend, objc_retain, or objc_release functions. For example, a crash where the Objective-C runtime can’t send a message to the deallocated object looks like this:

Thread 0 Crashed:
0   libobjc.A.dylib                   0x00000001a186d190 objc_msgSend + 16
1   Foundation                        0x00000001a1f31238 __NSThreadPerformPerform + 232
2   CoreFoundation                    0x00000001a1ac67e0 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 24


Here’s another example, where the Objective-C runtime tries to release an object that’s already released:

Thread 2 Crashed:
0   libobjc.A.dylib                 0x00007fff7478bd5c objc_release + 28
1   libobjc.A.dylib                 0x00007fff7478cc8c (anonymous namespace)::AutoreleasePoolPage::pop(void*) + 726
2   com.apple.CoreFoundation        0x00007fff485feee6 _CFAutoreleasePoolPop + 22


Another pattern that indicates a zombie object is a stack frame for an unrecognized selector, which is a method that an object doesn’t implement. Often this kind of crash looks like code where an unexpected type of object is asked to do something it obviously can’t do, such as a number formatter class trying to play a sound. This is because the operating system reused memory that once held the deallocated object, and that memory now contains a different kind of object. A zombie identified by an unrecognized selector has a call stack with the doesNotRecognizeSelector(_:) method:

Last Exception Backtrace:
0   CoreFoundation                    0x1bf596a48 __exceptionPreprocess + 220
1   libobjc.A.dylib                   0x1bf2bdfa4 objc_exception_throw + 55
2   CoreFoundation                    0x1bf49a5a8 -[NSObject+ 193960 (NSObject) doesNotRecognizeSelector:] + 139


If you reproduce a crash like this when debugging, the console logs additional information:

Terminating app due to uncaught exception 'NSInvalidArgumentException',
    reason: '-[NSNumberFormatter playSound]: 
    unrecognized selector sent to instance 0x28360dac0'
    
    
    In this example, a message was sent to a NumberFormatter to perform the playSound selector, but NumberFormatter doesn’t implement a method with that name, so the app crashed. An object was previously allocated at the same memory address as the current NumberFormatter that did implement the playSound method, but that object was deallocated, and the unrelated NumberFormatter object is now using the same memory address. The playSound selector is a clue for debugging. If you identify the class implementing the playSound selector, you can identify the code paths that call it and determine why the expected object deallocated too early.

