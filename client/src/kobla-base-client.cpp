#include <ncnet/Client.h>

#include <SFML/Graphics.hpp>

using namespace ncnet;
using namespace sf;
using namespace std;

bool run_engine(RenderWindow &window, Client &client) {
    // Render loop
    while (window.isOpen()) {
        Event event;
        while (window.pollEvent(event)) {
            if (event.type == Event::Closed) {
                window.close();
                return true;
            }
        }

        window.clear();
        // Draw everything
        window.display();
    }

    return true;
}

bool connect_server(Client &client) {
    // TODO: Register transfer loop?
    return client.start("localhost", 11112);
}

bool load_engine(RenderWindow &window) {
    window.setVerticalSyncEnabled(true);
    // TODO: Add loading
    return true;
}

int main() {
    RenderWindow window(VideoMode(640, 480), "kobla-base-client");
    if (!load_engine(window)) {
        return -1;
    }

    Client client;
    if (!connect_server(client)) {
        // Fine for now
    }

    run_engine(window, client);
    client.stop();
}
