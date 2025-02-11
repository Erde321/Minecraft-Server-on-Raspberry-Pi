
# Minecraft Server on Raspberry Pi

This guide will walk you through setting up a Minecraft server on your Raspberry Pi using Ngrok for port forwarding and CallMeBot to receive the server hostname on WhatsApp.

## Required Software

To get started, make sure you have the following software installed:

- **Java Development Kit (JDK)**:
  ```bash
  sudo apt install default-jdk
  ```
- **Jq**:
  ```bash
  sudo apt install jq
  ```
- **Ngrok**:
  ```bash
  curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
  ```

## Setup Minecraft Server

1. Download the Minecraft server JAR file from [Minecraft's official website](https://www.minecraft.net/en-us/download/server) with wget.
   ```bash
   wget "Download Link to Server.jar"
   ```
3. Place the downloaded `minecraft_server.jar` file in the same directory as the Makefile.
4. Start the Minecraft server with the following command:
   ```bash
   java -Xmx1024M -Xms1024M -jar server.jar nogui
   ```
5. Open the `eula.txt` file generated in the server directory and change `eula=false` to `eula=true`.

## Configure CallMeBot

1. Obtain your phone number and API key from [CallMeBot's website](https://www.callmebot.com/blog/free-api-whatsapp-messages/).
2. Edit the `sendtext.py` file and insert your phone number and API key.
3. 'callmebot.py' from https://github.com/stonatm/CallMeBot-Whatsapp-Signal needs to be in the directory 'callmebot'

## Starting and Stopping the Server

To start the Minecraft server, run:
```bash
make start
```

To stop the Minecraft server, run:
```bash
make stop
```

That's it! Your Minecraft server should now be up and running on your Raspberry Pi. If you have any questions or issues, feel free to reach out for assistance. Enjoy your gaming!!
