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

