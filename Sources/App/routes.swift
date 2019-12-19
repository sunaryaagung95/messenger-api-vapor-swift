import Routing
import Vapor


public func routes(_ router: Router) throws {
    router.get { req in
        return "This is Root"
    }

   try router.register(collection: UserController())
}
