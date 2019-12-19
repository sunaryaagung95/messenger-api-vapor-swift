import Vapor
import FluentPostgreSQL

public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure postgresql
    let config = PostgreSQLDatabaseConfig(hostname: "localhost", port: 5432, username: "postgres", database: "messenger", password: "magnum2706", transport: .cleartext)
    let postgres = PostgreSQLDatabase(config: config)

    // Register configure db
    var databases = DatabasesConfig()
    databases.add(database: postgres, as: .psql)
    services.register(databases)

    // Migrating model
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    services.register(migrations)


    var commands = CommandConfig.default()
    commands.useFluentCommands()
    services.register(commands)
}
