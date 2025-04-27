# idan-api
A simple and secure external HTTP API for your FiveM server.

## Features
- Whitelist system (per IP and per endpoint)
- Debug logging for development
- Webhook logging for actions (Discord)
- Configurable endpoints
- Safe body and method validation

## Installation
1. Download or clone the resource into your server resources folder.
2. Add to your `server.cfg`: ensure idan-api
3. Edit `config.lua` to configure your whitelist, endpoints, and webhook settings.

## Usage
The API only accepts **POST** requests.

Example Endpoints:
- `/Kick` → Kick a player from the server
- `/Announce` → Send a chat message to all players

### You can take example from tester.cmd file
