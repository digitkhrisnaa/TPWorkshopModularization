class Cat: Animal {
    override init() {
        super.init()
    }

    override func eat() {
        super.eat()
        print("Cat - eat")
    }
}