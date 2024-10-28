import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    let postgresConfig = SQLPostgresConfiguration(
        hostname: "localhost",
        port: 5432,
        username: "postgres",
        password: "yourpassword",
        database: "grocerydb",
        tls: .disable
    )

    app.databases.use(.postgres(configuration: postgresConfig), as: .psql)


    //register migration
    app.migrations.add(CreateUserTableMigration())
    app.migrations.add(CreateGroceryCategoryTableMigration())
    app.migrations.add(CreateGroceryItemTableMigration())
    
    try app.register(collection: UserController())
    try app.register(collection: GroceryController())
    
    app.jwt.signers.use(.hs256(key: "secret"))
    
    // register routes
    try routes(app)
}
