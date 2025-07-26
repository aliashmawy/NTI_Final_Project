# 🐳 3-Tier Node.js Application with Docker Compose

## 📂 Navigation
- [Backend Dockerfile](./backend/Dockerfile)
- [Frontend Dockerfile](./frontend/Dockerfile)
- [docker-compose.yml](./docker-compose.yml)

---

## 🎯 Overview
This directory demonstrates a full-stack, 3-tier web application using Docker Compose. It allows you to run and test the application locally—complete with a MongoDB database—before deploying to Kubernetes.

- **Frontend:** React.js (served by NGINX)
- **Backend:** Node.js/Express
- **Database:** MongoDB (official image)

---

## 🛠️ Key Docker Features

### ✅ Base Verified Images
- Uses official, trusted images from Docker Hub:
  - `node:18-alpine` and `node:16` for backend/frontend builds
  - `nginx:stable-alpine` for serving the frontend
  - `mongo:6.0` for the database

### 🏗️ Multi-Stage Builds
- **Backend** and **Frontend** both use multi-stage Dockerfiles:
  - **Backend:**
    - First stage builds dependencies and app with Node.js
    - Second stage copies only the built app and runs it in a clean Node.js container
  - **Frontend:**
    - First stage builds the React app
    - Second stage serves the static build with NGINX
- This approach ensures smaller, more secure, and production-ready images.

---

## 🧭 File Navigation
- **[backend/Dockerfile](./backend/Dockerfile):** Multi-stage build for the Node.js backend
- **[frontend/Dockerfile](./frontend/Dockerfile):** Multi-stage build for the React frontend
- **[docker-compose.yml](./docker-compose.yml):** Orchestrates all three services for local development

---

## 🗄️ Local Testing with Docker Compose
- The `docker-compose.yml` file defines three services:
  - **mongo:** Runs MongoDB using the official image, with persistent storage
  - **backend:** Runs the Node.js API, depends on `mongo`
  - **frontend:** Runs the React app (served by NGINX), depends on `backend`
- This setup allows you to test the full application stack locally, including database integration, before moving to Kubernetes.