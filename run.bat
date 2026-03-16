@echo off
cd ai-model-comparison-project

REM Start Docker containers in detached mode

start cmd /c "docker-compose up"
@echo off
IF ERRORLEVEL 1 (
    echo "Error starting Docker containers in detached mode. Exiting."
    exit /b 1
)

echo "Run completed successfully!"
