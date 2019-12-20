import Vapor
import FluentSQL

final class ParticipantController: RouteCollection {
    func boot(router: Router) throws {
        let participants = router.grouped("api", "participants")

        participants.post(Participant.self, use: add)

    }

    func add(_ req: Request, _ participant: Participant) throws -> Future<Participant> {
        return participant.save(on: req)
    }
}