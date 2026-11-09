@echo off
REM Launcher for Godot MCP Server
set GODOT_PATH=C:\Program Files\Godot\Godot_v4.7.2-stable_win64.exe\Godot_v4.7.2-stable_win64.exe
set DEBUG=true
echo Starting Godot MCP Server with Godot: %GODOT_PATH%
node "C:\Users\Pc\.gemini\antigravity\scratch\godot-mcp-solo\build\index.js"
