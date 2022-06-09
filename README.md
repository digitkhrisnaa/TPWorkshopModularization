# Scalable iOS Project Using Modularization and MicroApp Architecture Strategy

This project contains tutorial how to extract your monolith iOS project to modular project include with microapp strategy. What you will learn on this workshop will be:

1. **Introduce to Swift Compiler** - You will learn what is compile and what is linker using Swift Compiler.
2. **Getting Know Static and Dynamic Library** - You will learn what is static and dynamic library based on linker perspective.
3. **Extract the Monolith** - You will learn how to extract the project to modular, also you will learn about Dynamic and Static framework on XCode.

If you want to learn those 3 sessions or you accidentally landed here, then let's start the journey!

## Session 1 - Introduce to Swift Compiler
Many of you may familiar how to create Swift Project, if you're working as iOS Developer or familiar with XCode, you know how to run the project by clicking the `play` button or `build` button. Did you know how Swift Compiler actually work? 
### Swift Language
Swift language is high level programming language, means there are tons of computer science abstraction till today, you as developer can easily to read and write the code without needs to worry regarding target architecture (x86_64, arm64, etc), addressing memory, or else. It's easy just to print `hello world` nowadays. 

Under the hood, Swift Compile works very complicated, here's the figure of Swift (or any C Family language) works:

