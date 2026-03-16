REM What does %errorlevel% mean?
REM It is a special variable in Windows that holds the result of the last command.
REM command was successful, %errorlevel% is 0.
REM command failed or didn’t find what it was looking for, %errorlevel% will be a non-zero number.
REM findstr "1" searches for the number 1 in the query output.
REM >nul discards any visible output (it won’t print anything to the console).
REM If findstr finds 1:
REM It sets the %errorlevel% to 0 (indicating success).
REM If findstr doesn’t find 1 (e.g., the query returned no rows because the table doesn’t exist):
REM It sets %errorlevel% to a non-zero value.




@echo off

REM Wait for PostgreSQL container to fully start
echo "Waiting for PostgreSQL container to be ready..."
:wait_for_container
docker inspect -f "{{.State.Running}}" postgres_db | findstr "true" >nul
if %errorlevel% neq 0 (
  echo "Container is not ready yet. Retrying..."
  timeout /t 2 /nobreak >nul
  goto wait_for_container
)
echo "PostgreSQL container is running!"

REM Wait for PostgreSQL service to be fully initialized
echo "Waiting for PostgreSQL service to be ready..."
:wait_for_postgres
docker exec -i postgres_db pg_isready -U postgres >nul 2>&1
if %errorlevel% neq 0 (
  echo "PostgreSQL is still starting up. Retrying..."
  timeout /t 2 /nobreak >nul
  goto wait_for_postgres
)
echo "PostgreSQL is ready to accept connections!"

REM Wait for the table 'ai-model' to exist
echo "Waiting for table 'ai-model' to be created..."
:wait_for_ai_model_table
docker exec -i postgres_db psql -U postgres -d ai_comparison_db -tAc "SELECT 1 FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'ai-model';"

if %errorlevel% neq 0 (
  echo "Table 'ai-model' does not exist yet. Retrying..."
  timeout /t 2 /nobreak >nul
  goto wait_for_ai_model_table
)
echo "Table 'ai-model' exists!"


cd ai-model-comparison-project/scripts/sql 


REM Run ai-models.sql
echo "Running ai-models.sql..."
docker exec -i postgres_db psql -U postgres -d ai_comparison_db < "./ai-models.sql"
if %errorlevel% neq 0 (
  echo "Error: Failed to execute ai-models.sql"
  exit /b 1
)

REM Wait for the table 'users' to exist
echo "Waiting for table 'user' to be created..."
:wait_for_users_table
docker exec -i postgres_db psql -U postgres -d ai_comparison_db -tAc "SELECT 1 FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'user';" | findstr "1" >nul
if %errorlevel% neq 0 (
  echo "Table 'user' does not exist yet. Retrying..."
  timeout /t 2 /nobreak >nul
  goto wait_for_users_table
)
echo "Table 'user' exists!"

REM Run admin-users.sql
echo "Running admin-users.sql..."
docker exec -i postgres_db psql -U postgres -d ai_comparison_db < "./admin-users.sql"
if %errorlevel% neq 0 (
  echo "Error: Failed to execute admin-users.sql"
  exit /b 1
)

echo "SQL scripts executed successfully!"
