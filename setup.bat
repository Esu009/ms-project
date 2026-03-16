@echo off

rd /s /q ai-model-comparison-project > nul 2>&1

REM Clone the main repository
git clone https://git.dcpltechnology.com/dcpl/ai-model-comparison/ai-model-comparison-project.git
IF ERRORLEVEL 1 (
    echo "Error cloning ai-model-comparison-composer-app. Exiting."
    exit /b 1
)

REM Change to the main directory
cd ai-model-comparison-project

REM Clone the backend services repository
git clone https://git.dcpltechnology.com/dcpl/ai-model-comparison/backend-services-app.git
IF ERRORLEVEL 1 (
    echo "Error cloning backend-services-app. Exiting."
    exit /b 1
)

REM Clone the admin panel repository
git clone https://git.dcpltechnology.com/dcpl/ai-model-comparison/admin-panel-app.git
IF ERRORLEVEL 1 (
    echo "Error cloning admin-panel-app. Exiting."
    exit /b 1
)

REM Clone the frontend repository
git clone https://git.dcpltechnology.com/dcpl/ai-model-comparison/frontend-app.git
IF ERRORLEVEL 1 (
    echo "Error cloning frontend-app. Exiting."
    exit /b 1
)



REM Pull the latest changes for composer-app
git fetch origin main
git checkout main
git pull origin main
IF ERRORLEVEL 1 (
    echo "Error pulling backend-services-app main-comments branch. Exiting."
    exit /b 1
)

REM Pull the latest changes for backend-services-app
cd backend-services-app
git fetch origin main
git checkout main
git pull origin main
IF ERRORLEVEL 1 (
    echo "Error pulling backend-services-app main-comments branch. Exiting."
    exit /b 1
)
cd ..

REM Pull the latest changes for admin-panel-app
cd admin-panel-app
git fetch origin main
git checkout main
git pull origin main
IF ERRORLEVEL 1 (
    echo "Error pulling admin-panel-app main branch. Exiting."
    exit /b 1
)
cd ..

REM Pull the latest changes for frontend-app
cd frontend-app
git fetch origin main
git checkout main
git pull origin main
IF ERRORLEVEL 1 (
    echo "Error pulling frontend-app main branch. Exiting."
    exit /b 1
)
cd ..

REM Copy the run.bat file to the main directory
copy scripts\windows\build.bat ..\build.bat
copy scripts\windows\run.bat ..\run.bat
copy scripts\windows\import-data.bat ..\import-data.bat 


cd ..

echo "Setup complete!"