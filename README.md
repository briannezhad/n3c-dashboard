# Running the N3C Dashboard

## Prerequisites

1. **Docker**: Ensure you have Docker installed on your machine. You can download it from [Docker's official website](https://www.docker.com/).
2. **Required Files**: The following files are needed to run this project:
   - `server.xml` (provided in the repository under `config/`)
   - `rewrite.config` (provided in the repository under `config/`)
   - `n3c-dashboard-0.0.1-SNAPSHOT.war` This file must be provided by another developer. Place it in the `config/` directory before running the project.
   - **`context.xml`**: This file must be provided by another developer. Place it in the `config/` directory before running the project.

---

## Steps to Run the Project Locally

1. **Clone the Repository**: Clone the repository containing the Dockerfile and other configuration files.

2. **Ensure `context.xml` is Available**: 
   - Obtain the `context.xml` file from your team.
   - Place it in the `config/` directory.

3. **Build the Docker Image**:
   Open a terminal in the project directory and run:
   ```bash
   docker-compose build
   ```

4. **Run the Docker Container**:
   Start the container with:
   ```bash
   docker-compose up
   ```

5. **Access the Application in Your Browser**:
   - Open your browser and navigate to: [http://localhost:8080](http://localhost:8080)
   - The N3C Dashboard should be running and accessible.

---

## Troubleshooting

- **Port Conflicts**: If port 8080 is already in use, modify the `ports` section in the `docker-compose.yml` file to use a different port (e.g., `9090:8080`) and access the app at [http://localhost:9090](http://localhost:9090).
- **Missing `context.xml`**: Ensure you have placed the `context.xml` file in the `config/` directory. The container will not work without it.
- **Logs**: If the application fails to start, check the container logs:
  ```bash
  docker logs n3c-dashboard
  ```

---

## Stopping the Container

To stop the running container, press `Ctrl+C` in the terminal or run:
```bash
docker-compose down
```

---

## Additional Notes

- If you need to rebuild the container after making changes, use:
  ```bash
  docker-compose up --build
  ```
- For additional configurations or setup, refer to the documentation provided in the project repository.