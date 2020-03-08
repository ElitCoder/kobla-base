#include <ncnet/Client.h>

using namespace std;

int main() {
    ncnet::Client client;
    client.start("localhost", 10000);

    ncnet::Packet echo;
    echo << "Hello!";
    client.send_packet(echo);
    this_thread::sleep_for(1000ms);
    client.stop();
}
