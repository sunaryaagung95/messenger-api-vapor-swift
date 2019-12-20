import Vapor
import FluentPostgreSQL

final class ConversationController: RouteCollection {
    func boot(router: Router) throws {
        let conversations = router.grouped("api", "conversations")

        conversations.post(Conversation.self, use: create)

        conversations.get(use: getAll)
        conversations.get(Conversation.parameter, use: getOne)

        conversations.delete(Conversation.parameter, use: delete)
    }

    func create(_ req: Request, _ conversation: Conversation) throws -> Future<Conversation> {
        return conversation.save(on: req)
    }

    func getAll(_ req: Request) throws -> Future<[Conversation]> {
        return Conversation.query(on: req).all()
    }

    func getOne(_ req: Request) throws -> Future<Conversation> {
        return try req.parameters.next(Conversation.self)
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Conversation.self).delete(on: req).transform(to: .noContent)
    }
}