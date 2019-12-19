import Vapor
import Crypto
import FluentSQL

final class UserController: RouteCollection {
    func boot(router: Router) throws {
        let users = router.grouped("api", "users")

        users.post(User.self, use: create)

        users.get(use: getAll)
    }

    func create(_ req: Request, _ user: User) throws -> Future<User> {
        user.password = try BCrypt.hash(user.password)
        return user.save(on: req)
    }

    func getAll(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }


}