# Coolify deployment

The production frontend is the `frontend` application in the Ape-Ame project's production environment.
Coolify builds the Dockerfile from `main`, exports the game with Godot 4.3, and serves it with nginx at https://ape-ame.ultrablob.me.

nginx serves the cross-origin isolation headers needed by the web export and proxies `/api/` to the backend on the private `coolify` Docker network. Its upstream hostname is the backend application's Coolify UUID. Update `nginx.conf` if that application is recreated.

The backend repository is https://code.ultrablob.me/ultrablob/ape-ame-backend. Its application has no public domain. `/api/healthz` checks backend and Redis connectivity; `/api/leaderboard` reads the leaderboard.

After pushing changes, deploy the corresponding application in Coolify. Both applications must use the same Docker network.
