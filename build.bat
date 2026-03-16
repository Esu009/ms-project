@echo off
cd ai-model-comparison-project


REM Build  Docker containers
docker-compose build
IF ERRORLEVEL 1 (
    echo "Error building Docker containers. Exiting."
    exit /b 1
)

cd ..
