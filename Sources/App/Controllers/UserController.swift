import Vapor
import Crypto
import FluentSQL

final class UserController: RouteCollection {
    func boot(router: Router) throws {
        let users = router.grouped("api", "users")

        users.post(User.self, use: create)

        users.get(use: getAll)
        users.get(User.parameter, use: getOne)
        users.get("search", use: search)

        users.put(UserContent.self, at: User.parameter, use: update)

        users.delete(User.parameter, use: delete)
    }

    func create(_ req: Request, _ user: User) throws -> Future<User> {
        user.password = try BCrypt.hash(user.password)
        return user.save(on: req)
    }

    func getAll(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }

    func getOne(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }

    func search(_ req: Request) throws -> Future<[User]> {
        let email = try req.query.get(String.self, at: "email")
        return User.query(on: req).group(.or) { query in
            query.filter(\.email =~ email)
        }.all()
    }

    func update(_ req: Request, _ body: UserContent) throws -> Future<User> {
        let user = try req.parameters.next(User.self)
        return user.map(to: User.self) { user in
            user.email = body.email ?? user.email
            user.password = body.password ?? user.password
            user.password = try BCrypt.hash(user.password)
            return user
        }.update(on: req)
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).delete(on: req).transform(to: .noContent)
    }
}

struct UserContent: Content {
    var email: String?
    var password: String?
}