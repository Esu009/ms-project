# Project Documentation – User Manual
## AI Model Comparison

---

# Commands

## Steps to Run Back End Locally

1. Create a directory in an appropriate location

```bash
mkdir D:/Projects/Deployment
```

2. Pull code from Repository

```bash
git clone https://github.com/Esu009/ms-project
```

3. Go into the project source folder

```bash
cd ai-model-comparison-be
```

4. Check out the dev branch

```bash
git checkout dev
```

5. Configure the project

```bash
npm install
```

6. Build the docker image

```bash
docker-compose build --no-cache --pull
```

7. Run the docker-compose file

```bash
docker-compose up
```

8. Import seed data (Run the batch file)

```bash
cmd.exe import-data.bat
```

9. Testing

After completing steps **1–8**:

- Open **Docker Desktop**
- Shut down the **node-app container** from the management console

Run the tests:

```bash
npm test
```

This will start the test process.

### Available Tests

- **AI Model Controller**
  - Integration Tests
- **AI Model Service**
  - Unit Tests
- **Transaction Controller**
  - Integration Tests
- **Transaction Service**
  - Unit Tests

---

# Steps to Run Front End Locally

1. Create a directory in an appropriate location

```bash
mkdir D:/Projects/Deployment
```

2. Pull Code from Repository

```bash
git clone https://github.com/Esu009/ms-project
```

3. Check out the dev branch

```bash
git checkout dev
```

4. Configure the project

```bash
npm install
```

5. Run the application

```bash
npm start
```

6. Navigate to the application in a browser

```
http://localhost:3001
```

### Authentication

Login using **Google Login**

---

# Steps to Run Admin Panel Locally

1. Create a directory in an appropriate location

```bash
mkdir D:/Projects/Deployment
```

2. Pull Code from Repository

```bash
git clone https://github.com/Esu009/ms-project
```

3. Check out the dev branch

```bash
git checkout dev
```

4. Configure the project

```bash
npm install
```

5. Run the application

```bash
npm start
```

6. Navigate to the application in a browser

```
http://localhost:3002
```

### Admin Credentials

- **Username:** admin@example.com  
- **Password:** 123456

---


# URLs

## Front End

```
http://localhost:3001
```

## Admin Panel

```
http://localhost:3002
```

## Swagger API Documentation

```
http://localhost:4040/api-docs
```

## Grafana / Prometheus Monitoring

```
http://localhost:3000/
```

### Credentials

- **Username:** admin  
- **Password:** admin  

⚠️ **You must change the password on the first login.**
