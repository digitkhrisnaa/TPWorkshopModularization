class Dog: Animal {
    override init() {
        super.init()
    }

    override func eat() {
        super.eat()
        print("Dog - eat")
    }
}