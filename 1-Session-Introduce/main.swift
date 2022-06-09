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