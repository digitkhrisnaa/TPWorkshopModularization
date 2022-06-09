public class Dog: Animal {
    public override init() {
        super.init()
    }

    public override func eat() {
        super.eat()
        print("Dog - eat")
    }
}