![Figure 1: Swift Build](https://user-images.githubusercontent.com/22362226/172788893-8b13ea2a-c461-4f20-8dd1-afea5e9f675a.png)

#### Compiler
Compiler is a program that translate high-level and human-readable source code such as Swift to machine code. In a nutshell, each file Swift on your module or project will translated to machine code so it can be executed by CPU. At the end, your extension `.swift` will change `.o` that usually called as object file. For better context, let's do in practical way.

1. Open `1-Session-Introduce` directory. There are 4 Swift files which `Animal.swift`, `Cat.swift`, `Dog.swift`, and `main.swift`.
   - **Animal.swift**: Contain Animal class and later on will work as parent class.
   - **Cat.swift and Dog.swift**: Contain Cat and Dog class that inherit their parent class which Animal class.
   - **main.swift**: This is our apps entry point that contain Home class and pet function.

2. Get acquainted with Swift Compile.

    Swift compile has provided high level command, to build our swift file you can write the command on terminal 
    ```swift
    swiftc Animal.swift Cat.swift Dog.swift main.swift -module-name MyApp -o MyApp.app
    ```
    And you will see MyApp.app and try to execute it `./MyApp.app` and it will show our print statement.
    - -module-name value - Name of the module to build, to easier your understanding, you can assume this is group of swift file in the same directory.
    - -o filename - Write output to <file>
  
3. Get your hand dirty
  
    Previously we have talked that compiler is program that translate our swift file to object file, so how to do it on our case? First, we need to know how is relation between swift file on the module. On our case we can describe it as below
  
  ![Figure 2 - Example Swift Dependencies](https://user-images.githubusercontent.com/22362226/172804776-78505ce5-68f2-40ca-a06c-29968db74780.png)  
  
  **Compile `Animal.swift` to `Animal.o`**
  
  This class has no dependecy to the other we can run the command 
  ```swift
  swiftc -c Animal.swift
  ``` 
  After you execute the command, it will showing Animal.o. We just translate `Animal.swift` to object file that can be understand only by computer.
  
  **Compile `Cat.swift` and `Dog.swift`** 
  
  These 2 classes has dependency to Animal class, so we need to run thise command
  Cat.swift to Cat.o
  ```swift
  swiftc -c Cat.swift Animal.swift -module-name MyApp
  ```
  
  Dog.swift to Dog.o
  ```swift
  swiftc -c Dog.swift Animal.swift -module-name MyApp
  ```
  And the result is you will found 2 new files which Cat.o and Dog.o. We succeed to translate those 2 swift files to object files.
  Notes:
  - You can assume the order is matter, the first order is the swift file that will translated to the object file and the rest is the file dependencies.
  - -module-name <value> - Name of the module to build, to easier your understanding, you can assume this is group of swift file in the same directory.
  
  **Compile `main.swift`**
  
  This class initialize Cat and Dog class that has dependency to Animal, for this case we need to run below command.
  ```swift
  swiftc -c main.swift Cat.swift Dog.swift Animal.swift -module-name MyApp
  ```
  And you will get the same result like before, you have succeed translate `main.swift` to the `main.o`.
    
After you get 4 object files which `main.o`, `Cat.o`, `Dog.o`, and `Animal.o`, we haven't create the executable binary for this so you can't running or see your program, yet. So how to run the program? first we need to combine them (the object file) to the single executable, and that's the linker job. Let's move to the next topic, Linker.

#### Linker
Linker is the computer system program that combine one or more object file into single binary or executable. Imagine a puzzle, before you see the image of the puzzle, you need to combine each pieces to the correct place until you see a whole image. With this case, you as the person who combine pieces of puzzle is the Linker, and each piece of puzzle is the Object File.
  
From previous case, we have 4 object file `main.o`, `Cat.o`, `Dog.o` and `Animal.o`. Next, we need to give "job" to the linker to combine our object file. Swift Compiler has wrap the linker abstraction so it is easier to link them without knowing about `ld` (You can learn about this if you want to go deeper on the build system). Let's run the linker using this command:
  ```swift
  swiftc main.o Cat.o Dog.o Animal.o -o MyApp.app
  ```

After you run the command, it will produce 1 file call MyApp.app, that's our executable, the linker has succeed to combine our object file into single binary. Now you can execute the program `./MyApp.app`.

#### Session 1 - Final Word
We have succeed to learn about Swift Build System without need to going deeper to the low level. In the real world you may face with the word `duplicate symbol` or `unresolved symbol`, we won't to talk about that in this workshop. The thing that you need to know is how Swift Build System working in a simple-way. On the next topic we will discuss regarding static and dynamic library, so first thing first is you get a better context between Compiler and Linker.

## Session 2 - Getting Know Static and Dynamic Library
Now, we will working on directory `2-Session-Swift-Framework`, so let's jump there.
  
  <img width="295" alt="image" src="https://user-images.githubusercontent.com/22362226/172815813-7f922296-8169-4146-a935-519c6f8451af.png">

Assuming that we will creating `Animal` library because we want to distribute our Animal library so it can be reuse by other project. First, move `Animal.swift`, `Cat.swift`, and `Dog.swift` to `Animal` directory. The final format will be like below:
  
  <img width="294" alt="image" src="https://user-images.githubusercontent.com/22362226/172818154-e44fccee-465a-47a6-9727-62cc25057370.png">

🚨🚨🚨🚨🚨🚨🚨
> Before we continuing the session, don't forget to put ACL (Access Control Level) on every classes and function that want to expose to other swift module. Swift default ACL is Internal. If we want to expose to other module we need to change it to Public.
  
**Create Static Library**

Move to your terminal and point it to Animal directory. It's easy to create static library, you can run this command.
  
  ```swift
  swiftc -emit-module -emit-library -static Animal.swift Cat.swift Dog.swift -module-name Animal
  ```
  - -emit-module - Emit an importable module, so our module can imported on any Swift file and project.
  - -emit-library - Emit a linked library, default is dynamic so put -static to create static library.
  
After you run the command, it will showing 4 files:
  
  <img width="268" alt="image" src="https://user-images.githubusercontent.com/22362226/172819762-85cac21a-0525-4cd6-83da-cad12fefbe38.png">

  - .swiftdoc .swiftmodule .swiftsourceinfo - in a short word, this files contains our Swift header so it can import and read by other modules or swift project.
  - .a - is our static library, in this binary we can see collection of our object file. To prove that try to run this command `nm libAnimal.a` and we can look the table list of our object file
  
  <img width="671" alt="image" src="https://user-images.githubusercontent.com/22362226/172820847-4e195a23-17a3-4fe0-9942-658c6b5d048c.png">

move those 4 items to the library director on the previous directory. The final structure like below.
  
  <img width="297" alt="image" src="https://user-images.githubusercontent.com/22362226/172821539-ef501b19-2de3-496a-8e3e-ce47210030f3.png">

After that, we need slightly change on our `main.swift`, because we put Cat and Dog class on the library, we need to import the library to our Swift file.
  ```swift
  import Animal //add this if you imported other module or library

  class Home {
      func myPet() {
          let cat = Cat()
          cat.eat()

          let dog = Dog()
          dog.eat()
      }
  }

  let home = Home()
  home.myPet()
  ```
  
Finally, move to root library which `2-Session-Swift-Framework` and we need to link our `main.swift` with the static library we just created before.
  ```swift
  swiftc main.swift -L ./library/ -I ./library/ -lAnimal -o MyApp.app
  ```
  
  - -L value - Add directory to library link search path.
  - -I value - Add directory to the import search path.
  - -lvalue - Specifies a library which should be linked against. Our library name Animal, so define it with -lAnimal.
  
It will produce MyApp.app, and you can execute it `./MyApp.app` and see the print statement.
  
  <img width="337" alt="image" src="https://user-images.githubusercontent.com/22362226/172824503-6d1de68d-7ec6-41b1-8666-6c9e49eaf828.png">

Try to remove items inside `/library/` directory and execute your app without compiling. You will see the print statement and your program still executed. That's because, the linker will "copy-pasting" the source code from the library to the `main.swift`. Also, you can move the MyApp.app to anywhere and still can be executable.
  
  ![Untitled-2021-11-02-1423](https://user-images.githubusercontent.com/22362226/172826913-b711d75e-543e-4962-9539-d4c8767120a8.png)
  
**Create Dynamic Library**

To create dynamic, we only need to remove `-static` when executing the command emit library.
  ```swift
  swiftc -emit-module -emit-library Animal.swift Cat.swift Dog.swift -module-name Animal
  ```
  
and will produce .dylib extension which stand for dynamic library.
  
  <img width="292" alt="image" src="https://user-images.githubusercontent.com/22362226/172827848-d4e5a012-8ba1-4f7c-b88e-bc33a961a817.png">

The same like static library, let's move it those 4 files to directory `/library/` and link them to the `main.swift`
  ```swift
    swiftc main.swift -L ./library/ -I ./library/ -lAnimal -o MyApp.app
  ```
  
try to run them `./MyApp.app` and you will get error like below.
  
  <img width="870" alt="image" src="https://user-images.githubusercontent.com/22362226/172828469-81ee0abe-0168-4e04-a086-c3898153428d.png">

Don't worry, now please try to move `libAnimal.dylib` to the same level with our executable. The final directory structure like below
  
  <img width="289" alt="image" src="https://user-images.githubusercontent.com/22362226/172828693-81415af6-2ee0-46cb-bad2-07efb17548af.png">

try to run it without recompiling it again and your program will running successfully. Why this is happen?
  
  ![Untitled-2021-11-02-1424](https://user-images.githubusercontent.com/22362226/172830709-c1a2ec91-a195-4de5-82ac-17e321804a05.png)

So, instead of writing or "copy-paste" the library to the main code, it only write the reference address of the library and the header without looking at the implementation. The look-up of reference will be done on the runtime, so if the library or implementation not exist, the application will crash and show the error like on the first example.
  
Dynamic library can help when we want to reuse the library in more than one application. In desktop environment like macos, windows, or linux, we can store dynamic library on file system level and the library can be use by other application WITHOUT need to embed it to the application level like static library. 
  
> try to change the extension libAnimal.dylib to libAnimal.dylib.foo without recompiling the application can run but will crash on the runtime
  
**Session 2 - Final Word**
  
You have see difference between static and dynamic, there are tons of pros and cons using both of them. You as developer need to know what's the difference and use it wisely, both of them are good as long as you know how to use it. Here's a slightly difference between static and dynamic:

Static
  - Fast load time: Because the binary included into single binary.
  - Can be small or big app size: Use static we can achieve smaller app size if we're use optimization because they can remove unused symbol, but can be big too based on the each use case.
  
Dynamic
  - Slow load time: Because when app launch on runtime, they need to solve the address or look-up to the address of library.
  - Can be small or big app size: Use dynamic we can achieve big size if we embed the dynamic library to our package. And also it can be smaller if we distribute it separately with the main package.
  
There are no which are good, you should know the difference and how to use it. After you're getting clear with this session, let's jump to the next session and playing around XCode with the knowledge we have, till now.
  
## Session 3 - Extract the Monolith
  
