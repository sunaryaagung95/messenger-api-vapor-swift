import Vapor
import FluentSQL
import Fluent

final class ParticipantController: RouteCollection {
    func boot(router: Router) throws {
        let participants = router.grouped("api", "participants")

        participants.post(Participant.self, use: add)

        participants.get(Conversation.parameter, use: get)
    }

    func add(_ req: Request, _ participant: Participant) throws -> Future<Participant> {
        return participant.save(on: req)
    }

    func get(_ req: Request) throws -> Future<[Participant]> {
        return try req.parameters.next(Conversation.self).flatMap { conversation in 
            return try conversation.participants.query(on: req).all()
        }
    }
}