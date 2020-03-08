#include <ncnet/Server.h>

#include <iostream>

using namespace std;

void parse_incoming_packets(ncnet::Transfer &transfer) {
    cout << "Got packet from ID " << transfer.get_connection_id() << endl;
}

int main() {
    ncnet::Server server;

    server.start("", 10000);
    server.run_transfer_loop(parse_incoming_packets);

    server.stop();
}
