using Bonito
app = App() do 
    return DOM.h1("Hello Bonito!")
end

port = 8080
server = Bonito.Server(app, "0.0.0.0", port)
println("Server running at http://localhost:$port")
wait(server)