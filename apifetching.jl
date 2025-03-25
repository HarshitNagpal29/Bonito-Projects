using JSON
using Bonito, Observables

response = Observable("")
app = App() do
    button = DOM.button("Fetch Data", onclick=js"""(e) => {
        fetch("https://api.github.com/users/JuliaLang")
        .then(response => response.json())
        .then(data => {
            $(response).notify(data.followers.toString());
        });
    }""")

    followers_display = map(r -> "Followers: $r", response)
    
    return DOM.div(button, DOM.p(followers_display))
end

port = 8080
server = Bonito.Server(app, "0.0.0.0", port)
println("Server running at http://localhost:$port")
wait(server)