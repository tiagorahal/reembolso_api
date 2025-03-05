## Docker Setup & Running the Application

This section provides step-by-step instructions on how to **build and run the application using Docker**.

### **1️⃣ Install Docker & Docker Compose**

Ensure you have **Docker** and **Docker Compose** installed on your system. If not, install them following the official documentation:

- [Docker Installation](https://docs.docker.com/get-docker/)
- [Docker Compose Installation](https://docs.docker.com/compose/install/)

---

### **2️⃣ Clone the Repository**

```bash
git clone https://github.com/your-repo/reembolso_api.git
cd reembolso_api
```

---

### **3️⃣ Build and Run Docker Containers**

Run the following command to build the containers and start the application:

```bash
docker compose up --build -d
```

This will:

- Build the Docker images.
- Start the PostgreSQL database container.
- Start the Rails application container.

👉 **Verify running containers:**

```bash
docker compose ps
```

---

### **4️⃣ Setup the Database**

Run the following command to create and migrate the database:

```bash
docker compose exec web rails db:setup
```

If you need to run migrations separately:

```bash
docker compose exec web rails db:migrate
```

---

### **5️⃣ Running the Application**

Once everything is set up, your API will be available at:

```
http://localhost:3000
```

You can now follow the [Authentication & API Usage](#authentication--api-usage) section to interact with the API.

---

### **6️⃣ Stopping and Removing Containers**

To stop the running containers, use:

```bash
docker compose down
```

If you want to **remove volumes and clean up completely**, run:

```bash
docker compose down --volumes
```

---

### **7️⃣ Debugging & Logs**

To check the logs for the running containers:

```bash
docker compose logs -f
```

If you need an interactive shell inside the running **web** container:

```bash
docker compose exec web bash
```

To restart a container without rebuilding:

```bash
docker compose restart web
```

---

### **8️⃣ Rebuilding the Docker Containers**

If you made changes to the Gemfile or other dependencies, rebuild the application with:

```bash
docker compose up --build -d
```

---

### **Final Notes**

- Make sure **port 5432** is available for PostgreSQL. If you get an error about "address already in use", stop any running PostgreSQL instances on your system.
- If you need to clean up old containers, images, and volumes:
  ```bash
  docker system prune -af
  docker volume rm $(docker volume ls -q)
  ```
- Always use **environment variables** to manage sensitive data instead of hardcoding them in your application.

Now, you're ready to use the API! 🚀



## Authentication & API Usage

This section provides step-by-step instructions on how to **create a user, log in, create a reembolso, check reembolsos, and log out** using **cURL**.

### **1️⃣ Create a User**
```bash
curl -X POST http://localhost:3000/auth \
     -H "Content-Type: application/json" \
     -d '{
       "email": "alice@example.com",
       "password": "password123",
       "password_confirmation": "password123"
     }'
```
👉 **Expected Response:**
```json
{
  "status": "success",
  "data": {
    "email": "alice@example.com",
    "provider": "email",
    "uid": "alice@example.com"
  }
}
```

---

### **2️⃣ Log In User**
```bash
curl -i -X POST http://localhost:3000/auth/sign_in \
     -H "Content-Type: application/json" \
     -d '{
       "email": "alice@example.com",
       "password": "password123"
     }'
```
👉 **Important Response Headers:**
```
access-token: <TOKEN>
token-type: Bearer
client: <CLIENT_ID>
expiry: <EXPIRY>
uid: alice@example.com
```
✅ **Save the `access-token`, `client`, and `uid` values for the next steps.**

---

### **3️⃣ Create a Reembolso**
```bash
curl -X POST http://localhost:3000/reembolsos \
     -H "Content-Type: application/json" \
     -H "access-token: <TOKEN>" \
     -H "client: <CLIENT_ID>" \
     -H "uid: alice@example.com" \
     -d '{
       "reembolso": {
         "descricao": "Taxi to airport",
         "valor": 30.00,
         "data": "2025-03-02"
       }
     }'
```
👉 **Expected Response:**
```json
{
  "id": 1,
  "descricao": "Taxi to airport",
  "valor": 30.00,
  "data": "2025-03-02",
  "user_id": 1
}
```

---

### **4️⃣ Check Reembolsos**
```bash
curl -X GET http://localhost:3000/reembolsos \
     -H "Content-Type: application/json" \
     -H "access-token: <TOKEN>" \
     -H "client: <CLIENT_ID>" \
     -H "uid: alice@example.com"
```
👉 **Expected Response:**
```json
[
  {
    "id": 1,
    "descricao": "Taxi to airport",
    "valor": 30.00,
    "data": "2025-03-02",
    "user_id": 1
  }
]
```

---

### **5️⃣ Log Out User**
```bash
curl -X DELETE http://localhost:3000/auth/sign_out \
     -H "Content-Type: application/json" \
     -H "access-token: <TOKEN>" \
     -H "client: <CLIENT_ID>" \
     -H "uid: alice@example.com"
```
👉 **Expected Response:**
```json
{
  "success": true
}
```

---

### **Final Notes**
- Replace `<TOKEN>`, `<CLIENT_ID>`, and `alice@example.com` with the actual values received in the login step.
- You **must** include the authentication headers (`access-token`, `client`, and `uid`) in **every authenticated request**.
- The **token will persist until logout** or expiration.

